module GeoPattern
  # Roles
  module Roles
    # A comparable metadata
    module ComparableMetadata
      def self.included(base)
        base.extend ClassMethods
      end

      def generator?(value)
        return false unless value.is_a?(Class) || value.nil?
        return true if value.nil? && @generator

        return true if value == generator

        false
      end

      # Class Methods
      module ClassMethods
        # Define comparators
        def def_comparators(*methods)
          methods.flatten.each do |m|
            define_method "#{m}?".to_sym do |value|
              return true if value.nil? && public_send(m)
              return true if value == public_send(m)

              false
            end
          end
        end
      end
    end
  end
end
