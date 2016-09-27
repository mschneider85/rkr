# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

uuid = 'd2b4dc9b-3b46-4beb-98be-0e9c98c765de'
1000.times do
  snippet = Snippet.create(title: 'test', body: '<html><title>hello</title><html>', language: 'yaml')
  snippet.create_temp_association(uuid: uuid)
end

# 1000.times do
#   %w(application_record identity snippet user).each do |file|
#     user = User.all.sample
#     title = (0...8).map { (65 + rand(26)).chr }.join
#     Snippet.create(author: user, title: title, body: open("app/models/#{file}.rb").read, language: Snippet.languages.keys.sample)
#   end
# end
