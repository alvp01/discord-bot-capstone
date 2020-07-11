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
