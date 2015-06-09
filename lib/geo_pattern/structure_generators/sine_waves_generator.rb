module GeoPattern
  module StructureGenerators
    class SineWavesGenerator < BaseGenerator
      private

      attr_reader :period, :amplitude, :wave_width

      def after_initialize
        @period     = map(hex_val(0, 1), 0, 15, 100, 400).floor
        @amplitude  = map(hex_val(1, 1), 0, 15, 30, 100).floor
        @wave_width = map(hex_val(2, 1), 0, 15, 3, 30).floor

        self.height = wave_width * 36
        self.width  = period
      end

      def generate_structure
        for i in 0..35
          val      = hex_val(i, 1)
          opacity  = opacity(val)
          fill     = fill_color(val)
          x_offset = period / 4 * 0.7

          styles = {
            'fill'      => 'none',
            'stroke'    => fill,
            'style'     => {
              'opacity'      => opacity,
              'stroke-width' => "#{wave_width}px"
            }
          }

          str = 'M0 ' + amplitude.to_s + ' C ' + x_offset.to_s + ' 0, ' + (period / 2 - x_offset).to_s + ' 0, ' + (period / 2).to_s + ' ' + amplitude.to_s + ' S ' + (period - x_offset).to_s + ' ' + (amplitude * 2).to_s + ', ' + period.to_s + ' ' + amplitude.to_s + ' S ' + (period * 1.5 - x_offset).to_s + ' 0, ' + (period * 1.5).to_s + ', ' + amplitude.to_s

          svg.path(str, styles.merge('transform' => "translate(-#{period / 4}, #{wave_width * i - amplitude * 1.5})"))
          svg.path(str, styles.merge('transform' => "translate(-#{period / 4}, #{wave_width * i - amplitude * 1.5 + wave_width * 36})"))
        end

        svg
      end
    end
  end
end
