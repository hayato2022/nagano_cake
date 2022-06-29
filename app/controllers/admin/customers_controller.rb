class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def customer_params
  end

end
