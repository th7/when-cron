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
      @day    == time.day &&
      @month  == time.month &&
      @wday   == time.wday
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
