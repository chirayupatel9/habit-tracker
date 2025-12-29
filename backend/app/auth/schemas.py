"""
Authentication Pydantic schemas.
"""
from pydantic import BaseModel, EmailStr


class Token(BaseModel):
    """Schema for JWT token response."""
    access_token: str
    refresh_token: str
    token_type: str = "bearer"


class TokenData(BaseModel):
    """Schema for token payload data."""
    user_id: str | None = None


class UserRegister(BaseModel):
    """Schema for user registration."""
    email: EmailStr
    password: str


class UserLogin(BaseModel):
    """Schema for user login."""
    email: EmailStr
    password: str


class ForgotPasswordRequest(BaseModel):
    """Schema for forgot password request."""
    email: EmailStr


class RefreshTokenRequest(BaseModel):
    """Schema for refresh token request."""
    refresh_token: str

