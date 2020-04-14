class FortniteTracker::Players

    # class variable that holds an array of all player objects
    @@all = []

    # access contents of the class variable '@@all' array
    def self.all 
        @@all 
    end

    # create and save instance
    def self.create(response)
        new(response).save
        @@all.last.id
    end 

    # find player object by ID
    def self.find_by_id(response)
        @@all.find{|player| player.id == response["accountId"]}
    end 

    # uses the find_by_id method to check if a player already exists. 
    # if the player exists, return the player. If not, create a new player object
    def self.find_or_create_by_id(response)
        if self.find_by_id(response)
            self.find_by_id.id
        else 
            self.create(response)
        end
    end 

    attr_reader :id, :name, :platform

    # all instances take in the API response and set instance variables (id, name, platform and stats)
    def initialize(response)
        @id = response["accountId"]
        @name = response["epicUserHandle"]
        @platform = response["platformName"]
        @stats = {"stats" => response["stats"], "lifeTimeStats" => response["lifeTimeStats"], "recentMatches" => response["recentMatches"]}
    end 

    # displays all stats and match history
    def all_stats
        puts "Time Played: #{time_played}"
        puts "Total Kills: #{kills}"
        puts "K/D Ratio: #{kdr}"
        puts "Top 5's: #{top_fives}"
        puts "Win Percentage: #{win_percentage}"
        puts "Wins: #{wins}"
    end 

    # targets the minutesPlayed hash and converts the minutes to hours and minutes
    def time_played
        minutes = @stats["stats"]["p2"]["minutesPlayed"]["valueInt"] + @stats["stats"]["p10"]["minutesPlayed"]["valueInt"] + @stats["stats"]["p9"]["minutesPlayed"]["valueInt"]
        puts "#{minutes / 60}hrs #{minutes % 60}mins"
    end 

    # targets the lifeTimeStats hash and the element holding the top 5's value
    def top_fives 
        @stats["lifeTimeStats"][0]["value"]
    end 

    # targets the lifeTimeStats hash and the element holding the wins value
    def wins 
        @stats["lifeTimeStats"][8]["value"]
    end

    # targets the lifeTimeStats hash and the element holding the win percentage value
    def win_percentage 
        @stats["lifeTimeStats"][9]["value"]
    end 

    # targets the lifeTimeStats hash and the element holding the kills value
    def kills
        @stats["lifeTimeStats"][10]["value"]
    end 

    # targets the lifeTimeStats hash and the element holding the kdr value
    def kdr 
        @stats["lifeTimeStats"][11]["value"]
    end 

    # checks if player has recent match history and iterates through the matches to puts out the information
    def match_history
        if @stats["recentMatches"].empty?
            puts "There are no recent matches available."
        else
            collection = 1
            @stats["recentMatches"].each do |matches|
                puts ""
                puts ""
                puts "Collection #{collection}:"
                puts "-----------------------------------"
                puts "Matches Played: #{matches["matches"]}"
                puts ""
                puts "Date Collected: #{matches["dateCollected"].split("T")[0]}"
                puts ""
                puts "Playlist: #{matches["playlist"].capitalize}"
                puts ""
                if matches["top1"] > 0 
                    puts "Result: #{matches["top1"]} win(s)"
                else 
                    puts "Result: No matches won"
                end
                puts ""
                puts "Kills: #{matches["kills"]}"
                puts""
                puts "Outlived #{matches["playersOutlived"]} players in #{matches["matches"]} matches"
                puts "-----------------------------------"
                collection += 1
            end 
        end
    end

    # adds instance to class variable '@@all'
    def save 
        @@all << self
    end 

end 

binding.pry