"""
User database models.
"""
from sqlalchemy import Column, String, DateTime
from sqlalchemy.types import UUID as SQLUUID
from datetime import datetime
import uuid
from app.database import Base


class User(Base):
    """User model for authentication and user data."""
    
    __tablename__ = "users"
    
    id = Column(SQLUUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    email = Column(String(255), unique=True, nullable=False, index=True)
    password_hash = Column(String(255), nullable=False)
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow, nullable=False)

