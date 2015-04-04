require_relative 'sub'

class ElementManager < SubManager
    #Makes a new element with name
    def initialize(name, manager = nil, count = 0)
      super(name, 'element', count, manager)
    end
end
