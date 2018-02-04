class MeditionsController < ApplicationController

  helper_method :totalConsumption
  helper_method :sort_column, :sort_direction
  before_action :logged_in_user,     only: [:show ]
  before_action :set_medition, only: [:show, :edit, :update, :destroy]

  # GET /meditions
  # GET /meditions.json
  def index
    @meditions = Medition.where(nil)
    filtering_params(params).each do |key, value|
      @meditions = @meditions.public_send(key, value) if value.present?
    end
    consume = view_context.consumeInfo()
    number_of_members = consume.number_of_members() + 1
    @meditions = @meditions.paginate(page: params[:page], :per_page => number_of_members,).order(sort_column + ' ' + sort_direction)
  end

  # GET /meditions/1
  # GET /meditions/1.json
  def show
    admin_user
  end

  # GET /meditions/new
  def new
    admin_user
    @medition = Medition.new
  end

  # GET /meditions/1/edit
  def edit
    admin_user
  end

  # POST /meditions
  # POST /meditions.json
  def create
    admin_user
    @medition = Medition.new(medition_params)

    respond_to do |format|
      if @medition.save
        format.html { redirect_to @medition, notice: t('Medition was successfully created.') }
        format.json { render :show, status: :created, location: @medition }
      else
        format.html { render :new }
        format.json { render json: @medition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meditions/1
  # PATCH/PUT /meditions/1.json
  def update
    admin_user
    respond_to do |format|
      if @medition.update(medition_params)
        format.html { redirect_to @medition, notice: 'Medition was successfully updated.' }
        format.json { render :show, status: :ok, location: @medition }
      else
        format.html { render :edit }
        format.json { render json: @medition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meditions/1
  # DELETE /meditions/1.json
  def destroy
    admin_user
    @medition.destroy
    respond_to do |format|
      format.html { redirect_to meditions_url, notice: 'Medition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medition
      @medition = Medition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medition_params
      params.require(:medition).permit(:user_id, :at_date, :measure, :billed)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end

    def sort_column
      Medition.column_names.include?(params[:sort]) ? params[:sort] : "at_date"
    end

    # A list of the param names that can be used for filtering the Product list
    def filtering_params(params)
      params.slice(:user)
    end

end
