'use client';

import { useState } from 'react';
import HabitList from './components/HabitList';
import HabitForm from './components/HabitForm';
import DraggableHabitBoard from './components/DraggableHabitBoard';
import { useHabits } from './lib/HabitContext';
import { Add, Close } from './components/icons';

export default function Home() {
  const { habits } = useHabits();
  const [showForm, setShowForm] = useState(false);
  const [viewMode, setViewMode] = useState<'list' | 'board'>('board');

  return (
    <div className="space-y-10">
      <header className="py-8 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div className="flex-1">
          <h1 className="text-3xl font-semibold text-neutral-800">
            <span className="text-transparent bg-clip-text bg-gradient-to-r from-primary-500 to-accent-purple">Habit Tracker</span>
          </h1>
          <p className="mt-2 text-neutral-600">Build consistent routines and track your progress</p>
        </div>
        <div className="flex items-center gap-3">
          <div className="bg-neutral-100 p-1 rounded-lg flex">
            <button
              onClick={() => setViewMode('list')}
              className={`px-4 py-2 rounded-md transition-all duration-200 ${
                viewMode === 'list' 
                  ? 'bg-white shadow-md text-primary-700' 
                  : 'text-neutral-600 hover:text-neutral-800'
              }`}
            >
              List View
            </button>
            <button
              onClick={() => setViewMode('board')}
              className={`px-4 py-2 rounded-md transition-all duration-200 ${
                viewMode === 'board' 
                  ? 'bg-white shadow-md text-primary-700' 
                  : 'text-neutral-600 hover:text-neutral-800'
              }`}
            >
              Board View
            </button>
          </div>
          <button
            onClick={() => setShowForm(!showForm)}
            className={`btn-primary animate-ripple ${showForm ? 'bg-neutral-700 hover:bg-neutral-800' : ''}`}
          >
            {showForm ? (
              <>
                <Close className="h-5 w-5 mr-2" />
                Cancel
              </>
            ) : (
              <>
                <Add className="h-5 w-5 mr-2" />
                Add Habit
              </>
            )}
          </button>
        </div>
      </header>

      {showForm && (
        <div className="material-card p-6 shadow-card">
          <HabitForm onClose={() => setShowForm(false)} />
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

      {viewMode === 'list' ? (
        <HabitList />
      ) : (
        <DraggableHabitBoard />
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