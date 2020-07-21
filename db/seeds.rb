# db/seeds.rb
users = [
  {name: 'Jon'},
  {name: 'Jane'},
]

users.each do |u|
  User.create(u)
end
