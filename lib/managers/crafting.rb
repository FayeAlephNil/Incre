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
    if check(ingredients)
      if product != nil
        if first
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
    result = true
    threads = []

    ingredients.each do |key, count|
      threads << Thread.new {
        if manager.get_subs[key] == nil || (manager.get_subs[key].count < count)
          result = false
        end
      }
    end

    threads.each { |thr|
      thr.join
      if !result then break end
    }

    return result
  end

  def eql?(other)
    result = true
    threads = []

    @recipes.each do |key, value|
      threads << Thread.new {
        if !(other.recipes[key].eql?(value))
          result = false
        end
      }
    end

    threads.each { |thr|
      thr.join
      if !result then break end
    }

    return result
  end

  def inspect
    return "CraftingManager.new(nil, #{@recipes.inspect})"
  end
end
