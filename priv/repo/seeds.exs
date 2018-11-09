# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TaskTracker.Repo.insert!(%TaskTracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TaskTracker.Repo
alias TaskTracker.Users.User

pwhash = Argon2.hash_pwd_salt("pass1")

alice = Repo.insert!(%User{email: "alice@example.com", admin: true, password_hash: pwhash})
bob = Repo.insert!(%User{email: "bob@example.com", admin: false, password_hash: pwhash})

alias TaskTracker.Tasks.Task
Repo.insert!(%Task{name: "test", desc: "test desc", assigned_user: alice}) 
