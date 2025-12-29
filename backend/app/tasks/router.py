"""
Task routes.
"""
from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from uuid import UUID
from app.database import get_db
from app.deps import get_current_user
from app.users.models import User
from app.tasks.models import Task
from app.tasks.schemas import TaskCreate, TaskUpdate, TaskResponse

router = APIRouter(prefix="/tasks", tags=["tasks"])


@router.post("", response_model=TaskResponse, status_code=status.HTTP_201_CREATED)
async def create_task(
    task_data: TaskCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Create a new task for the current user.
    
    Returns:
        TaskResponse: Created task data
    """
    new_task = Task(
        user_id=current_user.id,
        name=task_data.name,
        is_active=task_data.is_active
    )
    
    db.add(new_task)
    await db.commit()
    await db.refresh(new_task)
    
    return new_task


@router.get("", response_model=List[TaskResponse])
async def get_tasks(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Get all tasks for the current user.
    
    Returns:
        List[TaskResponse]: List of user's tasks
    """
    result = await db.execute(
        select(Task).where(Task.user_id == current_user.id)
    )
    tasks = result.scalars().all()
    return list(tasks)


@router.get("/{task_id}", response_model=TaskResponse)
async def get_task(
    task_id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Get a specific task by ID.
    
    Args:
        task_id: UUID of the task
        
    Returns:
        TaskResponse: Task data
        
    Raises:
        HTTPException: If task not found or doesn't belong to user
    """
    result = await db.execute(
        select(Task).where(Task.id == task_id, Task.user_id == current_user.id)
    )
    task = result.scalar_one_or_none()
    
    if not task:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Task not found"
        )
    
    return task


@router.patch("/{task_id}", response_model=TaskResponse)
async def update_task(
    task_id: UUID,
    task_update: TaskUpdate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Update a task.
    
    Args:
        task_id: UUID of the task
        task_update: Task update data
        
    Returns:
        TaskResponse: Updated task data
        
    Raises:
        HTTPException: If task not found or doesn't belong to user
    """
    result = await db.execute(
        select(Task).where(Task.id == task_id, Task.user_id == current_user.id)
    )
    task = result.scalar_one_or_none()
    
    if not task:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Task not found"
        )
    
    # Update fields
    if task_update.name is not None:
        task.name = task_update.name
    if task_update.is_active is not None:
        task.is_active = task_update.is_active
    
    await db.commit()
    await db.refresh(task)
    
    return task


@router.delete("/{task_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_task(
    task_id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Delete a task.
    
    Args:
        task_id: UUID of the task
        
    Raises:
        HTTPException: If task not found or doesn't belong to user
    """
    result = await db.execute(
        select(Task).where(Task.id == task_id, Task.user_id == current_user.id)
    )
    task = result.scalar_one_or_none()
    
    if not task:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Task not found"
        )
    
    await db.delete(task)
    await db.commit()

