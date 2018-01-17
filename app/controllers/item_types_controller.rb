class ItemTypesController < ApplicationController
  def index
    @item_types = ItemType.all
    respond_to do |format|
      format.html
      format.csv { send_data @item_types.to_csv }
      format.xls { send_data @item_types.to_csv(col_sep: "\t") }
    end
  end

  def show
    @item_type = ItemType.find(params[:id])
  end

  def new
    @item_type = ItemType.new(medium_ids: params[:medium_ids])
  end

  def edit
    @item_type = ItemType.find(params[:id])
  end

  def create
    @item_type = ItemType.new(item_type_params)

    if @item_type.save
      flash[:notice] = "ItemType was saved successfully."
      redirect_to @item_type
    else
      flash.now[:alert] = "Error creating ItemType. Please try again."
      render :edit
    end
  end

  def update
    @item_type = ItemType.find(params[:id])
    @item_type.assign_attributes(item_type_params)

    if @item_type.save
      flash[:notice] = "item_type was updated successfully."
      render :edit
    else
      flash.now[:alert] = "Error updated item_type. Please try again."
      render :edit
    end
  end

  def import
    ItemType.import(params[:file])
    redirect_to item_types_path, notice: 'ItemType imported.'
  end

  def destroy
    @item_type = ItemType.find(params[:id])

    if @item_type.destroy
      flash[:notice] = "\"#{@item_type.name}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the item_type."
      render :show
    end
  end

  private

  def item_type_params
    #properties = params[:item_type].delete(:properties)
    #media = params[:item_type].delete(:medium_ids)
    params.require(:item_type).permit! #( :id, :name, :properties ).tap do |whitelisted|
      #whitelisted[:properties] = params[:item_type][:properties].to_h
    #   whitelisted[:medium_ids] = media
    # end
      #{ :category_groups_attributes => [:id, :item_type_id, :medium_id, :_destroy] } )
      #{ :field_groups_attributes => [:id, :item_field_id, :medium_id, :_destroy] } )

      #{ :media_attributes => [:id, :medium] } )
  end
end
