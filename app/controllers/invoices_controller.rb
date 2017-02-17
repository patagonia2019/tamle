class InvoicesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :logged_in_user
  before_action :admin_user, only: [:show, :edit, :update, :destroy]
  before_action :set_invoice, only: [:show, :edit, :update, :destroy, :bill]

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.all.paginate(page: params[:page], :per_page => 30,).order(sort_column + ' ' + sort_direction)
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /bill
  # GET /bill/1
  def bill
    #respond_to do |format|
      view_context.invoiceGenerateBills(@invoice)
      #  format.html { redirect_to @invoice, notice: 'Bills were successfully created.' }
      #  format.json { render :show, status: :ok, location: @invoice }
      #else
      #  format.html { render :show }
      #  format.json { render json: @invoice.errors, status: :unprocessable_entity }
      #end
    #end
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Bills were successfully created.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:at_date)
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
        Invoice.column_names.include?(params[:sort]) ? params[:sort] : "at_date"
    end

    # A list of the param names that can be used for filtering the Product list
    def filtering_params(params)
      params.slice(:user)
    end

end
