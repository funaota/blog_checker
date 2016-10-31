require 'dotenv'
Dotenv.load

every 10.minutes do
	rake 'checker:start'
end
