class PropertyInfosController < ApplicationController
  before_action :set_property_info, only: [:show, :edit, :update, :destroy, :result]

  # GET /property_infos
  # GET /property_infos.json
  def index
    @property_infos = PropertyInfo.all
  end

  # GET /property_infos/1
  # GET /property_infos/1.json
  def show
  end

  # GET /property_infos/new
  def new
    @property_info = PropertyInfo.new
  end

  # GET /property_infos/1/edit
  def edit
  end

  # POST /property_infos
  # POST /property_infos.json
  def create
    @property_info = PropertyInfo.new(property_info_params)

    respond_to do |format|
      if @property_info.save
        format.html { redirect_to result_path(@property_info), notice: 'Property info was successfully created.' }
        format.json { render action: 'show', status: :created, location: @property_info }
      else
        format.html { render action: 'new' }
        format.json { render json: @property_info.errors, status: :unprocessable_entity }
      end
    end
  end

  def result
    # @property_info = PropertyInfo.find(params[:id])
  end

  # PATCH/PUT /property_infos/1
  # PATCH/PUT /property_infos/1.json
  def update
    respond_to do |format|
      if @property_info.update(property_info_params)
        format.html { redirect_to result_path(@property_info), notice: 'Property info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @property_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /property_infos/1
  # DELETE /property_infos/1.json
  def destroy
    @property_info.destroy
    respond_to do |format|
      format.html { redirect_to property_infos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property_info
      @property_info = PropertyInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_info_params
      params.require(:property_info).permit(:email, :phone_number, :postcode, :rental_period_type_id, :rent_income, :property_cost)
    end
end
