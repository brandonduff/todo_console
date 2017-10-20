require 'test_helper'
require 'tempfile'
require 'todo/reader'
require 'todo/task_list'
require 'todo/task'
require 'todo/writer'

module Todo
  class ReaderTest < Minitest::Test

    def test_get_current_day_when_file_exists
      current_day = '1-1-2000'
      todo_path = 'foo'
      todo_file = Tempfile.new(todo_path)
      todo_file.write(current_day)
      todo_file.close
      env_helper = double
      allow(env_helper).to receive(:current_day_path).and_return(todo_file.path)
      reader = Reader.new(env_helper)

      assert_equal(current_day, reader.current_day)
    end


    def test_get_current_day_when_file_doesnt_exist_returns_empty_string
      env_helper = double
      allow(env_helper).to receive(:current_day_path).and_return('non_existent')
      reader = Reader.new(env_helper)

      assert_equal('', reader.current_day)
    end
  end
end
