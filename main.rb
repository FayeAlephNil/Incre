require_relative 'lib/elements'
require_relative 'lib/producers'

manager = ElementsManager.new
ProducerManager.new 'air', 10, 'Air Producer', 1, manager
ProducerManager.new 'earth', 5, 'Earth Producer', 1, manager

loop do # Main loop
  manager.tick
  sleep 1
  manager.get_elements.each do |key|
    p "We have #{manager.get_element key} elements of #{key}"
  end

  manager.producers.each do |key, producer|
    p "We have #{producer.count} #{key}s"
  end
end
