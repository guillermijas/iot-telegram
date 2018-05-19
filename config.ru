require 'rubygems'
require 'bundler'
require 'yaml'
require 'telegram/bot'

Bundler.require

require './app.rb'

run IotTelegram.freeze.app
