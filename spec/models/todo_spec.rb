require 'rails_helper'

RSpec.describe Todo, type: :mongoid_model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should have_many(:items) }
  it { should belong_to(:user) } 
  it { should validate_presence_of(:title) }
  
end
