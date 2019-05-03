candidates = [
  {name: 'bernie sanders', candid_id: 0, num_votes: 0},
  {name: 'joe biden', candid_id: 1, num_votes: 0},
  {name: 'boris shmuylovich', candid_id: 2, num_votes: 0},
  {name: 'donald trump', candid_id: 3, num_votes: 0},
  {name: 'vladimir putin', candid_id: 4, num_votes: 0},
  {name: 'deng xiaoping', candid_id: 5, num_votes: 0} # Jeffrey Shen's big contribution to our team: see commit history for more details.
]

# Reset the database
Candid.all.delete_all
Vote.all.delete_all

# Put the initial candidates in
candidates.each do |candidate|
  Candid.create(candidate)
end
