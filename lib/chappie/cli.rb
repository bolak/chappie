require 'thor'
require 'chappie/cli/project'

module Chappie
  class App < Thor

    desc "init", "Creates a Chappiefile in the current directory."
    def init
      system "touch Chappiefile"
      config_file = YAML::load_file "Chappiefile"

      config_file = {
        "server_pilot" => {
          "client" => nil,
          "key" => nil,
          "server_id" => nil
        },
        "bitbucket" => {
          "request_token" => nil,
          "request_secret" => nil,
          "consumer_key" => nil,
          "consumer_secret" => nil
        }
      }

      File.open('Chappiefile', 'w') { |f| f.write config_file.to_yaml }
    end

    desc "new COMMANDS", "New Project Control Module"
    subcommand "new", Chappie::CLI::New

  end
end
