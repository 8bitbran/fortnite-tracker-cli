class FortniteTracker::CLI

    attr_reader :player
    
    def call 
        puts "Welcome to Fortnite Tracker!\n"
        puts "Track players' stats by platform and player name\n"
        start 
    end 

    def start 
        puts "Enter a platform (pc, xbox, ps4): "
        platform = gets.downcase
        puts "Enter a username: "
        handle = gets.downcase
        APIManager.get_player(platform, handle)
        @player = Players.all.find{|player| player.name.downcase == handle.downcase}
        track_player
    end 

    def menu 
        puts "Menu:\n"
        puts "Type 'all' for all stats"
        puts "Type 'time played' for total time played"
        puts "Type 'top fives' for total games with Top 5 placement"
        puts "Type 'wins' for total wins"
        puts "Type 'percentage' for win percentage"
        puts "Type 'kills' for total kills"
        puts "Type 'kdr' for kill-death ratio"
        puts "Type 'history' for match history"
        puts "Type 'player' to get a different player"
        puts "\nType 'exit' to exit"
    end

    def track_player
        menu
        input = nil 
        while input != "exit" || input != "player"
            input = gets.downcase
            case input
                when "all"
                    puts "\nAll Stats for #{player.name}\n"
                    player.all_stats
                    puts "\nEnter another option or 'exit' to exit: "
                when "time played"
                    puts "\n#{player.name} has played for #{player.time_played}\n"
                    puts "Enter another option or 'exit' to exit: "
                when "top fives"
                    puts "\n#{player.name} has placed top 5 in #{player.top_fives} games\n"
                    puts "Enter another option or 'exit' to exit: "
                when "wins"
                    puts "\n#{player.name} has won #{player.wins} games\n"
                    puts "Enter another option or 'exit' to exit: "
                when "percentage"
                    puts "\n#{player.name} has a win percentage of #{player.win_percentage}\n"
                    puts "Enter another option or 'exit' to exit: "
                when "kills"
                    puts "\n#{player.name} has #{player.kills} total kills\n"
                    puts "Enter another option or 'exit' to exit: "
                when "kdr"
                    puts "\n#{player.name} has a KDR of #{player.kdr}\n"
                when "history"
                    puts "\n#{player.match_history}\n"
                    puts "Enter another option or 'exit' to exit: "
                when "player"
                    start
                when "exit"
                    exit
                else 
                    puts "Please enter a valid input:"
                end
        end 
    end 
    
end