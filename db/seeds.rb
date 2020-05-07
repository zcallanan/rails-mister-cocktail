# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

# Construct the URL we'll be calling
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

# Actually fetch the contents of the remote URL as a String.
list = open(url).read

list.each do |row|

end
