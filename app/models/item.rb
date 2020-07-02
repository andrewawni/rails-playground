class Item
  include Mongoid::Document
  field :name, type: String
  belongs_to :todo

  validates_presence_of :name
end
