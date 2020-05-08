# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

# Ingredient.destroy_all

# url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
# list = open(url).read
# result = JSON.parse(list)
# result["drinks"].each do |row|
#   ingredient = Ingredient.new(name: row["strIngredient1"])
#   ingredient.save
# end

url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'
list = open(url).read
result = JSON.parse(list)
