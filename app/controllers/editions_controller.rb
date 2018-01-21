class EditionsController < ApplicationController
  def index
    @editions = Edition.all
    respond_to do |format|
      format.html
      format.csv { send_data @editions.to_csv }
      format.xls { send_data @editions.to_csv(col_sep: "\t") }
    end
  end

  def show
    @edition = Edition.find(params[:id])
  end

  def new
    @edition = Edition.new(medium_ids: params[:medium_ids])
  end

  def edit
    @edition = Edition.find(params[:id])
  end

  def create
    @edition = Edition.new(edition_params)

    if @edition.save
      flash[:notice] = "Edition was saved successfully."
      redirect_to @edition
    else
      flash.now[:alert] = "Error creating Edition. Please try again."
      render :edit
    end
  end

  def update
    @edition = Edition.find(params[:id])
    @edition.assign_attributes(edition_params)

    if @edition.save
      flash[:notice] = "edition was updated successfully."
      render :edit
    else
      flash.now[:alert] = "Error updated edition. Please try again."
      render :edit
    end
  end

  def import
    Edition.import(params[:file])
    redirect_to editions_path, notice: 'Edition imported.'
  end

  def destroy
    @edition = Edition.find(params[:id])

    if @edition.destroy
      flash[:notice] = "\"#{@edition.name}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the edition."
      render :show
    end
  end

  private

  def edition_params
    params.require(:edition).permit!
  end
end
