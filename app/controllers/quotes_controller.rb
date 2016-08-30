class QuotesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :find_quote, only: [:show, :edit, :destroy, :update]

  def index
    @quotes = Quote.all
    @select_only_belong_to_current_user = true if params[:select_only] == "Show mine"
    @quotes = Quote.where(user: current_user) if @select_only_belong_to_current_user
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = current_user.quotes.build(quote_params)
    @quote.author = "Anonymous" if @quote.author.empty?
    if @quote.save
      redirect_to quotes_path, notice: 'Yeah! Done!'
    else
      render 'new', notice: "Emmmm... not really... can't do it..."
    end
  end

  def show
  end

  def edit
  end

  def update
    if @quote.update quote_params
      redirect_to @quote, notice: 'Yay! Quote saved'
    else
      render 'edit'
    end
  end

  def destroy
    @quote.destroy
    redirect_to quotes_path
  end

  private

  def quote_params
    params.require(:quote).permit(:text, :author, :user_id)
  end

  def find_quote
    @quote = Quote.find(params[:id])
  end
end
