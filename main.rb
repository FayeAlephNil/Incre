require_relative 'lib/sampleincrementable'

$incrementable_count = Hash.new
$incrementable_count.default = 0
$incrementable_vals = Hash.new
$incrementable_vals.default = 0
$incrementables = Array.new

SampleIncrementable.new

loop do # Main loop
  $incrementables.each do |incrementable|
    if incrementable != nil
      incrementable.tick
    end
  end
  sleep 1
  p $incrementable_count
  p $incrementable_vals
end
