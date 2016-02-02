class MutualHonor < ActiveRecord::Base

	belongs_to :from_object, :class_name => 'Player', :foreign_key => 'from'
	belongs_to :to_object, :class_name => 'Npc', :foreign_key => 'to'
	belongs_to :champion_object, :class_name => 'Champion', :foreign_key => 'champion'
	
	def from_name
		self.from_object.name
	end
	
	def to_name
		self.to_object.name
	end
	
	def champion_name
		self.champion_object.name
	end
	
	


end