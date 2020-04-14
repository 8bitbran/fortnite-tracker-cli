class FortniteTracker::CLI

    def call 
        puts "Welcome to Fortnite Tracker!"
        puts ""
        puts "Track players' stats by platform and player name"
        puts ""
        puts ""
        start 
    end 

    def start 
        puts "Enter a platform (pc, xbox, ps4):"
        platform = gets.downcase
        puts "Enter a username:"
        player = gets.downcase
        find_player(APIManager.get_player(platform, player).id)
    end 

    def find_player(id)
        track_player(Players.all.find{|player| player.id == id})

    def track_player(player)
        puts "Options:"
        puts "" 
        puts "Type 'all' for all stats"
        puts "Type 'time played' for total time played"
        puts "Type 'top fives' for total games with Top 5 placement"
        puts "Type 'wins' for total wins"
        puts "Type 'percentage' for win percentage"
        puts "Type 'kills' for total kills"
        puts "Type 'kdr' for kill-death ratio"
        puts "Type 'history' for match history"
        puts "Type 'exit' to exit"
        input = nil 
        while input != "exit"
            input = gets.downcase
            case input
                when "all"
                    puts ""
                    puts "All Stats for #{player.name}"
                    puts""
                    player.all_stats
                    puts""
                when "time played"
                    puts ""
                    puts "#{player.name} has played for #{player.time_played}"
                    puts ""
                when "top fives"
                    puts ""
                    puts "#{player.name} has placed top 5 in #{player.top_fives} games"
                    puts ""
                when "wins"
                    puts ""
                    puts "#{player.name} has won #{player.wins} games"
                    puts ""
                when "percentage"
                    puts ""
                    puts "#{player.name} has a win percentage of #{player.win_percentage}"
                    puts ""
                when "kills"
                    puts ""
                    puts "#{player.name} has #{player.kills} total kills"
                    puts ""
                when "kdr"
                    puts ""
                    puts "#{player.name} has a KDR of #{player.kdr}"
                    puts ""
                when "history"
                    puts "#{player.match_history}"
                when "exit"
                
                else 
                    puts "Please enter a valid input:"
                end
        end 
    end 

end