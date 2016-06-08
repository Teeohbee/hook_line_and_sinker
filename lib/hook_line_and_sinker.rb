require 'sinatra/base'
require 'tilt/erb'
require 'date'
require_relative '../data_mapper_setup.rb'

require 'pry'
require 'json'

class HookLineAndSinker < Sinatra::Base

  get '/api/emails' do
    if params
      Email.all(params).to_json
    else
      Email.all.to_json
    end
  end

  post '/' do
    @data = JSON.parse(request.body.read) rescue nil
    if @data.nil?
      status 400
      body "No Data Provided"
    else
      @email = Email.new  timestamp: @data['Timestamp'],
                          address: @data['Address'],
                          emailtype: @data['EmailType'],
                          event: @data['Event']
      if @email.save
        status 200
        body "Webhook Data Parsed"
      else
        status 400
        body "Data failed validations"
      end
    end
  end

  run! if app_file == $PROGRAM_NAME

end
