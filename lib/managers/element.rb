require_relative 'sub'

class ElementManager < SubManager

    # Rate is how many elements will be produced per count per tick. Element is the symbol to be produced in the ElementManager.
    def initialize(name, manager = nil, count = 0)
      super(name, 'element', count, manager)
    end

    def tick(manager)
    end
end
