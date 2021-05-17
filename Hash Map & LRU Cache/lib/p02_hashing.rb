class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    return 2349847234 if self.length < 1 
    hash_int = 1
    self.each_with_index do |el, idx|
      hash_int += el.to_s.length*27
      if el.is_a?(String)
        hash_int += 7453
        if el.length >= 3
          hash_int /= el[2].ord
          hash_int += 8
        else
          hash_int *= 35
          hash_int += 4
        end
      elsif el.is_a?(Array)
        el.hash
      elsif el.is_a?(Hash)
        hash_int += el.keys.length
        if el.keys.length >= 3
          hash_int *= el.keys[2].to_s.length + 15 
        end
      else
        hash_int += 234234
        hash_int /= 3
      end
      hash_int *= idx^4/7
    end
    hash_int
  end
end

class String
  def hash
    return 293842347627 if self.length == 0
    hash_int = 7453 * (self.length + 456)
    if self.length >= 3
      hash_int /= self[2].ord
      hash_int += 8
    else
      hash_int *= 35
      hash_int += 4
    end
    self.each_char.with_index {|char, idx| hash_int += char.ord**7 + ((idx + 234)%15)**5 + 14*idx}
    hash_int
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end

# p [3,"cat", "doggo", {:fred => 12, "fly" => 6554, 34576 => "rat"}].hash
# p "sdhjkfsdfb".hash