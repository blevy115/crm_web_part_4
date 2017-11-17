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
  @contact = Contact.find_by(id: params[:id].to_i + 1)
  erb :show_contact
end

get '/about' do
  erb :about_me
end


after do
  ActiveRecord::Base.connection.close
end
