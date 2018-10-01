# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:


110.times do
  Link.create(url: "https://www.#{Faker::Address.city.gsub(' ','').downcase}.com", access_count: rand(0..100))
end
