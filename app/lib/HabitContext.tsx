'use client';

import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { Habit } from '../data/habits';
import { habits as initialHabits } from '../data/habits';
import { toggleHabitCompletion, generateId, calculateStreak } from './utils';

type HabitContextType = {
  habits: Habit[];
  addHabit: (habit: Omit<Habit, 'id' | 'completedDates' | 'streakCount' | 'createdAt'>) => void;
  deleteHabit: (id: string) => void;
  toggleCompletion: (id: string) => void;
  toggleFavorite: (id: string) => void;
  getHabit: (id: string) => Habit | undefined;
  setCompletionStatus: (id: string, isCompleted: boolean) => void;
};

const HabitContext = createContext<HabitContextType | undefined>(undefined);

export function HabitProvider({ children }: { children: ReactNode }) {
  const [habits, setHabits] = useState<Habit[]>([]);

  // Load habits from local storage or use initial data
  useEffect(() => {
    const storedHabits = localStorage.getItem('habits');
    if (storedHabits) {
      setHabits(JSON.parse(storedHabits));
    } else {
      setHabits(initialHabits);
    }
  }, []);

  // Save habits to local storage when they change
  useEffect(() => {
    if (habits.length > 0) {
      localStorage.setItem('habits', JSON.stringify(habits));
    }
  }, [habits]);

  // Add a new habit
  const addHabit = (habitData: Omit<Habit, 'id' | 'completedDates' | 'streakCount' | 'createdAt'>) => {
    const newHabit: Habit = {
      ...habitData,
      id: generateId(),
      completedDates: [],
      streakCount: 0,
      createdAt: new Date().toISOString().split('T')[0],
      favorite: habitData.favorite || false,
    };
    setHabits([...habits, newHabit]);
  };

  // Delete a habit
  const deleteHabit = (id: string) => {
    setHabits(habits.filter(habit => habit.id !== id));
  };

  // Toggle a habit's completion status
  const toggleCompletion = (id: string) => {
    // Log before update
    const habitBeforeUpdate = habits.find(h => h.id === id);
    console.log(`Before toggle - Habit ${id}:`, habitBeforeUpdate?.completedDates);
    
    setHabits(
      habits.map(habit =>
        habit.id === id ? toggleHabitCompletion(habit) : habit
      )
    );
    
    // Log after update (this won't actually show the updated state due to how React state works)
    setTimeout(() => {
      const habitAfterUpdate = habits.find(h => h.id === id);
      console.log(`After toggle - Habit ${id}:`, habitAfterUpdate?.completedDates);
    }, 0);
  };

  // Directly set completion status
  const setCompletionStatus = (id: string, isCompleted: boolean) => {
    // Format today's date consistently
    const today = new Date();
    const formattedToday = 
      `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`;
    
    console.log(`Setting completion status - Habit ${id} to ${isCompleted ? 'completed' : 'pending'}`);
    
    setHabits(
      habits.map(habit => {
        if (habit.id !== id) return habit;
        
        if (isCompleted) {
          // Mark as completed - add today's date if not already there
          if (!habit.completedDates.includes(formattedToday)) {
            const updatedDates = [...habit.completedDates, formattedToday];
            console.log(`Adding today (${formattedToday}) to completedDates:`, updatedDates);
            return {
              ...habit,
              completedDates: updatedDates,
              streakCount: calculateStreak({ ...habit, completedDates: updatedDates }),
            };
          }
          return habit;
        } else {
          // Mark as pending - remove today's date if it's there
          if (habit.completedDates.includes(formattedToday)) {
            const updatedDates = habit.completedDates.filter(date => date !== formattedToday);
            console.log(`Removing today (${formattedToday}) from completedDates:`, updatedDates);
            return {
              ...habit,
              completedDates: updatedDates,
              streakCount: calculateStreak({ ...habit, completedDates: updatedDates }),
            };
          }
          return habit;
        }
      })
    );
  };

  // Toggle a habit's favorite status
  const toggleFavorite = (id: string) => {
    setHabits(
      habits.map(habit =>
        habit.id === id ? { ...habit, favorite: !habit.favorite } : habit
      )
    );
  };

  // Get a habit by ID
  const getHabit = (id: string) => {
    return habits.find(habit => habit.id === id);
  };

  return (
    <HabitContext.Provider
      value={{
        habits,
        addHabit,
        deleteHabit,
        toggleCompletion,
        toggleFavorite,
        getHabit,
        setCompletionStatus,
      }}
    >
      {children}
    </HabitContext.Provider>
  );
}

// Custom hook to use the habit context
export function useHabits() {
  const context = useContext(HabitContext);
  if (context === undefined) {
    throw new Error('useHabits must be used within a HabitProvider');
  }
  return context;
} 