class CraftingManager
  attr_accessor :recipes

  def initialize(manager, recipes = Hash.new(nil))
    @manager = manager
    @recipes = recipes
  end

  def add_recipe(ingredients, product)
    @recipes[ingredients] = product
  end

  def craft(ingredients, first_element = false)
    product = @recipes[ingredients]
    if product != nil
      if first_element then
        @manager.produce_element(product, 1)
      else
        @manager.produce_general(product, 1)
      end
    end
  end
end
