class FortniteTracker::CLI

    attr_accessor :player
    
    def call 
        puts "Welcome to Fortnite Tracker!\n\n"
        puts "Track players' stats by platform and player name\n\n"
        start 
    end 

    def start 
        puts "Enter a platform (pc, xbox, ps4): "
        platform = gets.chomp.downcase
        puts "\nEnter a username: "
        handle = gets.chomp.downcase
        FortniteTracker::Players.find_or_create_by_name(platform, handle)
        @player = FortniteTracker::Players.all.find{|player| player.name.downcase == handle.downcase}
        track_player
    end 

    def menu 
        puts "Menu:\n\n"
        puts "Type 'all' for all stats"
        puts "Type 'time played' for total time played"
        puts "Type 'top fives' for total games with Top 5 placement"
        puts "Type 'wins' for total wins"
        puts "Type 'percentage' for win percentage"
        puts "Type 'kills' for total kills"
        puts "Type 'kdr' for kill-death ratio"
        puts "Type 'history' for match history"
        puts "Type 'player' to get a different player"
        puts "\n\nType 'exit' to exit\n\n"
    end

    def track_player
        menu
        input = nil 
        while input != "exit" || input != "player" || input != "start"
            input = gets.chomp.downcase
            case input
                when "all"
                    puts "\n\nAll Stats for #{player.name}\n\n"
                    player.all_stats
                    puts "\n\n"
                    puts "Enter another option or type 'menu' for menu: \n\n"
                when "time played"
                    puts "\n\n#{player.name} has played #{player.time_played}\n\n"
                    puts "Enter another option or type 'menu' for menu: \n\n"
                when "top fives"
                    puts "\n\n#{player.name} has placed top 5 in #{player.top_fives} games\n\n"
                    puts "Enter another option or type 'menu' for menu: \n\n"
                when "wins"
                    puts "\n\n#{player.name} has won #{player.wins} games\n\n"
                    puts "Enter another option or type 'menu' for menu: \n\n"
                when "percentage"
                    puts "\n\n#{player.name} has a win percentage of #{player.win_percentage}\n\n"
                    puts "Enter another option or type 'menu' for menu: \n\n"
                when "kills"
                    puts "\n\n#{player.name} has #{player.kills} total kills\n\n"
                    puts "Enter another option or type 'menu' for menu: \n\n"
                when "kdr"
                    puts "\n\n#{player.name} has a KDR of #{player.kdr}\n\n"
                    puts "Enter another option or type 'menu' for menu: \n\n"
                when "history"
                    puts "\n"
                    puts "#{player.match_history}"
                    puts "\n"
                    puts "Enter another option or 'menu' for menu: \n\n"
                when "menu"
                    menu 
                when "player"
                    puts "\n"
                    start
                when "exit"
                    exit
                else 
                    puts "\nPlease enter a valid input: \n\n"
                end
        end 
    end 

end