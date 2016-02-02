class Npc < ActiveRecord::Base

	def self.fill_from_file
		file = File.foreach('lib/assets/names.txt') do |x|
			begin
				npc = Npc.new
				npc.name = x.gsub(/ new/, '').gsub(/[^a-z]/i, '')
				npc.save
			rescue
				# Do nothing
			end
		end
	end
	
	def self.get_random(number, name, npc_names = [])
		invalid_names = npc_names + [name]
		Npc.where.not(name: invalid_names).order('RAND()').first(number)
	end
	
end