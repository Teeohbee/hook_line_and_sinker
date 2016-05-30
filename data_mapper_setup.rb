require 'data_mapper'
require 'dm-validations'
require 'pry'
require './lib/models/email'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/hls_#{env}")

DataMapper.finalize

DataMapper.auto_upgrade!
