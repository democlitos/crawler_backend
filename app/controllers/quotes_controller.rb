class QuotesController < ApplicationController
  before_action :find_quotes, only: :show

  def show
    # If we don't find quotes for the requested tag in our database, we need
    # to 'craw' the quotes website and then persist the response for future
    # searchs.
    @quotes ||= Quotes.create(tag: params[:id])

    render json: @quotes.content
  end

  private

  def find_quotes
    @quotes = Quotes.find_by(tag: params[:id])
  end
end
