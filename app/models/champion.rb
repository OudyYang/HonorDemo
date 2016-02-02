class Champion < ActiveRecord::Base

	def self.fill_data
		champion_data = JSON.parse(Riotapi.get_champions)
		champion_data['data'].each do |k,v|
			current = Champion.where(champion_id: v['id']).first
			if current.nil?
				current = Champion.new
				current.id = v['id']
			end
			current.name = v['name']
			current.save
		end
	end
	
	def self.get_select_options
		Champion.uniq.pluck(:name)
	end
	
	def self.get_random(number, name)
		Champion.where.not(name: name).order('RAND()').first(number)
	end
	
end