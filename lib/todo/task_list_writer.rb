module Todo
  class TaskListWriter
    def initialize
      @env_helper = EnvHelper.new
    end

    def write_todays_tasks(tasks)
      Writer.for(tasks).write_to(@env_helper.todo_file_for_day(Reader.new(@env_helper).current_day))
    end

    def write_current_day(day)
      Writer.for(day).write_to(@env_helper.current_day_path)
    end
  end
end
