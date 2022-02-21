class QuotesController < ApplicationController
  before_action :find_quotes, only: :show

  def show
    @quotes ||= Quotes.create(tag: params[:id])

    render json: @quotes.content
  end

  private

  def find_quotes
    @quotes = Quotes.find_by(tag: params[:id])
  end
end
