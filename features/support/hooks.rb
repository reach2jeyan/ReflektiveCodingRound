require_relative '../../features/support/env'

$instance = Configurations.new
Before do
  $instance.validate
  File.delete('expendituredetails.txt') if File.exist?('expendituredetails.txt')
end

at_exit do
  $instance.reports
end

After do |scenario|
  if scenario.failed?
    $instance.screenshot(ENV['BROWSER'])
  end
end