module When
  class CronArray
    def initialize(array)
      @array = array
    end

    def ==(int)
      @array.any? { |i| i == int }
    end
  end
end
