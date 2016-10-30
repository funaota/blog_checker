require 'watir'

class UpdateChecker
  def initialize(url, interval = 600)
    @browser = Watir::Browser.start(url, :phantomjs)
    @interval = interval
    @old_content = nil
  end

  def start
    Thread.new do
      loop do
        check
        sleep @interval
      end
    end
  end

  def check
    new_content = nil

    @browser.refresh
    new_content = @browser.div(class: "box")
                          .ul(class: "datelist")
                          .li(class: "page").text

    unless @old_content.nil?
      if @old_content == new_content
        not_updated
      else
        updated(@old_content, new_content)
      end
    end

    @old_content = new_content
  end

  def updated(new_content)
    puts "#{@browser.title} updated on #{Time.now}"
    puts new_content
  end

  def not_updated
    puts "#{@browser.title} not updated"
  end
end