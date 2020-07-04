require 'rails_helper'

RSpec.describe User, type: :mongoid_model do
  
  it { should have_many(:todos) } 
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }

  it { should validate_uniqueness_of(:email) }
end
