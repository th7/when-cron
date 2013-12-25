class Rule
  def initialize(cron)
    @cron = cron
  end

  def matches?(date)
    [
      wday_matches?(date),
      day_matches?(date),
      month_matches?(date)
    ].all? { |m| m == true }
  end

  private

  def wday
    @wday ||= cron_arr[2]
  end

  def wday_matches?(date)
    wday == '*' || wday.to_i == date.wday
  end

  def day
    @day ||= cron_arr[0]
  end

  def day_matches?(date)
    day == '*' || day.to_i == date.day
  end

  def month
    @month ||= cron_arr[1]
  end

  def month_matches?(date)
    month == '*' || month.to_i == date.month
  end

  def cron_arr
    @cron_arr ||= @cron.split(' ')
  end
end
