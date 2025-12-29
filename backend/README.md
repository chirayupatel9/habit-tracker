# Habit Tracker API

Production-ready FastAPI backend for a Habit Tracker App.

## Tech Stack

- **Python 3.11+**
- **FastAPI** - Modern, fast web framework
- **MySQL** - Database
- **SQLAlchemy 2.0** (async) - ORM
- **Alembic** - Database migrations
- **Pydantic v2** - Data validation
- **JWT** - Authentication (access + refresh tokens)
- **bcrypt** - Password hashing
- **APScheduler** - Background jobs for notifications

## Features

### Authentication
- User registration
- Login with JWT tokens
- Refresh token support
- Forgot password (email stub)
- Secure password hashing with bcrypt

### Daily Tracking
- One entry per date per user
- Track moment of day, sleep hours, daily notes
- Task completions linked to entries

### Tasks
- User-defined tasks
- Active/inactive toggle
- CRUD operations

### Aggregations
- Monthly aggregation with average sleep and task completion counts
- Yearly tracking view (tracked/not tracked per date)

### Dashboard
- Random past moment
- Average sleep (7 & 30 days)
- Task consistency percentage

### Notifications (Logic Only)
- Daily reminders (9:00 AM)
- Weekly summaries (Sunday 9:00 AM)
- Monthly summaries (1st of month 9:00 AM)
- FCM placeholders (not implemented)

## Project Structure

```
backend/
├── app/
│   ├── main.py              # FastAPI app
│   ├── config.py            # Configuration
│   ├── database.py          # Database setup
│   ├── deps.py              # Dependencies
│   ├── auth/                # Authentication
│   ├── users/               # User models/schemas
│   ├── tasks/               # Tasks module
│   ├── entries/             # Daily entries module
│   ├── feedback/            # Feedback module
│   ├── notifications/      # Notification scheduler
│   └── utils/               # Utilities
├── alembic/                 # Migrations
└── requirements.txt         # Dependencies
```

## Setup

1. **Install dependencies:**
```bash
pip install -r requirements.txt
```

2. **Configure environment:**
```bash
cp .env.example .env
# Edit .env with your database credentials and secret key
```

3. **Run migrations:**
```bash
alembic upgrade head
```

4. **Start the server:**
```bash
uvicorn app.main:app --reload
```

The API will be available at `http://localhost:8000`
API documentation at `http://localhost:8000/docs`

## Database Schema

- **users** - User accounts
- **tasks** - User-defined tasks
- **daily_entries** - Daily tracking entries
- **task_completions** - Task completion records
- **feedback** - User feedback

## API Endpoints

### Authentication
- `POST /auth/register` - Register new user
- `POST /auth/login` - Login and get tokens
- `POST /auth/refresh` - Refresh access token
- `POST /auth/forgot-password` - Forgot password (stub)

### Tasks
- `POST /tasks` - Create task
- `GET /tasks` - Get all tasks
- `GET /tasks/{task_id}` - Get task
- `PATCH /tasks/{task_id}` - Update task
- `DELETE /tasks/{task_id}` - Delete task

### Daily Entries
- `POST /entries` - Create entry
- `GET /entries` - Get all entries (paginated)
- `GET /entries/{entry_id}` - Get entry
- `PATCH /entries/{entry_id}` - Update entry
- `DELETE /entries/{entry_id}` - Delete entry
- `GET /entries/monthly/{year}/{month}` - Monthly aggregation
- `GET /entries/yearly/{year}` - Yearly tracking
- `GET /entries/dashboard/summary` - Dashboard summary

### Feedback
- `POST /feedback` - Submit feedback
- `GET /feedback` - Get user's feedback

## Security

- Passwords are hashed with bcrypt
- JWT tokens for authentication
- Access tokens expire in 30 minutes
- Refresh tokens expire in 7 days
- All endpoints (except auth) require authentication
- Resource ownership validation on all operations

## Notes

- One daily entry per date per user (enforced by unique constraint)
- Monthly and yearly views are derived from daily entries (no separate tables)
- Notification scheduler runs in background (APScheduler)
- FCM integration is placeholder only (not implemented)

