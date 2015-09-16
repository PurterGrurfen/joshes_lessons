require 'sinatra'
require 'pony'
require 'byebug'
require 'erubis'
require 'tilt/erubis'

set :public_folder, 'public'

get '/' do
  redirect to('/index.html'), 302
end

post '/signup' do
  Pony.mail :to => params[:email],
            :from => 'me@example.com',
            :subject => 'Howdy, Partna!',
            :via => :smtp,
            :via_options => {
              :address              => 'smtp.gmail.com',
              :port                 => '587',
              :enable_starttls_auto => true,
              :user_name            => 'cirode',
              :password             => 'Sp3lls4',
              :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
              :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
            }
  erb :signup
end