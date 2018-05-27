# frozen_string_literal: true

config = YAML.load_file('app_config.yaml')
TOKEN = config['bot_token']
TARGET_USER_ID = config['user_id']

class TelegramUtil
  def send_message(message)
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.api.send_message(chat_id: TARGET_USER_ID, text: message)
    end
  end

  def start_server
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        case message.text
        when '/help'
          send(bot, 'Utiliza los siguientes comandos: ')
          send(bot, '/mode (silence | auto | alarm | off)')
          send(bot, '/alarm (on | off)')
          send(bot, '/lights (on | off)')
        when '/mode silence'
          send(bot, 'Modo silencioso activado: no se activarán alarmas ni se apagarán luces')
        when '/mode all'
          send(bot, 'Modo automátco activado: se activarán alarmas y se apagarán luces')
        when '/mode alarm'
          send(bot, 'Modo alarma activado: se activarán alarmas pero no se apagarán luces')
        when '/mode off'
          send(bot, 'Modo apagado activado: el sistema queda inactvo')
        when '/alarm on'
          send(bot, 'Alarmas activadas')
        when '/alarm off'
          send(bot, 'Alarmas desactivadas')
        when '/lights on'
          send(bot, 'Luces encendidas')
        when '/lights off'
          send(bot, 'Luces apagadas')
        end
      end
    end
  end

  def send(bot, text)
    bot.api.send_message(chat_id: TARGET_USER_ID, text: text)
  end
end
