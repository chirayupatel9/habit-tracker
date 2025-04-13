import './globals.css';
import type { Metadata } from 'next';
import { HabitProvider } from './lib/HabitContext';
import Reminders from './components/Reminders';

export const metadata: Metadata = {
  title: 'Habit Tracker',
  description: 'Build consistent routines with our beautiful habit tracker app',
  icons: {
    icon: '/favicon.ico',
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className="scroll-smooth">
      <head>
        <link rel="icon" href="/favicon.ico" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta name="theme-color" content="#2196f3" />
      </head>
      <body className="bg-gradient-to-b from-background-default to-white min-h-screen">
        <div className="fixed inset-0 bg-primary-500 opacity-[0.02] pointer-events-none" />
        
        {/* Simplified background animations for better performance */}
        <div className="bg-animations">
          <div className="bg-bubble"></div>
          <div className="bg-bubble"></div>
        </div>
        
        <HabitProvider>
          <div className="relative">
            {/* Decorative Background Elements */}
            <div className="hidden md:block absolute top-20 left-10 w-64 h-64 rounded-full bg-primary-100 opacity-20 blur-3xl" />
            <div className="hidden md:block absolute bottom-40 right-10 w-96 h-96 rounded-full bg-secondary-100 opacity-20 blur-3xl" />
            
            <main className="relative min-h-screen px-4 py-8 sm:px-6 lg:px-8 max-w-6xl mx-auto">
              {children}
            </main>
            
            <Reminders />
          </div>
        </HabitProvider>
        
        <footer className="py-6 px-4 mt-20 text-center text-neutral-500 text-sm">
          <p>© {new Date().getFullYear()} Habit Tracker - Track your routines and build consistent habits</p>
        </footer>
      </body>
    </html>
  );
} 