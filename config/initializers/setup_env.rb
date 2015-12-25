# Read environment variables and set them

variable_file_path = File.expand_path('../../../.env', __FILE__)

File.open(variable_file_path, 'r') do |f|
  while line = f.gets
    line.gsub!(/\n/,'')
    key, value = line.split "="
    ENV[key] = value
  end
end
