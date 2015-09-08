# Code by Yen168.
# NYC 2015
# with comment

require 'colorize'

class MatchGame
  
	def initialize(size)
		# refactor
		size_s = size.times
		size_d = (size*size).times

		@size = size
		@first_second = true
		@grid = grid_gem(size)
		@layer = size_s.inject([]) {|a| a << Array.new(size,"*")}
		@inputs_pool = size_s.reduce([]) {|a,i| a << i}
		# easy to pick
		@pick_map = size_d.reduce([]) {|a,i| a << i+1}
		# automation hash-value map
		@pool_map = size_d.reduce({}) do |hash, num|

			temp1 = num % size
			temp2 = num / size
			hash[num+1] = [temp2,temp1]

			hash
		end
	end

	def pick_map_draw
		# play string
		print @pick_map.reduce([]) {|a,i| i % @size == 0 ? a << "#{"%2s"}\n" % i : a << "#{"%2s" % i},"; a}.join("")
		# or you may like... remember (cruly)
		# print (@pick_map.reduce([]) do |a,i| 
		# 	i % @size == 0 ? a << "#{"%2s"}\n" % i : a << "#{"%2s" % i},"
		# 	a 
		# end.join(""))
	end

	def color_me(num)
		# color num. use 'colorize' gem
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


	def draw
		# puts @layer.map {|a| a.join(",")}
		puts "\e[H\e[2J"
		
		puts @layer.map {|a| a.reduce([]) {|a,i| a<< color_me(i)}.join(",")}
		puts "\n"

		pick_map_draw
		puts "\n"
	end

	def input_get2
	  
		temp = ""
		
		while not (@pick_map.include?(temp)) do
			@first_second ? (print "first card: ") : (print "second card: ")
			temp = gets.chomp
			temp = temp.to_i
		end

		x,y = @pool_map.fetch(temp)

		if @layer[x][y] == "*"
			@first_second = !@first_second
			return x,y 
		else
			puts "Opps!Pick Again!"
			input_get2
		end
	end

	# if you don't want to use hash-value map

	# def input_get(x,y)
	# 	temp = ""
		
	# 	while not (@inputs_pool.include?(temp[0])&&@inputs_pool.include?(temp[1])) do
	# 		print "#{x} #{y}: "
	# 		temp = gets.chomp
	# 		temp = temp.split(" ").inject([]) {|a,i| a << i.to_i }
	# 	end

	# 	return temp if @layer[temp[0]][temp[1]] == "*"
		
	# 	puts "Opps!Pick Again!"
	# 	input_get(x,y)
	# end

	def pick
		# x1,y1 = input_get("x1","y1")
		x1,y1 = input_get2
		# x2,y2 = input_get("x2","y2")
		x2,y2 = input_get2
		# x2,y2 = input_get("x2","y2") until [x1,y1] != [x2,y2]
		# (cruly again! To enforce turn order status to be correct)
		(@first_second = !@first_second ; x2,y2 = input_get2 ) until [x1,y1] != [x2,y2]

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
		@layer.flatten.include?("*")
	end

	def answer
		puts "\e[H\e[2J"
		puts @grid.map {|a| a.reduce([]) {|a,i| a<< color_me(i)}.join(",")}
		puts "\n"
	end

	private

	def grid_gem(size)
		# number of cards pairs
		guess_pool = size*size/2
		pools = Hash.new(0)
		# I know this may be complex. find self
		size.times.reduce([]) do |a| # first block
			a << # first block
			size.times.reduce([]) do |a| # second block
				n = rand(guess_pool)
				loop do
					if pool_check(pools[n]){pools[n]+=1;a << n} # second block
						pools[n]+=1
						a << n # second block
						break 
					end
					n = rand(guess_pool)
				end
				a # second block
			end
		end
	end

	def pool_check(n)
		return n < 2 ? true : false
	end

end
