require_relative 'lib/sampleincrementable'

CURRENT_GAME = IncrementableManager.new

SampleIncrementable.new
CURRENT_GAME.vals[:sample_gain] = 5

loop do # Main loop
  CURRENT_GAME.incrementables.each do |incrementable| # Tick each incrementable
    if incrementable != nil
      incrementable.tick
    end
  end
  sleep 1
  p CURRENT_GAME.incrementable_count
  p CURRENT_GAME.vals
end
