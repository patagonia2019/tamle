class EmissionsController < ApplicationController
  helper_method :sort_column, :sort_direction
  #before_action :logged_in_user,     only: [:show ]
  #before_action :admin_user, only: [:show, :showpdf, :edit, :update, :destroy]
  before_action :set_emission, only: [:show, :showpdf, :edit, :update, :destroy]

  # GET /emissions
  # GET /emissions.json
  def index
    if logged_in?
	    consume = view_context.consumeInfo()
	    number_of_members = consume.number_of_members()
	    if current_user.admin?
		@emissions = Emission.all.paginate(page: params[:page], :per_page => number_of_members,).order(sort_column + ' ' + sort_direction)
	    else
		#@emissions = Emission.byCurrentUser().paginate(page: params[:page],).order(sort_column + ' ' + sort_direction)
		#@emissions = emissionsByCurrentUser.paginate(page: params[:page], :per_page => number_of_members,).order(sort_column + ' ' + sort_direction)
		@emissions = Emission.where(user_id:current_user.id).paginate(page: params[:page], :per_page => number_of_members,).order(sort_column + ' ' + sort_direction)
	    end
    else
        flash[:danger] = "Please log in."
        redirect_to login_url
    end
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
	   page_size: 'A4',
	   dpi: 400,
           margin: { bottom: 0, top: 0, left:10, right:1 },
           encoding: 'utf8')

        @filename='Factura '+@date+' '+@name+'.pdf'
        save_path = Rails.root.join('pdfs',@filename)
        File.open(save_path, 'wb') do |file|
            file << @pdf
        end
        send_data @pdf,
            :filename => @filename,
            :type => "application/pdf"

  end

  # GET /emissions/new
  def new
	admin_user
    @emission = Emission.new
  end

  # GET /emissions/1/edit
  def edit
	admin_user
  end

  # POST /emissions
  # POST /emissions.json
  def create
	admin_user
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
	admin_user
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
	admin_user
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
      params.require(:emission).permit(:medition_id, :previous_medition_id, :at_emission_date, :consume_id, :water_previous_measure, :water_measure, :water_consumed, :exceedance_m3, :exceedance_amount, :ceb_date, :ceb_amount, :social_quote_amount, :balance_previous_amount, :balance_previous_date, :payment_amount, :payment_date, :balance_amount, :ceb_amount_by_user, :exceedance_m3_by_user, :exceedance_m3_amount_on_user, :water_fix_consume_amount, :water_fix_consume_on_user_amount, :water_provision_amount, :water_provision_on_user_amount, :invoice_id, :user_id, :sia_amount, :sia_date)
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
        Emission.column_names.include?(params[:sort]) ? params[:sort] : "at_emission_date"
    end

    # A list of the param names that can be used for filtering the Product list
    def filtering_params(params)
      params.slice(:user)
    end

end
