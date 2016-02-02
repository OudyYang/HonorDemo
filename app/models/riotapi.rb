require 'rest-client'

class Riotapi < ActiveRecord::Base

    API_KEY = 'd0fe44c4-d516-4b36-874b-cea808798dce'
	KEY_FOOTER = "api_key=#{API_KEY}"
	ENDPOINT = 'https://global.api.pvp.net/api/lol/'
	HEADERS = {'User-Agent' => 'Riot-Games-Developer-Portal',
				'Accept-Language' => 'en-US',
				'Accept-Charset' => 'ISO-8859-1,utf-8',
				'Origin' => 'https://developer.riotgames.com'}

	def self.test
		
	end
	
	def self.get_champions
		Riotapi.execute(:get, "#{ENDPOINT}static-data/na/v1.2/champion?#{KEY_FOOTER}")
	end
	
	def self.execute(method, url)
		RestClient::Request.execute(method: method, url: url, headers: HEADERS)
	end

end