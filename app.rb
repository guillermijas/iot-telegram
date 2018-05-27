# frozen_string_literal: true

require './telegram_util'

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
        'Se ha avisado del timbre'
      end
      r.is 'pendig' do
        @telegram.send_message('pendiente')
        'Se ha avisado la operacion pendiente'
      end
      r.is 'alarma' do
        5.times do
          @telegram.send_message('ALARMA')
        end
        'Se ha enviado la alerta'
      end
    end
  end
end
