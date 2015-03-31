require_relative 'baseincrementable'
class SampleIncrementable < BaseIncrementable
  @@name = :sample_incrementable
  @@amount_per_increment = 1
  @@attr_to_increase = :sample_count
  @@bind_attr = :sample_gain
end
