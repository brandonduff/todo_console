module Todo
  class Task
    attr_reader :todos

    def initialize(buffer=StringIO.new)
      @todos = buffer.string.split("\n")
    end

    def add_todo(text)
      @todos << text
    end

    def done
      @todos.shift
    end

    def to_s
      @todos.join("\n")
    end

    def save(buffer)
      buffer.truncate(0)
      buffer.puts(self)
    end
  end
end