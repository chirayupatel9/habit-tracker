"""
Authentication service for password hashing and JWT token generation.
"""
from datetime import datetime, timedelta
from typing import Optional
from jose import jwt
import bcrypt
from app.config import settings


def verify_password(plain_password: str, hashed_password: str) -> bool:
    """
    Verify a plain password against a hashed password.
    
    Args:
        plain_password: The plain text password
        hashed_password: The bcrypt hashed password
        
    Returns:
        True if password matches, False otherwise
    """
    try:
        # Convert password to bytes
        password_bytes = plain_password.encode('utf-8')
        
        # If password is longer than 72 bytes, hash it with SHA-256 first (same as in get_password_hash)
        if len(password_bytes) > 72:
            import hashlib
            password_bytes = hashlib.sha256(password_bytes).digest()
        
        # Decode the hashed password if it's a string
        if isinstance(hashed_password, str):
            hashed_password = hashed_password.encode('utf-8')
        
        return bcrypt.checkpw(password_bytes, hashed_password)
    except Exception:
        return False


def get_password_hash(password: str) -> str:
    """
    Hash a password using bcrypt.
    
    Bcrypt has a 72-byte limit, so we handle longer passwords by hashing them first.
    
    Args:
        password: The plain text password to hash
        
    Returns:
        Bcrypt hashed password as string
    """
    # Bcrypt has a 72-byte limit. For longer passwords, we can:
    # 1. Truncate (not recommended)
    # 2. Hash with SHA-256 first, then bcrypt (more secure)
    # 3. Use a different approach
    
    # Convert password to bytes
    password_bytes = password.encode('utf-8')
    
    # If password is longer than 72 bytes, hash it with SHA-256 first
    if len(password_bytes) > 72:
        import hashlib
        password_bytes = hashlib.sha256(password_bytes).digest()
    
    # Generate salt and hash
    salt = bcrypt.gensalt()
    hashed = bcrypt.hashpw(password_bytes, salt)
    
    # Return as string
    return hashed.decode('utf-8')


def create_access_token(data: dict, expires_delta: Optional[timedelta] = None) -> str:
    """
    Create a JWT access token.
    
    Args:
        data: Dictionary containing user data (typically user_id)
        expires_delta: Optional custom expiration time
        
    Returns:
        Encoded JWT token string
    """
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    
    to_encode.update({"exp": expire, "type": "access"})
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
    return encoded_jwt


def create_refresh_token(data: dict) -> str:
    """
    Create a JWT refresh token.
    
    Args:
        data: Dictionary containing user data (typically user_id)
        
    Returns:
        Encoded JWT refresh token string
    """
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS)
    to_encode.update({"exp": expire, "type": "refresh"})
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
    return encoded_jwt


def decode_token(token: str) -> dict:
    """
    Decode a JWT token.
    
    Args:
        token: JWT token string
        
    Returns:
        Decoded token payload
        
    Raises:
        JWTError: If token is invalid
    """
    return jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])

