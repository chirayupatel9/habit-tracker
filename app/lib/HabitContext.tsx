'use client';

import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { Habit } from '../data/habits';
import { habits as initialHabits } from '../data/habits';
import { toggleHabitCompletion, generateId } from './utils';

type HabitContextType = {
  habits: Habit[];
  addHabit: (habit: Omit<Habit, 'id' | 'completedDates' | 'streakCount' | 'createdAt'>) => void;
  deleteHabit: (id: string) => void;
  toggleCompletion: (id: string) => void;
  toggleFavorite: (id: string) => void;
  getHabit: (id: string) => Habit | undefined;
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
    setHabits(
      habits.map(habit =>
        habit.id === id ? toggleHabitCompletion(habit) : habit
      )
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