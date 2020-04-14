class FortniteTracker::CLI

    def call 
        puts "Welcome to Fortnite Tracker!"
        puts ""
        puts "Track players stats by platform and player name"
        puts ""
        puts ""
        start 
    end 

    def start 
        puts "Enter a platform (pc, xbox, ps4):"
        platform = gets.downcase
        puts "Enter a username:"
        player = gets.downcase
        APIManager.get_player(platform, player)
    end 

end