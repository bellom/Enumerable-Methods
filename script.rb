module Enumerable

  def my_each
    type = self.class
    if type == Array || type == Range
      for item in self
        yield item
      end
    elsif type == Hash
      keys = self.keys
      for key in keys
        value = self[key]
        yield(value)
        yield(key)
      end
    end
    return self
  end

  def my_each_with_index
    for i in (0...self.size) do
      yield(self[i], i)
    end
    self
  end

  def my_select
    array = []
    self.my_each do |i|
      array << i if yield(i)
    end
    array
  end

  def my_all
    self.my_each do |i|
      return false if not yield i 
    end
    true
  end

  def my_any
    self.my_each do |i| 
      return true if yield i 
    end
    false
  end 

  def my_none 
    self.my_each do |i|
      return false if yield i 
    end
    true 
  end 

  def my_count
    count = 0 
    self.my_each {|i| count += 1}
    count
  end

  # def my_map
  #   array = []
  #   self.my_each {|i| array << yield(i)}
  #   array
  # end 

  def my_inject(start = self[0])
    pointer = start
    self.my_each do |i|
      next if start == i 
      pointer = yield(pointer, i)
    end
    pointer
  end

  #Modify my_map method to take a proc instead.
  # def my_map(proc_map)
  #   array = []
  #   self.my_each {|i| array << proc_map.call(i)}
  #   array
  # end 

  #Modify your #my_map method to take either a proc
  def my_map(&proc_map)
    array = []
    self.my_each do |i|
      array << yield(i) if !proc_map
      array << proc_map.call(i)
    end 
    array
  end 
  
end
  
  #testing my_inject method 
def multiply_els (array_test)
  record = array_test.my_inject {|i, j| i * j}
  return record
end 

multiply_els ([2,4,5])
  
  
  #To test the methods:
  array = [1,2,3,4,5]
  array.my_each {|i| puts i}
  # array.my_each_with_index {|i,j| puts i.to_s + " " + j.to_s}
  # puts array.my_select {|i| i > 5}
  # puts array.select {|i| i > 5}
  # puts array.my_all {|x| x < 5}
  #puts array.my_none {|x| x < 5}
  #puts array.my_any {|x| x < 3}
  #puts array.my_count {|i| i > 2}
  #puts ["A","B"].my_map {|x| x.upcase}
  

h = { "a" => 100, "b" => 200, "c" => 300 }
  h.my_each {|i| puts i}
  h.my_each_with_index {|i,j| puts i.to_s + " " + j.to_s}
  #puts h.select {|k,v| k > "a"}
  #puts h.my_all {|k| k < 5}
  #puts h.my_none {|x| x < 5}
  #puts h.my_any {|x| x < 3}
  #puts h.my_count {|i| i > 2}
  #puts ["A","B"].my_map {|x| x.upcase}
