module When
  class Cron
    def self.valid?(cron)
      Validator.valid?(cron)
    end

    def self.valid(cron)
      new(cron) if valid?(cron)
    end

    def initialize(cron)
      @cron = cron
    end

    def ==(time)
      @parsed ||= parse(@cron)

      @minute == time.min &&
      @hour   == time.hour &&
      @month  == time.month &&
      day_of_week_and_or_day_of_month?(time)
    end

    def day_of_week_and_or_day_of_month?(time)
      if @day.wildcard? || @wday.wildcard?
        @day == time.day && @wday == time.wday
      else
        @day == time.day || @wday == time.wday
      end
    end

    private

    def parse(string)
      strings = string.split(' ')
      @minute = CronPart.new(strings[0])
      @hour   = CronPart.new(strings[1])
      @day    = CronPart.new(strings[2])
      @month  = CronPart.new(strings[3])
      @wday   = CronPart.new(strings[4])
    end
  end
end
