require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:full_name) }
  it { is_expected.to validate_presence_of(:role) }
  it { is_expected.to define_enum_for(:role).with_values({ admin: 0, client: 1 }) }
end