class ConsumesController < ApplicationController
  before_action :logged_in_user
  before_action :set_consume, only: [:show, :edit, :update, :destroy]

  # GET /consumes
  # GET /consumes.json
  def index
    @consumes = Consume.where(nil)
    @consumes = @consumes.paginate(page: params[:page], :per_page => 30,)
  end

  # GET /consumes/1
  # GET /consumes/1.json
  def show
    admin_user
  end

  # GET /consumes/new
  def new
    admin_user
    @consume = Consume.new
  end

  # GET /consumes/1/edit
  def edit
    admin_user
  end

  # POST /consumes
  # POST /consumes.json
  def create
    admin_user
    @consume = Consume.new(consume_params)

    respond_to do |format|
      if @consume.save
        format.html { redirect_to @consume, notice: 'Consume was successfully created.' }
        format.json { render :show, status: :created, location: @consume }
      else
        format.html { render :new }
        format.json { render json: @consume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consumes/1
  # PATCH/PUT /consumes/1.json
  def update
    admin_user
    respond_to do |format|
      if @consume.update(consume_params)
        format.html { redirect_to @consume, notice: 'Consume was successfully updated.' }
        format.json { render :show, status: :ok, location: @consume }
      else
        format.html { render :edit }
        format.json { render json: @consume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consumes/1
  # DELETE /consumes/1.json
  def destroy
    admin_user
    @consume.destroy
    respond_to do |format|
      format.html { redirect_to consumes_url, notice: 'Consume was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consume
      @consume = Consume.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consume_params
      params.require(:consume).permit(:at_date, :water_fix_consume_amount, :water_provision_amount, :exceedance_m3, :exceedance_m3_amount, :social_quote_amount, :number_of_members)
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

end
