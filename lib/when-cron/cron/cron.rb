module When
  class Cron
    def self.valid?(cron)
      #checks for 5 space delimited groups of only * / 0-9 , -
      !!(cron =~ /\A((\d|\*|\/|,|-)+ ){4}(\d|\*|\/|,|-)+\z/)
    end

    def initialize(cron)
      parse(cron)
    end

    def ==(time)
      matches = []
      matches << (@minute == time.min)
      matches << (@hour == time.hour)
      matches << (@day == time.day)
      matches << (@month == time.month)
      matches << (@wday == time.wday)
      matches.all?
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
