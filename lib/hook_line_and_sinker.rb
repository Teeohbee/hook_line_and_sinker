require 'sinatra/base'

class HookLineAndSinker < Sinatra::Base
  get '/' do
    'Hello HookLineAndSinker!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
