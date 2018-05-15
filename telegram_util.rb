require 'telegram/bot'
require 'yaml'

config = YAML.load_file('secrets.yaml')
TOKEN = config['bot_token']
TARGET_USER_ID = config['user_id']

class TelegramUtil
  
  def send_message(message)
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.api.send_message(chat_id: TARGET_USER_ID, text: message)
    end  
  end
end

