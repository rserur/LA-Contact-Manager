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

    @contacts = Contact.limit(2).offset(@page * 2).order(first_name: :asc)
  end

  @last_page = (Contact.count / 2) - 1

  erb :index

end

get '/contacts/:id' do

  @contact = Contact.find(params[:id])

  erb :show
end

get '/submit' do

  erb :submit

end

post '/submit' do

  @first_name = params[:first_name]
  @last_name = params[:last_name]
  @phone_number = params[:phone_number]

  Contact.create(first_name: @first_name, last_name: @last_name, phone_number: @phone_number)

  redirect '/'

end
