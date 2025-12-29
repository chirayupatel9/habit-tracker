"""
Notification service for FCM placeholders.
"""
from typing import Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from datetime import date, timedelta
from app.users.models import User
from app.entries.models import DailyEntry
from app.tasks.models import Task


async def send_daily_reminder(db: AsyncSession, user_id: str) -> None:
    """
    Send daily reminder notification (placeholder).
    
    In production, this would send an FCM push notification.
    Currently, it's a stub that would check if user has an entry for today.
    
    Args:
        db: Database session
        user_id: User UUID as string
    """
    from uuid import UUID
    today = date.today()
    
    # Check if user has entry for today
    user_uuid = UUID(user_id)
    result = await db.execute(
        select(DailyEntry).where(
            DailyEntry.user_id == user_uuid,
            DailyEntry.date == today
        )
    )
    entry = result.scalar_one_or_none()
    
    # In production: Send FCM notification if no entry exists
    # fcm_service.send_notification(
    #     user_id=user_id,
    #     title="Daily Reminder",
    #     body="Don't forget to log your habits today!"
    # )
    
    # Placeholder: Just log the action
    if not entry:
        print(f"[NOTIFICATION] Daily reminder sent to user {user_id}")


async def send_weekly_summary(db: AsyncSession, user_id: str) -> None:
    """
    Send weekly summary notification (placeholder).
    
    In production, this would send an FCM push notification with weekly stats.
    
    Args:
        db: Database session
        user_id: User UUID as string
    """
    from uuid import UUID
    today = date.today()
    week_start = today - timedelta(days=today.weekday())  # Monday of current week
    
    # Get entries for the past week
    user_uuid = UUID(user_id)
    result = await db.execute(
        select(DailyEntry).where(
            DailyEntry.user_id == user_uuid,
            DailyEntry.date >= week_start - timedelta(days=7),
            DailyEntry.date < week_start
        )
    )
    entries = result.scalars().all()
    
    # Calculate stats
    total_entries = len(entries)
    avg_sleep = sum(e.sleep_hours for e in entries) / total_entries if entries else 0
    
    # In production: Send FCM notification with summary
    # fcm_service.send_notification(
    #     user_id=user_id,
    #     title="Weekly Summary",
    #     body=f"You logged {total_entries} days last week. Average sleep: {avg_sleep:.1f} hours."
    # )
    
    # Placeholder: Just log the action
    print(f"[NOTIFICATION] Weekly summary sent to user {user_id}: {total_entries} entries, {avg_sleep:.1f}h avg sleep")


async def send_monthly_summary(db: AsyncSession, user_id: str) -> None:
    """
    Send monthly summary notification (placeholder).
    
    In production, this would send an FCM push notification with monthly stats.
    
    Args:
        db: Database session
        user_id: User UUID as string
    """
    from uuid import UUID
    today = date.today()
    # First day of previous month
    if today.month == 1:
        month_start = date(today.year - 1, 12, 1)
    else:
        month_start = date(today.year, today.month - 1, 1)
    
    # Last day of previous month
    if month_start.month == 12:
        month_end = date(month_start.year + 1, 1, 1) - timedelta(days=1)
    else:
        month_end = date(month_start.year, month_start.month + 1, 1) - timedelta(days=1)
    
    # Get entries for the previous month
    user_uuid = UUID(user_id)
    result = await db.execute(
        select(DailyEntry).where(
            DailyEntry.user_id == user_uuid,
            DailyEntry.date >= month_start,
            DailyEntry.date <= month_end
        )
    )
    entries = result.scalars().all()
    
    # Calculate stats
    total_entries = len(entries)
    avg_sleep = sum(e.sleep_hours for e in entries) / total_entries if entries else 0
    
    # In production: Send FCM notification with summary
    # fcm_service.send_notification(
    #     user_id=user_id,
    #     title="Monthly Summary",
    #     body=f"You logged {total_entries} days last month. Average sleep: {avg_sleep:.1f} hours."
    # )
    
    # Placeholder: Just log the action
    print(f"[NOTIFICATION] Monthly summary sent to user {user_id}: {total_entries} entries, {avg_sleep:.1f}h avg sleep")

