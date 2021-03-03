# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create({
                     email: 'rodrigomarcondes2000@gmail.com',
                     password: 'password',
                     confirmed_at: DateTime.now
                   })

books = [
  {
    name: '1984',
    author: 'George Orwell',
    genre: 'Politics, Sci-fi',
    pages: 300,
    relevance: 10,
    user_id: user.id
  },
  {
    name: 'Projeto Nacional - O dever da esperança',
    author: 'Ciro Ferreira Gomes',
    genre: 'Politics, Economy',
    pages: 300,
    relevance: 10,
    user_id: user.id
  }
]

books.each do |book|
  Book.create(book)
end
