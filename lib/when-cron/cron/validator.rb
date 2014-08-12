module When
  class Cron
    class Validator
      MONTHS = {
        'JAN' => '1',
        'FEB' => '2',
        'MAR' => '3',
        'APR' => '4',
        'MAY' => '5',
        'JUN' => '6',
        'JUL' => '7',
        'AUG' => '8',
        'SEP' => '9',
        'OCT' => '10',
        'NOV' => '11',
        'DEC' => '12',
      }

      WDAYS = {
        'SUN' => '0',
        'MON' => '1',
        'TUE' => '2',
        'WED' => '3',
        'THU' => '4',
        'FRI' => '5',
        'SAT' => '6',
      }

      NOT_BASIC_CHARS      = /[^\d,\/\*\-]/
      NOT_BASIC_OR_LETTERS = /[^\d,\/\*\-a-zA-Z]/

      def self.valid?(cron)
        v = new(cron)
        v.correct_number_of_parts? &&
        v.min_correct? &&
        v.hour_correct? &&
        v.day_correct? &&
        v.month_correct? &&
        v.wday_correct?
      end

      attr_reader :cron

      def initialize(cron)
        @cron = cron
      end

      def parts
        @parts ||= cron.split(' ')
      end

      def min
        parts[0]
      end

      def hour
        parts[1]
      end

      def day
        parts[2]
      end

      def month
        parts[3]
      end

      def wday
        parts[4]
      end

      def correct_number_of_parts?
        cron.split(' ').count == 5
      end

      def min_correct?
        correct_range?(min, 0..59) &&
        !(min =~ NOT_BASIC_CHARS)
      end

      def hour_correct?
        correct_range?(hour, 0..23) &&
        !(hour =~ NOT_BASIC_CHARS)
      end

      def day_correct?
        correct_range?(day, 1..31) &&
        !(day =~ NOT_BASIC_CHARS)
      end

      def month_correct?
        correct_range?(month, 1..12) &&
        month.scan(/[a-zA-Z]+/).all? { |w| MONTHS[w.upcase] } &&
        !(month =~ NOT_BASIC_OR_LETTERS)
      end

      def wday_correct?
        correct_range?(wday, 0..6) &&
        wday.scan(/[a-zA-Z]+/).all? { |w| WDAYS[w.upcase] } &&
        !(wday =~ NOT_BASIC_OR_LETTERS)
      end

      private

      def correct_range?(part, range)
        part.scan(/\d+/).all? do |digits|
          range === digits.to_i
        end
      end
    end
  end
end
