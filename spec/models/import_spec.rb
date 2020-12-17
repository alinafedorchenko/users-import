require 'rails_helper'

RSpec.describe Import do

  describe 'validations' do

    context 'nil file' do
      it { expect(build(:import, file: nil)).to_not be_valid }
    end

    context 'empty title' do
      it { expect(build(:import, title: '')).to_not be_valid }
    end
  end
end
