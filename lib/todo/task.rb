require 'todo/task_item'

module Todo
  class Task
    def initialize(buffer=StringIO.new)
      @todos = buffer.string.split("\n").map { |description| TaskItem.new(description) }
    end

    def add_todo(text)
      @todos << TaskItem.new(text)
    end

    def done
      first_unfinished_todo = @todos.find(&:in_progress?)
      first_unfinished_todo.done if first_unfinished_todo
    end

    def to_s
      @todos.map(&:description).join("\n")
    end

    def save(buffer)
      buffer.truncate(0)
      buffer.puts(self)
    end
  end
end