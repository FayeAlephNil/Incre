require_relative 'lib/elements'
require_relative 'lib/producers'

manager = ElementsManager.new
ProducerManager.new 'air', 10, 'Air Producer', 1, manager
ProducerManager.new 'earth', 5, 'Earth Producer', 1, manager

loop do # Main loop
  manager.tick
  sleep 1
  manager.log_vals
end
