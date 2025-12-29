"""
Daily entry Pydantic schemas.
"""
from pydantic import BaseModel, Field
from uuid import UUID
from datetime import date, datetime
from typing import Optional, List


class TaskCompletionBase(BaseModel):
    """Base task completion schema."""
    task_id: UUID
    completed: bool = False
    feedback: Optional[str] = None


class TaskCompletionCreate(TaskCompletionBase):
    """Schema for creating a task completion."""
    pass


class TaskCompletionResponse(TaskCompletionBase):
    """Schema for task completion response."""
    entry_id: UUID
    
    class Config:
        from_attributes = True


class DailyEntryBase(BaseModel):
    """Base daily entry schema."""
    date: date
    moment_of_day: str = Field(..., description="Moment of the day description")
    sleep_hours: float = Field(..., ge=0, le=24, description="Sleep hours (0-24)")
    daily_note: Optional[str] = None


class DailyEntryCreate(DailyEntryBase):
    """Schema for creating a daily entry."""
    task_completions: List[TaskCompletionCreate] = []


class DailyEntryUpdate(BaseModel):
    """Schema for updating a daily entry."""
    moment_of_day: Optional[str] = None
    sleep_hours: Optional[float] = Field(None, ge=0, le=24)
    daily_note: Optional[str] = None
    task_completions: Optional[List[TaskCompletionCreate]] = None


class DailyEntryResponse(DailyEntryBase):
    """Schema for daily entry response."""
    id: UUID
    user_id: UUID
    created_at: datetime
    updated_at: datetime
    task_completions: List[TaskCompletionResponse] = []
    
    class Config:
        from_attributes = True


class MonthlyAggregationResponse(BaseModel):
    """Schema for monthly aggregation response."""
    date: date
    moment_of_day: Optional[str] = None
    sleep_hours: Optional[float] = None
    daily_note: Optional[str] = None
    task_completion_counts: dict[str, int] = Field(
        default_factory=dict,
        description="Task name -> completion count for the month"
    )
    average_sleep: Optional[float] = None


class YearlyTrackingResponse(BaseModel):
    """Schema for yearly tracking response."""
    date: date
    tracked: bool


class DashboardSummaryResponse(BaseModel):
    """Schema for dashboard summary response."""
    random_past_moment: Optional[str] = None
    average_sleep_7_days: Optional[float] = None
    average_sleep_30_days: Optional[float] = None
    task_consistency_percentage: float = Field(
        default=0.0,
        ge=0.0,
        le=100.0,
        description="Percentage of days where all tasks were completed"
    )

