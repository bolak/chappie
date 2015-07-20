module Chappie
  module Generator
    class Smores
      def initialize(name)
        @name = name
        system "git clone git@github.com:findsomewinmore/smores.git www/#{@name}/htdocs/wp-content/themes/#{@name}"
        Dir.chdir("www/#{@name}/htdocs/wp-content/themes/#{@name}") do
          system "rm -rf .git"
          system "git flow init -fd"
          system "npm install"
          system "git add --all && git commit -am 'initial commit'"
        end
      end
    end
  end
end
