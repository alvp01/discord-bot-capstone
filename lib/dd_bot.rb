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
        pp 'quejesto'
      end
    end
  end

  def bot_roll(bot)
    desc = "Type \"#{ENV['BOT_PREFIX']} roll d + num"
    bot.command :roll, description: desc do |event|
      arr = msg_splitter(event.message.content.delete_prefix('pls roll '))
      msg_validator(arr)
      event.respond 'derps!'
    end
  end

  def bot_run(bot)
    bot.run
  end
end
