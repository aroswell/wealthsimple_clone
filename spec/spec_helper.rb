# Script to delete data in test database and include whatever models and controllers required

# Set environment to test mode
ENV["APP_ENVIRONMENT"] = "test"

require File.expand_path( "../../lib/database_module", __FILE__ )
require File.expand_path( "../../app/models/user", __FILE__ )
require File.expand_path( "../../app/controllers/users/registration_controller", __FILE__ )
require File.expand_path( "../../app/controllers/users/sessions_controller", __FILE__ )

# Purge test database
pool = Database::Pool.new
pool.connect
require File.expand_path( "../../db/schema", __FILE__ )
pool.release
