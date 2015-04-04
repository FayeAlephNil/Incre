require_relative 'lib/managers/game'

require_relative 'lib/managers/producer'

p 'Do you want to load the save? (y/n)'
manager = if gets.chomp == 'y' then GameManager.load else GameManager.new end
ProducerManager.new({'air' => 5, 'earth' => 4, 'water' => 3, 'fire' => 2}, 'Primal Core', manager, 1)
manager.crafter.add_recipe!({'water' => 2, 'earth' => 5}, ElementManager.new('mud'))
manager.crafter.add_recipe!({'air' => 3, 'fire' => 1}, ElementManager.new('heat'))
manager.crafter.add_recipe!({'earth' => 20, 'fire' => 40}, ElementManager.new('lava'))
manager.crafter.add_recipe!({'lava' => 20, 'water' => 10}, ElementManager.new('obsidian'))
manager.crafter.add_recipe!({'heat' => 100, 'fire' => 20}, ElementManager.new('energy'))
manager.crafter.add_recipe!({'water' => 20, 'fire' => 30}, ElementManager.new('steam'))
manager.crafter.add_recipe!({'air' => 30, 'fire' => 20}, ElementManager.new('wind'))
manager.crafter.add_recipe!({'lava' => 20, 'wind' => 10}, ElementManager.new('stone'))
manager.crafter.add_recipe!({'stone' => 30, 'wind' => 50}, ElementManager.new('gravel'))
manager.crafter.add_recipe!({'gravel' => 30, 'wind' => 50}, ElementManager.new('sand'))
manager.crafter.add_recipe!({'mud' => 20, 'sand' => 20}, ElementManager.new('clay'))
manager.crafter.add_recipe!({'sand' => 20, 'heat' => 70}, ElementManager.new('glass'))
manager.crafter.add_recipe!({'gravel' => 20, 'heat' => 70}, ElementManager.new('concrete'))
manager.crafter.add_recipe!({'clay' => 20, 'heat' => 70}, ElementManager.new('brick'))
manager.crafter.add_recipe!({'mud' => 30, 'energy' => 100}, ElementManager.new('organism'))

loop do # Main loop
  clone = manager.clone
  Thread.new { manager = clone.tick }.join
  clone.log_vals
  p 'Command for this run, nil if no command'
  eval gets.chomp
  sleep 1
end
