namespace :clipboard do
  desc "copy the clipboard SWF file into your public folder"
  task :install => :environment do
    Dir.chdir("#{RAILS_ROOT}/vendor/plugins/clipboard") do
      FileUtils.cp_r("swf", "#{RAILS_ROOT}/public")
    end
  end
  desc "Remove the Clipboard SWF from your public folder"
  task :uninstall => :environment do
    Dir.chdir("#{RAILS_ROOT}/public") do
      FileUtils.rm("swf/copy_button.swf")
    end
  end
  
  
end