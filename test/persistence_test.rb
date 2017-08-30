require_relative 'test_helper'
require 'todo/persistence'

class TaskTest < Minitest::Test
  def test_saving_obj_to_buffer
    writable = 'ima writable'
    buffer = StringIO.new
    Todo::Persistence.for(writable).write_to(buffer)
    assert_equal(writable + "\n", buffer.string)
  end
end
