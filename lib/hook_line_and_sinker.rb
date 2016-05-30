require 'sinatra/base'
require 'tilt/erb'
require_relative '../data_mapper_setup.rb'

require 'pry'
require 'json'

class HookLineAndSinker < Sinatra::Base

  get '/' do
    erb :'index'
  end

  post '/' do
    @data = JSON.parse(request.body.read || '{}')
    if @data.nil?
      status 400
      body({ :error => "No Data Provided" }.to_json)
    else
      @email = Email.new  timestamp: @data['Timestamp'],
                          address: @data['Address'],
                          emailtype: @data['EmailType'],
                          event: @data['Event']
      @email.save
      status 200
      body({ :error => "Webhook Data Parsed" }.to_json)
    end
  end

  get '/emails' do
    @emails = Email.all
    erb :'emails/email_list'
  end

  run! if app_file == $PROGRAM_NAME

end
