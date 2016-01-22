# Read environment variables and set them

variable_file_path = if ENV["RACK_ENV"] == "development"
    File.expand_path('../../../.dev_env', __FILE__)
  elsif ENV["RACK_ENV"] == "test"
    File.expand_path('../../../.test_env', __FILE__)
  else
    nil
  end

puts variable_file_path

if variable_file_path
  File.open(variable_file_path, 'r') do |f|
    while line = f.gets
      line.gsub!(/\n/,'')
      key, value = line.split "="
      ENV[key] = value
    end
  end
end
