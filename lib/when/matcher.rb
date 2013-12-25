class Matcher
  def initialize(raw_string)
    @raw_string = raw_string
  end

  def matches?(date)
    if date == Date.today
      true
    else
      false
    end
  end
end
