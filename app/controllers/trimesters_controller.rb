class TrimestersController < ApplicationController
  before_action :require_admin, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_trimester, only: [:show, :edit, :update]
  
    def index
      @trimesters = Trimester.all
    end
  
    def show
    end
  
    def edit
      # @trimester is set via before_action
    end
  
    def update
      if params[:trimester][:application_deadline].present?
        if @trimester.update(trimester_params)
          redirect_to trimester_path(@trimester), notice: "Trimester updated successfully."
        else
          render :edit, status: :bad_request
        end
      else
        render plain: "Application deadline is required", status: :bad_request
      end
    rescue ArgumentError
      render plain: "Invalid date format", status: :bad_request
    end
  
    private
  
    def set_trimester
      @trimester = Trimester.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render plain: "Trimester not found", status: :not_found
    end
  
    def trimester_params
      params.require(:trimester).permit(:application_deadline)
    end
  end
  