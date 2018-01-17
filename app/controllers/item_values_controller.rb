class ItemValuesController < ApplicationController
  def index
    @item_values = ItemValue.all
    respond_to do |format|
      format.html
      format.csv { send_data @item_values.to_csv }
      format.xls { send_data @item_values.to_csv(col_sep: "\t") }
    end
  end

  def show
    @item_value = ItemValue.find(params[:id])
  end

  def new
    @item_value = ItemValue.new
  end

  def edit
    @item_value = ItemValue.find(params[:id])
  end

  def create
    # @item_field = ItemField.find(params[:item_field_id])
    # @item_value = @item_field.item_values.build(item_value_params)
    @item_value = ItemValue.new(item_value_params)

    if @item_value.save
      flash[:notice] = "ItemValue was saved successfully."
      #redirect_to @item_value
      #redirect_to edit_invoice_item_path(@item_value.invoice, @item_value)
    else
      flash.now[:alert] = "Error creating ItemValue. Please try again."
      #render :new
      #redirect_to edit_invoice_item_path(@item_value.invoice, @item_value)
    end
    render :edit
  end

  def update
    @item_value = ItemValue.find(params[:id])
    @item_value.assign_attributes(item_value_params)

    if @item_value.save
      flash[:notice] = "item_value was updated successfully."
      #redirect_to @item_value
      #redirect_to edit_invoice_item_path(@item_value.invoice, @item_value)
    else
      flash.now[:alert] = "Error updated item_value. Please try again."
      #render :edit
      #redirect_to edit_invoice_item_path(@item_value.invoice, @item_value)
    end
    render :edit
  end

  def destroy
    #@item_field = ItemField.find(params[:item_field_id])
    #@item_value = @item_field.item_values.find(params[:id])
    @item_value = ItemValue.find(params[:id])

    if @item_value.destroy
      flash[:notice] = "\"#{@item_value.name}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the item_value."
      render :show
    end
  end

  def import
    ItemValue.import(params[:file])
    redirect_to item_values_path, notice: 'ItemValue imported.'
  end

  private

  def item_value_params
    params.require(:item_value).permit(:id, :name)
  end
end
