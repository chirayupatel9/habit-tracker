'use client';

import { useState } from 'react';
import { useHabits } from '../lib/HabitContext';
import { Add, Close, Schedule, Repeat, Star, StarBorder } from '../components/icons';

interface HabitFormProps {
  onClose: () => void;
}

export default function HabitForm({ onClose }: HabitFormProps) {
  const { addHabit } = useHabits();
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    frequency: 'daily',
    reminderTime: '',
    favorite: false,
  });
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!formData.name.trim()) {
      alert('Please enter a habit name');
      return;
    }
    
    setIsSubmitting(true);
    
    setTimeout(() => {
      addHabit({
        name: formData.name.trim(),
        description: formData.description.trim(),
        frequency: formData.frequency as 'daily' | 'weekly',
        reminderTime: formData.reminderTime || undefined,
        favorite: formData.favorite,
      });
      
      setIsSubmitting(false);
      onClose();
    }, 300);
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-6 animate-fade-in">
      <div className="flex justify-between items-center mb-6">
        <h3 className="text-xl font-semibold text-neutral-800">Create New Habit</h3>
        <button
          type="button"
          onClick={onClose}
          className="text-neutral-500 hover:text-neutral-700 p-2 rounded-full hover:bg-neutral-100 transition-colors duration-200"
        >
          <Close fontSize="small" />
        </button>
      </div>
      
      <div className="space-y-6">
        <div className="space-y-2">
          <label htmlFor="name" className="block text-sm font-medium text-neutral-700">
            Habit Name*
          </label>
          <input
            type="text"
            name="name"
            id="name"
            value={formData.name}
            onChange={handleChange}
            className="input-material"
            placeholder="e.g., Morning Meditation"
            required
          />
        </div>

        <div className="space-y-2">
          <label htmlFor="description" className="block text-sm font-medium text-neutral-700">
            Description
          </label>
          <textarea
            name="description"
            id="description"
            value={formData.description}
            onChange={handleChange}
            rows={2}
            className="input-material"
            placeholder="e.g., 10 minutes of mindfulness meditation"
          />
        </div>

        <div className="grid grid-cols-1 gap-6 sm:grid-cols-2">
          <div className="space-y-2">
            <label htmlFor="frequency" className="flex items-center text-sm font-medium text-neutral-700">
              <Repeat fontSize="small" className="mr-2 text-primary-600" />
              Frequency
            </label>
            <div className="relative">
              <select
                id="frequency"
                name="frequency"
                value={formData.frequency}
                onChange={handleChange}
                className="input-material pr-10"
              >
                <option value="daily">Daily</option>
                <option value="weekly">Weekly</option>
              </select>
              <div className="absolute right-3 top-1/2 transform -translate-y-1/2 pointer-events-none">
                <div className="border-t-2 border-l-2 border-neutral-400 h-2 w-2 transform rotate-225" />
              </div>
            </div>
          </div>

          <div className="space-y-2">
            <label htmlFor="reminderTime" className="flex items-center text-sm font-medium text-neutral-700">
              <Schedule fontSize="small" className="mr-2 text-primary-600" />
              Reminder Time
            </label>
            <input
              type="time"
              name="reminderTime"
              id="reminderTime"
              value={formData.reminderTime}
              onChange={handleChange}
              className="input-material"
            />
          </div>
        </div>

        <div className="space-y-2">
          <button
            type="button"
            onClick={() => setFormData({ ...formData, favorite: !formData.favorite })}
            className="flex items-center text-sm font-medium"
          >
            {formData.favorite ? (
              <>
                <Star className="text-yellow-500 mr-1" fontSize="small" />
                <span>Favorite</span>
              </>
            ) : (
              <>
                <StarBorder className="text-gray-500 mr-1" fontSize="small" />
                <span>Mark as favorite</span>
              </>
            )}
          </button>
        </div>
      </div>

      <div className="flex justify-end space-x-3 pt-6 border-t border-neutral-200">
        <button
          type="button"
          onClick={onClose}
          className="btn-secondary"
          disabled={isSubmitting}
        >
          Cancel
        </button>
        <button
          type="submit"
          className={`btn-primary relative ${isSubmitting ? 'opacity-80' : ''}`}
          disabled={isSubmitting}
        >
          {isSubmitting ? (
            <span className="flex items-center">
              <svg className="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              Creating...
            </span>
          ) : (
            <>
              <Add className="mr-2 h-5 w-5" />
              Create Habit
            </>
          )}
        </button>
      </div>
    </form>
  );
} 