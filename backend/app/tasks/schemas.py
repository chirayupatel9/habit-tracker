"""
Task Pydantic schemas.
"""
from pydantic import BaseModel
from uuid import UUID


class TaskBase(BaseModel):
    """Base task schema."""
    name: str
    is_active: bool = True


class TaskCreate(TaskBase):
    """Schema for creating a task."""
    pass


class TaskUpdate(BaseModel):
    """Schema for updating a task."""
    name: str | None = None
    is_active: bool | None = None


class TaskResponse(TaskBase):
    """Schema for task response."""
    id: UUID
    user_id: UUID
    
    class Config:
        from_attributes = True

