class Todo
  include Mongoid::Document
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  field :title, type: String
  field :description, type: String

  has_many :items, dependent: :destroy
  belongs_to :user

  validates_presence_of :title
  def as_indexed_json(options={})
    as_json(except: [:id, :_id])
  end
end
