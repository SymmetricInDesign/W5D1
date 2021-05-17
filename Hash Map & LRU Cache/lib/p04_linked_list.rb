class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList 
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each {|node| return node.val if node.key == key}
    return nil
  end

  def include?(key)
    self.each {|node| return true if node.key == key}
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    prev_node = @tail.prev
    new_node.next = @tail
    new_node.prev = prev_node
    @tail.prev = new_node
    prev_node.next = new_node
    new_node
  end

  def update(key, val)
    self.each {|node| node.val = val if node.key == key}
  end

  def remove(key)
    node = nil
    self.each do |node1|
      node = node1 if node1.key == key
    end
    prev_node = node.prev
    next_node = node.next
    prev_node.next = next_node
    next_node.prev = prev_node
    node.prev = nil
    node.next = nil
  end

  def each(&prc)
    arr = []
    node = @head.next 
    while node.val != nil
      prc.call(node)
      node = node.next 
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

# list = LinkedList.new
# list.append(3,7)
# list.append(5,8)
# puts list
# p list.each
