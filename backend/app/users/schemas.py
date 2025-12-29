"""
User Pydantic schemas.
"""
from pydantic import BaseModel, EmailStr
from datetime import datetime
from uuid import UUID


class UserBase(BaseModel):
    """Base user schema."""
    email: EmailStr


class UserCreate(UserBase):
    """Schema for user registration."""
    password: str


class UserResponse(UserBase):
    """Schema for user response (without password hash)."""
    id: UUID
    created_at: datetime
    
    class Config:
        from_attributes = True


class UserProfileResponse(BaseModel):
    """Schema for user profile response (current user's profile)."""
    id: UUID
    email: EmailStr
    created_at: datetime
    
    class Config:
        from_attributes = True


class UpdateProfileRequest(BaseModel):
    """Schema for updating user profile (email)."""
    email: EmailStr


class ChangePasswordRequest(BaseModel):
    """Schema for changing user password."""
    current_password: str
    new_password: str


class ChangePasswordResponse(BaseModel):
    """Schema for change password response."""
    message: str


class DeleteAccountRequest(BaseModel):
    """Schema for account deletion request (password confirmation)."""
    password: str


class DeleteAccountResponse(BaseModel):
    """Schema for account deletion response."""
    message: str