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
        bot.send_message(i.id, 'bot is ready')
      end
    end
  end

  def bot_roll(bot)
    desc = "Type \"#{ENV['BOT_PREFIX']} roll d + num"
    bot.command :roll, description: desc do |event|
      arr = msg_splitter(event.message.content.delete_prefix('pls roll '))
      if msg_validator(arr)
        roll_adv = false
        roll_dis = false
        roll_adv = true if arr[1].include? 'adv'
        roll_dis = true if arr[1].include? 'dis'
        arr[1].delete_if { |x| x.eql?('adv') or x.eql?('dis') }
        roll_arbiter(arr[0], arr[1], roll_adv, roll_dis)
        event.respond "#{event.message.author.mention} roll"
      end
    end
  end

  def roll_arbiter(operators, operands, adv, dis)
    values = dice_parser(operands)
    values = val_translator(values)
    if (adv and dis) or (!adv and !dis)
      dice_roll(operators, values)
    elsif @roll_adv
      puts 'hello 2'
    else
      puts 'hello 3'
    end
  end

  def dice_roll(operators, operands)
    p operators
    p operands
  end

  def bot_run(bot)
    bot.run
  end
end
