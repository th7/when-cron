class CronInterval
  def initialize(range, interval)
    @range = range
    @interval = interval
  end

  def ==(int)
    int == @range && (int - @range.first) % @interval == 0
  end
end
