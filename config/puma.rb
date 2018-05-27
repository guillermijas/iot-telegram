# frozen_string_literal: true

# Change to match your CPU core count
workers 1

# Min and Max threads per worker
threads 1, 6

# Default to production
rails_env = ENV['RAILS_ENV'] || 'production'
environment rails_env

# Set up socket location
bind 'unix:///tmp/puma.sock'

# Logging
stdout_redirect '/tmp/puma.stdout.log', '/tmp/puma.stderr.log', true

# Set master PID and state locations
pidfile '/tmp/puma.pid'
state_path '/tmp/puma.state'
activate_control_app
