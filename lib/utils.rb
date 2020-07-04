def msg_splitter(msg)
  split_str = []
  split_str << msg.scan(/[+-]/)
  split_str << msg.scan(/\w*/).reject {|x| x.eql? ""}
  split_str
end

def msg_validator(msg)
  return true if msg.index /\d*d(4|6|8|12|20|100)/
  
  false
end
