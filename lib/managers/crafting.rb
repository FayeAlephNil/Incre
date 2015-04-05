class CraftingManager
  attr_accessor :recipes
  attr_accessor :manager

  def initialize(manager = nil, recipes = Hash.new(nil))
    @recipes = recipes
    @manager = manager
  end

  # Adds the product (A sub_manager) to the recipes hash with the key of
  # ingredients (a hash of sub_manager names to numbers). The numbers in
  # the ingredients hash is how many will be used in the craft
  def add_recipe!(ingredients, product)
    @recipes[ingredients] = product
    return self
  end

  # returns a new instance with the recipe added. For immutability
  def add_recipe(ingredients, product)
    self.clone.add_recipe!(ingredients, product)
  end

  # Crafts what is associated in the recipes hash with ingredients
  # The ingredients hash is in the same format as in add_recipe!
  # optional manager is a GameManager, is by default @manager
  def craft(ingredients, manager = @manager)
    # Raise the exception ourselves instead of letting Ruby raise it
    if manager == nil then raise 'Did not provide a manager for this CraftingManager craft operation' end

    product = @recipes[ingredients]
    if check(ingredients) && product != nil
      # Produce, passing in product in case it does not exist
      manager.produce!(product.name, 1, product)

      # Use each of the different ingredients
      ingredients.each do |key, amount|
        manager.use!(key, amount)
      end
      return true
    end
    return false
  end

  # Checks if we have enough of the ingredients in the manager to do a craft
  def self.check(ingredients, manager = @manager)
    # Raise the exception ourselves instead of letting Ruby raise it
    if manager == nil then raise 'Did not provide a manager for this CraftingManager check' end
    # Default result is true, make a threads array
    result = true
    threads = []

    # Make a new thread for every key/value pair in ingredients
    ingredients.each do |key, count|
      threads << Thread.new {
        # In the thread do a nil check and check if the manager has < what is required
        if manager.get_subs[key] == nil || (manager.get_subs[key].count < count)
          result = false
        end
      }
    end

    # Initialize all the threads, breaking if result is ever false
    threads.each { |thr|
      thr.join
      if !result then break end
    }

    return result
  end

  # performs an equals check
  def eql?(other)
    # Default result is true, make a threads array
    result = true
    threads = []

    # Make a new thread for each key/value pair in recipes
    @recipes.each do |key, value|
      threads << Thread.new {
        # In the thrad, check if the values for the keys are !equal.
        if !(other.recipes[key].eql?(value))
          result = false
        end
      }
    end

    # Initialize all the threads, breaking if result is ever false
    threads.each { |thr|
      thr.join
      if !result then break end
    }

    return result
  end

  # Makes a string that will make a new CraftingManager with the same variables
  def inspect
    return "CraftingManager.new(nil, #{@recipes.inspect})"
  end
end
