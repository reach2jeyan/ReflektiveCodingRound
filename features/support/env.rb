require 'watir'
require 'report_builder'

class Configurations
  def validate
    @browserdetail = ENV['BROWSER']
    web_url = ENV['URL']
    case ENV['BROWSER']
      when 'chrome'
        args = ["--disable-notifications"]
        $browser = Watir::Browser.new :chrome, :args => args, headless: false
      when 'firefox'
        $browser = Watir::Browser.new :firefox , headless: false
    end
  end
  def reports
    options = {
        report_path:  'ReflektiveCodingRound' + "_" + "#{ENV['BROWSER']}", #Provide name of the report to be. Recommended is Projectname + reports. For eg: creditone, it is creditonereports
        report_types: ['html'],
        report_title: 'Reflektive Report', #provide the title you want to display
        include_images: true,
    }
    ReportBuilder.build_report options
  end
    def screenshot(browserfolder)
    sname = (0...8).map { (65 + rand(26)).chr }.join
    log_file = (0...8).map { (65 + rand(26)).chr }.join
    Dir::mkdir(browserfolder) if not File.directory?(browserfolder)
    $browser.screenshot.save("#{browserfolder}/#{sname}")
    embed_screenshot sname
    end
  def embed_screenshot(file_name)
    embed("#{file_name}", 'image/png', 'Scenario Failed Screenshot')
  end
end






