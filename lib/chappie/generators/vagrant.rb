module Chappie
  module Generator
    class Vagrant

      def initialize(name, client)
        @name   = name
        @client = client
      end

      def create_new
        puts "vv create -d #{@name}.#{@client}.dev -n #{@name} -x"
      end
    end
  end
end
