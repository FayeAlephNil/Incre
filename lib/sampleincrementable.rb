require_relative 'baseincrementable'
class SampleIncrementable < BaseIncrementable
  @@name = :sample_incrementable
  @@amount_per_increment = 1
  @@linked_attr = :sample_count
end
