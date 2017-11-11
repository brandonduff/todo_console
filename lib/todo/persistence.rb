module Todo
  class Persistence
    def initialize
      @env_helper = EnvHelper.new
    end

    def write_todays_tasks(tasks)
      Writer.for(tasks).write_to(@env_helper.todo_file_for_day(Reader.new(@env_helper).current_day))
    end

    def write_current_day(day)
      Writer.for(day).write_to(@env_helper.current_day_path)
    end

    def read_tasks_for_day(day)
      task_data = Reader.new(@env_helper).task_data_for_day(day)
      TaskList.new.tap do |task_list|
        task_data.each do |task|
          task_list.add_task(TaskBuilder.new(task).build)
        end
      end
    end
  end
end
