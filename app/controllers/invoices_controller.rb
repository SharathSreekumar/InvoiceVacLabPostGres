class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.all
    if params[:search]
      @invoices = Invoice.search(params[:search])
    else
      @invoices = Invoice.select(:invoice).uniq
    end
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
    @details = params[:invoice]
    @product = params[:ProdName] #product - list
    @rate = params[:Rate]# rate - list
    @quantity = params[:Quantity]# quantity - list
    @amount = params[:Amount]# amount - list
    
    @date = params[:date]

    puts "date is " + @details["date"].to_s# year - month - date
    
    new_records = Array.new
    successFlag = 0

    for i in 0..@rate.length - 1
      new_records = {:customer_name => @details["customer_name"].to_s, :customer_phone => @details["customer_phone"], :customer_email => @details["customer_email"].to_s, :invoice =>  @details["invoice"].to_s, :invoice_date => @details["date"], :product => @product[i].to_s, :rate => @rate[i].to_f, :quantity => @quantity[i].to_i, :amount => @amount[i].to_f }
      @invoiceS = Invoice.new(new_records)
      if @invoiceS.save
        successFlag = successFlag + 1
      end# end of if-else
    end# end of for loop

    respond_to do |format|
      if successFlag >= @rate.length
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render :index, status: :created, location: @invoice }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:customer_name, :customer_phone, :customer_email, :invoice, :invoice_date, :product, :rate, :quantity, :amount)
    end
end
