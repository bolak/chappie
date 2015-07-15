module Chappie
  module Connector
    class Staging

      require "ServerPilot"

      def initialize(name, client)
        @project_name   = name
        @project_client = client
        @client         = ENV['CHAPPIE_SPK']
        @key            = ENV['CHAPPIE_SPC']
        @server         = ENV['CHAPPIE_SPID']
        @sp_connection  = ServerPilot::API.new(@client, @key)
      end

      def create_user(password)
        user_params = {
          serverid: @server,
          name: "#{@project_name}-#{@project_client}",
          password: password
        }
        app_user = @sp_connection.post_sysusers user_params
        return app_user[:body]["data"]["id"]
      end

      def create_site(user_id)
        site_params = {
          name: @project_name + @project_client,
          sysuserid: user_id,
          runtime: "php5.4",
          domains: ["srv/users/serverpilot/apps/#{@project_name}_#{@project_client}/public"]
        }
        app = @sp_connection.post_apps site_params
        return app[:body]["data"]["id"]
      end

    end
  end
end
