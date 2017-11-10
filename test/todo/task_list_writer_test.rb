require 'test_helper'

module Todo
  class TaskListWriterTest < Minitest::Test

    def setup
      @task_list = Todo::TaskList.new(StringIO.new)
      @writer = double('Writer')
      @reader = double('Reader')
      @env_helper = double('EnvHelper')
      @current_day = '1=1=2000'
      @current_day_path = '/path/1-1-2000'
      @todo_path = 'todo-path'
      allow(EnvHelper).to receive(:new).and_return(@env_helper)
      allow(Writer).to receive(:for).with(@task_list).and_return(@writer)
      allow(Reader).to receive(:new).with(@env_helper).and_return(@reader)
      allow(@reader).to receive(:current_day).and_return(@current_day)
      allow(@env_helper).to receive(:current_day_path).and_return(@current_day_path)
      allow(@env_helper).to receive(:todo_file_for_day).with(@current_day).and_return(@todo_path)
    end

    def test_task_list_writer
      expect(@writer).to receive(:write_to).with(@todo_path)
      task_list_writer = TaskListWriter.new
      task_list_writer.write_todays_tasks('foo')
    end

    def test_write_current_day
      expect(@writer).to receive(:write_to).with(@current_day_path)
      TaskListWriter.new.write_current_day('1-1-2000')
    end
  end
end
