class Honor < ActiveRecord::Base

	def self.honor_probability(total_kills, kills, deaths, assists)
		((1 - (0.25 * (1 - ((kills.to_f + assists) / total_kills)))) * ((1 - (deaths.to_f / (kills + deaths + (assists * 0.5))))**2)) * 0.75
	end
	
	def self.roll_honors(count, probability)
		output = 0
		(1..count).each do |n|
			if rand() < probability
				output += 1
			end
		end
		output
	end
	
end