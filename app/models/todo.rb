class Todo
  include Mongoid::Document
  field :title, type: String
  
  has_many :items, dependent: :destroy
  belongs_to :user
  validates_presence_of :title
end
