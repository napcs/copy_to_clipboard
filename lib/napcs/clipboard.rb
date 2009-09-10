module NAPCS
  module Clipboard
  
  
    # Creates a copy to clipboard button
    # which uses an embedded flash movie.
    #
    # 
    # <%=copy_to_clipboard_tag :text=>shared_snippet_url(@snippet.privacy_hash),
    #          :update => "notice",
    #          :update_message => "Copied URL to the clipboard.",
    #          :text_string => "Copy",
    #          :text_color => "000000",
    #          :background_color => "FFFFFF",
    #          :height => 18,
    #          :width => 36
    # %>
    #
    # * <tt>:update</tt> is the div to render the results
    # * <tt>:update_message</tt> is the message the movie should place
    # * <tt>:text_string</tt> is the text you want to display on the button
    # * <tt>:text_color</tt> is the color of the button text. Default is FFFFFF
    # * <tt>:background_color</tt> is the background color of the button. Default is 000000
    # * <tt>:height</tt> is the height. Default is 36
    # * <tt>:width</tt> is the width. It'll resize the button. Default is 72 and you shouldn't really go smaller than 54
    # * <tt>:icon_image</tt> is the path to an icon image. the size specified in the movie is 18x18. It'll scale whatever you throw at it.
    # 
    def copy_to_clipboard_tag(text, options = {})
      
      to_clipboard = CGI::escape(text)
      
      default_options = {:id => "copy_button",
                         :width => 72,
                         :height => 18,
                         :icon_image => "/swf/clipboard.png",
                         :background_color => "000000",
                         :text_color => "FFFFFF",
                         :text_string => "Copy",
                         :update => "copy_notice",
                         :update_message => "Copied to the clipboard"}
      
      options = default_options.merge(options)     
      options[:update_message] = CGI::escape(options[:update_message]) 
      options[:text_string] = CGI::escape(options[:text_string]) 
      options[:icon_image] = CGI::escape(options[:icon_image]) 

      js = "document.getElementById(\"#{options[:update]}\").innerHTML=a;"

      vars = "button_width=#{options[:width]}&icon_image=#{options[:icon_image]}&send_to_clipboard=#{to_clipboard}&text_color=#{options[:text_color]}&background_color=#{options[:background_color]}&text_string=#{options[:text_string]}&update_text=#{options[:update_message]}"
  

      res = <<-EOF
<script language="javascript">
 function copy_button_DoFSCommand(m,a){
   #{js}
 }
</script>
<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" 
  codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" 
  width="#{options[:width]}"
  height="#{options[:height]}" 
  id="#{options[:id]}" 
  align="middle">
    <param name="allowScriptAccess" value="always" />
    <param name="allowFullScreen" value="false" />
    <param name="movie" value="/swf/copy_button.swf" />
    <param name="quality" value="high" />
    <param name="bgcolor" value="#ffffff" />	
    <param name=FlashVars VALUE="#{vars}">
    <embed flashvars="#{vars}" 
      src="/swf/copy_button.swf" 
      quality="high"
      width="#{options[:width]}"
      height=#{options[:height]} 
      name="copy_button" 
      align="middle" 
      allowScriptAccess="always" 
      allowFullScreen="false" 
      type="application/x-shockwave-flash"
      pluginspage="http://www.macromedia.com/go/getflashplayer"/>
</object>
      EOF
    end
  end
end