class EmissionsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :logged_in_user
  before_action :admin_user, only: [:show, :showpdf, :edit, :update, :destroy]
  before_action :set_emission, only: [:show, :showpdf, :edit, :update, :destroy]

  # GET /emissions
  # GET /emissions.json
  def index
    consume = view_context.consumeInfo()
    number_of_members = consume.number_of_members()
    @emissions = Emission.all.paginate(page: params[:page], :per_page => number_of_members,).order(sort_column + ' ' + sort_direction)
  end

  # GET /emissions/1
  # GET /emissions/1.json
  def show
  end

  def showpdf
      @name = User.find(Medition.find(@emission.medition_id).user_id).name
      @date = @emission.at_emission_date.strftime("%b-%Y")
      body_html   = render_to_string( partial: "emissions/show.pdf.erb" )
      @pdf = WickedPdf.new.pdf_from_string(
           body_html,
           orientation: 'Portrait',
           margin: { bottom: 10, top: 10 },
           encoding: 'utf8')

    save_path = Rails.root.join('pdfs','Factura '+@date+' '+@name+'.pdf')
    File.open(save_path, 'wb') do |file|
        file << @pdf
    end
  end

  # GET /emissions/new
  def new
    @emission = Emission.new
  end

  # GET /emissions/1/edit
  def edit
  end

  # POST /emissions
  # POST /emissions.json
  def create
    @emission = Emission.new(emission_params)

    respond_to do |format|
      if @emission.save
        format.html { redirect_to @emission, notice: 'Emission was successfully created.' }
        format.json { render :show, status: :created, location: @emission }
      else
        format.html { render :new }
        format.json { render json: @emission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emissions/1
  # PATCH/PUT /emissions/1.json
  def update
    respond_to do |format|
      if @emission.update(emission_params)
        format.html { redirect_to @emission, notice: 'Emission was successfully updated.' }
        format.json { render :show, status: :ok, location: @emission }
      else
        format.html { render :edit }
        format.json { render json: @emission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emissions/1
  # DELETE /emissions/1.json
  def destroy
    @emission.destroy
    respond_to do |format|
      format.html { redirect_to emissions_url, notice: 'Emission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emission
      @emission = Emission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def emission_params
      params.require(:emission).permit(:medition_id, :previous_medition_id, :at_emission_date, :consume_id, :water_previous_measure, :water_measure, :water_consumed, :exceedance_m3, :exceedance_amount, :ceb_date, :ceb_amount, :social_quote_amount, :balance_previous_amount, :balance_previous_date, :payment_amount, :payment_date, :balance_amount)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
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
        Emission.column_names.include?(params[:sort]) ? params[:sort] : "at_emission_date"
    end

    # A list of the param names that can be used for filtering the Product list
    def filtering_params(params)
      params.slice(:user)
    end

end
