'use client';

import { useEffect, useState } from 'react';
import { useHabits } from '../lib/HabitContext';
import { formatReminderTime, isHabitCompletedToday } from '../lib/utils';
import { Close, Check, Notifications } from '../components/icons';

export default function Reminders() {
  const { habits, toggleCompletion } = useHabits();
  const [reminders, setReminders] = useState<string[]>([]);
  const [showNotification, setShowNotification] = useState(false);
  const [currentReminder, setCurrentReminder] = useState<{
    id: string;
    name: string;
    description?: string;
  } | null>(null);
  const [isCompleting, setIsCompleting] = useState(false);

  // Check for reminders every minute
  useEffect(() => {
    const checkReminders = () => {
      const now = new Date();
      const currentHour = now.getHours();
      const currentMinute = now.getMinutes();
      const currentTimeString = `${currentHour.toString().padStart(2, '0')}:${currentMinute.toString().padStart(2, '0')}`;
      
      // Filter habits that have a reminder set for the current time and are not completed today
      const dueHabits = habits.filter(habit => 
        habit.reminderTime === currentTimeString && 
        !isHabitCompletedToday(habit)
      );
      
      if (dueHabits.length > 0) {
        const habit = dueHabits[0]; // Take the first one
        setCurrentReminder({
          id: habit.id,
          name: habit.name,
          description: habit.description
        });
        setShowNotification(true);
        
        // Request browser notification permission
        if (typeof Notification !== 'undefined') {
          if (Notification.permission === 'granted') {
            new Notification(`Time for: ${habit.name}`, {
              body: habit.description,
              icon: '/icon-192.png'
            });
          } else if (Notification.permission !== 'denied') {
            Notification.requestPermission().then(permission => {
              if (permission === 'granted') {
                new Notification(`Time for: ${habit.name}`, {
                  body: habit.description,
                  icon: '/icon-192.png'
                });
              }
            });
          }
        }
      }
    };
    
    const interval = setInterval(checkReminders, 60000); // Check every minute
    checkReminders(); // Check immediately on mount
    
    return () => clearInterval(interval);
  }, [habits]);

  const handleCompleteReminder = () => {
    if (currentReminder) {
      setIsCompleting(true);
      
      // Add a slight delay for animation purposes
      setTimeout(() => {
        toggleCompletion(currentReminder.id);
        setIsCompleting(false);
        setShowNotification(false);
      }, 500);
    }
  };

  const handleDismissReminder = () => {
    setShowNotification(false);
  };

  if (!showNotification) return null;

  return (
    <div className="fixed bottom-6 right-6 z-50 w-full max-w-sm shadow-elevation-8 rounded-xl overflow-hidden animate-fade-in">
      <div className="bg-gradient-to-r from-primary-500 to-primary-600 text-white px-5 py-3 flex items-center">
        <Notifications className="mr-3" />
        <span className="font-medium">Habit Reminder</span>
        <div className="ml-auto flex items-center">
          <div className="h-2 w-2 rounded-full bg-white mr-2 animate-pulse" />
          <button
            onClick={handleDismissReminder}
            className="hover:bg-primary-600/50 p-1.5 rounded-full transition-colors duration-200"
            aria-label="Close notification"
          >
            <Close fontSize="small" />
          </button>
        </div>
      </div>
      
      <div className="bg-white p-5">
        <h3 className="font-semibold text-lg text-neutral-800">{currentReminder?.name}</h3>
        {currentReminder?.description && (
          <p className="mt-1.5 text-neutral-600 text-sm">{currentReminder.description}</p>
        )}
        
        <div className="mt-5 flex justify-end space-x-3">
          <button
            onClick={handleDismissReminder}
            className="btn-secondary py-2 px-4 text-sm"
          >
            Dismiss
          </button>
          <button
            onClick={handleCompleteReminder}
            disabled={isCompleting}
            className={`btn-primary py-2 px-4 text-sm relative overflow-hidden ${
              isCompleting ? 'bg-success-main' : ''
            }`}
          >
            {isCompleting ? (
              <span className="flex items-center">
                <svg className="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                  <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                  <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                Completing...
              </span>
            ) : (
              <>
                <Check className="mr-2" fontSize="small" />
                Complete
              </>
            )}
            
            {isCompleting && (
              <span className="absolute inset-0 bg-success-main animate-pulse-slow"></span>
            )}
          </button>
        </div>
      </div>
    </div>
  );
} 