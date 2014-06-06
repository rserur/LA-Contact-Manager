require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require_relative 'models/contact'

get '/' do

  @page = params[:page].to_i

  @contacts = Contact.limit(2).offset(@page * 2)

  erb :index
end

get '/contacts/:id' do

  @contact = Contact.find(params[:id])
  erb :show
end
