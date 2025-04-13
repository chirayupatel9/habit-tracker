'use client';

import React, { useState, useEffect, useMemo, memo, useCallback } from 'react';
import { DragDropContext, Droppable, Draggable, DropResult, DroppableProvided, DraggableProvided, DraggableStateSnapshot, DroppableStateSnapshot, DroppableProps } from 'react-beautiful-dnd';
import { useHabits } from '../lib/HabitContext';
import HabitItem from './HabitItem';
import { Habit } from '../data/habits';

// StrictModeDroppable component for React 18 compatibility
const StrictModeDroppable = ({ children, ...props }: DroppableProps) => {
  const [enabled, setEnabled] = useState(false);
  
  useEffect(() => {
    // This is needed for react-beautiful-dnd to work in strict mode
    const animation = requestAnimationFrame(() => setEnabled(true));
    
    return () => {
      cancelAnimationFrame(animation);
      setEnabled(false);
    };
  }, []);
  
  if (!enabled) {
    return null;
  }
  
  return <Droppable {...props}>{children}</Droppable>;
};

// Memoized HabitItem to prevent unnecessary re-renders
const MemoizedHabitItem = memo(({ habit, isDragging, isCompleted }: {
  habit: Habit;
  isDragging: boolean;
  isCompleted?: boolean;
}) => (
  <HabitItem
    habit={habit}
    isDragging={isDragging}
    isCompleted={isCompleted}
  />
));

// Add display name for debugging purposes
MemoizedHabitItem.displayName = 'MemoizedHabitItem';

const DraggableHabitBoard = () => {
  const { habits, toggleCompletion, deleteHabit } = useHabits();
  const [recentlyMoved, setRecentlyMoved] = useState<string | null>(null);
  const [showAnimation, setShowAnimation] = useState<boolean>(false);

  // Split habits into pending and completed for performance
  const pendingHabits = useMemo(() => 
    habits.filter(habit => !isHabitCompletedToday(habit)),
    [habits]
  );
  
  const completedHabits = useMemo(() => 
    habits.filter(habit => isHabitCompletedToday(habit)),
    [habits]
  );

  // Helper function to check if a habit is completed today
  function isHabitCompletedToday(habit: Habit): boolean {
    const today = new Date().toISOString().split('T')[0]; // "YYYY-MM-DD" format
    return habit.completedDates.includes(today);
  }

  useEffect(() => {
    // Trigger animation on mount
    setShowAnimation(true);
    
    // Cleanup function
    return () => {
      setShowAnimation(false);
    };
  }, []);
  
  const handleDragStart = useCallback(() => {
    // Optional - can add code here if needed for drag start effects
    document.body.classList.add('is-dragging');
  }, []);

  const handleDragEnd = useCallback((result: DropResult) => {
    document.body.classList.remove('is-dragging');
    
    const { destination, source, draggableId } = result;

    // If there's no destination or the item is dropped back in the same place, do nothing
    if (!destination || 
        (destination.droppableId === source.droppableId && 
         destination.index === source.index)) {
      return;
    }

    // Get the habit being dragged
    const habitId = draggableId;

    // If moving between columns, toggle the completion status
    if (destination.droppableId !== source.droppableId) {
      toggleCompletion(habitId);
      setRecentlyMoved(habitId);
      
      // Clear the recently moved flag after a delay
      setTimeout(() => {
        setRecentlyMoved(null);
      }, 800);
    }
  }, [toggleCompletion]);

  // Render functions to minimize work during drag operations
  const renderPendingList = useCallback(() => (
    pendingHabits.map((habit, index) => (
      <Draggable key={habit.id} draggableId={habit.id} index={index}>
        {(provided: DraggableProvided, snapshot: DraggableStateSnapshot) => (
          <div
            ref={provided.innerRef}
            {...provided.draggableProps}
            {...provided.dragHandleProps}
            style={{
              ...provided.draggableProps.style,
              margin: '0 0 12px 0',
            }}
            className={`draggable-board-item ${
              snapshot.isDragging ? 'dragging-item' : ''
            } ${recentlyMoved === habit.id ? 'recently-moved' : ''}`}
          >
            <MemoizedHabitItem
              habit={habit}
              isDragging={snapshot.isDragging}
            />
          </div>
        )}
      </Draggable>
    ))
  ), [pendingHabits, recentlyMoved]);

  const renderCompletedList = useCallback(() => (
    completedHabits.map((habit, index) => (
      <Draggable key={habit.id} draggableId={habit.id} index={index}>
        {(provided: DraggableProvided, snapshot: DraggableStateSnapshot) => (
          <div
            ref={provided.innerRef}
            {...provided.draggableProps}
            {...provided.dragHandleProps}
            style={{
              ...provided.draggableProps.style,
              margin: '0 0 12px 0',
            }}
            className={`draggable-board-item ${
              snapshot.isDragging ? 'dragging-item' : ''
            } ${recentlyMoved === habit.id ? 'recently-moved' : ''}`}
          >
            <MemoizedHabitItem
              habit={habit}
              isDragging={snapshot.isDragging}
              isCompleted={true}
            />
          </div>
        )}
      </Draggable>
    ))
  ), [completedHabits, recentlyMoved]);

  return (
    <DragDropContext onDragStart={handleDragStart} onDragEnd={handleDragEnd}>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6">
        <div className="board-column">
          <div className="column-header">
            <h2 className="text-xl font-medium text-neutral-800">Pending Tasks</h2>
            <span className="text-sm px-2 py-1 bg-primary-100 text-primary-700 rounded-full">
              {pendingHabits.length}
            </span>
          </div>
          
          <StrictModeDroppable droppableId="pending">
            {(provided: DroppableProvided, snapshot: DroppableStateSnapshot) => (
              <div
                ref={provided.innerRef}
                {...provided.droppableProps}
                className={`column-content ${snapshot.isDraggingOver ? 'dragging-over' : ''}`}
              >
                {pendingHabits.length === 0 ? (
                  <div className="empty-column-message">
                    <p>No pending tasks</p>
                  </div>
                ) : renderPendingList()}
                {provided.placeholder}
              </div>
            )}
          </StrictModeDroppable>
        </div>

        <div className="board-column">
          <div className="column-header">
            <h2 className="text-xl font-medium text-neutral-800">Completed Tasks</h2>
            <span className="text-sm px-2 py-1 bg-green-100 text-green-700 rounded-full">
              {completedHabits.length}
            </span>
          </div>
          
          <StrictModeDroppable droppableId="completed">
            {(provided: DroppableProvided, snapshot: DroppableStateSnapshot) => (
              <div
                ref={provided.innerRef}
                {...provided.droppableProps}
                className={`column-content ${snapshot.isDraggingOver ? 'dragging-over' : ''}`}
              >
                {completedHabits.length === 0 ? (
                  <div className="empty-column-message">
                    <p>No completed tasks</p>
                  </div>
                ) : renderCompletedList()}
                {provided.placeholder}
              </div>
            )}
          </StrictModeDroppable>
        </div>
      </div>
    </DragDropContext>
  );
};

export default DraggableHabitBoard; 