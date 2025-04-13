import { Habit } from '../data/habits';
import { addDays, format, isToday, parseISO, isSameDay, subDays, startOfWeek, endOfWeek } from 'date-fns';

// Format date for display
export function formatDate(date: Date): string {
  return format(date, 'yyyy-MM-dd');
}

// Check if a habit was completed on a specific date
export function isHabitCompletedOnDate(habit: Habit, date: Date): boolean {
  return habit.completedDates.some(completedDate => 
    isSameDay(parseISO(completedDate), date)
  );
}

// Check if a habit was completed today
export function isHabitCompletedToday(habit: Habit): boolean {
  return isHabitCompletedOnDate(habit, new Date());
}

// Get the current streak count for a habit
export function calculateStreak(habit: Habit): number {
  if (habit.completedDates.length === 0) {
    return 0;
  }

  // Sort dates in descending order (most recent first)
  const sortedDates = [...habit.completedDates]
    .map(date => parseISO(date))
    .sort((a, b) => b.getTime() - a.getTime());

  let streak = 1;
  let currentDate = sortedDates[0];
  
  // For daily habits
  if (habit.frequency === 'daily') {
    for (let i = 1; i < sortedDates.length; i++) {
      const expectedPrevDate = subDays(currentDate, 1);
      if (isSameDay(sortedDates[i], expectedPrevDate)) {
        streak++;
        currentDate = sortedDates[i];
      } else {
        break;
      }
    }
    
    // Check if streak is broken because today is not completed
    if (!isToday(sortedDates[0]) && !isSameDay(sortedDates[0], subDays(new Date(), 1))) {
      return 0;
    }
  } 
  // For weekly habits
  else if (habit.frequency === 'weekly') {
    const thisWeekStart = startOfWeek(new Date());
    const thisWeekEnd = endOfWeek(new Date());
    
    let weekCounter = 0;
    let hasCompletedThisWeek = sortedDates.some(date => 
      date >= thisWeekStart && date <= thisWeekEnd
    );
    
    if (!hasCompletedThisWeek) {
      return 0;
    }
    
    // Count completed weeks in a row
    const weeks: Date[][] = [];
    let currentWeek = 0;
    
    while (sortedDates.length > 0 && currentWeek < 52) { // Limit to a year
      const weekStart = startOfWeek(subDays(new Date(), 7 * currentWeek));
      const weekEnd = endOfWeek(subDays(new Date(), 7 * currentWeek));
      
      const completionsInWeek = sortedDates.filter(date => 
        date >= weekStart && date <= weekEnd
      );
      
      if (completionsInWeek.length > 0) {
        streak = currentWeek + 1;
      } else {
        break;
      }
      
      currentWeek++;
    }
  }

  return streak;
}

// Format reminder time for display
export function formatReminderTime(time: string | undefined): string {
  if (!time) return 'No reminder set';
  
  const [hours, minutes] = time.split(':');
  const date = new Date();
  date.setHours(parseInt(hours, 10));
  date.setMinutes(parseInt(minutes, 10));
  
  return format(date, 'h:mm a');
}

// Generate a random ID for new habits
export function generateId(): string {
  return Math.random().toString(36).substring(2, 9);
}

// Toggle a habit's completion status for today
export function toggleHabitCompletion(habit: Habit): Habit {
  const today = format(new Date(), 'yyyy-MM-dd');
  const isCompleted = isHabitCompletedToday(habit);
  
  if (isCompleted) {
    // Remove today from completed dates
    return {
      ...habit,
      completedDates: habit.completedDates.filter(date => date !== today),
      streakCount: calculateStreak({ 
        ...habit, 
        completedDates: habit.completedDates.filter(date => date !== today) 
      }),
    };
  } else {
    // Add today to completed dates
    const updatedCompletedDates = [...habit.completedDates, today];
    return {
      ...habit,
      completedDates: updatedCompletedDates,
      streakCount: calculateStreak({ ...habit, completedDates: updatedCompletedDates }),
    };
  }
} 