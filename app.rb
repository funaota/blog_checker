require 'rubygems'
require 'sinatra'
require 'slim'
require 'rack-flash'
require 'rack/session/cookie'
require './classes/update_checker.rb'
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
	slim :index
end

get '/go_maimai' do
	checker = UpdateChecker.new("http://tencarat.com/talent/talent042/diary/", 10)
	thread = checker.start
	thread.join
end

