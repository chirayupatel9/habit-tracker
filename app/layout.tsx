import './globals.css';
import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import { AuthProvider } from './lib/AuthContext';
import { HabitProvider } from './lib/HabitContext';
import Header from './components/Header';
import Reminders from './components/Reminders';

const inter = Inter({ subsets: ['latin'] });

export const metadata: Metadata = {
  title: 'Habit Tracker',
  description: 'Track your daily habits and build consistency',
  icons: {
    icon: '/favicon.ico',
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="scroll-smooth">
      <head>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="theme-color" content="#2196f3" />
      </head>
      <body className="bg-gradient-to-b from-background-default to-white min-h-screen">
        <div className="fixed inset-0 bg-primary-500 opacity-[0.02] pointer-events-none" />
        
        {/* Simplified background animations for better performance */}
        <div className="bg-animations">
          <div className="bg-bubble"></div>
          <div className="bg-bubble"></div>
        </div>
        
        <AuthProvider>
          <HabitProvider>
            <div className="relative">
              {/* Decorative Background Elements */}
              <div className="hidden md:block absolute top-20 left-10 w-64 h-64 rounded-full bg-primary-100 opacity-20 blur-3xl" />
              <div className="hidden md:block absolute bottom-40 right-10 w-96 h-96 rounded-full bg-secondary-100 opacity-20 blur-3xl" />
              
              <Header />
              
              <main className="relative min-h-screen px-4 py-8 sm:px-6 lg:px-8 max-w-6xl mx-auto pt-16">
                {children}
              </main>
              
              <Reminders />
            </div>
          </HabitProvider>
        </AuthProvider>
        
        <footer className="py-6 px-4 mt-20 text-center text-neutral-500 text-sm">
          © {new Date().getFullYear()} Habit Tracker | All rights reserved
        </footer>
      </body>
    </html>
  );
} 