require 'carrierwave'

class User
  include Mongoid::Document
  include ActiveModel::SecurePassword 
  # include Elasticsearch::Model 
  # include Elasticsearch::Model::Callbacks 
  has_secure_password
  field :email, type: String
  field :password_digest, type: String

  mount_uploader :avatar, AvatarUploader
  
  has_many :todos, dependent: :destroy
  validates_presence_of :email, :password_digest
  validates_uniqueness_of :email
  
  
  # def as_indexed_json 
  #   # as_json(except: [:_id])
  #   as_json 
  # end
   
end
