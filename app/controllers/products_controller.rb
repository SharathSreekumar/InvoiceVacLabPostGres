class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all.order("rate asc")
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    if params[:product]
      check = Product.find_by(:product_name => params[:product]["product_name"].capitalize)
      if check.present?
        puts "present"
        respond_to do |format|
          format.html { redirect_to @product, notice: 'Product already present.' }
          format.json { render :index, status: :created, location: @product }
        end
      else # if thedata is not present
        new_records = Array.new
        new_records = {:product_name => params[:product]["product_name"].capitalize, :rate => params[:product]["rate"].to_f}
        @productS = Product.new(new_records)

        respond_to do |format|
          if @productS.save
            format.html { redirect_to @product, notice: 'Product was successfully created.' }
            format.json { render :index, status: :created, location: @product }
          else
            format.html { render :new }
            format.json { render json: @product.errors, status: :unprocessable_entity }
          end
        end
      end # end of else
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :index, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:product_name, :rate)
    end
end
