module Todo
  class Persistence
    def save(obj)
      @obj = obj
      self
    end

    def to(buffer)
      buffer.truncate(0)
      buffer.puts(@obj)
    end
  end
end
