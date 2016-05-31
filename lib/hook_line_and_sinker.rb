require 'sinatra/base'
require 'tilt/erb'
require 'date'
require_relative '../data_mapper_setup.rb'

require 'pry'
require 'json'

class HookLineAndSinker < Sinatra::Base

  get '/' do
    @sent_emails_count = Email.count(:event => "send")
    @clicked_emails_count = Email.count(:event => "click")
    @opened_emails_count = Email.count(:event => "open")
    status 200
    erb :'index'
  end

  post '/' do
    @data = JSON.parse(request.body.read || '{}')
    if @data.nil?
      status 400
      body "No Data Provided".to_json
    else
      @email = Email.new  timestamp: @data['Timestamp'],
                          address: @data['Address'],
                          emailtype: @data['EmailType'],
                          event: @data['Event']
      if @email.save
        status 200
        body "Webhook Data Parsed".to_json
      else
        status 400
        body "Data failed validations".to_json
      end
    end
  end

  get '/emails' do
    @emails = Email.all
    erb :'emails/email_list'
  end

  run! if app_file == $PROGRAM_NAME

end
