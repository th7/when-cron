module When
  class CronPart
    class InvalidString < StandardError; end

    REMAP = {
      'SUN' => '0',
      'MON' => '1',
      'TUE' => '2',
      'WED' => '3',
      'THU' => '4',
      'FRI' => '5',
      'SAT' => '6',

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

    def initialize(cron_part)
      @cron_part = cron_part
      @part = parse(cron_part)
    end

    def ==(int)
      @part ||= parse(@cron_part)
      @part == int
    end

    private

    def parse(cron_part)
      if cron_part =~ /,/
        CronArray.new(cron_part.split(',').map { |s| parse(s) })
      elsif cron_part =~ /\//
        CronInterval.new(*cron_part.split('/').map { |s| parse(s) })
      elsif cron_part =~ /-/
        CronRange.new(*cron_part.split('-').map { |s| parse(s) })
      elsif cron_part == '*'
        Wildcard.new
      else
        to_int(cron_part)
      end
    end

    def to_int(cron_part)
      to_valid_int(REMAP[cron_part] || cron_part)
    end

    def to_valid_int(cron_part)
      int = cron_part.to_i
      if int.to_s == cron_part
        int
      else
        raise When::CronPart::InvalidString, "found #{cron_part.inspect}: only * or integer values and / , - operators are supported"
      end
    end
  end

end
