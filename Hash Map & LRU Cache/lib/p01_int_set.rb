require "byebug"
class MaxIntSet
  attr_reader :store

  def initialize(max)
    @max = max
    @store = Array.new(max,false) 
  end

  def insert(num)
    is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    is_valid?(num)
    return @store[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if !num.between?(0,@max)
  end

end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end
  
  def insert(num)
    array = self[num]
    array << num if !array.include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % @store.length]# optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if self.include?(num)
    self[num] << num
    self.count += 1
    resize! if num_buckets < self.count
    return num
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      @count -=1
    end
  end

  def include?(num)
    arr = self[num]
    arr.include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets] # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_arr = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        new_arr[el % (num_buckets * 2)] << el
      end
    end
    @store = new_arr
  end
end


    # # if !self.include?(num)
    # #   @count += 1
    # #   if @count >= num_buckets
    # #     old_store = @store
    # #     @store = Array.new(num_buckets + 1) { Array.new } 
    # #     @store.each do |bucket|
    # #       bucket.each do |element|

    # #       end
    # #     end
    # #   else


    # #   end

      
      
      
    #   # @store.each do |bucket|
    #   #   bucket.each_with_index do |el, idx|
    #   #     to_move = el
    #   #     bucket[idx] = nil

    #   #   end
    #   #   bucket.delete(nil)
    #   # end
    # else
    #   return false
    # end
    # true