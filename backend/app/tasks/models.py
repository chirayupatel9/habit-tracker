"""
Task database models.
"""
from sqlalchemy import Column, String, Boolean, ForeignKey
from sqlalchemy.types import UUID as SQLUUID
from sqlalchemy.orm import relationship
import uuid
from app.database import Base


class Task(Base):
    """Task model for user-defined habits/tasks."""
    
    __tablename__ = "tasks"
    
    id = Column(SQLUUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(SQLUUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    name = Column(String(255), nullable=False)
    is_active = Column(Boolean, default=True, nullable=False)
    
    # Relationships
    user = relationship("User", backref="tasks")
    completions = relationship("TaskCompletion", back_populates="task", cascade="all, delete-orphan")

