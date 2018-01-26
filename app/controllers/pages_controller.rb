class PagesController < ApplicationController
  def show
    if valid_page?
      render template: "pages/#{params[:page]}"
    else # Handles not found errors
      render file: "public/404.html", status: :not_found
    end
  end

  private
  # A method that checks page exists - returns boolean
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
  end
end
