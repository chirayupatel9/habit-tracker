"""
Daily entry database models.
"""
from sqlalchemy import Column, String, Float, Text, ForeignKey, Date, DateTime, Boolean, UniqueConstraint
from sqlalchemy.types import UUID as SQLUUID
from sqlalchemy.orm import relationship
from datetime import datetime, date
import uuid
from app.database import Base


class DailyEntry(Base):
    """Daily entry model for tracking habits, sleep, and notes."""
    
    __tablename__ = "daily_entries"
    
    id = Column(SQLUUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(SQLUUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    date = Column(Date, nullable=False)
    moment_of_day = Column(String(50), nullable=False)
    sleep_hours = Column(Float, nullable=False)
    daily_note = Column(Text, nullable=True)
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)
    
    # Unique constraint: one entry per user per date
    __table_args__ = (
        UniqueConstraint('user_id', 'date', name='unique_user_date'),
    )
    
    # Relationships
    user = relationship("User", backref="daily_entries")
    task_completions = relationship("TaskCompletion", back_populates="entry", cascade="all, delete-orphan")


class TaskCompletion(Base):
    """Task completion model linking tasks to daily entries."""
    
    __tablename__ = "task_completions"
    
    entry_id = Column(SQLUUID(as_uuid=True), ForeignKey("daily_entries.id", ondelete="CASCADE"), primary_key=True)
    task_id = Column(SQLUUID(as_uuid=True), ForeignKey("tasks.id", ondelete="CASCADE"), primary_key=True)
    completed = Column(Boolean, default=False, nullable=False)
    feedback = Column(Text, nullable=True)
    
    # Relationships
    entry = relationship("DailyEntry", back_populates="task_completions")
    task = relationship("Task", back_populates="completions")

