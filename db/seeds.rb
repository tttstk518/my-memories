# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
Admin.create!(
   email: 'tttstk518@gmail.com',
   password: 'tatsuta5018'
)

 Genre.create!(
    [{ name: '居酒屋' }, { name: '本' }])
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
