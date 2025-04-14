'use client';

import { useState } from 'react';
import { CheckCircle, RadioButtonUnchecked, Delete, AccessTime, Loyalty, Star, StarBorder } from '../components/icons';
import { formatReminderTime, isHabitCompletedToday, formatDate } from '../lib/utils';
import { useHabits } from '../lib/HabitContext';
import { Habit } from '../data/habits';

interface HabitItemProps {
  habit: Habit;
  isDragging?: boolean;
  isCompleted?: boolean;
}

export default function HabitItem({
  habit,
  isDragging,
  isCompleted: propCompleted,
}: HabitItemProps) {
  const { toggleCompletion, deleteHabit, toggleFavorite } = useHabits();
  const [confirmDelete, setConfirmDelete] = useState(false);
  
  // Create today's date string in consistent format
  const today = new Date();
  const formattedToday = 
    `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`;
  
  // Use the prop value if provided, otherwise calculate it
  const isCompletedToday = propCompleted !== undefined 
    ? propCompleted 
    : habit.completedDates.includes(formattedToday);

  const handleDelete = (e: React.MouseEvent) => {
    // Prevent event from bubbling up to the draggable parent
    e.stopPropagation();
    
    if (confirmDelete) {
      deleteHabit(habit.id);
    } else {
      setConfirmDelete(true);
      setTimeout(() => setConfirmDelete(false), 3000);
    }
  };

  const handleToggle = (e: React.MouseEvent) => {
    // Prevent event from bubbling up to the draggable parent
    e.stopPropagation();
    toggleCompletion(habit.id);
  };

  const handleFavorite = (e: React.MouseEvent) => {
    // Prevent event from bubbling up to the draggable parent
    e.stopPropagation();
    toggleFavorite(habit.id);
  };

  return (
    <div className="material-card p-4 relative">
      <div className="flex justify-between items-center">
        <div className="flex items-center gap-2">
          <h3 className="text-lg font-medium">{habit.name}</h3>
          {habit.favorite && (
            <Star className="text-amber-400 text-lg" />
          )}
        </div>
        
        <div className="flex gap-2">
          <button
            onClick={handleFavorite}
            className="p-1 rounded hover:bg-gray-100"
            aria-label={habit.favorite ? "Remove from favorites" : "Add to favorites"}
          >
            {habit.favorite ? (
              <Star className="text-amber-400" fontSize="small" />
            ) : (
              <StarBorder className="text-gray-400" fontSize="small" />
            )}
          </button>
          
          <button
            onClick={handleDelete}
            className="p-1 rounded hover:bg-gray-100"
            aria-label="Delete habit"
          >
            <Delete className="text-gray-400" fontSize="small" />
          </button>
        </div>
      </div>
      
      {habit.description && (
        <p className="text-neutral-600 text-sm mt-2">{habit.description}</p>
      )}
      
      <div className="flex items-center mt-3">
        <button
          onClick={handleToggle}
          className="mr-3"
          aria-label={isCompletedToday ? "Mark as incomplete" : "Mark as complete"}
        >
          {isCompletedToday ? (
            <CheckCircle className="text-green-500 text-2xl" />
          ) : (
            <RadioButtonUnchecked className="text-gray-400 text-2xl" />
          )}
        </button>
        
        <div className="flex flex-wrap gap-2">
          <span className="inline-flex items-center px-2 py-1 bg-gray-100 text-gray-700 text-xs rounded-full">
            <AccessTime fontSize="small" className="mr-1" />
            {formatReminderTime(habit.reminderTime)}
          </span>
          
          {habit.streakCount > 0 && (
            <span className="inline-flex items-center px-2 py-1 bg-amber-100 text-amber-700 text-xs rounded-full">
              <Loyalty fontSize="small" className="mr-1" />
              {habit.streakCount} day streak
            </span>
          )}
          
          <span className="inline-flex items-center px-2 py-1 text-xs rounded-full 
            bg-blue-100 text-blue-700">
            {habit.frequency}
          </span>
        </div>
      </div>
      
      {habit.completedDates.length > 0 && (
        <div className="mt-3 text-gray-500 text-xs">
          Last completed: {formatDate(new Date(habit.completedDates[habit.completedDates.length - 1]))}
        </div>
      )}
    </div>
  );
} 