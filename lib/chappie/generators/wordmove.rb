module Chappie
  module Generator
    class Wordmove
      require "yaml"
      def initialize(name, client, db_pass, ssh_pass)
        @name     = name
        @client   = client
        @db_pass  = db_pass
        @ssh_pass = ssh_pass

        self.create_movefile
      end


      def create_movefile
        Dir.chdir("www/#{@name}/htdocs/wp-content/themes/#{@name}") do
            system "wordmove init"

            move_file = YAML::load_file 'Movefile'

            move_file['local']['vhost']                  = "http://#{@name}.#{@client}.dev"
            move_file['local']['database']['name']       = "#{@name}"
            move_file['local']['database']['user']       = "external"
            move_file['local']['database']['password']   = "external"
            move_file['local']['database']['host']       = "#{@name}.#{@client}.dev"
            move_file['staging']['vhost']                = "http://#{@name}.#{@client}.staging.findsomewinmore.com"
            move_file['staging']['wordpress_path']       = "/srv/users/#{@name}-#{@client}/apps/#{@name + @client}/public"
            move_file['staging']['database']['name']     = "#{@name}_#{@client}"
            move_file['staging']['database']['user']     = "#{@name}-#{@client}"
            move_file['staging']['database']['password'] = "#{@db_pass}"
            move_file['staging']['database']['host']     = "50.56.174.21"
            move_file['staging']['ssh'] = {'host' => nil, 'user' => nil, 'password' => nil}
            move_file['staging']['ssh']['host']          = "50.56.174.21"
            move_file['staging']['ssh']['user']          = "#{@name}-#{@client}"
            move_file['staging']['ssh']['password']      = "#{@ssh_pass}"

            File.open('Movefile', 'w') { |f| f.write move_file.to_yaml ExplicitTypes: true }
        end
      end
    end
  end
end
