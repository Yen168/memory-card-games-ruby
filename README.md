# memory-card-games-ruby


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

# JQuery version

[Live Demo](http://yen168.github.io/memory-card-games-ruby/match-game-jquery/matchGame.html)
