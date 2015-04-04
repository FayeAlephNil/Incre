require_relative 'lib/managers/game'

require_relative 'lib/managers/producer'

manager = GameManager.new
ProducerManager.new({'air' => 5, 'earth' => 4, 'water' => 3, 'fire' => 2}, 'Primal Core', manager, 1)
manager.crafter.add_recipe!({'water' => 2, 'earth' => 5}, ElementManager.new 'mud')
manager.crafter.add_recipe!({'air' => 3, 'fire' => 1}, ElementManager.new 'heat')

loop do # Main loop
  clone = manager.clone
  Thread.new { manager = clone.tick }.join
  clone.log_vals
  sleep 1
end
