# BettingSystem

To start your Phoenix server:

- Run `mix setup` to install and set up dependencies.
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Database Setup

This project uses MySQL as the database backend. To set up the database, follow these steps:

1. **Configure your database credentials:**
   Edit your `config/dev.exs`, `config/prod.exs`, or `config/test.exs` file (depending on your environment) to set up the appropriate database variables.

   Example for **PostgreSQL**:

   ```elixir
   config :betting_system, BettingSystem.Repo,
     username: "your_db_username",
     password: "your_db_password",
     database: "betting_system_dev",  # Change this to your database name
     hostname: "localhost",
     pool_size: 10
   ```
