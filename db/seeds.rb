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
drink_ids = []
result['drinks'].each do |row|
  drink_ids << row['idDrink']
end

Cocktail.destroy_all
Dose.destroy_all

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
    if ingredient['name'] == drink_details['drinks'][0]['strIngredient1']
      ingredient_hash[ingredient['id']] = drink_details['drinks'][0]['strMeasure1']
    end
    if ingredient['name'] == drink_details['drinks'][0]['strIngredient2']
      ingredient_hash[ingredient['id']] = drink_details['drinks'][0]['strMeasure2']
    end
    if ingredient['name'] == drink_details['drinks'][0]['strIngredient3']
      ingredient_hash[ingredient['id']] = drink_details['drinks'][0]['strMeasure3']
    end
    if ingredient['name'] == drink_details['drinks'][0]['strIngredient4']
      ingredient_hash[ingredient['id']] = drink_details['drinks'][0]['strMeasure4']
    end
    if ingredient['name'] == drink_details['drinks'][0]['strIngredient5']
      ingredient_hash[ingredient['id']] = drink_details['drinks'][0]['strMeasure5']
    end
    if ingredient['name'] == drink_details['drinks'][0]['strIngredient6']
      ingredient_hash[ingredient['id']] = drink_details['drinks'][0]['strMeasure6']
    end
    if ingredient['name'] == drink_details['drinks'][0]['strIngredient7']
      ingredient_hash[ingredient['id']] = drink_details['drinks'][0]['strMeasure7']
    end
    if ingredient['name'] == drink_details['drinks'][0]['strIngredient8']
      ingredient_hash[ingredient['id']] = drink_details['drinks'][0]['strMeasure8']
    end
    if ingredient['name'] == drink_details['drinks'][0]['strIngredient9']
      ingredient_hash[ingredient['id']] = drink_details['drinks'][0]['strMeasure9']
    end
    if ingredient['name'] == drink_details['drinks'][0]['strIngredient10']
      ingredient_hash[ingredient['id']] = drink_details['drinks'][0]['strMeasure10']
    end
    if ingredient['name'] == drink_details['drinks'][0]['strIngredient11']
      ingredient_hash[ingredient['id']] = drink_details['drinks'][0]['strMeasure11']
    end
    if ingredient['name'] == drink_details['drinks'][0]['strIngredient12']
      ingredient_hash[ingredient['id']] = drink_details['drinks'][0]['strMeasure12']
    end
    if ingredient['name'] == drink_details['drinks'][0]['strIngredient13']
      ingredient_hash[ingredient['id']] = drink_details['drinks'][0]['strMeasure13']
    end
    if ingredient['name'] == drink_details['drinks'][0]['strIngredient14']
      ingredient_hash[ingredient['id']] = drink_details['drinks'][0]['strMeasure14']
    end
    if ingredient['name'] == drink_details['drinks'][0]['strIngredient15']
      ingredient_hash[ingredient['id']] = drink_details['drinks'][0]['strMeasure15']
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
