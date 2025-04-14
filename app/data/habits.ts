export interface Habit {
  id: string;
  name: string;
  description: string;
  frequency: 'daily' | 'weekly';
  reminderTime?: string;
  streakCount: number;
  completedDates: string[]; // ISO date strings
  createdAt: string;
  favorite: boolean;
}

export const habits: Habit[] = [
  {
    id: '1',
    name: 'Morning Meditation',
    description: '10 minutes of mindfulness meditation',
    frequency: 'daily',
    reminderTime: '08:00',
    streakCount: 5,
    completedDates: [
      '2025-04-12',
      '2025-04-11',
      '2025-04-10',
      '2025-04-09',
      '2025-04-08',
    ],
    createdAt: '2025-04-01',
    favorite: true,
  },
  {
    id: '2',
    name: 'Read a Book',
    description: 'Read for 30 minutes',
    frequency: 'daily',
    reminderTime: '21:00',
    streakCount: 3,
    completedDates: [
      '2025-04-12',
      '2025-04-11',
      '2025-04-10',
    ],
    createdAt: '2025-04-05',
    favorite: false,
  },
  {
    id: '3',
    name: 'Exercise',
    description: '30 minutes of physical activity',
    frequency: 'daily',
    reminderTime: '18:00',
    streakCount: 0,
    completedDates: [],
    createdAt: '2025-04-07',
    favorite: false,
  },
  {
    id: '4',
    name: 'Weekly Review',
    description: 'Review goals and plan next week',
    frequency: 'weekly',
    reminderTime: '17:00',
    streakCount: 2,
    completedDates: [
      '2025-04-07',
      '2025-03-31',
    ],
    createdAt: '2025-03-24',
    favorite: false,
  },
]; 