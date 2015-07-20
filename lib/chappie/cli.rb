require 'thor'
require 'chappie/cli/project'

module Chappie
  class App < Thor
    desc "new COMMANDS", "New Project Control Module"
    subcommand "new", Chappie::CLI::New
  end
end
