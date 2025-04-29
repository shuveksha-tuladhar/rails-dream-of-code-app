require 'rails_helper'

RSpec.describe "Mentors", type: :request do
  describe "GET /mentors" do
    let!(:mentor1) { Mentor.create(first_name: "Tom", last_name: "Phelps", email: "tomphelps@test.com", max_concurrent_students: 3) }
    let!(:mentor2) { Mentor.create(first_name: "Eva", last_name: "Smith", email: "evasmith@test.com", max_concurrent_students: 2) }

    it "returns a successful response" do
      get mentors_path
      expect(response).to have_http_status(:ok)
    end

    it "renders a list of mentors" do
      get mentors_path
      expect(response.body).to include("Tom")
      expect(response.body).to include("Eva")
    end

   end

  describe "GET /mentors/:id" do
    let!(:mentor) { Mentor.create(first_name: "Ada", last_name: "Haynes", email: "ada@test.org", max_concurrent_students: 5) }

    it "returns a successful response" do
      get mentor_path(mentor)
      expect(response).to have_http_status(:ok)
    end

    it "shows the mentor details" do
      get mentor_path(mentor)
      expect(response.body).to include("Ada")
      expect(response.body).to include("Haynes")
      expect(response.body).to include("ada@test.org")
    end

    it "returns 404 for non-existent mentor" do
        get mentor_path(id: 9999)
        expect(response).to have_http_status(:not_found)
      end
      
  end
end
