require 'test_helper'
require 'todo/use_cases/list_todos'

module Todo
  module UseCases
    class ListTodosTest < Minitest::Test
      def test_list_with_no_current_todos_returns_empty_list
        env_helper = double
        reader = double
        current_day = '1-1-2003'
        allow(EnvHelper).to receive(:new).and_return(env_helper)
        allow(Reader).to receive(:new).with(env_helper).and_return(reader)
        allow(reader).to receive(:current_day).and_return(current_day)

        todos = ListTodos.new({}).perform

        assert_equal([], todos)
      end
    end
  end
end
