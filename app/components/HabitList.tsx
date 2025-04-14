'use client';

import { useState } from 'react';
import { useHabits } from '../lib/HabitContext';
import HabitItem from './HabitItem';
import { FilterList, Star } from '../components/icons';

type FilterType = 'all' | 'daily' | 'weekly' | 'favorites';
type SortType = 'recent' | 'streak' | 'alphabetical' | 'favorites';

export default function HabitList() {
  const { habits } = useHabits();
  const [filter, setFilter] = useState<FilterType>('all');
  const [showFilters, setShowFilters] = useState(false);
  const [sortBy, setSortBy] = useState<SortType>('recent');

  const filteredHabits = filter === 'all' 
    ? habits 
    : filter === 'favorites'
    ? habits.filter(habit => habit.favorite)
    : habits.filter(habit => habit.frequency === filter);
    
  const sortedHabits = [...filteredHabits].sort((a, b) => {
    switch (sortBy) {
      case 'recent':
        return new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime();
      case 'streak':
        return b.streakCount - a.streakCount;
      case 'alphabetical':
        return a.name.localeCompare(b.name);
      case 'favorites':
        if (a.favorite && !b.favorite) return -1;
        if (!a.favorite && b.favorite) return 1;
        return new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime();
      default:
        return 0;
    }
  });

  return (
    <div>
      <div className="material-tabs mb-8 border-b border-neutral-200 relative">
        <div className="flex items-center justify-between">
          <div className="flex gap-2 overflow-x-auto pb-2">
            <button
              onClick={() => setFilter('all')}
              className={`tab ${filter === 'all' ? 'active-tab' : ''}`}
            >
              All
            </button>
            <button
              onClick={() => setFilter('daily')}
              className={`tab ${filter === 'daily' ? 'active-tab' : ''}`}
            >
              Daily
            </button>
            <button
              onClick={() => setFilter('weekly')}
              className={`tab ${filter === 'weekly' ? 'active-tab' : ''}`}
            >
              Weekly
            </button>
            <button
              onClick={() => setFilter('favorites')}
              className={`tab ${filter === 'favorites' ? 'active-tab' : ''} flex items-center gap-1`}
            >
              <Star className="h-4 w-4" />
              Favorites
            </button>
          </div>
          <button 
            onClick={() => setShowFilters(!showFilters)}
            className={`p-2 rounded-full transition-all duration-200 ${showFilters ? 'bg-primary-100 text-primary-600' : 'hover:bg-neutral-100 text-neutral-500'}`}
            aria-label="Show filters"
          >
            <FilterList className={`transition-transform duration-200 ${showFilters ? 'rotate-180' : ''}`} />
          </button>
        </div>

        {showFilters && (
          <div className="animate-fade-in py-4 px-2">
            <h4 className="text-sm font-medium text-neutral-700 mb-2">Sort by</h4>
            <div className="flex flex-wrap gap-2">
              <button 
                onClick={() => setSortBy('recent')}
                className={`px-3 py-1.5 text-xs rounded-full font-medium transition-colors ${
                  sortBy === 'recent' 
                    ? 'bg-primary-100 text-primary-700' 
                    : 'bg-neutral-100 text-neutral-700 hover:bg-neutral-200'
                }`}
              >
                Recent first
              </button>
              <button 
                onClick={() => setSortBy('streak')}
                className={`px-3 py-1.5 text-xs rounded-full font-medium transition-colors ${
                  sortBy === 'streak' 
                    ? 'bg-primary-100 text-primary-700' 
                    : 'bg-neutral-100 text-neutral-700 hover:bg-neutral-200'
                }`}
              >
                Streak
              </button>
              <button 
                onClick={() => setSortBy('alphabetical')}
                className={`px-3 py-1.5 text-xs rounded-full font-medium transition-colors ${
                  sortBy === 'alphabetical' 
                    ? 'bg-primary-100 text-primary-700' 
                    : 'bg-neutral-100 text-neutral-700 hover:bg-neutral-200'
                }`}
              >
                Alphabetical
              </button>
              <button 
                onClick={() => setSortBy('favorites')}
                className={`px-3 py-1.5 text-xs rounded-full font-medium transition-colors flex items-center gap-1 ${
                  sortBy === 'favorites' 
                    ? 'bg-amber-100 text-amber-700' 
                    : 'bg-neutral-100 text-neutral-700 hover:bg-neutral-200'
                }`}
              >
                <Star className="h-3 w-3" />
                Favorites first
              </button>
            </div>
          </div>
        )}
      </div>

      {filteredHabits.length === 0 ? (
        <div className="material-card p-12 text-center bg-neutral-50/50">
          <div className="w-32 h-32 bg-neutral-100 rounded-full mx-auto mb-6 flex items-center justify-center">
            <img 
              src="/images/empty-state.svg" 
              alt="No habits found" 
              className="w-24 h-24 opacity-70"
              onError={(e) => {
                // Fallback if image doesn't exist
                e.currentTarget.style.display = 'none';
              }}
            />
          </div>
          <h3 className="text-xl font-semibold text-neutral-800 mb-2">No habits found</h3>
          <p className="text-neutral-600 max-w-sm mx-auto">
            {filter === 'all' 
              ? 'Create a new habit to get started with tracking your daily routines!'
              : filter === 'favorites'
              ? "You don't have any favorite habits yet. Try marking some habits as favorites!"
              : `You don't have any ${filter} habits yet. Try adding some!`}
          </p>
        </div>
      ) : (
        <div className="grid gap-6 grid-cols-1 md:grid-cols-2 lg:grid-cols-3 animate-fade-in">
          {sortedHabits.map(habit => (
            <HabitItem key={habit.id} habit={habit} />
          ))}
        </div>
      )}
    </div>
  );
} 