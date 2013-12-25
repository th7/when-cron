module When
  class Cron
    def initialize(cron)
      @cron = cron
    end

    def ==(time)
      parse unless parsed?
      matches = []
      matches << (@minute == time.min)
      matches << (@hour == time.hour)
      matches << (@day == time.day)
      matches << (@month == time.month)
      matches << (@wday == time.wday)
      matches.all?
    end

    private

    def parsed?
      @parsed ||= parse(@cron)
    end

    def parse(string)
      strings = string.split(' ')
      @minute = CronPart.new(strings[0])
      @hour = CronPart.new(strings[1])
      @day = CronPart.new(strings[2])
      @month = CronPart.new(strings[3])
      @wday = CronPart.new(strings[4])
    end
  end
end
