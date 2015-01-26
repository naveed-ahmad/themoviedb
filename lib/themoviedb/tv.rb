module Tmdb
  class TV < Resource
    has_resource 'tv', :plural => 'tv'

    #http://docs.themoviedb.apiary.io/#tv
    @@fields = [
      :backdrop_path,
      :created_by,
      :episode_run_time,
      :first_air_date,
      :genres,
      :homepage,
      :id,
      :in_production,
      :languages,
      :last_air_date,
      :name,
      :networks,
      :number_of_episodes,
      :number_of_seasons,
      :original_name,
      :origin_country,
      :overview,
      :popularity,
      :poster_path,
      :seasons,
      :status,
      :vote_average,
      :vote_count,
      :credits,
      :external_ids,
      :changes,
      :page,
      :total_pages,
      :total_results,
      :start_date,
      :end_date
    ]

    @@fields.each do |field|
      attr_accessor field
    end

    #Get the latest movie id. singular
    def self.latest
      search = Tmdb::Search.new("/tv/latest")
      search.fetch_response
    end

    #Get the list of popular TV shows. This list refreshes every day.
    def self.popular
      search = Tmdb::Search.new("/tv/popular")
      search.fetch
    end

    #Get the list of top rated TV shows. By default, this list will only include TV shows that have 2 or more votes. This list refreshes every day.
    def self.top_rated
      search = Tmdb::Search.new("/tv/top_rated")
      search.fetch
    end

    #Discover TV shows by different types of data like average rating, number of votes, genres, the network they aired on and air dates
    def self.discover(conditions={})
      search = Tmdb::Search.new("/discover/tv")
      search.filter(conditions)
      search.fetch
    end

    #Airing today: Get the list of TV shows that air today. Without a specified timezone, this query defaults to EST (Eastern Time UTC-05:00).
    def self.airing_today(page=1)
      search = Tmdb::Search.new("/tv/airing_today")
      search.filter page: page
      search.fetch
    end

    #Get the list of TV shows that are currently on the air. This query looks for any TV show that has an episode with an air date in the next 7 days
    def self.on_the_air(page=1)
      search = Tmdb::Search.new("/tv/on_the_air")
      search.filter page: page
      search.fetch
    end

    #Get a list of TV show ids that have been edited.
    # By default we show the last 24 hours and only 100 items per page.
    # The maximum number of days that can be returned in a single request is 14.
    # You can then use the TV changes API to get the actual data that has been changed.
    def self.latest(page=1)
      search = Tmdb::Search.new("/tv/latest")
      search.fetch
    end

    def self.changes(start_date, end_date, page = 1)
      search = Tmdb::Search.new("/tv/changes")
      search.filter page: page, start_date: start_date.strftime("%Y-%m-%d"), end_date: end_date.strftime("%Y-%m-%d")
      search.fetch
    end


    #Get the cast information about a TV series.
    def self.cast(id, conditions={})
      search = Tmdb::Search.new("/#{self.endpoints[:singular]}/#{self.endpoint_id + id.to_s}/credits")
      search.fetch_response.cast
    end

    #Get the crew information about a TV series.
    def self.crew(id, conditions={})
      search = Tmdb::Search.new("/#{self.endpoints[:singular]}/#{self.endpoint_id + id.to_s}/credits")
      search.fetch_response.crew
    end

    #Get the external ids that we have stored for a TV series.
    def self.external_ids(id, conditions={})
      search = Tmdb::Search.new("/#{self.endpoints[:singular]}/#{self.endpoint_id + id.to_s}/external_ids")
      search.fetch_response
    end

    #Get the images (posters and backdrops) for a TV series.
    def self.images(id, conditions={})
      search = Tmdb::Search.new("/#{self.endpoints[:singular]}/#{self.endpoint_id + id.to_s}/images")
      search.fetch_response
    end

    #Get the videos (trailers etc) for a TV series.
    def self.videos(id, conditions={})
      search = Tmdb::Search.new("/#{self.endpoints[:singular]}/#{self.endpoint_id + id.to_s}/videos")
      search.fetch_response
    end

    def self.changes(id=nil, conditions={})
      if id.present?
        search = Tmdb::Search.new("/#{self.endpoints[:singular]}/#{self.endpoint_id + id.to_s}/changes")
      else
        search = Tmdb::Search.new("/tv/changes")
        search.filter(conditions)
      end
      search.fetch_response
    end
  end
end
