# Memory Card Games - Ruby version


Test:

```ruby

g = MatchGame.new(4)

#if you want to see the answer
#g.answer

#start

g.draw

loop do
	break if !g.check_for_stop
	p g.pick()
end

#end
# code by Yen
```

# jQuery version

[Live Demo](http://yen168.github.io/memory-card-games-ruby/match-game-jquery/matchGame.html)

[source](https://github.com/Yen168/memory-card-games-ruby/tree/master/match-game-jquery)

# Ruby runtime screenshot
![pic](https://github.com/Yen168/memory-card-games-ruby/blob/master/mg-ruby.png)
