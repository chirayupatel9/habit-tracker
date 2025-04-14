'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import HabitList from './components/HabitList';
import HabitForm from './components/HabitForm';
import DraggableHabitBoard from './components/DraggableHabitBoard';
import { useHabits } from './lib/HabitContext';
import { useAuth } from './lib/AuthContext';
import { Add, Close } from './components/icons';

export default function Home() {
  const { habits } = useHabits();
  const { isAuthenticated, isLoading } = useAuth();
  const [showForm, setShowForm] = useState(false);
  const [viewMode, setViewMode] = useState<'list' | 'board'>('board');
  const router = useRouter();

  // Redirect to login if not authenticated
  useEffect(() => {
    if (!isLoading && !isAuthenticated) {
      console.log('Not authenticated, redirecting to login');
      router.replace('/login');
    }
  }, [isAuthenticated, isLoading, router]);

  // Add an extra check when the component mounts
  useEffect(() => {
    // Check localStorage directly as a fallback
    const storedUser = localStorage.getItem('habit_tracker_user');
    if (!storedUser && !isLoading) {
      console.log('No user in localStorage, redirecting to login');
      router.replace('/login');
    }
  }, []);

  // Show loading state while checking auth
  if (isLoading) {
    return (
      <div className="flex justify-center items-center min-h-[60vh]">
        <div className="animate-pulse text-lg font-medium text-primary-600">
          Loading...
        </div>
      </div>
    );
  }

  // Don't render content if not authenticated
  if (!isAuthenticated) {
    return null;
  }

  return (
    <div className="space-y-10">
      <header className="py-8 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div className="flex-1">
          <h1 className="text-3xl font-semibold text-neutral-800">
            <span className="text-transparent bg-clip-text bg-gradient-to-r from-primary-500 to-accent-purple">Habit Tracker</span>
          </h1>
          <p className="mt-2 text-neutral-600">Build consistent routines and track your progress</p>
        </div>
        
        <div className="flex flex-wrap items-center gap-3">
          <div className="bg-white rounded-lg shadow-sm p-1 flex">
            <button
              onClick={() => setViewMode('board')}
              className={`px-3 py-1.5 rounded-md text-sm font-medium transition-colors ${
                viewMode === 'board'
                  ? 'bg-primary-50 text-primary-700'
                  : 'text-neutral-600 hover:bg-neutral-50'
              }`}
            >
              Board
            </button>
            <button
              onClick={() => setViewMode('list')}
              className={`px-3 py-1.5 rounded-md text-sm font-medium transition-colors ${
                viewMode === 'list'
                  ? 'bg-primary-50 text-primary-700'
                  : 'text-neutral-600 hover:bg-neutral-50'
              }`}
            >
              List
            </button>
          </div>
          
          <button
            onClick={() => setShowForm(true)}
            className="btn-primary flex items-center gap-1"
          >
            <Add fontSize="small" />
            New Habit
          </button>
        </div>
      </header>

      {showForm && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-xl shadow-lg max-w-md w-full max-h-[90vh] overflow-y-auto">
            <div className="p-4 flex justify-between items-center border-b">
              <h2 className="text-xl font-semibold">Create New Habit</h2>
              <button
                onClick={() => setShowForm(false)}
                className="p-1 rounded-full hover:bg-neutral-100"
              >
                <Close />
              </button>
            </div>
            <HabitForm onClose={() => setShowForm(false)} />
          </div>
        </div>
      )}

      <div className="pb-4">
        <div className="flex items-center justify-between">
          <h2 className="text-xl font-semibold text-neutral-800">Your Habits</h2>
          <div className="px-3 py-1.5 bg-gradient-to-r from-primary-50 to-primary-100 rounded-full">
            <span className="text-sm font-medium text-primary-700">
              {habits.length} habit{habits.length !== 1 ? 's' : ''}
            </span>
          </div>
        </div>
      </div>

      {viewMode === 'board' ? (
        <DraggableHabitBoard />
      ) : (
        <HabitList />
      )}
      
      {/* Mobile FAB for adding habits */}
      <button
        onClick={() => setShowForm(!showForm)}
        className={`btn-fab fixed right-6 bottom-6 md:hidden z-10 ${
          showForm ? 'bg-neutral-700 hover:bg-neutral-800 rotate-45' : ''
        }`}
        aria-label={showForm ? "Cancel" : "Add Habit"}
      >
        <Add className={`transition-transform duration-300 ${showForm ? 'rotate-45' : ''}`} />
      </button>
    </div>
  );
} 