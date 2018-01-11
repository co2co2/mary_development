# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
res = HTTParty.get('http://strainapi.evanbusse.com/sj4h0h8/strains/search/all')
      body = JSON.parse(res.body)

      body.keys[0..10].each do |key|
        @strain = Strain.new
        @strain.name = key
        @strain.race = body[key]["race"]
        @strain.flavours = body[key]["flavors"][0]
        @strain.effect = body[key]["effects"]["positive"][0]
        @strain.save
      end
# Users
user1 = User.create!(id:1, email:'cat@gmail.com', username: 'cat', password:'valid_password', password_confirmation: 'valid_password')
user2 = User.create!(id:2, email:'dog@gmail.com', username: 'dog', password:'valid_password', password_confirmation: 'valid_password')
user3 = User.create!(id:3, email:'coco@gmail.com', username: 'coco', password:'valid_password', password_confirmation: 'valid_password')
user4 = User.create!(id:4, email:'lena@gmail.com', username: 'lena', password:'valid_password', password_confirmation: 'valid_password')
user5 = User.create!(id:5, email:'william@gmail.com', username: 'william', password:'valid_password', password_confirmation: 'valid_password')
user6 = User.create!(id:6, email:'tyler@gmail.com', username: 'tyler', password:'valid_password', password_confirmation: 'valid_password')

# Categories
concentrate_category = RecipeCategory.create!(name: 'Concentrates')
RecipeCategory.create!(name: 'Appetizers')
RecipeCategory.create!(name: 'Beverages')
desserts = RecipeCategory.create!(name: 'Desserts')
RecipeCategory.create!(name: 'Entrées')
snacks = RecipeCategory.create!(name: 'Snacks')
sides = RecipeCategory.create!(name: 'Sides')
# Predefined Concentrate Recipes
concentrate1 = user1.recipes.create!(id:1, recipe_category_id: concentrate_category.id, strain_id:1, title:'Cannabis Coconut Oil', image:'https://s3.amazonaws.com/leafly-s3/content/cannabis-and-coconut-oil-uses-benefits-and-a-recipe-to-make-your/QqYwInfNQHedUETFu2Dm_Subhead-2.jpg', description:'coconut oil has among the highest concentration of fatty acids (saturated fats). The surplus of these fatty acids in the coconut oil create a stronger binding agent for cannabinoids. ', prep_time: 360, concentrate: true,
instructions_attributes: [
  { step: 'Grind the cannabis. You can include the entire plant, just the flower, a little bit of both — this is all a matter of preference. Just keep in mind that anything small enough to fit through the strainer will end up in your finished product, so again, do not grind your cannabis to a fine powder.'},
  {step: 'Combine oil and cannabis in your double-boiler or slow cooker, and heat the two together on low or warm for a few hours. This allows for decarboxylation (activation of THC) without scorching (which destroys the active ingredients). Cooking can be done a variety of ways: in a slow cooker on low for 4-6 hours, stirring occasionally; in a double-boiler on low for at least 6 hours (8 is better), stirring occasionally; or in a simple saucepan on low for at least three hours, stirring frequently (a saucepan is most susceptible to scorching). In all cases, a small amount of water can be added to the mixture to help avoid burning. Note: whatever method you choose, temperature of the oil should not exceed 245°F.'},
  {step: 'Strain and store the oil. Do not squeeze the cheesecloth; this will simply add more chlorophyll to your oil. All remaining plant material can be discarded or used in other dishes if you have the wherewithal. The oil’s shelf life is at least two months, and can be extended with refrigeration.'}],
measurements_attributes: [
    {quantity:'1 cup', ingredient_attributes:
      {name:'ground cannabis flower'}
    },
    {quantity:'1 cup', ingredient_attributes:
      {name:'coconut oil'}
    }
  ]
)
# Rick Simpson Oil
concentrate2 = user1.recipes.create!(id:2, recipe_category_id:concentrate_category.id, strain_id:1, title:'Rick Simpson Oil', image:'https://cannabis.net/drive/1000/media/ricks.gif', description:'Rick Simpson Oil, or RSO is a concentrated form of cannabis oil known to have medical benefits, particularly for cancer.', prep_time: 360, concentrate: true,
instructions_attributes: [
  {step: 'Place dry cannabis material into the 5-gallon bucket and pour in the solvent until the plant matter is covered.'},
  {step: 'Stir and crush the plant material with your wooden spoon while adding the solvent to your mixture. Continue stirring the mixture for about three minutes while the THC dissolves into the solvent. This will dissolve about 80% of the THC into the solvent.'},
  {step: 'Drain the solvent from the plant material into your bowl using the cheesecloth. Place the plant material back in the bucket and add more solvent. Continue stirring for another three minutes.'},
  {step: 'Drain the solvent from your plant material into your bowl using the cheesecloth and discard the remaining plant material.'},
  {step: 'Transfer your solvent to your rice cooker until it is about ¾ full and turn on your rice cooker.'}
],
measurements_attributes: [
    {quantity:'1 pound', ingredient_attributes:
      {name:'dried cannabis material (indica strain)'}
    },
    {quantity:'2 gallons', ingredient_attributes:
      {name:'99% isopropyl alcohol as solvent'}
    },
  ]
)
#  Cannabutter


concentrate3 = user1.recipes.create!(id:3, recipe_category_id:concentrate_category.id, strain_id:1, title:'Cannabis-Infused Butter', image:'https://s3.amazonaws.com/leafly-s3/content/recipe-how-to-make-basic-cannabutter/HyiZ4sSkVIDtbpo9tnA6_Cannabutter-Body.jpg', description:'cannabis-infused butter (cannabutter) is one of the simplest and most common ways to make medicated foods, yet making infused butter properly can be a little bit tricky. In order for THC to properly decarboxylate—change from its acid form to its psychoactive form—the cannabis needs to be heated at low temperatures over long periods of time.', prep_time: 180, concentrate: true,
instructions_attributes: [
  { step: 'Add one cup of water and 1 lb of butter into a stock pot or sauce pan; let the butter melt and begin to simmer on low. Adding water helps to regulate the temperature and prevents the butter from scorching.'},
  {step: 'As butter begins to melt, add in your ground cannabis product.'},
  {step: 'Maintain low heat and let the mixture simmer for 2-3 hours, stirring occasionally. Make sure the mixture never comes to a full boil.'}
],
measurements_attributes: [
    {quantity:'1 lb', ingredient_attributes:
      {name:'unsalted butter'}
    },
    {quantity:'1 cup', ingredient_attributes:
      {name:'water'}
    },
    {quantity:'1 ounce', ingredient_attributes:
      {name:'ground cannabis flower'}
    }
  ]
)


concentrate4 = user2.recipes.create!(id:4, recipe_category_id:concentrate_category.id, strain_id:1, title:'Cannabis-Infused Olive Oil', image:'http://www.ethiopianimporter.com/imagesexport/72oil-seed.jpg', video:'https://www.youtube.com/embed/hEz0zkzGQGQ', description:'It is super easy to infuse cannabis into your olive oil with the sous vide technique. Since you can fit many mason jars in a sous vide water bath, imagine the all the different flavored oil concoctions you can whip up all in one sitting! This technique is simple and discreet--no smell! ', prep_time: 240, concentrate: true,
instructions_attributes: [
  { step: 'Pour olive oil in two 12oz mason jars. It is important to use jars specific to canning, so please no repurposed mayo jars. Inspect the jar for cracks. A freezer-safe zip bag may be used as well.'},
  {step: 'Decarb your cannabis to activate the THC and pour half into each jar of olive oil. Seal the jars finger tight.'},
  {step: 'Set your sous vide water bath to 85ºC (185ºF). '},
  {step: 'Once the sous vide water bath has reached its temp, gently place the jars in the water bath. '},
  {step: 'Sous vide for 4 hours. Remove from water bath and strain. Discard the clippings and allow the infused olive oil to cool. Store in a cool dark place.'},
],
measurements_attributes: [
    {quantity:'16oz ', ingredient_attributes:
      {name:'extra virgin olive oil'}
    },
    {quantity:'1 oz', ingredient_attributes:
      {name:'cannabis clippings/trim or flowers'}
    }
  ]
)

concentrate5 = user2.recipes.create!(id:5, recipe_category_id:concentrate_category.id, strain_id:1, title:'Cannabis Cooking Oil', image:'https://s3.amazonaws.com/leafly/content/recipe-how-to-make-cannabis-cooking-oil/TRaosPRdRpOyuSZfpMWe_large_6896388410.jpg', description:'cannabis-infused butter (cannabutter) is one of the simplest and most common ways to make medicated foods, yet making infused butter properly can be a little bit tricky. In order for THC to properly decarboxylate—change from its acid form to its psychoactive form—the cannabis needs to be heated at low temperatures over long periods of time.', prep_time: 180, concentrate: true,
instructions_attributes: [
  {step: 'Add one cup of water and 1 lb of butter into a stock pot or sauce pan; let the butter melt and begin to simmer on low. Adding water helps to regulate the temperature and prevents the butter from scorching.'},
  {step: 'As butter begins to melt, add in your ground cannabis product.'},
  {step: 'Maintain low heat and let the mixture simmer for 2-3 hours, stirring occasionally. Make sure the mixture never comes to a full boil.'}
],
measurements_attributes: [
    {quantity:'1 cup', ingredient_attributes:
      {name:'ground cannabis flower'}
    },
    {quantity:'1 cup', ingredient_attributes:
      {name:'cooking oil of your choice'}
    }
  ]
)
recipe1 = user3.recipes.create!(id:6, recipe_category_id: snacks.id, strain_id:1, title:'Dope Beets: A Hummus Collab with Bloom Farms', image:'https://static1.squarespace.com/static/5541baefe4b0d1854a60b4bc/5a4c326f085229be305f2d51/5a4c326f53450a16cf26d26f/1514943104198/SousWeed_DopeBeetHummus_6B7A9340_LoRes.jpg?format=300w', description:'The roasted beets add a mellow sweetness and rosy color to a basic hummus recipe. The texture is sultry smooth and goes great with warm pita or crisp veggies. If you have your Sous Weed olive oil prepared, it’s quick to throw together in a blender and is sure to be a hit at your next get-together.', prep_time: 70, concentrate: true,
instructions_attributes: [
  {step: 'Pre-heat oven to 375ºF.'},
  {step: 'Lightly wrap peeled beets in foil and roast for about an hour.'},
  {step: 'Halve the roasted beets and add to food processor or blender and blend with all ingredients until smooth.'},
  {step: 'Salt and pepper to taste. Add additional lemon juice or spices if needed.'},
  {step: 'Drizzle a little olive oil on top and garnish with herbs, nuts, and seeds.'},
  {step: 'Serve with veggies and pita for dipping.'}
],
measurements_attributes: [
    {quantity:'1/4 cup', ingredient_attributes:
      {name:'Cannabis-Infused Olive Oil'}
    },
    {quantity:'2', ingredient_attributes:
      {name:'red beets'}
    },
    {quantity:'1 can', ingredient_attributes:
      {name:'chickpeas'}
    },
    {quantity:'1/2', ingredient_attributes:
      {name:'lemon'}
    },
    {quantity:'2', ingredient_attributes:
      {name:'garlic cloves(smashed)'}
    },
    {quantity:'1 tea spoon', ingredient_attributes:
      {name:'cumin(ground)'}
    },
    {quantity:'2 tea spoon', ingredient_attributes:
      {name:'tahini'}
    },
    {quantity:'some', ingredient_attributes:
      {name:'salt'}
    },
    {quantity:'some', ingredient_attributes:
      {name:'cracked black pepper'}
    }
  ]
)

recipe2 = user4.recipes.create!(id:7, recipe_category_id:desserts.id, strain_id:1, title:'Smoky-Sweet Pineapple Fruitcake', image:'https://static1.squarespace.com/static/5541baefe4b0d1854a60b4bc/5a3c691e8165f53e1ebf2ed8/5a3c699424a694df8674714c/1513908659466/SousWeed_BloomFarms_HolidayPairing-3842.jpg?format=300w', description:'Woodsy, Earthy, Fruity!CBD-heavy to bring down the high, chill-out.', prep_time: 60, concentrate: true,
instructions_attributes: [
  {step: 'Preheat oven to 350ºF and grease an 8-in non-stick bundt pan.'},
  {step: 'Melt 3 Tbsp butter in a skillet over medium-high and add brown sugar. Cook until you see bubbles then add pineapple and cook for 2-3 minutes, until softened. Remove from heat and pour into the prepared cake pan.'},
  {step: ' In a small bowl, soak dried cherries in mezcal.'},
  {step: 'In a medium bowl, mix all-purpose flour, baking powder, salt, and ginger.'},
  {step: ' With an electric mixer, beat  ½ cup butter and ¾ cup sugar until whipped and fluffy. Start adding eggs one at a time until the mixture is uniform. Add in vanilla. Reduce the speed and slowly add in ⅓ of the flour mixture and ½ of the milk, beat until uniform before repeating with more flour and milk until all is incorporated.'},
  {step: ' Using a spatula, fold the soaked mezcal cherries into the batter until evenly distributed. Pour the batter into the cake pan on top of the pineapple.'},
  {step: ' Bake in the oven for 30 minutes or until a cake tester inserted into the center of the cake comes out clean.'},
  {step: 'Remove from the oven and let cool for about 15 minutes before releasing the cake from the pan. Carefully peel off the parchment paper and serve warm.'}
],
measurements_attributes: [
    {quantity:'1/2 cup', ingredient_attributes:
      {name:'brown sugar'}
    },
    {quantity:'2 cups', ingredient_attributes:
      {name:'fresh pineapple'}
    },
    {quantity:'1/4 cup', ingredient_attributes:
      {name:'mezcal'}
    },
    {quantity:'1/3 cup', ingredient_attributes:
      {name:'dried sour cherries'}
    },
    {quantity:'1 1/2 cups', ingredient_attributes:
      {name:'all-purpose flour'}
    },
    {quantity:'3 teaspoon', ingredient_attributes:
      {name:'butter'}
    },
    {quantity:'2 teaspoon', ingredient_attributes:
      {name:'baking powder'}
    },
    {quantity:'1/2 teaspoon', ingredient_attributes:
      {name:'salt'}
    },
    {quantity:'1/4 teaspoon', ingredient_attributes:
      {name:'ground ginger'}
    },
    {quantity:'3/4 cup', ingredient_attributes:
      {name:'granulated sugar'}
    },
    {quantity:'1/3 cup', ingredient_attributes:
      {name:'milk'}
    },
    {quantity:'1 teaspoon', ingredient_attributes:
      {name:'vanilla extract'}
    },
    {quantity:'2', ingredient_attributes:
      {name:'eggs'}
    },
    {quantity:'1/2cup', ingredient_attributes:
      {name:'Cannabis-Infused Butter'}
    }
  ]
)
recipe3 = user5.recipes.create!(id:8, recipe_category_id:sides.id, strain_id:2, title:'Stuffed Portabella Mushrooms with Sundried Tomatoes', image:'https://static1.squarespace.com/static/5541baefe4b0d1854a60b4bc/5a3c691e8165f53e1ebf2ed8/5a3c69690d92975090bdbc1f/1513908631359/SousWeed_BloomFarms_HolidayPairing-3935.jpg?format=300w', description:'Black Jack(strain) from Bloom Farms,Earthy, Sweet, Pine, make you euphoric and talkative', prep_time: 45, concentrate: false,
instructions_attributes: [
  {step: 'Preheat oven to 400ºF.'},
  {step: 'In large bowl, toss portobello mushrooms in canola oil and set aside.'},
  {step: 'Finely chop sun-dried tomatoes and reserve 1 TBSP of the oil. Heat a skillet over moderate heat and add the sun-dried tomatoes, reserved oil, shallots, garlic, and salt. Stir until shallots are softened and add in chopped spinach. Cook for an additional minute.'},
  {step: 'Remove the spinach mixture from heat and mix in egg yolk, bread crumbs, and basil pesto until uniform.'},
  {step: 'Mound the stuffing into the portobello mushroom caps. Arrange on a baking sheet and shave asiago cheese on top. Bake for 15 minutes.'},
  {step: 'Drizzle olive oil on top before serving.'}
],
measurements_attributes: [
    {quantity:'1/4 cup', ingredient_attributes:
      {name:'canola oil'}
    },
    {quantity:'3', ingredient_attributes:
      {name:'portobella mushroom'}
    },
    {quantity:'1 cup', ingredient_attributes:
      {name:'spinach'}
    },
    {quantity:'1/4 cup', ingredient_attributes:
      {name:'shallots(minced)'}
    },
    {quantity:'5', ingredient_attributes:
      {name:'tomatoes(sun-dried packed in oil)'}
    },
    {quantity:'1/2 teaspoon', ingredient_attributes:
      {name:'salt'}
    },
    {quantity:'2 teaspoon', ingredient_attributes:
      {name:'basil pesto'}
    },
    {quantity:'some', ingredient_attributes:
      {name:'Shaved asiago cheese'}
    },
    {quantity:'some', ingredient_attributes:
      {name:'Shaved asiago cheese'}
    },
    {quantity:'1/3 cup', ingredient_attributes:
      {name:'bread crumbs'}
    },
    {quantity:'2 teaspoon', ingredient_attributes:
      {name:'extra virgin olive oil'}
    },
    {quantity:'1', ingredient_attributes:
      {name:'egg yolk'}
    }
  ]
)
