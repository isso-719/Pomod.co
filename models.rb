require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

class User < ActiveRecord::Base
  has_secure_password

  has_many :tomatoes

  validates :name, presence: true, length: { maximum: 8 }, format: { with: /\A[a-z0-9]+\z/i }
  validates :mail, uniqueness: true, presence: true, format: { with: /.+@.+/ }

  before_create do
    self.user_gravatar = SecureRandom.hex(32)
  end

end

class Tomato < ActiveRecord::Base
  belongs_to :user
end