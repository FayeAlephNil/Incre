class SubManager
  attr_accessor :count
  attr_reader :name
  attr_reader :type

  def initialize(name, type = 'element', count = 0, manager = nil)
    @name = name
    @type = type
    @count = count
    if manager != nil then manager.add_manager self end
  end

  #Placeholder for subs to override if they need to
  def tick(manager)
  end
end
