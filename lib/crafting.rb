class CraftingManager
  attr_accessor :recipes

  def initialize(manager, recipes = Hash.new(nil))
    @manager = manager
    @recipes = recipes
  end

  def add_recipe(ingredients, product)
    @recipes[ingredients] = product
  end

  def craft(ingredients, first = false)
    product = @recipes[ingredients]
    product.count = 1
    if checker(ingredients)
      if product != nil
        if first_element
          @manager.sub_managers[product.name] = product
        else
          @manager.produce product.name, 1
        end
      end

      ingredients.each do |key, amount|
        @manager.use key, amount
      end
    end
  end

  def checker(ingredients)
    ingredients.each do |key, count|
      if @manager.sub_managers[key] = nil || !@manager.sub_managers[key].count < count
        return false
      end
    end
    return true
  end
end
