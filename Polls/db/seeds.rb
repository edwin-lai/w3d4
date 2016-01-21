# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times { User.create!(user_name: Faker::Name.name) }

20.times { Poll.create!(
  title: Faker::Hipster.words(Random.new.rand(3..7)).join(" ").capitalize,
  author_id: Random.new.rand(1..10)
  ) }

100.times { Question.create!(
  poll_id: Random.new.rand(1..20),
  question: Faker::Hipster.sentence
  ) }

400.times { AnswerChoice.create!(
  question_id: Random.new.rand(1..100),
  answer_choice: Faker::Hacker.say_something_smart
  ) }

800.times { Response.create!(
  user_id: Random.new.rand(1..10),
  answer_choice_id: Random.new.rand(1..400)
  ) }
