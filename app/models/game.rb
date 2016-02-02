class Game < ActiveRecord::Base

	def self.random_sum(n, sum)
		array = [0, sum]
		(1..(n-1)).each do |x|
			array.push(rand(sum+1))
		end
		array.sort!
		
		output = Array.new
		(1..n).each do |x|
			output.push(array[x]-array[x-1])
		end
		output
	end
	
	def self.calculate_victory(blue_kill_total, red_kill_total)
		blue_chance = 2**((blue_kill_total-red_kill_total)/2)
		red_chance = 2**((red_kill_total-blue_kill_total)/2)
		rand() * (blue_chance + red_chance - 1) <= blue_chance
	end
	
	def self.generate_assists(kill_total, kill_array, death_total, death_array)
		output = Array.new
		(0..4).each do |x|
			max = kill_total - kill_array[x]
			chance = (1-(death_array[x].to_f/death_total.to_f))*(4.0/5.0)
			assists = 0;
			(1..max).each do |y|
				if (rand() < chance)
					assists += 1;
				end
			end
			output.push(assists)
		end
		output
	end
	
end