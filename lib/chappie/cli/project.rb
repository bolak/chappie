require "chappie/generators/serverpilot"
require "chappie/generators/vagrant"
require "chappie/generators/smores"

module Chappie
  module CLI
    class New < Thor
      desc "project NAME CLIENT", "Scaffolds a new WordPress project."
      long_desc <<-NEW_PROJECT
      `project NAME CLIENT` will scaffold an entirely new project.

      This command creates a Bitbucket repo named after the {project-client}
      syntax. Additionally the script will provision your local VVV instance
      utilizing VV generator. The VVV project will contain our theme framework
      "Smores", and a Movefile for WordMove within the theme directory.
      The WordMove file will be programmatically populated with the information
      generated in this command. Finally the script sets up a ServerPilot virtual
      host and database on the staging server ( already in the Movefile ).

      NEW_PROJECT

      def project( name, client )
        puts "Creating New Project #{name}-#{client}."

        #Initializing Project Properties
        @client          = client
        @name            = name
        @staging_pass    = create_password
        @staging_db_pass = create_password

        sp_connection = Chappie::Generator::Staging.new @name, @client
        sp_user_id = sp_connection.create_user @staging_pass
        sp_app_id = sp_connection.create_site sp_user_id
        sp_db = sp_connection.create_database sp_app_id, @staging_db_pass

        local_install = Chappie::Generator::Vagrant.new @name, @client
        local_install.create_new

        Chappie::Generator::Smores.new @name
        Chappie::Generator::WordMove.new @name, @client, @staging_db_pass, @staging_pass

        puts "===============================================================",
             "Please copy & paste the following into a new file in the WIKI: ",
             "===============================================================",
             "Staging Database: #{@name}_#{@client}",
             "Staging Database User: #{@name}_#{@client}",
             "Staging Database Password: #{@staging_db_pass}",
             "Staging URL: #{@name}.#{@client}.staging.findsomewinmore.com",
             "Staging SFTP User: #{@name}-#{@client}",
             "Staging SFTP Password: #{@staging_pass}"
      end

      protected

      def create_password
        o = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten
        string = (0...10).map { o[rand(o.length)] }.join
        return string
      end
    end
  end
end
