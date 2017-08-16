module Todo
  class TaskListFetcher
    def initialize(day)
      @day = day
    end

    def task_data
      File.exist?(todo_file) ? File.read(todo_file) : ''
    end

    def todo_file
      File.join(ENV['HOME'], 'todos', @day + '.txt')
    end
  end
end
