alias TimeManager.Repo
alias TimeManager.Accounts.User
alias TimeManager.TimeTracking.{Clock, WorkingTime}  # Assure-toi que Clock et WorkingTime sont bien définis ici
alias TimeManager.Teams.Team

# Seed : Utilisateurs
IO.puts("Création des utilisateurs...")

user1 = %User{
  username: "john.doe",
  email: "john.doe@example.com",
  role: "employee"
} |> Repo.insert!()

user2 = %User{
  username: "jane.doe",
  email: "jane.doe@example.com",
  role: "manager"
} |> Repo.insert!()

user3 = %User{
  username: "admin.boss",
  email: "admin.boss@example.com",
  role: "general_manager"
} |> Repo.insert!()

IO.puts("Utilisateurs créés !")

# Seed : Équipes (Teams)
IO.puts("Création des équipes...")

team1 = %Team{
  name: "Development Team"
} |> Repo.insert!()

team2 = %Team{
  name: "Marketing Team"
} |> Repo.insert!()

IO.puts("Équipes créées !")

# Seed : Pointages (Clocks)
IO.puts("Création des pointages...")

current_time = DateTime.truncate(DateTime.utc_now(), :second)

clock1 = %Clock{
  time: current_time,
  status: true,
  user_id: user1.id  # Liaison avec user1
} |> Repo.insert!()

clock2 = %Clock{
  time: current_time,
  status: false,
  user_id: user1.id  # Liaison avec user1
} |> Repo.insert!()

clock3 = %Clock{
  time: current_time,
  status: true,
  user_id: user2.id  # Liaison avec user2
} |> Repo.insert!()

clock4 = %Clock{
  time: current_time,
  status: false,
  user_id: user2.id  # Liaison avec user2
} |> Repo.insert!()

IO.puts("Pointages créés !")

# Seed : Heures de travail (Working Times)
IO.puts("Création des heures de travail...")

working_time1 = %WorkingTime{
  start: ~U[2024-10-01 08:00:00Z],
  end: ~U[2024-10-01 17:00:00Z],
  user_id: user1.id  # Liaison avec user1
} |> Repo.insert!()

working_time2 = %WorkingTime{
  start: ~U[2024-10-02 09:00:00Z],
  end: ~U[2024-10-02 18:00:00Z],
  user_id: user1.id  # Liaison avec user1
} |> Repo.insert!()

working_time3 = %WorkingTime{
  start: ~U[2024-10-01 09:00:00Z],
  end: ~U[2024-10-01 18:00:00Z],
  user_id: user2.id  # Liaison avec user2
} |> Repo.insert!()

working_time4 = %WorkingTime{
  start: ~U[2024-10-02 10:00:00Z],
  end: ~U[2024-10-02 19:00:00Z],
  user_id: user2.id  # Liaison avec user2
} |> Repo.insert!()

IO.puts("Heures de travail créées !")
