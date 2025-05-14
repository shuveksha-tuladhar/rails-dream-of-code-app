require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /dashboard' do
    before do
      @current_trimester = Trimester.create!(
        term: 'Spring',
        year: Date.today.year.to_s,
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 10.days,
      )

      @upcoming_trimester = Trimester.create!(
        term: 'Summer',
        year: Date.today.year.to_s,
        start_date: Date.today + 1.month,
        end_date: Date.today + 3.months,
        application_deadline: Date.today + 15.days,
      )

      @past_trimester = Trimester.create!(
        term: 'Fall', 
        year: 2024, 
        start_date: Date.today - 6.months, 
        end_date: Date.today - 4.months,
        application_deadline: Date.today - 7.months,
      )

      @coding_class1 = CodingClass.create!(title: 'Ruby on Rails')
      @coding_class2 = CodingClass.create!(title: 'Python')

      Course.create!(coding_class: @coding_class1, trimester: @current_trimester)
      Course.create!(coding_class: @coding_class2, trimester: @upcoming_trimester)
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
      get "/dashboard"
      expect(response.body).to include(@coding_class1.title)
    end

    it 'displays the upcoming trimester' do
      get "/dashboard"
      expect(response.body).to include("#{@upcoming_trimester.term} - #{@upcoming_trimester.year}")
    end

    it 'displays links to the courses in the upcoming trimester' do
      get "/dashboard"
      expect(response.body).to include(@coding_class2.title)
    end

    it 'displays the past trimester' do
      get "/dashboard"
      expect(response.body).to include("#{@past_trimester.term} - #{@past_trimester.year}")
    end
    
    it 'displays links to the courses in the past trimester' do
      get "/dashboard"
      past_coding_class = CodingClass.create!(title: 'Python')
      Course.create!(coding_class: past_coding_class, trimester: @past_trimester)
      
      get "/dashboard" 
      expect(response.body).to include(past_coding_class.title)
    end
    
  end
end