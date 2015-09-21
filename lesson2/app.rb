require 'sinatra'
require 'pony'
require 'erubis'
require 'sinatra/flash'

set :public_folder, settings.root + '/static'
set :views, settings.root + '/templates'

enable :sessions

def email_body(name, body)
  'Email from ' + name + ',' + "\n" + body
end

get '/' do
  erb :index, locals: { message: flash[:message] }
end

post '/subscribe' do

  Pony.mail({
              :to => params[:emailaddress],
              :subject => params[:subject],
              :via => :smtp,
              :body => email_body(params[:name], params[:body]),
              :via_options => {
                :address              => 'smtp.gmail.com',
                :port                 => '587',
                :enable_starttls_auto => true,
                :user_name            => 'mcmanus.jpm@gmail.com',
                :password             => '*********',
                :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
                :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
              }
  })
  message = "email sent"
  flash[:message] = "Mesage Sent to #{params[:emailaddress]}"
  redirect to('/')
end
