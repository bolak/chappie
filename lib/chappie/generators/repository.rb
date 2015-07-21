module Chappie
  module Generator
    class Repository
      require "bitbucket_rest_api"
      require "yaml"

      def initialize
        @config = YAML::load_file "Chappiefile"

        @bit_bucket = BitBucket.new do |config|
          config.oath_token = @config["bitbucket"]["request_token"]
          config.oath_secret = @config["bitbucket"]["request_secret"]
          config.client_id = @config["bitbucket"]["consumer_key"]
          config.client_secret = @config["bitbucket"]["consumer_secret"]
          config.adapter = :net_http
        end

        @bit_bucket.repos.list do |repo|
          puts repo.slug
        end
      end
    end
  end
end
