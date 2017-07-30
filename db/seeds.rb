# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

untag = Tag.find_or_create_by(:title => 'unTag')
Tag.find_or_create_by(:title => 'Family')
Tag.find_or_create_by(:title => 'Animals')
Tag.find_or_create_by(:title => 'Children')
10.times{
  Photo.create(:title => '1',:tag => untag)
}
