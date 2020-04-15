class FortniteTracker::APIManager

    BASE_URL = "https://api.fortnitetracker.com/v1/profile/"

    def self.get_player(platform, player)
        headers = {"TRN-Api-Key" => "5b6dbd29-9779-4709-85cf-ce5174b36f90"}
        response = HTTParty.get("#{BASE_URL}#{platform}/#{player}", headers: headers)
        FortniteTracker::Players.create(response)
    end
end 