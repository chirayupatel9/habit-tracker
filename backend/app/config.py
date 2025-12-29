"""
Application configuration settings.
"""
from pydantic_settings import BaseSettings
from pydantic import field_validator
from typing import Optional, Union


class Settings(BaseSettings):
    """Application settings loaded from environment variables."""
    
    # Database
    DATABASE_URL: str = "mysql+aiomysql://root:password@localhost:3306/habit_tracker"
    
    # JWT
    SECRET_KEY: str = "your-secret-key-change-in-production"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    REFRESH_TOKEN_EXPIRE_DAYS: int = 7
    
    # CORS
    CORS_ORIGINS: list[str] = ["http://localhost:3000", "http://localhost:8000"]
    
    # Email (for forgot password stub)
    SMTP_HOST: Optional[str] = None
    SMTP_PORT: Optional[int] = None
    SMTP_USER: Optional[str] = None
    SMTP_PASSWORD: Optional[str] = None
    
    # Firebase (placeholder)
    FCM_SERVER_KEY: Optional[str] = None
    
    @field_validator('SMTP_PORT', mode='before')
    @classmethod
    def parse_smtp_port(cls, v: Union[str, int, None]) -> Optional[int]:
        """Convert empty string to None for SMTP_PORT."""
        if v == '' or v is None:
            return None
        if isinstance(v, str):
            return int(v) if v.strip() else None
        return v
    
    class Config:
        env_file = ".env"
        case_sensitive = True


settings = Settings()

