# frozen_string_literal: true

require './app/sqlite_driver.rb'
config = YAML.load_file('./config/app_config.yaml')
TOKEN = config['bot_token']
TARGET_USER_ID = config['user_id']

class TelegramUtil

  def initialize
    @db = SqliteDriver.new
  end

  def next_command
    request = @db.select_last_request
    return nil if request.nil?
    @db.mark_done(request[:id])
    request[:command]
  end

  def start_listen_server
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        case message.text
          when '/help'
            bot_send(bot, 'Utiliza los siguientes comandos: ')
            bot_send(bot, '/modo (silencio | auto | alarma | off)')
            bot_send(bot, '/alarma (on | off)')
            bot_send(bot, '/leds (on | off)')
          when '/modo silencio'
            bot_send(bot, 'Modo silencioso activado: no se activarán alarmas ni se apagarán luces')
            @db.insert('modo_silencio')
          when '/modo auto'
            bot_send(bot, 'Modo automátco activado: se activarán alarmas y se apagarán luces')
            @db.insert('modo_auto')
          when '/mode alarma'
            bot_send(bot, 'Modo alarma activado: se activarán alarmas pero no se apagarán luces')
            @db.insert('modo_alarma')
          when '/mode off'
            bot_send(bot, 'Modo apagado activado: el sistema queda inactvo')
            @db.insert('modo_off')
          when '/alarma on'
            bot_send(bot, 'Alarmas activadas')
            @db.insert('alarma_on')
          when '/alarma off'
            bot_send(bot, 'Alarmas desactivadas')
            @db.insert('alarma_off')
          when '/leds on'
            bot_send(bot, 'Luces encendidas')
            @db.insert('leds_on')
          when '/leds off'
            bot_send(bot, 'Luces apagadas')
            @db.insert('leds_off')
          else
            bot_send(bot, 'El comando no es válido')
        end
      end
    end
  end

  def send_message(message)
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.api.send_message(chat_id: TARGET_USER_ID, text: message)
    end
  end

  private

  def bot_send(bot, text)
    bot.api.send_message(chat_id: TARGET_USER_ID, text: text)
  end
end
