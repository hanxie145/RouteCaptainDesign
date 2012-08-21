# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

locations = [{name: "Canada"}, {name: "USA"}, {name: "Mexico"}, {name: "Chile"}, {name: "Peru"}]
products = [{name: "Gold"}, {name: "Silver"}, {name: "Copper"}, {name: "Zinc"}, {name: "Uranium"},
            {name: "Rare Earth"}, {name: "Magnesium"}, {name: "Manganese"}]
exchanges = [{name: "Toronto Venture Exchange", abv: "TSX.V", barchart: "VN", prefix: "V"}]
topics = [{name: "Markets"}, {name: "Metal Markets"}, {name: "Gold"}, {name: "Silver"}, {name: "Juniors"}]
groups = [{name: "Reaugh"}, {name: "Manex"}]

Location.collection.insert(locations)
Product.collection.insert(products)
Exchange.collection.insert(exchanges)
Topic.collection.insert(topics)
Group.collection.insert(groups)