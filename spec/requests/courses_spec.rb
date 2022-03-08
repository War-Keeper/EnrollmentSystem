require 'rails_helper'

RSpec.describe "Courses", type: :request do
  describe "GET /courses" do
    let(:user) {profile.user}
    let(:profile) {create :profile}
    it "can get index" do
      get courses_url
      expect(response).to have_http_status(302)
    end
    it "works! (now write some real specs)" do
      get courses_path
      expect(response).to have_http_status(302)
    end
  end
end
