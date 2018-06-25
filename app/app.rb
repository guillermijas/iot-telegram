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
        @telegram.send_message('ALARMA PUERTA')
        'ok'
      end
      r.is 'alarma_ventana' do
        @telegram.send_message('ALARMA VENTANA')
        'ok'
      end
      r.is 'command' do
        @telegram.next_command
      end
    end
  end
end
