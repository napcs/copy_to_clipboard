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
    def copy_to_clipboard_tag(text, options = {})
      
      to_clipboard = CGI::escape(text)
      
      
      id=options[:id] || "copy_button"
      width=options[:width] || 72
      height=options[:height] || 36
      bgcolor=options[:background_color] || "000000"
      txtcolor=options[:text_color] || "FFFFFF"

      update_id = options[:update] || "copy_notice"
      text_string = options[:text_string] ? CGI::escape(options[:text_string])  : "Copy"
      update_string = options[:update_message] ? CGI::escape(options[:update_message])  : "Copied to the clipboard"
  
      vars = "send_to_clipboard=#{to_clipboard}&text_color=#{txtcolor}&background_color=#{bgcolor}&text_string=#{text_string}&update_text=#{update_string}"
  
  
      res = %Q{
        <script language="javascript">
         function copy_button_DoFSCommand(m,a){
           document.getElementById("#{update_id}").innerHTML=a;
         }
        </script>
        <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="#{width}" height="#{height}" id="#{id}" align="middle">
      	<param name="allowScriptAccess" value="sameDomain" />
      	<param name="allowFullScreen" value="false" />
      	<param name="movie" value="/swf/copy_button.swf" />
      	<param name="quality" value="high" /><param name="bgcolor" value="#ffffff" />	
      	<param name=FlashVars VALUE="#{vars}">
      	<embed flashvars="#{vars}" src="/swf/copy_button.swf" quality="high" bgcolor="#ffffff" width="#{width}" height=#{height} name="copy_button" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
      	</object>}
      
    end
  end
end