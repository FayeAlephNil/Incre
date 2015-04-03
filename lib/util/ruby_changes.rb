class String
  def to_eval
    return "\"#{self}\""
  end
end

class Hash
  def to_eval
    result = []
    each do |key, producer|
      result << "#{key.to_eval} => #{producer.to_eval}"
    end
    hash = "{#{result.join ", "}}"

    return "Hash.new(#{self.default}).merge(#{hash})"
  end
end
