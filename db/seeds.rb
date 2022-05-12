# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

City.delete_all
User.delete_all
Gossip.delete_all
Tag.delete_all
Comment.delete_all

cities = []
users = []
gossips = []
tags = []
comments = []

10.times do
  city = City.create(name: Faker::Nation.capital_city, zip_code: Faker::Number.number(digits: 5))
  cities << city
  puts "CITY ====> #{city.name} created"
end

10.times do
  user = User.create(first_name: Faker::TvShows::NewGirl.character, last_name: Faker::TvShows::GameOfThrones.house, email: Faker::Internet.email, description:Faker::Lorem.sentence(word_count: 50), age: Faker::Number.within(range: 18..99), city_id: City.all.sample.id, password_digest: Faker::Internet.password)
  users << user
  puts "USER  ====> #{user.first_name} created"
end

20.times do
  gossip = Gossip.create(title: Faker::TvShows::Friends.location, content:Faker::TvShows::Friends.quote, user_id: User.all.sample.id)
  gossips << gossip
  puts "GOSSIP  ====> #{gossip.title} a été créé"
end

10.times do
  tag = Tag.create(title: Faker::Lorem.word)
  tags << tag
  puts "TAG  ====> #{tag.title} a été créé"
end

Gossip.all.each do |gos|
  JoinTableTagGossip.create(gossip:gos, tag: tags.sample)
  puts "TAG-GOSSIP CRÉÉ"
end

40.times do
  comment=Comment.create(content: Faker::TvShows::GameOfThrones.quote, gossip_id: Gossip.all.sample.id, user_id: User.all.sample.id)
  comments << comment
  puts "COMMENTAIRE ===> le commentaire n°#{comment.id} a été créé"
end