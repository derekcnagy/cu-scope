# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.index([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.index(name: 'Luke', movie: movies.first)

Team.create(team_name: 'No Team')
UserType.create(type_name: 'Admin')
UserType.create(type_name: 'Contributor')
UserType.create(type_name: 'Team Contributor')
UserType.create(type_name: 'Viewer')