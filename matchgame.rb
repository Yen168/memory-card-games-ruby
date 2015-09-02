require 'colorize'

class MatchGame

	def initialize(size)
		@size = size
		@grid = grid_gem(size)
		@layer = size.times.inject([]) {|ai| ai << Array.new(size,"*")}
		@inputs_pool = size.times.reduce([]) {|a,i|a<<i}

	end

	def color_me(num)
		num_str = "%s" % num
		re_num = ""
		
		case num % 6
			when 0
				re_num = num_str.red	
			when 1
				re_num = num_str.yellow
			when 2
				re_num = num_str.light_blue
			when 3
				re_num = num_str.light_magenta
			when 4
				re_num = num_str.light_green
			when 5
				re_num = num_str.light_cyan
			when '*'
				re_num = num_str.white
			else
				abort "Something Wrong!!!"
		end
		return re_num.underline
	end

	def input_get(x,y)
		
		temp = ""
		
		while not (@inputs_pool.include?(temp[0])&&@inputs_pool.include?(temp[1])) do
			print "#{x} #{y}: "
			temp = gets.chomp
			temp = temp.split(" ").inject([]) {|a,i| a << i.to_i }
		end

		return temp if @layer[temp[0]][temp[1]] == "*"
		
		puts "Opps!Pick Again!"
		input_get(x,y)

	end

	def draw
		#puts @layer.map {|a| a.join(",")}
		puts @layer.map {|a| a.reduce([]) {|a,i| a<< color_me(i)}.join(",")}
		puts "\n"
	
		

	end

	def pick

		x1,y1 = input_get("x1","y1")
		x2,y2 = input_get("x2","y2")

		x2,y2 = input_get("x2","y2") until [x1,y1] != [x2,y2]


		@layer[x1][y1],@layer[x2][y2]= @grid[x1][y1],@grid[x2][y2]

		draw

		if @grid[x1][y1] == @grid[x2][y2]
			return true
		else
			@layer[x1][y1] = @layer[x2][y2] = "*"
			return false
		end
		

	end

	def check_for_stop
		@layer.flatten.include?"*"
	end

	def answer

		puts "\e[H\e[2J"

		puts @grid.map {|a| a.reduce([]) {|a,i| a<< color_me(i)}.join(",")}
		puts "\n"

	end

	private

	def grid_gem(size)
		guess_pool = size*size/2
		pools = Hash.new(0)
		size.times.reduce([]) do |a| 
			a << 
			size.times.reduce([]) do |a|
				n = rand(guess_pool)
				loop do
					if pool_check(pools[n]){pools[n]+=1;a << n}
						pools[n]+=1
						a << n
						break 
					end
					n = rand(guess_pool)
				end
				a
			end
		end
		
	end

	def pool_check(n)
		return n < 2 ? true : false
	end

end

