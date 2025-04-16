require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe '#is_past_application_deadline' do
    let(:application_deadline) { Time.zone.parse("2025-05-15") }

    let(:coding_class) { 
      CodingClass.create(title: 'Test Class')
    }

    let(:trimester) do
      Trimester.create!(
        year: "2025",
        term: "Summer",
        application_deadline: application_deadline,
        start_date: Date.today,
        end_date: Date.today + 3.months
      )
    end

    let(:course) do
      Course.create!(
        coding_class: coding_class,
        trimester: trimester,
        max_enrollment: 25
      )
    end

    let(:student) do
      Student.create!(
        first_name: "Adam",
        last_name: "West",
        email: "adam@example.com"
      )
    end

    context 'when enrollment is created after the application deadline' do
      it 'returns true' do
        enrollment = Enrollment.create!(
          course: course,
          student: student,
          created_at: application_deadline + 1.day
        )

        expect(enrollment.is_past_application_deadline).to be true
      end
    end

    context 'when enrollment is created before the application deadline' do
      it 'returns false' do
        enrollment = Enrollment.create!(
          course: course,
          student: student,
          created_at: application_deadline - 1.day
        )

        expect(enrollment.is_past_application_deadline).to be false
      end
    end

    context 'when enrollment is created exactly at the application deadline' do
      it 'returns false' do
        enrollment = Enrollment.create!(
          course: course,
          student: student,
          created_at: application_deadline
        )

        expect(enrollment.is_past_application_deadline).to be false
      end
    end
  end
end
