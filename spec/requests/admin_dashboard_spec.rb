require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /dashboard' do
    before do
      @current_trimester = Trimester.create!(
        term: 'Spring',
        year: Date.today.year.to_s,
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )
      # Define past_trimester here and uncomment it when you're ready.
      # past_trimester =
    end

    it 'returns a 200 OK status' do
      get "/dashboard"

      expect(response).to have_http_status(:ok)
    end
  
    it 'displays the current trimester' do
      get "/dashboard"
      expect(response.body).to include("#{@current_trimester.term} - #{@current_trimester.year}")
    end

    it 'displays links to the courses in the current trimester' do
    end

    it 'displays the upcoming trimester' do
      get "/dashboard"
      expect(response.body).to include("#{@upcoming_trimester.term} - #{@upcoming_trimester.year}")
    end

    it 'displays links to the courses in the upcoming trimester' do
    end
  end
end