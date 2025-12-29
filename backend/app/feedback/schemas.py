"""
Feedback Pydantic schemas.
"""
from pydantic import BaseModel, Field
from uuid import UUID
from datetime import datetime


class FeedbackBase(BaseModel):
    """Base feedback schema."""
    rating: int = Field(..., ge=1, le=5, description="Rating from 1 to 5")
    message: str


class FeedbackCreate(FeedbackBase):
    """Schema for creating feedback."""
    pass


class FeedbackResponse(FeedbackBase):
    """Schema for feedback response."""
    id: UUID
    user_id: UUID
    created_at: datetime
    
    class Config:
        from_attributes = True

