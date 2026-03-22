# Support Ticket Management System — API

A GraphQL-powered Rails API backend for the Support Ticket Management System. Built with Ruby on Rails, GraphQL-Ruby, and PostgreSQL.

---

## Tech Stack

- **Ruby on Rails 7** — API only mode
- **PostgreSQL** — database
- **GraphQL-Ruby** — API layer
- **JWT** — authentication
- **Bcrypt** — password hashing

---

## Prerequisites

Make sure you have the following installed:

- Ruby 3.2+
- Rails 7+
- PostgreSQL
- Bundler

---

## Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/your-username/support-ticket-api.git
cd support-ticket-api
```

### 2. Install dependencies
```bash
bundle install
```

### 3. Set up credentials

Generate a JWT secret key:
```bash
rails secret
```

Open the credentials file:
```bash
EDITOR="code --wait" rails credentials:edit
```

Add the following:
```yaml
jwt_secret_key: your_generated_secret_here
```

### 4. Set up the database
```bash
rails db:create
rails db:migrate
rails db:seed
```

### 5. Start the server
```bash
rails server
```

The API will be available at `http://localhost:3000/graphql`

GraphiQL playground is available at `http://localhost:3000/graphiql`

---

## Seed Accounts

After running `rails db:seed`, the following accounts are available:

| Role  | Email | Password |
|-------|-------|----------|
| Admin | admin@support.com | password123 |
| User  | juan@example.com | password123 |
| User  | maria@example.com | password123 |

---

## GraphQL Endpoints

All requests go to a single endpoint:
```
POST http://localhost:3000/graphql
```

### Authentication

Include the JWT token in the Authorization header:
```
Authorization: Bearer your_token_here
```

### Available Queries

| Query | Description | Auth Required |
|-------|-------------|---------------|
| `me` | Returns current logged in user | Yes |
| `tickets` | Returns tickets (own for users, all for admins) | Yes |
| `ticket(id)` | Returns a single ticket by ID | Yes |
| `dashboardStats` | Returns ticket statistics for admin dashboard | Yes (Admin) |

### Available Mutations

| Mutation | Description | Auth Required |
|----------|-------------|---------------|
| `register` | Create a new user account | No |
| `login` | Authenticate and receive JWT token | No |
| `logout` | Log out current user | Yes |
| `createTicket` | Submit a new support ticket | Yes |
| `updateTicket` | Update an existing ticket | Yes |
| `deleteTicket` | Delete or cancel a ticket | Yes |

---

## Data Models

### User
| Field | Type | Description |
|-------|------|-------------|
| email | String | Unique email address |
| password | String | Minimum 6 characters |
| role | Enum | `user` or `admin` |

### Ticket
| Field | Type | Description |
|-------|------|-------------|
| subject | String | Brief summary |
| description | Text | Full description |
| category | Enum | `general`, `technical`, `billing`, `other` |
| priority | Enum | `low`, `medium`, `high`, `critical` |
| status | Enum | `open`, `in_progress`, `resolved`, `closed` |
| assigned_to | String | Support staff name (optional) |

---

## Project Structure
```
app/
├── graphql/
│   ├── mutations/         # All GraphQL mutations
│   │   ├── register.rb
│   │   ├── login.rb
│   │   ├── logout.rb
│   │   ├── create_ticket.rb
│   │   ├── update_ticket.rb
│   │   └── delete_ticket.rb
│   ├── types/             # All GraphQL types
│   │   ├── user_type.rb
│   │   ├── ticket_type.rb
│   │   ├── dashboard_stats_type.rb
│   │   ├── query_type.rb
│   │   └── mutation_type.rb
│   └── schema.rb
├── models/
│   ├── user.rb
│   └── ticket.rb
└── lib/
    └── json_web_token.rb
```

---

## Running Tests
```bash
rails test
```

---

## Deployment

This API is deployed at: 
