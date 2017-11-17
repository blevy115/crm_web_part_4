require_relative 'contact.rb'
require 'sinatra'

get '/' do
  @contacts = Contact.all
  erb :index
end


get'/contacts' do
  redirect to ('/')
end

get '/contacts/new' do
  @contacts = Contact.all
  erb :new
end

get '/contacts/:id' do
  @contact = Contact.find_by(id: params[:id])
  erb :show_contact
end

get '/about' do
  erb :about_me
end

post '/contacts' do
  Contact.create(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    note: params[:note]
  )
  redirect to ('/contacts')
end

get '/contacts/:id/edit' do
  @contact = Contact.find_by(id: params[:id])
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put '/contacts/:id' do
  @contact = Contact.find_by(id: params[:id])
  if @contact
    @contact.update(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
    )

    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

after do
  ActiveRecord::Base.connection.close
end
