class SubManager
  attr_accessor :count
  attr_reader :name
  attr_reader :type

  def initialize(name, type = 'element', count = 0, manager = nil)
    @name = name
    @type = type
    @count = count
    if manager != nil then manager.add_manager! self end
  end

  # Placeholder for subs to override if they need to
  def tick(manager)
  end

  # Returns valid ruby to create a new copy of this with the same vars
  def inspect
    return "SubManager.new(#{@name.inspect}, #{@type.inspect}, #{@count.inspect})"
  end

  # equality test
  def eql?(other)
    if @name != other.name || @type != other.type || @count != other.count
      return false
    end

    return true
  end
end
