module Todo
  class Day
    def initialize(buffer)
      @buffer = buffer
    end

    def to_s
      @buffer
    end
  end
end