require 'fileutils'

require 'minitest/autorun'
require './lib/application'

class ApplicationTest < MiniTest::Test
  def test_if_exists
    app = Application.new("filepath")
    assert_kind_of Application, app
  end

  def test_if_it_handles_nil_parameter
    assert_raises(Exception) {Application.new}
  end

  def test_if_it_runs
    test_input_file_path = "test/data/1.input.txt"
    app = Application.new(test_input_file_path)
    result = app.run()

    assert true == result
  end
end
