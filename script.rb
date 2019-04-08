module Enumerable

  def my_each
    i = 0
    arr = self.to_a
    while i < self.size
      yield arr[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    arr = self.to_a
    while i < self.size
      yield arr[i], i
      i += 1
    end
    self
  end

  def my_select
    arr = []
    for i in self
      if yield(i)
        arr << i
      end
    end

    arr
  end

  def my_all?
    arr = self.to_a
    false_counter = 0
    i = 0
    while i < self.size
      break if false_counter > 0
      if block_given?
          if yield(arr[i]) == false
            false_counter += 1
          end
      elsif arr[i].nil? or arr[i] == false
          false_counter += 1
      end
      i += 1
    end
    false_counter == 0 ? true : false
  end 

  def my_any?
    arr = self.to_a
    true_counter = 0
    i = 0
    while i < self.size
      break if true_counter > 0
      if block_given?
        if yield(arr[i]) == true
          true_counter += 1
        end
      elsif arr[i] != nil and arr[i] != false
        true_counter += 1
      end
      i += 1
    end
    true_counter == 0 ? false : true
  end


  def my_none?
    arr = self.to_a
    true_counter = 0
    i = 0
    while i < self.size
      break if true_counter > 0
      if block_given?
        if yield(arr[i]) == true
          true_counter += 1
        end
      elsif arr[i] != nil and arr[i] != false
        true_counter += 1
      end
      i += 1
    end
    true_counter == 0 ? true : false
  end 

  def my_count(target=nil)
    if !block_given? && target.nil?
      return self.size
    end

    count = 0
    self.my_each do |e|
      if block_given? && yield(e)
        count += 1
      elsif e == target
        count += 1
      end
    end

    count
  end 

  def my_inject(start = self[0])
    pointer = start
    self.my_each do |i|
      next if start == i 
      pointer = yield(pointer, i)
    end
    pointer
  end 

  #Modify your #my_map method to take either a proc
  def my_map(proc = nil)
    arr = self.to_a
    new_arr = Array.new
    i = 0
    while i < self.size
        if block_given?
          new_arr << yield(arr[i])
        else
          new_arr << proc.call(arr[i])
        end
        i += 1
    end
    new_arr
  end 
  
end
  
  #testing my_inject method 
def multiply_els (array_test)
  record = array_test.my_inject {|i, j| i * j}
  return record
end 

multiply_els ([2,4,5])
  
  
  # To test the methods:
  # array = [1,2,3,4,5,6]
  # array.my_each {|i| puts i}
  # array.my_each_with_index {|i,j| puts i.to_s + " " + j.to_s}
  # puts array.my_select {|i| i > 5}
  # puts array.select {|i| i > 5}
  # puts array.my_all? {|x| x > 0}
  # puts array.my_none {|x| x < 5}
  # puts array.my_any {|x| x < 3}
  # puts array.my_count {|i| i > 2}
  # puts array.my_map {|x| x*2}
  

  h = { "a" => 100, "b" => 200, "c" => 80 }
  # h.each {|k,v| puts v}
  h.my_each_with_index {|i,j| puts i.to_s + " " + j.to_s}
  # h.my_select {|k,v| k > "a"}
  # puts h.my_count
  # puts h.my_all? {|k, v| v < 10}
  # puts h.my_none? {|k,v| v < 90}
  # puts h.my_any? {|k,v| v < 90}
  # h.my_map { |k,v| v*2 } 