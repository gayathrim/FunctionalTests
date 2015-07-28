require 'fileutils'

After do |scenario|
  if (scenario.failed?)
    time = Time.new
    name = scenario.backtrace_line.split(":in").first.gsub(/[\/\\.]/, "_").gsub(":", "_line_") + "_" + time.strftime("%Y-%m-%d %H:%M:%S").gsub(" ", "_").gsub(":", "-")
    image_name = name + ".png"

    @session.save_screenshot image_name
    FileUtils.mv("./#{image_name}", File.join(File.dirname(__FILE__), "..", "..", "output"))
    embed image_name, 'image/png'

    File.open('failures.txt', 'a') { |file|
      p 'File writing..'
      file << scenario.source_tag_names
      file << "\n"
     }
  end
end