"""
Alembic environment configuration for async migrations.
"""
from logging.config import fileConfig
from sqlalchemy import pool
from sqlalchemy.engine import Connection
from sqlalchemy.ext.asyncio import async_engine_from_config
from alembic import context
import asyncio

# Import all models for autogenerate
from app.database import Base
from app.users.models import User
from app.tasks.models import Task
from app.entries.models import DailyEntry, TaskCompletion
from app.feedback.models import Feedback

# Import config
from app.config import settings

# this is the Alembic Config object
config = context.config

# Override sqlalchemy.url with our settings
# Keep the async URL format for async_engine_from_config
config.set_main_option("sqlalchemy.url", settings.DATABASE_URL)

# Interpret the config file for Python logging.
if config.config_file_name is not None:
    fileConfig(config.config_file_name)

# Set target metadata for autogenerate
target_metadata = Base.metadata


def run_migrations_offline() -> None:
    """Run migrations in 'offline' mode."""
    url = config.get_main_option("sqlalchemy.url")
    # For offline mode, convert async URL to sync URL
    if url and "+aiomysql" in url:
        url = url.replace("+aiomysql", "")
    context.configure(
        url=url,
        target_metadata=target_metadata,
        literal_binds=True,
        dialect_opts={"paramstyle": "named"},
    )

    with context.begin_transaction():
        context.run_migrations()


def do_run_migrations(connection: Connection) -> None:
    """Run migrations with connection."""
    context.configure(connection=connection, target_metadata=target_metadata)

    with context.begin_transaction():
        context.run_migrations()


async def run_async_migrations() -> None:
    """Run migrations in async mode."""
    # Get the database URL from settings (keep async format)
    database_url = settings.DATABASE_URL
    
    # Create async engine directly with the URL
    from sqlalchemy.ext.asyncio import create_async_engine
    try:
        connectable = create_async_engine(
            database_url,
            poolclass=pool.NullPool,
        )

        async with connectable.connect() as connection:
            await connection.run_sync(do_run_migrations)

        await connectable.dispose()
    except Exception as e:
        print(f"\n❌ Database connection failed!")
        print(f"   URL: {database_url.split('@')[-1] if '@' in database_url else database_url}")
        print(f"   Error: {str(e)}")
        print(f"\n💡 Make sure:")
        print(f"   1. MySQL is running")
        print(f"   2. DATABASE_URL in .env file is correct")
        print(f"   3. Database server is accessible")
        print(f"   4. Database 'habit_tracker' exists (or create it)")
        raise


def run_migrations_online() -> None:
    """Run migrations in 'online' mode."""
    asyncio.run(run_async_migrations())


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()

