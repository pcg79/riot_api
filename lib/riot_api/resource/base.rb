module RiotApi
  module Resource
    class Base
      def initialize(connection, region, options = {})
        @connection = connection
        @region = region
      end

      def endpoint_precursor
        "lol/#{@region}/v1.1"
      end

      private

      def build_model(data)
        model_class.new data
      end

      # Returns the Model class of the same name as the Resource.
      # The awful idea was mine but I take no credit for the implementation.
      # Stole it from the comments here:
      # http://infovore.org/archives/2006/08/02/getting-a-class-object-in-ruby-from-a-string-containing-that-classes-name/
      def model_class
        base_class = self.class.to_s.split('::').last
        class_name = "RiotApi::Model::#{base_class}"
        class_name.split('::').inject(Kernel) { |scope, const_name| scope.const_get(const_name) }
      end

    end
  end
end
