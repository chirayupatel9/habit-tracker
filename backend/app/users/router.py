"""
User routes.
"""
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, delete
from app.database import get_db
from app.deps import get_current_user
from app.users.models import User
from app.users.schemas import (
    UserProfileResponse,
    UpdateProfileRequest,
    ChangePasswordRequest,
    ChangePasswordResponse,
    DeleteAccountRequest,
    DeleteAccountResponse
)
from app.auth.service import verify_password, get_password_hash

router = APIRouter(prefix="/users", tags=["users"])


@router.get("/me", response_model=UserProfileResponse)
async def get_current_user_profile(
    current_user: User = Depends(get_current_user)
) -> UserProfileResponse:
    """
    Get the current authenticated user's profile.
    
    Returns:
        UserProfileResponse: Current user's profile data (id, email, created_at)
        
    Raises:
        HTTPException: 401 if unauthenticated (handled by get_current_user dependency)
    """
    return current_user


@router.put("/me", response_model=UserProfileResponse)
async def update_profile(
    profile_update: UpdateProfileRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
) -> UserProfileResponse:
    """
    Update the current authenticated user's profile (email).
    
    Args:
        profile_update: Profile update data containing new email
        
    Returns:
        UserProfileResponse: Updated user profile data
        
    Raises:
        HTTPException: 401 if unauthenticated
        HTTPException: 409 if email is already taken by another user
    """
    # Check if email is already taken by another user
    if profile_update.email != current_user.email:
        result = await db.execute(
            select(User).where(User.email == profile_update.email)
        )
        existing_user = result.scalar_one_or_none()
        
        if existing_user:
            raise HTTPException(
                status_code=status.HTTP_409_CONFLICT,
                detail="Email already registered"
            )
    
    # Update email
    current_user.email = profile_update.email
    await db.commit()
    await db.refresh(current_user)
    
    return current_user


@router.put("/me/password", response_model=ChangePasswordResponse)
async def change_password(
    password_data: ChangePasswordRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
) -> ChangePasswordResponse:
    """
    Change the current authenticated user's password.
    
    Args:
        password_data: Password change data (current_password, new_password)
        
    Returns:
        ChangePasswordResponse: Success message
        
    Raises:
        HTTPException: 401 if current password is incorrect
        HTTPException: 400 if new password is too weak (< 8 characters)
    """
    # Verify current password
    if not verify_password(password_data.current_password, current_user.password_hash):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Current password is incorrect"
        )
    
    # Validate new password strength (minimum 8 characters)
    if len(password_data.new_password) < 8:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="New password must be at least 8 characters long"
        )
    
    # Hash and update password
    current_user.password_hash = get_password_hash(password_data.new_password)
    await db.commit()
    
    return ChangePasswordResponse(message="Password updated successfully")


@router.delete("/me", response_model=DeleteAccountResponse)
async def delete_account(
    delete_request: DeleteAccountRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
) -> DeleteAccountResponse:
    """
    Permanently delete the current authenticated user's account and all associated data.
    
    This action is irreversible. All user data including tasks, daily entries,
    task completions, and feedback will be permanently deleted.
    
    Args:
        delete_request: Account deletion request containing password confirmation
        
    Returns:
        DeleteAccountResponse: Success message
        
    Raises:
        HTTPException: 401 if password is incorrect
        HTTPException: 500 if deletion fails (transaction rolled back)
    """
    # Verify password before deletion
    if not verify_password(delete_request.password, current_user.password_hash):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Password is incorrect"
        )
    
    try:
        # Delete user - database CASCADE will automatically delete:
        # - All tasks (via user_id foreign key with CASCADE)
        # - All daily_entries (via user_id foreign key with CASCADE)
        # - All feedback (via user_id foreign key with CASCADE)
        # - All task_completions (via CASCADE from tasks and daily_entries)
        await db.execute(delete(User).where(User.id == current_user.id))
        await db.commit()
        
        return DeleteAccountResponse(message="Account deleted successfully")
        
    except Exception as e:
        # Rollback transaction on any error
        await db.rollback()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to delete account. Transaction rolled back."
        )

