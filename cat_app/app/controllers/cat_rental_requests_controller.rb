class CatRentalRequestsController < ApplicationController
  def create
    @rental = CatRentalRequest.new(rent_params)
    if @rental.save
      flash.now[:approval] = "Approved! Expect your cat at #{@rental.start_date}!"
      redirect_to new_cat_rental_request_url
    else
      flash.now[:errors] = @rental.errors.full_messages
      render new_cat_rental_request_url
    end
  end

  def new
    @cats = Cat.all
    @rental = CatRentalRequest.new
    render :new
  end

  private

  def rent_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end

end
