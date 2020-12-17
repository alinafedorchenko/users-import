require 'rails_helper'

RSpec.describe ImportProcessingsController do
  describe 'POST /create' do
    subject(:request) { post :create, params: { import_id: user_import.id } }

    let(:user_import) { create :user_import }

    it 'creates new job' do
      expect(ImporterJob).to receive(:perform_in).with(1.second, user_import.id)
      request
    end
  end
end
