Given(/^a pattern file named "(.*?)" does not exist$/) do |name|
  FileUtils.rm_rf absolute_path(name)
end
