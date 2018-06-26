# frozen_string_literal: true

require './app/telegram_util.rb'

class IotTelegram < Roda
  Thread.start { TelegramUtil.new.start_listen_server }

  route do |r|
    @telegram = TelegramUtil.new

    r.root do
      'root'
    end

    r.get do
      r.is 'timbre' do
        @telegram.send_message('Llaman a la puerta')
        'ok'
      end
      r.is 'alarma_puerta' do
        @telegram.start_alarm_door
        'ok'
      end
      r.is 'alarma_ventana' do
        @telegram.start_alarm_window
        'ok'
      end
      r.is 'alarma_off' do
        @telegram.stop_alarm
        'ok'
      end
      r.is 'command' do
        @telegram.next_command
      end
    end
  end
end
