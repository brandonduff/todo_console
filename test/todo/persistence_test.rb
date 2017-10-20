require 'test_helper'
require 'todo/writer'

class TaskTest < Minitest::Test
  def test_saving_obj_to_buffer
    writable = 'ima writable'
    buffer = StringIO.new
    Todo::Writer.for(writable).write_to(buffer)
    assert_equal(writable + "\n", buffer.string)
  end
end
