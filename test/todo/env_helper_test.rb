require 'test_helper'

module Todo
  class EnvHelperTest < Minitest::Test
    def test_current_day_path
      ENV['HOME'] = '/tmp/'

      env_helper = EnvHelper.new

      assert_equal('/tmp/.current_day.txt', env_helper.current_day_path)
    end

    def test_todo_path
      ENV['HOME'] = '/tmp/'

      env_helper = EnvHelper.new

      assert_equal('/tmp/todos/', env_helper.todo_path)
    end
  end
end
