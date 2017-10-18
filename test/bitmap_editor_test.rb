require './bitmap_editor.rb'

class BitmapEditorTest < ApplicationTest
  def test_it_exists
    be = BitmapEditor.new
    assert_kind_of BitmapEditor, be
  end
end
