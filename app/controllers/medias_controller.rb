class MediasController < ApplicationController
  def index
    @medias = Media.all
  end

  def show
    @media = Media.find(params[:id])
  end

  def new
    @media = Media.new
  end

  def edit
    @media = Media.find(params[:id])
  end

  def create
    @media = Media.new(media_params)

    if @media.save
      flash[:notice] = "Media was saved successfully."
      redirect_to @media
    else
      flash.now[:alert] = "Error creating Media. Please try again."
      render :new
    end
  end

  def update
    @media = Media.find(params[:id])
    @media.assign_attributes(media_params)

    if @media.save
      flash[:notice] = "media was updated successfully."
      redirect_to @media
    else
      flash.now[:alert] = "Error updated media. Please try again."
      render :edit
    end
  end

  def destroy
    @media = Media.find(params[:id])

    if @media.destroy
      flash[:notice] = "\"#{@media.media}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the media."
      render :show
    end
  end

  private

  def media_params
    #params.require(:media).permit(:id, :name, { :fields_attributes => [:id, :field_type, :name, :required, :media_id, :_destroy] })
    params.require(:media).permit(:id, :media)
  end
end
