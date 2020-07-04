class User
  include Mongoid::Document
  include ActiveModel::SecurePassword 
  has_secure_password
  field :email, type: String
  field :password_digest, type: String

  has_many :todos, dependent: :destroy
  validates_presence_of :email, :password_digest
  validates_uniqueness_of :email

end
