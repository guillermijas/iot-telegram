# frozen_string_literal: true

require './app/telegram_util.rb'

class IotTelegram < Roda
  Thread.start { TelegramUtil.new.start_server }

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
      r.is 'pendig' do
        @telegram.send_message('pendiente')
        'ok'
      end
      r.is 'alarma' do
        @telegram.send_message('ALARMA')
        'ok'
      end
    end
  end
end
