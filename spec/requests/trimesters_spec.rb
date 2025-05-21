require 'rails_helper'

RSpec.describe "Trimesters", type: :request do
  describe "GET /trimesters" do
    context 'trimesters exist' do
      before do
        (1..2).each do |i|
          Trimester.create!(
            term: "Term #{i}",
            year: '2025',
            start_date: '2025-01-01',
            end_date: '2025-01-01',
            application_deadline: '2025-01-01',
          )
        end
      end

      it 'returns a page containing names of all trimesters' do
        get '/trimesters'
        expect(response.body).to include('Term 1 2025')
        expect(response.body).to include('Term 2 2025')
      end
    end
  end

  describe "PUT /trimesters/:id" do
    let!(:trimester) do
      Trimester.create!(
        year: 2025,
        term: "Fall",
        start_date: "2025-09-01",
        end_date: "2025-12-15",
        application_deadline: "2025-08-01"
      )
    end

    context "with valid application deadline" do
      it "updates the application deadline" do
        put "/trimesters/#{trimester.id}", params: {
          trimester: { application_deadline: "2025-08-15" }
        }

        expect(response).to have_http_status(:found) # assuming redirect after update
        follow_redirect!
        expect(response.body).to include("2025-08-15")
      end
    end

    context "with missing application deadline" do
      it "returns 400 bad request" do
        put "/trimesters/#{trimester.id}", params: {
          trimester: { application_deadline: "" }
        }

        expect(response).to have_http_status(:bad_request)
      end
    end

    context "with invalid application deadline format" do
      it "returns 400 bad request" do
        put "/trimesters/#{trimester.id}", params: {
          trimester: { application_deadline: "not-a-date" }
        }

        expect(response).to have_http_status(:bad_request)
      end
    end

    context "with non-existent trimester id" do
      it "returns 404 not found" do
        put "/trimesters/999999", params: {
          trimester: { application_deadline: "2025-08-15" }
        }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end