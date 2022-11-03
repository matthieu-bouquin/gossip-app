require 'faker'

Faker::Config.locale = 'fr'

City.destroy_all 
User.destroy_all 
Gossip.destroy_all
Tag.destroy_all 
JoinGossipTag.destroy_all
PrivateMessage.destroy_all
Comment.destroy_all 
Like.destroy_all


5.times do |c|
  city = City.create!(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
end

50.times do |u|
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    age: rand(18..100),
    city_id: City.ids.sample,
    password: Faker::Lorem.paragraph_by_chars(number: 6)
  )
end

100.times do
  gossip = Gossip.create!(
    title: Faker::Lorem.paragraph_by_chars(number: 15),
    content: Faker::Lorem.paragraph,
    user_id: User.ids.sample
  )
end

5.times do
  tag = Tag.create!(title: Faker::Color.color_name)
end

100.times do
  rand_gossip_id = Gossip.find_by(id: rand(1..Gossip.all.length)) #tirage aléatoire d'un id de la table gossips parmi le nombre d'entrées de la table (en évitant l'id 0 qui n'existe pas...)
  rand_tag_id = Tag.find_by(id: rand(1..Tag.all.length)) #idem

  gossip_tag_join = JoinGossipTag.create!(gossip: rand_gossip_id, tag: rand_tag_id)
end

10.times do 
  user_random = User.all.sample
  user_random2 = User.all.sample
  
  while user_random == user_random2
    user_random2 = User.all.sample 
end
  

  PrivateMessage.create!(
    sender: user_random, 
    recipient: user_random2,
    content:Faker::Lorem.paragraph)
end

20.times do
  comment = Comment.create!(
    content: Faker::Lorem.sentence,
    gossip_id: Gossip.ids.sample,
    user_id: User.ids.sample
  )
end

50.times do
  like = Like.create!(
    user_id: User.ids.sample,
    comment_id: Comment.ids.sample,
    gossip_id: Gossip.ids.sample
  )
end