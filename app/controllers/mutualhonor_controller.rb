class MutualhonorController < ApplicationController

	respond_to :html, :js

	def index
	end

	def login
		if params['name'].blank?
			redirect_to mutualhonor_index_url
		else
			@player = Player.find_or_create(params['name'])
			redirect_to mutualhonor_url(@player.player_id)
		end
	end
	
	def show
		@player = Player.find(params['id'])
		
		# Get rid of any old honors lying around
		@player.chance_old_honor
	end
	
	def queue
		@player = Player.find(params['mutualhonor_id'])
		@npcs = @player.generate_room
		@past_honored = @player.find_honored(@npcs)
	end
	
	def play
		@player = Player.find(params['mutualhonor_id'])
		npcs = Npc.find(params['npcs'])
		@npcs = params['npcs'].collect {|npc_id| npcs.detect {|x| x.npc_id == npc_id.to_i}}
		
		@player_champ = Champion.where(name: params['champion']).first
		@npc_champs = Champion.get_random(9, params['champion'])
		@blue_kill_total = rand(10..40)
		@red_kill_total = rand(10..40)
		@blue_victory = Game.calculate_victory(@blue_kill_total, @red_kill_total)
		
		@blue_kills = Game.random_sum(5, @blue_kill_total)
		@blue_deaths = Game.random_sum(5, @red_kill_total)
		@blue_assists = Game.generate_assists(@blue_kill_total, @blue_kills, @red_kill_total, @blue_deaths)
		
		@red_kills = Game.random_sum(5, @red_kill_total)
		@red_deaths = Game.random_sum(5, @blue_kill_total)
		@red_assists = Game.generate_assists(@red_kill_total, @red_kills, @blue_kill_total, @red_deaths)
		
		@probability = Honor.honor_probability(@blue_kill_total, @blue_kills[0], @blue_deaths[0], @blue_assists[0])
	end
	
	def return
		@player = Player.find(params['mutualhonor_id'])
		@mutual_honors = @player.chance_old_honor
		@extra_honors = Honor.roll_honors(params['unhonored'].to_i, params['unhonored_probability'].to_f)
	end
	
	def honor
		player = Player.find(params['mutualhonor_id'])
		@npc = Npc.find(params['npc'])
		@mutual_honor = player.send_honor(@npc.npc_id, params['champion'], params['probability'].to_f)
		@button = "##{params['button']}"
	end

end