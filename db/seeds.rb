# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create(id:1, email:'cat@gmail.com', username: 'cat', password:'valid_password', password_confirmation: 'valid_password')
user2 = User.create(id:2, email:'dog@gmail.com', username: 'dog', password:'valid_password', password_confirmation: 'valid_password')

concentrate1 = user1.recipes.create(id:1, category_id:1, recommended_strain_id:nil, title:'Cannabis Coconut Oil', image:'https://s3.amazonaws.com/leafly-s3/content/cannabis-and-coconut-oil-uses-benefits-and-a-recipe-to-make-your/QqYwInfNQHedUETFu2Dm_Subhead-2.jpg', description:'coconut oil has among the highest concentration of fatty acids (saturated fats). The surplus of these fatty acids in the coconut oil create a stronger binding agent for cannabinoids. ', prep_time: 360, concentrate: true,
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
concentrate2 = user1.recipes.create(id:2, category_id:1, recommended_strain_id:nil, title:'Rick Simpson Oil', image:nil, description:'Rick Simpson Oil, or RSO is a concentrated form of cannabis oil known to have medical benefits, particularly for cancer.', prep_time: 360, concentrate: true,
instructions_attributes: [
  { step: 'Place dry cannabis material into the 5-gallon bucket and pour in the solvent until the plant matter is covered.'},
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


concentrate3 = user1.recipes.create(id:3, category_id:1, recommended_strain_id:nil, title:'Cannabis-Infused Butter', image:'https://s3.amazonaws.com/leafly-s3/content/recipe-how-to-make-basic-cannabutter/HyiZ4sSkVIDtbpo9tnA6_Cannabutter-Body.jpg', description:'cannabis-infused butter (cannabutter) is one of the simplest and most common ways to make medicated foods, yet making infused butter properly can be a little bit tricky. In order for THC to properly decarboxylate—change from its acid form to its psychoactive form—the cannabis needs to be heated at low temperatures over long periods of time.', prep_time: 180, concentrate: true,
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


concentrate4 = user2.recipes.create(id:4, category_id:1, recommended_strain_id:nil, title:'Cannabis-Infused Olive Oil', image:nil, description:'It is super easy to infuse cannabis into your olive oil with the sous vide technique. Since you can fit many mason jars in a sous vide water bath, imagine the all the different flavored oil concoctions you can whip up all in one sitting! This technique is simple and discreet--no smell! ', prep_time: 240, concentrate: true,
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


concentrate5 = user2.recipes.create(id:5, category_id:1, recommended_strain_id:nil, title:'Cannabis Cooking Oil', image:'https://s3.amazonaws.com/leafly/content/recipe-how-to-make-cannabis-cooking-oil/TRaosPRdRpOyuSZfpMWe_large_6896388410.jpg', description:'cannabis-infused butter (cannabutter) is one of the simplest and most common ways to make medicated foods, yet making infused butter properly can be a little bit tricky. In order for THC to properly decarboxylate—change from its acid form to its psychoactive form—the cannabis needs to be heated at low temperatures over long periods of time.', prep_time: 180, concentrate: true, 
instructions_attributes: [
  { step: 'Add one cup of water and 1 lb of butter into a stock pot or sauce pan; let the butter melt and begin to simmer on low. Adding water helps to regulate the temperature and prevents the butter from scorching.'},
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
