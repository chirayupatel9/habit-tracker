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
  const { habits, toggleCompletion, deleteHabit, setCompletionStatus } = useHabits();
  const [recentlyMoved, setRecentlyMoved] = useState<string | null>(null);
  const [showAnimation, setShowAnimation] = useState<boolean>(false);

  // Split habits into pending and completed for performance
  const pendingHabits = useMemo(() => {
    // Format today's date consistently to match with what's in completedDates
    const today = new Date();
    const formattedToday = 
      `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`;
    
    return habits.filter(habit => !habit.completedDates.includes(formattedToday));
  }, [habits]);
  
  const completedHabits = useMemo(() => {
    // Format today's date consistently to match with what's in completedDates
    const today = new Date();
    const formattedToday = 
      `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`;
    
    return habits.filter(habit => habit.completedDates.includes(formattedToday));
  }, [habits]);

  // Force re-render when a habit is moved
  useEffect(() => {
    if (recentlyMoved) {
      // Use a shorter timeout for visual feedback that doesn't delay the actual UI update
      const timer = setTimeout(() => {
        setRecentlyMoved(null);
      }, 500);
      return () => clearTimeout(timer);
    }
  }, [recentlyMoved]);

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
    
    // Log the drag operation for debugging
    console.log(`Dragging habit ID ${habitId} from ${source.droppableId} to ${destination.droppableId}`);
    
    // If moving between columns, explicitly set completion status using the new direct method
    if (destination.droppableId !== source.droppableId) {
      if (destination.droppableId === 'completed') {
        // Use the direct completion function instead of toggle
        setCompletionStatus(habitId, true);
        console.log(`Directly setting habit ${habitId} as COMPLETED`);
      } 
      else if (destination.droppableId === 'pending') {
        // Use the direct completion function instead of toggle
        setCompletionStatus(habitId, false);
        console.log(`Directly setting habit ${habitId} as PENDING`);
      }
      
      // Force immediate UI update by setting recentlyMoved
      setRecentlyMoved(habitId);
    }
  }, [habits, setCompletionStatus]);

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