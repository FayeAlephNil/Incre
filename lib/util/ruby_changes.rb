class Fixnum
  def to_eval
    return to_s
  end
end

class Bignum
  def to_eval
    return to_s
  end
end

class String
  def to_eval
    return "\"#{self}\""
  end
end

class Hash
  def safe_invert
    self.each_with_object( {} ) { |(key, value), out| ( out[value] ||= [] ) << key }
  end

  def to_eval
    result = []
    each do |key, producer|
      result << "#{key.to_eval} => #{producer.to_eval}"
    end
    hash = "{#{result.join ", "}}"

    return "Hash.new(#{self.default}).merge(#{hash})"
  end
end
