require "chappie/version"
require "chappie/cli"
require "dotenv"
module Chappie
  Dotenv.load

  unless File.exist? 'Vagrantfile'
    abort "Error: \r\n Please run this command from the root of your Varying Vagrant Vagrants directory."
  end
end
