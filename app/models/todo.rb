class Todo
  include Mongoid::Document
  field :title, type: String
  field :created_by, type: String

  has_many :items, dependent: :destroy
  validates_presence_of :title, :created_by
end
