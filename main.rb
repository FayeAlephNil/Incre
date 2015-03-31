require_relative 'lib/game'
require_relative 'lib/producer'
require_relative 'lib/element'


manager = GameManager.new
ProducerManager.new 'air', 10, 'Air Producer', manager, 1
ProducerManager.new 'earth', 5, 'Earth Producer', manager, 1

loop do # Main loop
  manager.tick
  sleep 1
  manager.log_vals
end
