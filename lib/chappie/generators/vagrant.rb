module Chappie
  module Generator
    class Vagrant

      def initialize(name, client)
        @name   = name
        @client = client
        self.create_new
      end

      def create_new
        system "vv create -d #{@name}.#{@client}.dev -n #{@name} -x"
      end
    end
  end
end
