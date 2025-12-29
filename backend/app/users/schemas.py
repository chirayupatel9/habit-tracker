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

