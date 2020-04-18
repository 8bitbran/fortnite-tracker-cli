class FortniteTracker::CLI

    attr_accessor :player
                                                                                                               
    def call 
        fortnite_logo = AsciiArt.new("https://i.imgur.com/zwwIIFQ.jpg")
        puts fortnite_logo.to_ascii_art                                                                                                        
        puts "\n\nWelcome to Fortnite Tracker!\n\n".color(:red)
        puts "Track players' stats by platform and player name\n\n"
        start 
    end 

    def start
        platform, handle = platform_name, player_name
        FortniteTracker::Players.find_or_create_by_name(platform, handle)
        @player = FortniteTracker::Players.all.find{|player| player.name.downcase == handle.downcase}
        track_player
    end 

    def platform_name 
        platform = nil
        until platform == "pc" || platform == "xbox" || platform == "ps4" 
            puts "Please enter a platform (pc, xbox, ps4): "
            platform = gets.chomp.downcase
        end
        platform
    end
    
    def player_name
        puts "\nEnter a username: "
        handle = gets.chomp.downcase
        handle
    end 

    def menu 
        puts "\nMenu Options:\n\n".color(:red)
        puts "Type #{"'all'".color(:yellow)} for all stats"
        puts "Type #{"'time played'".color(:yellow)} for total time played"
        puts "Type #{"'top fives'".color(:yellow)} for total games with Top 5 placement"
        puts "Type #{"'wins'".color(:yellow)} for total wins"
        puts "Type #{"'percentage'".color(:yellow)} for win percentage"
        puts "Type #{"'kills'".color(:yellow)} for total kills"
        puts "Type #{"'kdr'".color(:yellow)} for kill-death ratio"
        puts "Type #{"'history'".color(:yellow)} for match history"
        puts "Type #{"'change player'".color(:yellow)} to get a different player"
        puts "\nType #{"'exit'".color(:red)} to exit\n\n"
    end

    def track_player
        menu
        input = nil 
        while input != "exit" || input != "player" || input != "start"
            input = gets.chomp.downcase
            case input
                when "all"
                    puts "\n#{"All Stats".color(:yellow)} for #{@player.name.color(:red)}\n\n"
                    player.all_stats
                    puts "\n\n"
                    puts "Enter another option or type #{"'menu'".color(:red)} for menu: \n\n"
                when "time played"
                    puts "\n#{@player.name.color(:red)} has played #{@player.time_played.color(:yellow)}\n\n"
                    puts "Enter another option or type #{"'menu'".color(:red)}  for menu: \n\n"
                when "top fives"
                    puts "\n#{@player.name.color(:red)} has placed top 5 in #{@player.top_fives.color(:yellow)} games\n\n"
                    puts "Enter another option or type #{"'menu'".color(:red)}  for menu: \n\n"
                when "wins"
                    puts "\n#{@player.name.color(:red)} has won #{@player.wins.color(:yellow)} games\n\n"
                    puts "Enter another option or type #{"'menu'".color(:red)}  for menu: \n\n"
                when "percentage"
                    puts "\n#{@player.name.color(:red)} has a win percentage of #{@player.win_percentage.color(:yellow)}\n\n"
                    puts "Enter another option or type #{"'menu'".color(:red)}  for menu: \n\n"
                when "kills"
                    puts "\n#{@player.name.color(:red)} has #{@player.kills.color(:yellow)} total kills\n\n"
                    puts "Enter another option or type #{"'menu'".color(:red)}  for menu: \n\n"
                when "kdr"
                    puts "\n#{@player.name.color(:red)} has a KDR of #{@player.kdr.color(:yellow)}\n\n"
                    puts "Enter another option or type #{"'menu'".color(:red)}  for menu: \n\n"
                when "history"
                    puts "\n#{"Match History".color(:yellow)} for #{@player.name.color(:red)}\n\n"
                    puts "#{@player.match_history}"
                    puts "\n"
                    puts "Enter another option or #{"'menu'".color(:red)}  for menu: \n\n"
                when "menu"
                    menu 
                when "change player"
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