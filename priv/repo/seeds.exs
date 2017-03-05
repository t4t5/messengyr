# priv/repo/seeds.exs

alias Messengyr.{Chat, Repo, Accounts}
alias Messengyr.Accounts.User

# Create a new room:
{:ok, room} = Chat.create_room()

# Fetch my user (the first one in the table):
me = Repo.one(User)

# Create a counterpart user:
{:ok, counterpart} = Accounts.create_user(%{
  "username" => "bob", 
  "email" => "bob@example.com", 
  "password" => "test",
})

# Add myself as a room_user:
Chat.add_room_user(%{room: room, user: me})

# Add the counterpart as a room_user:
Chat.add_room_user(%{room: room, user: counterpart})

# Add a message in the room:
Chat.add_message(%{
  room: room,
  user: me,
  text: "Hello world!",
})

