# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times { User.create!(user_name: Faker::name) }

200.times { Poll.create!(
  title: Faker::Hipster.sentence,
  author_id: Random.new.rand(1..100)
  ) }
