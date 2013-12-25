module When
  class CronPart
    def initialize(cron_part)
      @cron_part = cron_part
    end

    def ==(int)
      part == int
    end

    private

    def part
      @part ||= parse(@cron_part)
    end

    def parse(cron_part)
      if cron_part =~ /,/
        CronArray.new(cron_part.split(',').map { |s| parse(s) })
      elsif cron_part =~ /^((\d+|\*)-(\d+|\*)|\*)\/\d+$/
        CronInterval.new(*cron_part.split('/').map { |s| parse(s) })
      elsif cron_part =~ /^(\d+|\*)-(\d+|\*)$/
        CronRange.new(*cron_part.split('-').map { |s| parse(s) })
      elsif cron_part == '*'
        Wildcard.new
      else
        cron_part.to_i
      end
    end
  end
end
