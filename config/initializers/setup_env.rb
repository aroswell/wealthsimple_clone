# Read environment variables and set them

variable_file_path = if ENV["APP_ENVIRONMENT"] == "development"
    File.expand_path('../../../.dev_env', __FILE__)
  elsif ENV["APP_ENVIRONMENT"] == "test"
    File.expand_path('../../../.test_env', __FILE__)
  else
    File.expand_path('../../../.prod_env', __FILE__)
  end
puts variable_file_path

File.open(variable_file_path, 'r') do |f|
  while line = f.gets
    line.gsub!(/\n/,'')
    key, value = line.split "="
    ENV[key] = value
  end
end
