class CronMonth
  def initialize(cron_day)
    @cron_day = cron_day
  end

  def ==(date)
    day == date.month
  end

  private

  def day
    @day ||= parse(@cron_day)
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
