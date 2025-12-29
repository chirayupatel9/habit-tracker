"""
Daily entry routes.
"""
from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func, and_, or_
from sqlalchemy.orm import selectinload
from uuid import UUID
from datetime import date, datetime, timedelta
from app.database import get_db
from app.deps import get_current_user
from app.users.models import User
from app.entries.models import DailyEntry, TaskCompletion
from app.entries.schemas import (
    DailyEntryCreate,
    DailyEntryUpdate,
    DailyEntryResponse,
    MonthlyAggregationResponse,
    YearlyTrackingResponse,
    DashboardSummaryResponse
)
from app.tasks.models import Task

router = APIRouter(prefix="/entries", tags=["daily-entries"])


@router.post("", response_model=DailyEntryResponse, status_code=status.HTTP_201_CREATED)
async def create_entry(
    entry_data: DailyEntryCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Create a new daily entry.
    
    Enforces one entry per date per user.
    
    Returns:
        DailyEntryResponse: Created entry data
    """
    # Check if entry already exists for this date
    result = await db.execute(
        select(DailyEntry).where(
            DailyEntry.user_id == current_user.id,
            DailyEntry.date == entry_data.date
        )
    )
    existing_entry = result.scalar_one_or_none()
    
    if existing_entry:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Entry already exists for this date"
        )
    
    # Create entry
    new_entry = DailyEntry(
        user_id=current_user.id,
        date=entry_data.date,
        moment_of_day=entry_data.moment_of_day,
        sleep_hours=entry_data.sleep_hours,
        daily_note=entry_data.daily_note
    )
    
    db.add(new_entry)
    await db.flush()  # Flush to get entry.id
    
    # Create task completions
    if entry_data.task_completions:
        for completion_data in entry_data.task_completions:
            # Verify task belongs to user
            task_result = await db.execute(
                select(Task).where(
                    Task.id == completion_data.task_id,
                    Task.user_id == current_user.id
                )
            )
            task = task_result.scalar_one_or_none()
            
            if not task:
                raise HTTPException(
                    status_code=status.HTTP_404_NOT_FOUND,
                    detail=f"Task {completion_data.task_id} not found"
                )
            
            completion = TaskCompletion(
                entry_id=new_entry.id,
                task_id=completion_data.task_id,
                completed=completion_data.completed,
                feedback=completion_data.feedback
            )
            db.add(completion)
    
    await db.commit()
    await db.refresh(new_entry)
    
    # Load relationships
    result = await db.execute(
        select(DailyEntry)
        .options(selectinload(DailyEntry.task_completions))
        .where(DailyEntry.id == new_entry.id)
    )
    entry = result.scalar_one()
    
    return entry


@router.get("", response_model=List[DailyEntryResponse])
async def get_entries(
    skip: int = 0,
    limit: int = 100,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Get all daily entries for the current user with pagination.
    
    Returns:
        List[DailyEntryResponse]: List of user's entries
    """
    result = await db.execute(
        select(DailyEntry)
        .options(selectinload(DailyEntry.task_completions))
        .where(DailyEntry.user_id == current_user.id)
        .order_by(DailyEntry.date.desc())
        .offset(skip)
        .limit(limit)
    )
    entries = result.scalars().all()
    return list(entries)


@router.get("/{entry_id}", response_model=DailyEntryResponse)
async def get_entry(
    entry_id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Get a specific entry by ID.
    
    Args:
        entry_id: UUID of the entry
        
    Returns:
        DailyEntryResponse: Entry data
        
    Raises:
        HTTPException: If entry not found or doesn't belong to user
    """
    result = await db.execute(
        select(DailyEntry)
        .options(selectinload(DailyEntry.task_completions))
        .where(DailyEntry.id == entry_id, DailyEntry.user_id == current_user.id)
    )
    entry = result.scalar_one_or_none()
    
    if not entry:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Entry not found"
        )
    
    return entry


@router.patch("/{entry_id}", response_model=DailyEntryResponse)
async def update_entry(
    entry_id: UUID,
    entry_update: DailyEntryUpdate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Update a daily entry.
    
    Args:
        entry_id: UUID of the entry
        entry_update: Entry update data
        
    Returns:
        DailyEntryResponse: Updated entry data
        
    Raises:
        HTTPException: If entry not found or doesn't belong to user
    """
    result = await db.execute(
        select(DailyEntry)
        .options(selectinload(DailyEntry.task_completions))
        .where(DailyEntry.id == entry_id, DailyEntry.user_id == current_user.id)
    )
    entry = result.scalar_one_or_none()
    
    if not entry:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Entry not found"
        )
    
    # Update fields
    if entry_update.moment_of_day is not None:
        entry.moment_of_day = entry_update.moment_of_day
    if entry_update.sleep_hours is not None:
        entry.sleep_hours = entry_update.sleep_hours
    if entry_update.daily_note is not None:
        entry.daily_note = entry_update.daily_note
    
    # Update task completions if provided
    if entry_update.task_completions is not None:
        # Delete existing completions
        result_completions = await db.execute(
            select(TaskCompletion).where(TaskCompletion.entry_id == entry.id)
        )
        existing_completions = result_completions.scalars().all()
        for completion in existing_completions:
            await db.delete(completion)
        
        # Create new completions
        for completion_data in entry_update.task_completions:
            # Verify task belongs to user
            task_result = await db.execute(
                select(Task).where(
                    Task.id == completion_data.task_id,
                    Task.user_id == current_user.id
                )
            )
            task = task_result.scalar_one_or_none()
            
            if not task:
                raise HTTPException(
                    status_code=status.HTTP_404_NOT_FOUND,
                    detail=f"Task {completion_data.task_id} not found"
                )
            
            completion = TaskCompletion(
                entry_id=entry.id,
                task_id=completion_data.task_id,
                completed=completion_data.completed,
                feedback=completion_data.feedback
            )
            db.add(completion)
    
    await db.commit()
    await db.refresh(entry)
    
    # Reload with relationships
    result = await db.execute(
        select(DailyEntry)
        .options(selectinload(DailyEntry.task_completions))
        .where(DailyEntry.id == entry.id)
    )
    updated_entry = result.scalar_one()
    
    return updated_entry


@router.delete("/{entry_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_entry(
    entry_id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Delete a daily entry.
    
    Args:
        entry_id: UUID of the entry
        
    Raises:
        HTTPException: If entry not found or doesn't belong to user
    """
    result = await db.execute(
        select(DailyEntry).where(
            DailyEntry.id == entry_id,
            DailyEntry.user_id == current_user.id
        )
    )
    entry = result.scalar_one_or_none()
    
    if not entry:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Entry not found"
        )
    
    await db.delete(entry)
    await db.commit()


@router.get("/monthly/{year}/{month}", response_model=List[MonthlyAggregationResponse])
async def get_monthly_aggregation(
    year: int,
    month: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Get all daily entries for a given month with aggregation data.
    
    Args:
        year: Year (e.g., 2024)
        month: Month (1-12)
        
    Returns:
        List[MonthlyAggregationResponse]: Monthly entries with aggregation
    """
    # Validate month
    if not (1 <= month <= 12):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Month must be between 1 and 12"
        )
    
    # Get start and end dates for the month
    start_date = date(year, month, 1)
    if month == 12:
        end_date = date(year + 1, 1, 1) - timedelta(days=1)
    else:
        end_date = date(year, month + 1, 1) - timedelta(days=1)
    
    # Get all entries for the month
    result = await db.execute(
        select(DailyEntry)
        .options(selectinload(DailyEntry.task_completions))
        .where(
            DailyEntry.user_id == current_user.id,
            DailyEntry.date >= start_date,
            DailyEntry.date <= end_date
        )
        .order_by(DailyEntry.date)
    )
    entries = result.scalars().all()
    
    # Calculate average sleep for the month
    sleep_sum = sum(entry.sleep_hours for entry in entries)
    avg_sleep = sleep_sum / len(entries) if entries else None
    
    # Get all active tasks for the user
    tasks_result = await db.execute(
        select(Task).where(Task.user_id == current_user.id, Task.is_active == True)
    )
    tasks = {task.id: task.name for task in tasks_result.scalars().all()}
    
    # Build response
    response = []
    for entry in entries:
        # Count task completions
        completion_counts = {}
        for completion in entry.task_completions:
            if completion.completed:
                task_name = tasks.get(completion.task_id, "Unknown")
                completion_counts[task_name] = completion_counts.get(task_name, 0) + 1
        
        response.append(MonthlyAggregationResponse(
            date=entry.date,
            moment_of_day=entry.moment_of_day,
            sleep_hours=entry.sleep_hours,
            daily_note=entry.daily_note,
            task_completion_counts=completion_counts,
            average_sleep=avg_sleep
        ))
    
    return response


@router.get("/yearly/{year}", response_model=List[YearlyTrackingResponse])
async def get_yearly_tracking(
    year: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Get tracking status for all dates in a year.
    
    Args:
        year: Year (e.g., 2024)
        
    Returns:
        List[YearlyTrackingResponse]: All dates in year with tracked status
    """
    # Get start and end dates for the year
    start_date = date(year, 1, 1)
    end_date = date(year, 12, 31)
    
    # Get all entries for the year
    result = await db.execute(
        select(DailyEntry.date).where(
            DailyEntry.user_id == current_user.id,
            DailyEntry.date >= start_date,
            DailyEntry.date <= end_date
        )
    )
    tracked_dates = {row[0] for row in result.all()}
    
    # Generate all dates in the year
    response = []
    current_date = start_date
    while current_date <= end_date:
        response.append(YearlyTrackingResponse(
            date=current_date,
            tracked=current_date in tracked_dates
        ))
        current_date += timedelta(days=1)
    
    return response


@router.get("/dashboard/summary", response_model=DashboardSummaryResponse)
async def get_dashboard_summary(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Get dashboard summary with random past moment, sleep averages, and task consistency.
    
    Returns:
        DashboardSummaryResponse: Dashboard summary data
    """
    today = date.today()
    
    # Get random past moment
    result = await db.execute(
        select(DailyEntry.moment_of_day)
        .where(
            DailyEntry.user_id == current_user.id,
            DailyEntry.date < today
        )
        .order_by(func.rand())  # MySQL RAND() function
        .limit(1)
    )
    random_moment = result.scalar_one_or_none()
    
    # Calculate average sleep for last 7 days
    seven_days_ago = today - timedelta(days=7)
    result_7d = await db.execute(
        select(func.avg(DailyEntry.sleep_hours))
        .where(
            DailyEntry.user_id == current_user.id,
            DailyEntry.date >= seven_days_ago,
            DailyEntry.date < today
        )
    )
    avg_sleep_7d = result_7d.scalar_one_or_none()
    
    # Calculate average sleep for last 30 days
    thirty_days_ago = today - timedelta(days=30)
    result_30d = await db.execute(
        select(func.avg(DailyEntry.sleep_hours))
        .where(
            DailyEntry.user_id == current_user.id,
            DailyEntry.date >= thirty_days_ago,
            DailyEntry.date < today
        )
    )
    avg_sleep_30d = result_30d.scalar_one_or_none()
    
    # Calculate task consistency
    # Get all active tasks
    tasks_result = await db.execute(
        select(Task.id).where(Task.user_id == current_user.id, Task.is_active == True)
    )
    active_task_ids = {task_id for task_id in tasks_result.scalars().all()}
    
    if not active_task_ids:
        consistency = 0.0
    else:
        # Get all entries with their completions
        entries_result = await db.execute(
            select(DailyEntry)
            .options(selectinload(DailyEntry.task_completions))
            .where(DailyEntry.user_id == current_user.id)
        )
        entries = entries_result.scalars().all()
        
        total_days = len(entries)
        if total_days == 0:
            consistency = 0.0
        else:
            perfect_days = 0
            for entry in entries:
                # Get completions for this entry
                entry_completions = {
                    tc.task_id: tc.completed
                    for tc in entry.task_completions
                    if tc.task_id in active_task_ids
                }
                
                # Check if all active tasks are completed
                if len(entry_completions) == len(active_task_ids):
                    if all(entry_completions.values()):
                        perfect_days += 1
            
            consistency = (perfect_days / total_days * 100) if total_days > 0 else 0.0
    
    return DashboardSummaryResponse(
        random_past_moment=random_moment,
        average_sleep_7_days=float(avg_sleep_7d) if avg_sleep_7d else None,
        average_sleep_30_days=float(avg_sleep_30d) if avg_sleep_30d else None,
        task_consistency_percentage=consistency
    )

