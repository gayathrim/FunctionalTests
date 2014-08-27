require 'fileutils'

After do |scenario|
  if (scenario.failed?)
    time = Time.new
    name = scenario.backtrace_line.split(":in").first.gsub(/[\/\\.]/, "_").gsub(":", "_line_") + "_" + time.strftime("%Y-%m-%d %H:%M:%S").gsub(" ", "_").gsub(":", "-")
    image_name = name + ".png"

    @session.save_screenshot image_name
    FileUtils.mv("./#{image_name}", File.join(File.dirname(__FILE__), "..", "..", "output"))
    embed image_name, 'image/png'
  end
end