class Api::PurchaseRequestsController < ApplicationController
  before_action :set_purchase_request, only: [:show, :update, :submit, :approve, :reject]
  before_action :set_current_user
  after_action :log_response
  around_action :measure_time, only: [:index]

  def index
    @purchase_requests = PurchaseRequest.includes(:user).all
    render json: { status: "success", data: { purchase_requests: @purchase_requests } }
  end

  def show
    render json: {
      status: "success",
      data: {
        purchase_request: {
          id: @purchase_request.id,
          title: @purchase_request.title,
          description: @purchase_request.description,
          amount: @purchase_request.amount,
          status: @purchase_request.status,
          created_at: @purchase_request.created_at,
          user: {
            id: @purchase_request.user.id,
            name: @purchase_request.user.name,
            email: @purchase_request.user.email
          }
        }
      }
    }
  end

  def create
    @purchase_request = PurchaseRequest.new(purchase_request_params)
    if @purchase_request.save
      render json: { status: "success", data: { purchase_request: @purchase_request } }
    else
      render json: { status: "failure", message: @purchase_request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @purchase_request.update(purchase_request_params)
      render json: { status: "success", data: { purchase_request: @purchase_request } }
    else
      render json: { status: "failure", message: @purchase_request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def submit
    render json: { status: "success", message: "Purchase request submitted successfully." }
  end

  def approve
    render json: { status: "success", message: "Purchase request approved successfully." }
  end

  def reject
    render json: { status: "success", message: "Purchase request rejected successfully." }
  end

  private

  def set_purchase_request
    @purchase_request = PurchaseRequest.find(params[:id])
  end

  def set_current_user
    @current_user = User.find_by(id: params[:user_id]) || User.first
  end

  def log_response
    Rails.logger.info "#{request.method} #{request.path} -> #{response.status}"
  end

  def measure_time
    start = Time.current
    yield 
    elapsed = Time.current - start
    Rails.logger.info "index took #{elapsed.round(3)}s"
  end

  def purchase_request_params
    params.require(:purchase_request).permit( :title, :description, :amount, :user_id)
  end
end
