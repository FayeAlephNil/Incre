require_relative 'lib/elements'
require_relative 'lib/producers'

manager = ElementsManager.new
ProducerManager.new 'air', 10, 1, manager
ProducerManager.new 'earth', 5, 1, manager

loop do # Main loop
  manager.tick
  sleep 1
  manager.get_elements.each do |key|
    p "We have #{manager.get_element key} elements of #{key}"
  end
end
