module GeoPattern
  # Color generators
  module ColorGenerators
    # Simple one
    class SimpleGenerator
      private

      attr_reader :color, :creator

      public

      # New
      #
      # @param [String] color
      #   HTML color string, #0a0a0a
      def initialize(color, creator = Color)
        @color = color
        @creator = creator
      end

      # Generator color
      def generate
        creator.new(color)
      end
    end
  end
end
