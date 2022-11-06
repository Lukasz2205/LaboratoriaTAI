# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Book.destroy_all
Role.destroy_all 
User.destroy_all
UserRole.destroy_all

Book.create!([{
  name: 'Harry Potter',
  description: 'Young Czarodzej',
  pages: 233,
  author: 'J. K. Rolwing',
  price: 23.00
},
{
  name: 'Tom Potter',
  description: 'Young Tom',
  pages: 2333,
  author: 'J. K. Rolwing',
  price: 23.00
},
{
  name: 'Ja, inwkizytor',
  description: 'inwkizytor',
  pages: 233,
  author: 'Jacek Piekara',
  price: 43.00
},
{
  name: 'Szybki i wolny',
  description: 'Szybki i wolny',
  pages: 233,
  author: 'Gessler',
  price: 13.00
},
{
  name: 'Super party',
  description: 'Masno fest',
  pages: 233,
  author: 'Szymon Besser',
  price: 223.00
}])

Role.create([{
  name: 'Administrator'
}, 
{
  name: 'User'
}])

User.create([{
  login: 'Radek',
  password: '1234'
},
{
  login: 'Stanislaw',
  password: '1234'
},
{
  login: 'Lukasz',
  password: '1234'
}])

UserRole.create([{
  user_id: User.first.id,
  role_id: Role.first.id
},
{
  user_id: User.last.id,
  role_id: Role.last.id
}])