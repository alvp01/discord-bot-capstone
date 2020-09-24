require_relative './utils.rb'
require 'discordrb'
require 'dotenv'
Dotenv.load('../.env')

class DwarfBot
  attr_reader :discord_bot

  def initialize
    @tkn = ENV['BOT_TOKEN']
    create_bot
  end

  private

  def create_bot
    discord_bot = Discordrb::Commands::CommandBot.new(
      token: ENV['BOT_TOKEN'],
      client_id: ENV['CLIENT_ID'],
      prefix: ENV['BOT_PREFIX']
    )

    bot_commands(discord_bot)

    bot_run(discord_bot)
  end

  def bot_commands(bot)
    bot_roll(bot)

    bot.ready do |_event|
      var = bot.find_channel('general')
      var.each do |i|
        bot.send_message(i.id, "Type #{ENV['BOT_PREFIX']} roll with the dices and modifiers to roll dices.e.g: d20 + 5")
      end
    end
  end

  def bot_roll(bot)
    desc = "Type \"#{ENV['BOT_PREFIX']} roll d + num"
    bot.command :roll, description: desc do |event|
      arr = msg_splitter(event.message.content.delete_prefix('pls roll '))
      if event.message.content.match?(/\d*d\d+/) and msg_validator(arr)
        roll_adv = false
        roll_dis = false
        roll_adv = true if arr[1].include? 'adv'
        roll_dis = true if arr[1].include? 'dis'
        arr[1].delete_if { |x| x.eql?('adv') or x.eql?('dis') }
        roll_arbiter(arr[0], arr[1], roll_adv, roll_dis, event)
      end
    end
  end

  def roll_arbiter(operators, operands, adv, dis, event)
    values = dice_parser(operands)
    values = val_translator(values)
    if (adv and dis) or (!adv and !dis)
      dice_roll(operators, values, event)
    elsif adv
      dice_roll_adv(operators, values, event)
    else
      dice_roll_dis(operators, values, event)
    end
  end

  def dice_roll(operators, operands, event)
    dices = []
    if operators.empty?
      dices = dice_roller(operands[0])
      result = dices.sum
      event.respond "#{event.message.author.mention} here are the dices: #{dices}. And this is the sum: #{result}"
    else
      until operators.empty?
        a = operands.shift
        b = operands.shift
        op = operators.shift
        if a.length.eql? 2
          a = dice_roller(a)
          dices << a
        end
        if b.length.eql? 2
          b = dice_roller(b)
          dices << b
        end
        operands.unshift(calculator(a, b, op))
      end
      event.respond "#{event.message.author.mention} the dices were: #{dices} and the result was: #{operands[0]}"
    end
  end

  def dice_roll_adv(operators, operands, event)
    dices = []
    if operators.empty?
      x = operands[0]
      x[0] = 2 if x[0] != 2
      dices = dice_roller(x)
      event.respond "The dices were #{dices} and the result is: #{dices.max}"
    else
      until operators.empty?
        x = false
        y = false
        a = adv_dis_translator(operands.shift)
        b = adv_dis_translator(operands.shift)
        x = true if a.include? 20
        y = true if b.include? 20
        op = operators.shift
        if a.length.eql? 2
          a = dice_roller(a)
          dices << a
        end
        if b.length.eql? 2
          b = dice_roller(b)
          dices << b
        end
        operands.unshift(calculator_adv(a, x, b, y, op))
      end
      event.respond "The dices were: #{dices} and the result was: #{operands[0]}"
    end
  end

  def dice_roll_dis(operators, operands, event)
    dices = []
    if operators.empty?
      x = operands[0]
      x[0] = 2 if x[0] != 2
      dices = dice_roller(x)
      event.respond "The dices were #{dices} and the result is: #{dices.min}"
    else
      until operators.empty?
        x = false
        y = false
        a = adv_dis_translator(operands.shift)
        b = adv_dis_translator(operands.shift)
        x = true if a.include? 20
        y = true if b.include? 20
        op = operators.shift
        if a.length.eql? 2
          a = dice_roller(a)
          dices << a
        end
        if b.length.eql? 2
          b = dice_roller(b)
          dices << b
        end
        operands.unshift(calculator_dis(a, x, b, y, op))
      end
      event.respond "The dices were: #{dices} and the result was: #{operands[0]}"
    end
  end

  def test_method
    puts 'hello'
  end

  def bot_run(bot)
    bot.run
  end
end
