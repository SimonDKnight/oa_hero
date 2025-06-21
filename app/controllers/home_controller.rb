class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.any { render html: "", status: :ok }
    end
  end

  def retailer_list
  end
end
