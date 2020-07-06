def msg_splitter(msg)
  split_str = []
  split_str << msg.scan(/[+-]/)
  split_str << msg.scan(/\w*/).reject { |x| x.eql? '' }
  split_str
end

def msg_validator(arr)
  v = true
  arr[1].each do |elem|
    v &&= if elem.match?(/\d*d{1}(4|6|8|10|12|20|100)\z/)
            true
          elsif elem.eql? 'adv' or elem.eql? 'dis'
            true
          else
            (elem.match?(/\d+/) and !elem.match?(/[a-z]/))
          end
  end
  v
end

def dice_get(arr)
  x = arr[1][0]
  puts x
end
