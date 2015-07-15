require "chappie/connectors/serverpilot"

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
        @client = client
        @name = name
        self.create_staging_pass
        sp_connection = Chappie::Connector::Staging.new(@name, @client)
        sp_user_id = sp_connection.create_user(@staging_pass)
        sp_app_id = sp_connection.create_site(sp_user_id)
      end

      protected

      def create_staging_pass
        @staging_pass = self.create_password
      end

      def create_password
        o = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten
        string = (0...10).map { o[rand(o.length)] }.join
        return string
      end
    end
  end
end
