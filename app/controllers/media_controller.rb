class MediaController < ApplicationController
  def index
    @media = Medium.all
    respond_to do |format|
      format.html
      format.csv { send_data @media.to_csv }
      format.xls { send_data @media.to_csv(col_sep: "\t") }
    end
  end

  def show
    @medium = Medium.find(params[:id])
  end

  def new
    @medium = Medium.new
  end

  def edit
    @medium = Medium.find(params[:id])
  end

  def create
    @medium = Medium.new(medium_params)

    if @medium.save
      flash[:notice] = "Medium was saved successfully."
      redirect_to @medium
    else
      flash.now[:alert] = "Error creating Medium. Please try again."
      render :new
    end
  end

  def update
    @medium = Medium.find(params[:id])
    @medium.assign_attributes(medium_params)

    if @medium.save
      flash[:notice] = "medium was updated successfully."
      redirect_to @medium
    else
      flash.now[:alert] = "Error updated medium. Please try again."
      render :edit
    end
  end

  def destroy
    @medium = Medium.find(params[:id])

    if @medium.destroy
      flash[:notice] = "\"#{@medium.medium}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the medium."
      render :show
    end
  end

  def import
    Medium.import(params[:file])
    redirect_to media_path, notice: 'Media imported.'
  end

  private

  def medium_params
    #params.require(:medium).permit(:id, :name, { :fields_attributes => [:id, :field_type, :name, :required, :medium_id, :_destroy] })
    params.require(:medium).permit(:id, :medium)
  end
end
