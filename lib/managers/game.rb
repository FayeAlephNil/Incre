require_relative '../util/ruby_changes'

class GameManager
    #Allow access so that ProducerManagers can add themselves
    attr_reader :sub_managers

    #Initialize a new hash of elements and an array of producers
    def initialize(sub_managers = Hash.new(nil))
      @sub_managers = sub_managers
    end

    #Production of things
    def produce!(key, amount = 0)
      if @sub_managers[key] == nil
        raise 'Tryed to produce something which has not been added to the list of sub-managers'
      end
      @sub_managers[key].count += amount
    end

    #Use something. Returns false (and doesn't use) if the result is less than zero and true otherwise
    def use!(key, amount = 0)
        if @sub_managers[key].count >= amount
            @sub_managers[key].count -= amount
            return true
        end
        return false
    end

    def add_manager!(sub_manager)
      @sub_managers[sub_manager.name] = sub_manager
    end

    #Tick this GameManager
    def tick!
        #Cascade ticks down to subs
        @sub_managers.values.each do |sub_manager|
          sub_manager.tick self
        end
    end

    def log_vals
      @sub_managers.each do |key, sub_manager|
        p "There are #{sub_manager.count} of #{key}"
      end
    end

    def to_eval
      if @sub_managers.empty?
        return 'GameManager.new'
      end

      return "GameManager.new(#{@sub_managers.to_eval})"
    end

    def self.load
      return eval(saved)
    end
end
