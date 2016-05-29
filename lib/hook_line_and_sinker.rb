require 'sinatra/base'
require 'tilt/erb'
require_relative 'models/email'
require 'pry'

class HookLineAndSinker < Sinatra::Base
  get '/' do
    'Hello HookLineAndSinker!'
  end

  get '/emails' do
    @emails = Email.all
    erb :'emails/index'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
