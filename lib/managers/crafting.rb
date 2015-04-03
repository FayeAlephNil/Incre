require_relative '../util/ruby_changes'

class CraftingManager
  attr_accessor :recipes
  attr_accessor :manager

  def initialize(manager = nil, recipes = Hash.new(nil))
    @recipes = recipes
    @manager = manager
  end

  def add_recipe!(ingredients, product)
    @recipes[ingredients] = product
    return self
  end

  def add_recipe(ingredients, product)
    self.clone.add_recipe!(ingredients, product)
  end

  def craft(ingredients, first = false, manager = @manager)
    if manager == nil then raise 'Did not provide a manager for this CraftingManager craft operation' end

    product = @recipes[ingredients]
    product.count = 1
    if checker(ingredients)
      if product != nil
        if first_element
          manager.sub_managers[product.name] = product
        else
          manager.produce!(product.name, 1)
        end
      end

      ingredients.each do |key, amount|
        manager.use!(key, amount)
      end
      return true
    end
    return false
  end

  def check(ingredients, manager = @manager)
    if manager == nil then raise 'Did not provide a manager for this CraftingManager check' end

    ingredients.each do |key, count|
      if manager.get_subs[key] = nil || (manager.get_subs[key].count < count)
        return false
      end
    end
    return true
  end

  def eql?(other)
    @recipes.each do |key, value|
      if !(other.recipes[key].eql?(value))
        return false
      end
    end

    return true
  end

  def to_eval
    return "CraftingManager.new(nil, #{@recipes.to_eval})"
  end
end
