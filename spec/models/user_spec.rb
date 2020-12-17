require 'rails_helper'

RSpec.describe User do

  describe 'validations' do
    context 'short first_name' do
      it { expect(build(:user, first_name: 'a')).to_not be_valid }
    end

    context 'invalid date' do
      let(:error_message) { 'Date of birth User should be over 18 years old and less 100 years old.' }

      it 'raises an error for user less than 18 years old' do
        user = build(:user, date_of_birth: Time.current)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to match_array([error_message])
      end

      it 'raises an error for user more than 100 years old' do
        user = build(:user, date_of_birth: 101.years.ago)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to match_array([error_message])
      end
    end
  end
end
