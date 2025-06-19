class Api::V1::EnrollmentsController < ApplicationController
    def index
        course = Course.find(params[:course_id])
        enrollments = course.enrollments.includes(:student)

        enrollments_array = course.enrollments.includes(:student).map do |enrollment|
          {
            id: enrollment.student.id,
            student_name: "#{enrollment.student.first_name} #{enrollment.student.last_name}",
            email: enrollment.student.email,  
            enrolled_on: enrollment.created_at.strftime("%Y-%m-%d")
        }
        end

        render json: { enrollments: enrollments_array }
      end
end

