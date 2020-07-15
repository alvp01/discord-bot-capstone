require_relative '../lib/utils.rb'

describe 'msg_splitter' do
  msg1 = 'd20 + 4 + d4 + 6'
  msg2 = 'd20 + 4 + d4 + 6 * 3 * d5'
  msg3 = 'd100 adv'

  it 'recieves a string with parameters and returns an array of string arrays' do
    expect(msg_splitter(msg1)).to eql([['+', '+', '+'], %w[d20 4 d4 6]])
  end

  it 'ignores operators different from + or -' do
    expect(msg_splitter(msg2)).to eql([['+', '+', '+'], %w[d20 4 d4 6 3 d5]])
  end

  it 'the first array is empty if no operator is recieved' do
    expect(msg_splitter(msg3)).to eql([[], %w[d100 adv]])
  end
end

describe 'msg_validator' do
  arr1 = [[], %w[d20 4 d4 6 3 d5]]
  arr2 = [[], []]
  arr3 = [[], %w[d20 4 d4 6]]

  context 'recieves and array of arrays and ignores the first element' do
    it 'returns false if recieves an parameter out of scope' do
      expect(msg_validator(arr1)).to eql(false)
    end

    it 'returns false if recieves an empty array of operands' do
      expect(msg_validator(arr2)).to eql(false)
    end

    it 'returns true if the values are in order' do
      expect(msg_validator(arr3)).to eql(true)
    end
  end
end

describe 'dice_parser' do
  arr1 = %w[d20 4 d4 6]

  context 'it should not recieve any empty array because the validator prevents it' do
    it 'returns and array of string arrays with the values of the dices' do
      expect(dice_parser(arr1)).to eql([['', '20'], ['4'], ['', '4'], ['6']])
    end
  end
end

describe 'val_translator' do
  arr1 = [['', '20'], ['4'], %w[2 4], ['6']]

  it 'recieves an array of string arrays and convert the values to integer' do
    expect(val_translator(arr1)).to eql([[1, 20], [4], [2, 4], [6]])
  end
end

describe 'dice_roller' do
  arr1 = [5]
  arr2 = [2, 6]

  it 'recieves an array and returns the array if it is a number (length 1)' do
    expect(dice_roller(arr1)).to eql(arr1)
  end

  it 'returns an array and returns a new array with the values of the dices (length 2)' do
    expect(dice_roller(arr2)).to be_an Array
  end
end

describe 'calculator' do
  op1 = [6, 6, 6]
  op2 = [2]
  ops1 = '+'
  ops2 = '-'

  it 'recieves 2 arrays as operands and an operator (+), returns an array with the sum' do
    expect(calculator(op1, op2, ops1)).to eql([20])
  end

  it 'recieves 2 arrays as operands and an operator (-), returns an array with the substraction' do
    expect(calculator(op1, op2, ops2)).to eql([16])
  end
end

describe 'adv_dis_translator' do
  dice1 = [1, 20]
  dice2 = [5, 6]

  it 'returns the dice if it is not a d20' do
    expect(adv_dis_translator(dice2)).to eql(dice2)
  end

  it 'returns 2d20 if the dice is a d20' do
    expect(adv_dis_translator(dice1)).to eql([2, 20])
  end
end

describe 'calculator_adv' do
  dice1 = [19, 11]
  dice2 = [5, 6]
  op2 = [5]
  ops1 = '+'

  it 'grabs the highest result from a d20 and make the calculation with the other operand' do
    expect(calculator_adv(dice1, true, op2, false, ops1)).to eql([24])
  end

  it 'otherwise it sums the dices and make the calculation with the other operand' do
    expect(calculator_adv(dice2, false, op2, false, ops1)).to eql([16])
  end
end

describe 'calculator_dis' do
  dice1 = [19, 11]
  dice2 = [5, 6]
  op2 = [5]
  ops1 = '+'

  it 'grabs the lowest result from a d20 and make the calculation with the other operand' do
    expect(calculator_dis(dice1, true, op2, false, ops1)).to eql([16])
  end

  it 'otherwise it sums the dices and make the calculation with the other operand' do
    expect(calculator_dis(dice2, false, op2, false, ops1)).to eql([16])
  end
end
