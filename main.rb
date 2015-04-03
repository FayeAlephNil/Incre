require_relative 'lib/util/ruby_changes'

require_relative 'lib/managers/game'

require_relative 'lib/managers/producer'


manager = GameManager.new
ProducerManager.new('air', 10, 'Air Producer', manager, 1)
ProducerManager.new('earth', 5, 'Earth Producer', manager, 1)
manager.crafter.add_recipe!({'Air Producer' => 1, 'Earth Producer' => 1}, ProducerManager.new('fire', 15, 'Fire Producer'))

loop do # Main loop
  manager.tick!
  sleep 1
  manager.log_vals
end
