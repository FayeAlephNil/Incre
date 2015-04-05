require_relative 'crafting'

class GameManager
  attr_accessor :crafter

  # Initialize a new hash of elements and an array of producers
  def initialize(sub_managers = Hash.new, crafter = CraftingManager.new)
    @sub_managers = sub_managers
    crafter.manager = self
    @crafter = crafter
  end

  #Production of sub_managers
  def produce!(key, amount = 0, product = nil)
    if @sub_managers[key] == nil
      if product == nil
        raise 'Tryed to produce something which has not been added to the list of sub-managers'
      else
        self.add_manager! product
      end
    end
    @sub_managers[key].count += amount

    return self
  end

  # Immutable version of produce!
  def produce(key, amount = 0, product = nil)
    return self.clone.produce!(key, amount, product)
  end

  #Use something. Returns false (and doesn't use) if the result is less than zero and true otherwise
  def use!(key, amount = 0)
    if @sub_managers[key] == nil
      raise 'Tryed to use something which has not been added to the list of sub-managers'
    end

    if @sub_managers[key].count >= amount
      @sub_managers[key].count -= amount
        return true
      end
    return false
  end

  # Immutable version of use!
  def use
    result = self.clone
    if !(result.use!) then raise "Tryed to make a clone with use and got negative, handling myself" end
    return result
  end

  # Tick this GameManager
  def tick!
    # Cascade ticks down to subs
    @sub_managers.values.each do |sub_manager|
        sub_manager.tick self
    end
    return self
  end

  # Return a new ticked GameManager
  def tick
    return self.clone.tick!
  end

  # Adds a sub_manager to the hash of sub_managers under sub_manager.name
  def add_manager!(sub_manager)
    @sub_managers[sub_manager.name] = sub_manager
    return self
  end

  # Immutable version of add_manager!
  def add_manager(sub_manager)
    return self.clone.add_manager!(sub_manager)
  end

  # Gets the manager with key
  def get_manager(key)
    return @sub_managers[key]
  end

  # Makes a new copy of the sub_managers and returns it
  def get_subs
    return @sub_managers.clone
  end

  # Logs the critical values, useful for debugging
  def log_vals
    @sub_managers.each do |key, sub_manager|
      p "There are #{sub_manager.count} of #{key}"
    end
  end

  # Returns valid ruby to create a new copy of this with the same vars
  def inspect
    return "GameManager.new(#{@sub_managers.inspect}, #{@crafter.inspect})"
  end

  # equality test
  def eql?(other)
    if !(@crafter.eql?(other.crafter)) then return false end

    result = true
    threads = []

    @sub_managers.each do |key, value|
      threads << Thread.new {
        if !(other.get_subs[key].eql?(value)) then result = false end
      }
    end

    threads.each { |thr|
      thr.join
      if !result then break end
    }

    return result
  end

  # Saves the game to the path, with .save after it
  def save(path)
    begin
      File.write(path + '.save', self.inspect)
    rescue IOError
      return false
    end
    return true
  end

  # Returns a new GameManager form the save at path. Puts .save after the path
  def self.load(path = 'save')
    File.open(path + '.save', 'a+') do |file|
      to_load = file.read
      if to_load == '' then return GameManager.new end
      return eval to_load
    end
  end
end
