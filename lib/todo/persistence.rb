module Todo
  class Persistence
    def self.for(obj)
      new(obj)
    end

    def initialize(writable)
      @writable = writable
    end

    def write_to(buffer)
      buffer.truncate(0)
      buffer.puts(@writable)
    end
  end
end
