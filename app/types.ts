export interface Habit {
  id: string;
  name: string;
  description: string;
  frequency?: 'daily' | 'weekly';
  reminderTime?: string;
  streakCount: number;
  completedDates: string[]; // ISO date strings
  createdAt: string;
  favorite: boolean;
  userId?: string;
  streak?: number; // Seems to be used in HabitForm but not in the main data structure
}

export type FilterType = 'all' | 'daily' | 'weekly'; 