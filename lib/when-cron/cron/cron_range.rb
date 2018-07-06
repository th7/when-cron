module When
  class CronRange
    attr_reader :first, :last

    def initialize(first, last)
      @first = first
      @last = last
    end

    def ==(int)
      if any_wildcard? || @first <= @last
        @first <= int && @last >= int
      else
        @first <= int || @last >= int
      end
    end

    private

    def any_wildcard?
      @first.is_a?(Wildcard) || @last.is_a?(Wildcard)
    end
  end
end
