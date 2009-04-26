require 'test/unit'
require File.dirname(__FILE__) + '/../lib/napcs/clipboard'
require 'cgi'
class ClipboardTest < Test::Unit::TestCase

  include NAPCS::Clipboard
  
  def test_render
    puts copy_to_clipboard_tag "this goes on the clipboard!",
             :update => "notice",
             :update_message => "Copied something on the clipboard",
             :text_string => "Copy",
             :text_color => "000000",
             :background_color => "FFFFFF",
             :height => 18,
             :width => 72
  end
  
  def test_should_have_image_icon_by_default
    s = copy_to_clipboard_tag("foo")
    assert s.include? "icon_image=#{CGI::escape("/swf/clipboard.png")}"
  end
  
  def test_should_have_image_icon_when_passed_in
    s = copy_to_clipboard_tag("foo",:icon_image => "foo.png")
    assert s.include? "icon_image=#{CGI::escape("foo.png")}"
  end
  
  def test_should_use_height_if_passed
    s = copy_to_clipboard_tag("foo",:height => "46")
    assert s.include?('height="46"')
  end
  
  def test_should_use_width_if_passed
    s = copy_to_clipboard_tag("foo",:width => "46")
    assert s.include?('width="46"')
    assert s.include?('button_width=46')
  end
  
  def test_should_use_default_width
    s = copy_to_clipboard_tag("foo")
    assert s.include?('width="72"')
  end
  
  def test_should_use_default_height
    s = copy_to_clipboard_tag("foo")
    assert s.include?('height="18"')
  end
  
  def test_should_pass_text_to_vars
    s = copy_to_clipboard_tag("foo")
    assert s.include?('send_to_clipboard=foo')
  end
  
  def test_should_default_to_id_of_copy_button
    s = copy_to_clipboard_tag("foo")
    assert s.include?('id="copy_button"')
  end
  
  def test_should_use_id_if_passed
    s = copy_to_clipboard_tag("foo", :id=>"monkey")
    assert s.include?('id="monkey"') 
  end
  
  def test_should_send_text_string_if_passed
    s = copy_to_clipboard_tag("foo", :text_string =>"amazing")
    assert s.include?('text_string=amazing')
  end
  
  def test_should_escape_text_string_if_passed
    s = copy_to_clipboard_tag("foo", :text_string =>"amazing stuff")
    assert s.include?("text_string=#{CGI::escape("amazing stuff")}")
  end
  
  def test_should_send_text_color_if_passed
    s = copy_to_clipboard_tag("foo", :text_color =>"000000")
    assert s.include?('text_color=000000')
  end
  
  
  def test_should_send_background_color_if_passed
    s = copy_to_clipboard_tag("foo", :background_color =>"abcabc")
    assert s.include?('background_color=abcabc')
  end
  
  def test_should_set_update_id_if_passed
    s = copy_to_clipboard_tag("foo", :update =>"foo")
    
    assert s.include?('document.getElementById("foo")')
  end

end
