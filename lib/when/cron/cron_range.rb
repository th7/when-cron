class CronRange
  attr_reader :first, :last

  def initialize(first, last)
    @first = first
    @last = last
  end

  def ==(int)
    @first <= int && @last >= int
  end
end
