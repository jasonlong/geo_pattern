# frozen_string_literal: true

module GeoPattern
  module StructureGenerators
    class SineWavesGenerator < BaseGenerator
      private

      attr_reader :period, :amplitude, :wave_width

      def after_initialize
        @period = map(hex_val(0, 1), 0, 15, 100, 400).floor
        @amplitude = map(hex_val(1, 1), 0, 15, 30, 100).floor
        @wave_width = map(hex_val(2, 1), 0, 15, 3, 30).floor

        self.height = wave_width * 36
        self.width = period
      end

      def generate_structure
        36.times do |i|
          val = hex_val(i, 1)
          opacity = opacity(val)
          fill = fill_color(val)
          x_offset = period / 4 * 0.7

          styles = {
            "fill" => "none",
            "stroke" => fill,
            "style" => {
              "opacity" => opacity,
              "stroke-width" => "#{wave_width}px"
            }
          }

          str = "M0 #{amplitude} C #{x_offset} 0, #{period / 2 - x_offset} 0, #{period / 2} #{amplitude} S #{period - x_offset} #{amplitude * 2}, #{period} #{amplitude} S #{period * 1.5 - x_offset} 0, #{period * 1.5}, #{amplitude}"

          svg.path(str, styles.merge("transform" => "translate(-#{period / 4}, #{wave_width * i - amplitude * 1.5})"))
          svg.path(str, styles.merge("transform" => "translate(-#{period / 4}, #{wave_width * i - amplitude * 1.5 + wave_width * 36})"))
        end

        svg
      end
    end
  end
end
