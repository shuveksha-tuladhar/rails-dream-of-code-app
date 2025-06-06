require 'rails_helper'

RSpec.describe "Api::V1::Students", type: :request do
  describe "POST /api/v1/students" do
    let(:valid_attributes) do
      {
        student: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: 'validstudent@example.com'
        }
      }
    end

    let(:invalid_attributes) do
      {
        student: {
          first_name: '',    
          last_name: '',     
          email: 'invalid-email'  
        }
      }
    end

   context "with valid parameters" do
      it "creates a new student" do
        expect {
          post '/api/v1/students', params: valid_attributes
        }.to change(Student, :count).by(1)

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json['student']['email']).to eq('validstudent@example.com')
      end
    end

    context "with invalid parameters" do
      it "does not create a new student and returns errors" do
        expect {
          post '/api/v1/students', params: invalid_attributes
        }.not_to change(Student, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json).to have_key('errors')
        expect(json['errors']).to include("First name can't be blank")
        expect(json['errors']).to include("Last name can't be blank")
        expect(json['errors']).to include("Email is invalid")
      end
    end
  end
end
