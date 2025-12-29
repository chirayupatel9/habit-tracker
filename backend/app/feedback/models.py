"""
Feedback database models.
"""
from sqlalchemy import Column, String, Integer, ForeignKey, DateTime, Text
from sqlalchemy.types import UUID as SQLUUID
from sqlalchemy.orm import relationship
from datetime import datetime
import uuid
from app.database import Base


class Feedback(Base):
    """Feedback model for user ratings and messages."""
    
    __tablename__ = "feedback"
    
    id = Column(SQLUUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(SQLUUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    rating = Column(Integer, nullable=False)
    message = Column(Text, nullable=False)
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow, nullable=False)
    
    # Relationships
    user = relationship("User", backref="feedback")

