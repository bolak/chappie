module Chappie
  module Generator
    class Staging

      require "ServerPilot"
      require "yaml"

      def initialize(name, client)
        @config = YAML::load_file "Chappiefile"

        @project_name   = name
        @project_client = client
        @client = @config["server_pilot"]["client"]
        @key = @config["server_pilot"]["key"]
        @server = @config["server_pilot"]["server_id"]
        @sp_connection  = ServerPilot::API.new(@client, @key)
      end

      def create_user(password)
        user_params = {
          serverid: @server,
          name: "#{@project_name}-#{@project_client}",
          password: password
        }
        app_user = @sp_connection.post_sysusers user_params
        puts "Staging FTP user created with Server Pilot"
        return app_user[:body]["data"]["id"]
      end

      def create_site(user_id)
        site_params = {
          name: @project_name + @project_client,
          sysuserid: user_id,
          runtime: "php5.4",
          domains: ["#{@project_name}.#{@project_client}.staging.findsomewinmore.com"]
        }
        app = @sp_connection.post_apps site_params
        puts "Staging site created with Server Pilot"
        return app[:body]["data"]["id"]
      end

      def create_database(app_id, db_password)
        db_params = {
          appid: app_id,
          name: "#{@project_name}_#{@project_client}",
          user: { name: "#{@project_name}_#{@project_client}", password: db_password }
        }
        puts "Staging database created with Server Pilot"
        return @sp_connection.post_dbs db_params
      end

    end
  end
end
