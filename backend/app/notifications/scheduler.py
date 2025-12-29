"""
Notification scheduler using APScheduler.
"""
from apscheduler.schedulers.asyncio import AsyncIOScheduler
from apscheduler.triggers.cron import CronTrigger
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app.database import AsyncSessionLocal
from app.users.models import User
from app.notifications.service import (
    send_daily_reminder,
    send_weekly_summary,
    send_monthly_summary
)


scheduler = AsyncIOScheduler()


async def schedule_daily_reminders():
    """
    Schedule daily reminder notifications for all users.
    Runs every day at 9:00 AM.
    """
    async with AsyncSessionLocal() as db:
        # Get all users
        result = await db.execute(select(User))
        users = result.scalars().all()
        
        for user in users:
            try:
                await send_daily_reminder(db, str(user.id))
            except Exception as e:
                print(f"Error sending daily reminder to user {user.id}: {e}")


async def schedule_weekly_summaries():
    """
    Schedule weekly summary notifications for all users.
    Runs every Sunday at 9:00 AM.
    """
    async with AsyncSessionLocal() as db:
        # Get all users
        result = await db.execute(select(User))
        users = result.scalars().all()
        
        for user in users:
            try:
                await send_weekly_summary(db, str(user.id))
            except Exception as e:
                print(f"Error sending weekly summary to user {user.id}: {e}")


async def schedule_monthly_summaries():
    """
    Schedule monthly summary notifications for all users.
    Runs on the 1st of every month at 9:00 AM.
    """
    async with AsyncSessionLocal() as db:
        # Get all users
        result = await db.execute(select(User))
        users = result.scalars().all()
        
        for user in users:
            try:
                await send_monthly_summary(db, str(user.id))
            except Exception as e:
                print(f"Error sending monthly summary to user {user.id}: {e}")


def start_scheduler():
    """
    Start the notification scheduler.
    Schedules:
    - Daily reminders: Every day at 9:00 AM
    - Weekly summaries: Every Sunday at 9:00 AM
    - Monthly summaries: 1st of every month at 9:00 AM
    """
    # Daily reminder at 9:00 AM every day
    scheduler.add_job(
        schedule_daily_reminders,
        trigger=CronTrigger(hour=9, minute=0),
        id="daily_reminder",
        name="Daily Reminder",
        replace_existing=True
    )
    
    # Weekly summary every Sunday at 9:00 AM
    scheduler.add_job(
        schedule_weekly_summaries,
        trigger=CronTrigger(day_of_week=6, hour=9, minute=0),  # Sunday = 6
        id="weekly_summary",
        name="Weekly Summary",
        replace_existing=True
    )
    
    # Monthly summary on 1st of every month at 9:00 AM
    scheduler.add_job(
        schedule_monthly_summaries,
        trigger=CronTrigger(day=1, hour=9, minute=0),
        id="monthly_summary",
        name="Monthly Summary",
        replace_existing=True
    )
    
    scheduler.start()
    print("Notification scheduler started")


def stop_scheduler():
    """Stop the notification scheduler."""
    scheduler.shutdown()
    print("Notification scheduler stopped")

