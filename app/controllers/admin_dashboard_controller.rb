class AdminDashboardController < ApplicationController
    before_action :require_admin

    def index
        @current_trimester = Trimester.where("start_date <= ?", Date.today).where("end_date >= ?", Date.today).first
        @upcoming_trimester = Trimester.where('start_date > ? AND start_date < ?', Time.current, 6.months.from_now).order(:start_date).first
        @past_trimester = Trimester.where('end_date < ?', Time.current).order(end_date: :desc).first
      
        @current_courses = @current_trimester ? @current_trimester.courses.includes(:coding_class) : []
        @upcoming_courses = @upcoming_trimester ? @upcoming_trimester.courses.includes(:coding_class) : []
        @past_courses = @past_trimester ? @past_trimester.courses.includes(:coding_class) : []
      end 
  end