require 'todo/task'

module Todo
  class TaskList
    def initialize(buffer=StringIO.new)
      @tasks = buffer.string.split("\n").map { |description| Task.new(description) }
    end

    def add_task(text)
      @tasks << Task.new(text)
    end

    def done
      first_unfinished_todo = @tasks.find(&:in_progress?)
      first_unfinished_todo.done if first_unfinished_todo
    end

    def clear
      @tasks = @tasks.reject(&:done?)
    end

    def to_s
      @tasks.map(&:description).join("\n")
    end

    def unfinished_tasks
      TaskList.new.tap do |list|
        @tasks.select(&:in_progress?).each { |done_task| list.add_task(done_task.description) }
      end
    end

    def save(buffer)
      buffer.truncate(0)
      buffer.puts(self)
    end
  end
end