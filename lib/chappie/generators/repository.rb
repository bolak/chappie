module Chappie
  module Generator
    class Repository
      require "bitbucket_rest_api"
      require "yaml"

      def initialize
        @config = YAML::load_file "Chappiefile"
        @bit_bucket = BitBucket.new login: @config["bitbucket"]["login"],
                                    password: @config["bitbucket"]["password"]
      end

      def create_repo(name)
        @bit_bucket.repos.create name: name, owner: @config["bitbucket"]["team_name"]
      end
    end
  end
end
