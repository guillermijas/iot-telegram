# frozen_string_literal: true

config = YAML.load_file('./config/app_config.yaml')
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
          bot_send(bot, 'Utiliza los siguientes comandos: ')
          bot_send(bot, '/mode (silence | auto | alarm | off)')
          bot_send(bot, '/alarm (on | off)')
          bot_send(bot, '/lights (on | off)')
        when '/mode silence'
          bot_send(bot, 'Modo silencioso activado: no se activarán alarmas ni se apagarán luces')
        when '/mode all'
          bot_send(bot, 'Modo automátco activado: se activarán alarmas y se apagarán luces')
        when '/mode alarm'
          bot_send(bot, 'Modo alarma activado: se activarán alarmas pero no se apagarán luces')
        when '/mode off'
          bot_send(bot, 'Modo apagado activado: el sistema queda inactvo')
        when '/alarm on'
          bot_send(bot, 'Alarmas activadas')
        when '/alarm off'
          bot_send(bot, 'Alarmas desactivadas')
        when '/lights on'
          bot_send(bot, 'Luces encendidas')
        when '/lights off'
          bot_send(bot, 'Luces apagadas')
        else
          bot_send(bot, 'El comando no es válido')
        end
      end
    end
  end

  def bot_send(bot, text)
    bot.api.send_message(chat_id: TARGET_USER_ID, text: text)
  end
end
