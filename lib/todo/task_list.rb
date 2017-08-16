require 'todo/task_builder'

module Todo
  class TaskList
    def initialize(buffer=StringIO.new)
      @tasks = buffer.string.split("\n").map { |description| TaskBuilder.new(description).build }
    end

    def add_task(task)
      @tasks << task
    end

    def done
      if (first_unfinished_todo_position = @tasks.find_index(&:in_progress?))
        @tasks[first_unfinished_todo_position] = @tasks[first_unfinished_todo_position].done
      end
      self
    end

    def undo
      if (first_done_position = @tasks.find_index(&:done?))
        @tasks[first_done_position] = @tasks[first_done_position].undo
      end
      self
    end

    def clear
      @tasks = @tasks.reject(&:done?)
    end

    def to_s
      @tasks.map(&:description).join("\n")
    end

    def to_a
      @tasks
    end

    def ==(other_list)
      @tasks.each_with_index do |task, index|
        return false unless task == other_list.tasks[index]
      end
      true
    end

    def unfinished_tasks
      TaskList.new.tap do |list|
        @tasks.select(&:in_progress?).each { |done_task| list.add_task(done_task) }
      end
    end

    protected

    attr_reader :tasks

  end
end
