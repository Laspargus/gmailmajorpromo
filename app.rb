require_relative 'quickstart'
require 'json'

file = File.read('db/input_nico.json')
my_hash = JSON.parse(file)

	my_hash.length.times do |i|
		if my_hash[i]["mail"] != ""

			# On crée une instance de mail (qui va ouvrir une instance de mail gmail)

			mail = Mail.new
			
			name_town = my_hash[i]["name"]
			mail_town = my_hash[i]["mail"]

			mail.send_message(name_town, mail_town)
		end
	end

