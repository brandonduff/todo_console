require 'test_helper'
require 'todo/env_helper'

module Todo
  class EnvHelperTest < Minitest::Test
    def test_env_helper_todo_path
      ENV['HOME'] = '/tmp/'

      env_helper = EnvHelper.new

      assert_equal('/tmp/.current_day.txt', env_helper.current_day_path)
    end
  end
end
