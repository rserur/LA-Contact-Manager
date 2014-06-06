require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require_relative 'models/contact'

get '/' do

  @page = params[:page].to_i

  @search_term = params[:query]

  if @search_term != nil
    @contacts = Contact.where("first_name ILIKE '%#{@search_term}%' OR last_name ILIKE '%#{@search_term}%'")
  else

    @contacts = Contact.limit(2).offset(@page * 2)
  end

  erb :index
end

get '/contacts/:id' do

  @contact = Contact.find(params[:id])

  erb :show
end
