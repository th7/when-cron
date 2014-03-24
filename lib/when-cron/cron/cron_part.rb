module When
  class CronPart
    class InvalidString < StandardError; end

    def initialize(cron_part)
      @part = parse(cron_part)
    end

    def ==(int)
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
        to_valid_int(cron_part)
      end
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
