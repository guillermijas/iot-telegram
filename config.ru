# frozen_string_literal: true

require 'rubygems'
require 'bundler'
require 'yaml'
require 'telegram/bot'

Bundler.require

require './app/app.rb'
require './app/telegram_util.rb'

run IotTelegram.freeze.app
