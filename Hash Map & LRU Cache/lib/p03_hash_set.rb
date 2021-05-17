require_relative "p02_hashing.rb"
class HashSet
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return false if self.include?(key)
    self[key] << key
    self.count += 1
    resize! if num_buckets < self.count
    return key 
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self.count -= 1
      self[key].delete(key)
    end
  end

  private

  def [](key)
    @store[key.hash % num_buckets]  # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_arr = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        new_arr[el.hash % (num_buckets * 2)] << el
      end
    end
    @store = new_arr
  end
end
