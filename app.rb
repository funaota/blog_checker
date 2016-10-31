require 'rubygems'
require 'sinatra'
require 'slim'
require 'active_record'
require 'rack-flash'
require 'rack/session/cookie'
require './models/user.rb'

use Rack::Session::Cookie
use Rack::Flash

get '/' do
	slim :index
end

post '/' do
	if params[:email].nil?
		flash.now[:error] = "メールアドレスが入力されていません"
		slim :index
	end

	@user = User.new(email: params[:email])
	if @user.save
		redirect '/send'
	else
		flash.now[:error] = "メールアドレスを正しく入力してください"
		slim :index
	end
end

get '/send' do
	slim :send
end

get '/confirm' do
	User.confirm(params[:id])
	slim :confirm
end
