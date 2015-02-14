module GeoPattern
  module Roles
    module NamedGenerator
      def name?(other_name)
        name == other_name.to_sym
      end

      def name
        Helpers.underscore(Helpers.demodulize(self.class).gsub(/Generator/, '')).to_sym
      end
    end
  end
end
