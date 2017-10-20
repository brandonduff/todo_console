module Todo
  class Writer
    def self.for(writable)
      new(writable)
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
