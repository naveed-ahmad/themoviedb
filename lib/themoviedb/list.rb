module Tmdb
  class List
    # Get a list by ID
    def self.detail(id)
      Tmdb::Search.new("/list/#{id}").fetch_response
    end
  end
end