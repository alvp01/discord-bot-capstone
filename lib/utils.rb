def msg_splitter(msg)
  split_str = []
  split_str << msg.scan(/[+-]/)
  split_str << msg.scan(/\w*/).reject { |x| x.eql? '' }
  split_str
end

def msg_validator(arr)
  v = true
  arr[1].each do |elem|
    v &&= if elem.match?(/\A\d*d{1}(4|6|8|10|12|20|100)\z/)
            true
          elsif elem.eql? 'adv' or elem.eql? 'dis'
            true
          else
            elem.match?(/\A\d+\z/)
          end
  end
  v
end

def dice_parser(arr)
  dices_values = []
  arr.each do |e|
    dices_values << if e.include? 'd'
                      e.split('d')
                    else
                      e.scan(/\A\d+\z/)
                    end
  end
  dices_values
end

def val_translator(arr)
  values = arr.map do |e|
    e.map do |x|
      if x.eql? ''
        1
      else
        x.to_i
      end
    end
  end
  values
end

def dice_roller(arr)
  return arr if arr.length.eql? 1

  dices = []
  arr[0].times do |_x|
    dices << rand(1..arr[1])
  end
  dices
end

def calculator(op1, op2, ops)
  res = []
  x = op1.length != 1 ? op1.sum : op1[0]
  y = op2.length != 1 ? op2.sum : op2[0]
  x = ops == '+' ? x + y : x - y
  res << x
end

def adv_dis_translator(val)
  if val.length.eql? 2
    val[0] = 2 if val[1].eql? 20
  end
  val
end

def calculator_adv(op1, flg1, op2, flg2, ops)
  res = []
  x = if flg1
        op1.max
      else
        op1.length != 1 ? op1.sum : op1[0]
      end
  y = if flg2
        op2.max
      else
        op2.length != 1 ? op2.sum : op2[0]
      end
  x = x.send(ops, y)
  res << x
end

def calculator_dis(op1, flg1, op2, flg2, ops)
  res = []
  x = if flg1
        op1.min
      else
        op1.length != 1 ? op1.sum : op1[0]
      end
  y = if flg2
        op2.min
      else
        op2.length != 1 ? op2.sum : op2[0]
      end
  x = x.send(ops, y)
  res << x
end
