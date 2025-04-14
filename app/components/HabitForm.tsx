'use client';

import { useState } from 'react';
import { useHabits } from '../lib/HabitContext';
import { Habit } from '../types';
import { useAuth } from '../lib/AuthContext';
import { Close } from './icons';

interface HabitFormProps {
  onClose: () => void;
  editHabit?: Habit;
}

export default function HabitForm({ onClose, editHabit }: HabitFormProps) {
  const { addHabit, updateHabit } = useHabits();
  const { user } = useAuth();
  const [name, setName] = useState(editHabit?.name || '');
  const [description, setDescription] = useState(editHabit?.description || '');
  const [reminderTime, setReminderTime] = useState(editHabit?.reminderTime || '');
  const [error, setError] = useState('');

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

    if (!name.trim()) {
      setError('Habit name is required');
      return;
    }

    const habitData: Omit<Habit, 'id'> = {
      name: name.trim(),
      description: description.trim(),
      reminderTime,
      completedDates: editHabit?.completedDates || [],
      streak: editHabit?.streak || 0,
      createdAt: editHabit?.createdAt || new Date().toISOString().split('T')[0],
      userId: user?.id || 'guest',
      favorite: editHabit?.favorite || false
    };

    if (editHabit) {
      updateHabit({ ...habitData, id: editHabit.id });
    } else {
      addHabit(habitData);
    }

    onClose();
  };

  return (
    <form onSubmit={handleSubmit} className="p-4 space-y-4">
      {error && (
        <div className="p-3 bg-red-50 text-red-700 rounded-md text-sm">
          {error}
        </div>
      )}
      
      <div className="space-y-2">
        <label htmlFor="name" className="block text-sm font-medium text-neutral-700">
          Habit Name
        </label>
        <input
          id="name"
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          className="block w-full p-2 border border-neutral-300 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500"
          placeholder="e.g., Morning Meditation"
        />
      </div>

      <div className="space-y-2">
        <label htmlFor="description" className="block text-sm font-medium text-neutral-700">
          Description (Optional)
        </label>
        <textarea
          id="description"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          rows={3}
          className="block w-full p-2 border border-neutral-300 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500"
          placeholder="What is this habit about?"
        />
      </div>

      <div className="space-y-2">
        <label htmlFor="reminderTime" className="block text-sm font-medium text-neutral-700">
          Reminder Time (Optional)
        </label>
        <input
          id="reminderTime"
          type="time"
          value={reminderTime}
          onChange={(e) => setReminderTime(e.target.value)}
          className="block w-full p-2 border border-neutral-300 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500"
        />
      </div>

      <div className="flex justify-end space-x-3 pt-2">
        <button
          type="button"
          onClick={onClose}
          className="btn-secondary"
        >
          Cancel
        </button>
        <button
          type="submit"
          className="btn-primary"
        >
          {editHabit ? 'Update Habit' : 'Create Habit'}
        </button>
      </div>
    </form>
  );
} 