class CronWDay
  def initialize(cron_wday)
    @cron_wday = cron_wday
  end

  def ==(date)
    day == date.wday
  end

  private

  def day
    @day ||= parse(@cron_wday)
  end

  def parse(string)
    if string =~ /,/
      CronArray.new(string.split(',').map { |s| parse(s) })
    elsif string =~ /^((\d+|\*)-(\d+|\*)|\*)\/\d+$/
      CronInterval.new(*string.split('/').map { |s| parse(s) })
    elsif string =~ /^(\d+|\*)-(\d+|\*)$/
      CronRange.new(*string.split('-').map { |s| parse(s) })
    elsif string == '*'
      Wildcard.new
    else
      string.to_i
    end
  end
end
