# frozen_string_literal: true

require 'sqlite3'

class SqliteDriver

  def initialize
    @db = SQLite3::Database.new('./db/iotelegram.db')
  end

  def select_last_request
    rows = @db.execute('select * from requests where done = 0
               order by created_at limit 1')
    return nil if rows.empty?
    request = rows[0]
    { id: request[0], command: request[1], done: request[2],
      created_at: request[3], udpated_at: request[4] }
  end

  def insert(order)
    @db.execute('INSERT INTO requests (command, done, created_at, updated_at)
                VALUES (?, ?, ?, ?)', [order, 0, Time.now.to_s, Time.now.to_s])
    puts "insert #{order}"
    true
  rescue StandardError
    false
  end

  def mark_done(id)
    @db.execute('UPDATE requests SET done = ?, updated_at = ? where id = ?',
                [1, Time.now.to_s, id])
    puts "mark done #{id}"
    true
  rescue StandardError
    false
  end

  def drop_requests
    @db.execute('drop table requests')
  rescue StandardError
    false
  end

  def init_db
    @db.execute('create table requests (
                  id integer primary key autoincrement,
                  command text,
                  done int,
                  created_at datetime,
                  updated_at datetime
                )')
    true
  rescue StandardError
    false
  end
end