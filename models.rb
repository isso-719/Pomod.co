ActiveRecord::Base.establish_connection("sqlite3:db/development.db")

class User < ActiveRecord::Base
  has_secure_password
end