require 'discordrb'
require 'dotenv'
Dotenv.load('../.env')

class DwarfBot
  attr_reader :discord_bot

  def initialize
    @discord_bot = Discordrb::Commands::CommandBot.new token: ENV['BOT_TOKEN'], client_id: ENV['CLIENT_ID'], prefix: '*'
    
  end
end