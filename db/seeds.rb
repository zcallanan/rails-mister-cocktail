# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

# DESTROY ALL EXISTING DATA

Cocktail.destroy_all
Dose.destroy_all
Ingredient.destroy_all

# BUILD INGREDIENTS

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
list = open(url).read
result = JSON.parse(list)
result["drinks"].each do |row|
  ingredient = Ingredient.new(name: row['strIngredient1'])
  ingredient.save
end

# GET ARRAY WITH ALCOHOL DRINK IDS

url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'
list = open(url).read
result = JSON.parse(list)
drink_ids = []
result['drinks'].each do |row|
  drink_ids << row['idDrink']
end

# BUILD COCKTAILS AND DOSES

drink_ids.each do |id|
  url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{id}"
  drink_details_json = open(url).read
  drink_details = JSON.parse(drink_details_json)
  cocktail = Cocktail.new(
    name: drink_details['drinks'][0]['strDrink'],
    description: drink_details['drinks'][0]['strInstructions'],
    picture_url: drink_details['drinks'][0]['strDrinkThumb']
  )
  cocktail.save
  ingredients = Ingredient.all
  ingredient_hash = {}
  ingredients.each do |ingredient|
    n = 0
    15.times do
      n += 1
      if ingredient['name'] == drink_details['drinks'][0]["strIngredient#{n}"]
        ingredient_hash[ingredient['id']] = drink_details['drinks'][0]["strMeasure#{n}"]
      end
    end
  end

  ingredient_hash.each do |key, value|
    dose = Dose.new(
      cocktail_id: cocktail.id,
      ingredient_id: key,
      description: value
    )
    dose.save
  end
end
