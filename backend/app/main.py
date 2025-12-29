"""
FastAPI main application.
"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
from app.config import settings
from app.auth.router import router as auth_router
from app.tasks.router import router as tasks_router
from app.entries.router import router as entries_router
from app.feedback.router import router as feedback_router
from app.users.router import router as users_router
from app.notifications.scheduler import start_scheduler, stop_scheduler


@asynccontextmanager
async def lifespan(app: FastAPI):
    """
    Lifespan context manager for startup and shutdown events.
    Starts notification scheduler on startup and stops it on shutdown.
    """
    # Startup
    start_scheduler()
    yield
    # Shutdown
    stop_scheduler()


# Create FastAPI app
app = FastAPI(
    title="Habit Tracker API",
    description="Production-ready FastAPI backend for Habit Tracker App",
    version="1.0.0",
    lifespan=lifespan
)

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], #settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(auth_router)
app.include_router(tasks_router)
app.include_router(entries_router)
app.include_router(feedback_router)
app.include_router(users_router)


@app.get("/")
async def root():
    """Root endpoint."""
    return {
        "message": "Habit Tracker API",
        "version": "1.0.0",
        "docs": "/docs"
    }


@app.get("/health")
async def health_check():
    """Health check endpoint."""
    return {"status": "healthy"}

