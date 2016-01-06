# unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__))) do
#   $LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))
# end

# Test
# puts File.dirname( __FILE__ ) + "/static"

require 'singleton'

class Connection
  attr_reader :connection_object

  def initialize
    @connection_object = self
  end
end

class Pool
  include Singleton
  attr_reader :the_connection_pool

  def initialize
    puts self
    @the_connection_pool = Connection.new
  end

end

count = 0
3.times do
  count += 1
  puts count

  puts Pool.instance.the_connection_pool

end




