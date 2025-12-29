"""
Feedback routes.
"""
from typing import List
from fastapi import APIRouter, Depends, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app.database import get_db
from app.deps import get_current_user
from app.users.models import User
from app.feedback.models import Feedback
from app.feedback.schemas import FeedbackCreate, FeedbackResponse

router = APIRouter(prefix="/feedback", tags=["feedback"])


@router.post("", response_model=FeedbackResponse, status_code=status.HTTP_201_CREATED)
async def create_feedback(
    feedback_data: FeedbackCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Submit feedback.
    
    Returns:
        FeedbackResponse: Created feedback data
    """
    new_feedback = Feedback(
        user_id=current_user.id,
        rating=feedback_data.rating,
        message=feedback_data.message
    )
    
    db.add(new_feedback)
    await db.commit()
    await db.refresh(new_feedback)
    
    return new_feedback


@router.get("", response_model=List[FeedbackResponse])
async def get_feedback(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Get all feedback submitted by the current user.
    
    Returns:
        List[FeedbackResponse]: List of user's feedback
    """
    result = await db.execute(
        select(Feedback)
        .where(Feedback.user_id == current_user.id)
        .order_by(Feedback.created_at.desc())
    )
    feedback_list = result.scalars().all()
    return list(feedback_list)

