module Tmdb
  class Season < Resource
    has_resource 'season', :plural => 'seasons'

    @@fields = [
      :air_date,
      :episodes,
      :name,
      :overview,
      :id,
      :poster_path,
      :season_number,
      :credits,
      :external_ids,
      :images,
      :videos,
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

    #Get the primary information about a TV season by its season number.
    def self.detail(id, season, conditions={})
      search = Tmdb::Search.new("/tv/#{self.endpoint_id + id.to_s}/#{self.endpoints[:singular]}/#{self.endpoint_id + season.to_s}")
      search.filter(conditions)
      search.fetch_response
    end

    #Get the cast credits for a TV season by season number.
    def self.cast(id, season, conditions={})
      search = Tmdb::Search.new("/tv/#{self.endpoint_id + id.to_s}/#{self.endpoints[:singular]}/#{self.endpoint_id + season.to_s}/credits")
      search.fetch_response['cast']
    end

    #Get the crew credits for a TV season by season number.
    def self.crew(id, season, conditions={})
      search = Tmdb::Search.new("/tv/#{self.endpoint_id + id.to_s}/#{self.endpoints[:singular]}/#{self.endpoint_id + season.to_s}/credits")
      search.fetch_response['crew']
    end

    #Get the external ids that we have stored for a TV season by season number.
    def self.external_ids(id, season, conditions={})
      search = Tmdb::Search.new("/tv/#{self.endpoint_id + id.to_s}/#{self.endpoints[:singular]}/#{self.endpoint_id + season.to_s}/external_ids")
      search.fetch_response
    end

    #Get the images (posters) that we have stored for a TV season by season number.
    def self.images(id, season, conditions={})
      search = Tmdb::Search.new("/tv/#{self.endpoint_id + id.to_s}/#{self.endpoints[:singular]}/#{self.endpoint_id + season.to_s}/images")
      search.fetch_response
    end

    #Get the videos (teasers etc) that we have stored for a TV season by season number.
    def self.videos(id, season, conditions={})
      search = Tmdb::Search.new("/tv/#{self.endpoint_id + id.to_s}/#{self.endpoints[:singular]}/#{self.endpoint_id + season.to_s}/videos")
      search.fetch_response
    end

  end
end
