require 'capybara/cuprite'

Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1200, 800],
    headless: true,
    timeout: 30,
    browser_options: {
      'disable-gpu': true
    }
  )
end

Capybara.javascript_driver = :cuprite
Capybara.default_driver = :cuprite
