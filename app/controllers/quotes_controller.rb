class QuotesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :find_quote, only: [:show, :edit, :destroy, :update]
  # load_and_authorize_resource param_method: :my_sanitizer
  load_and_authorize_resource except: :index

  def index
    @quotes = Quote.all
    @select_only_belong_to_current_user = true if params[:select_only] == "Show mine"
    if @select_only_belong_to_current_user
      Quote.where(user: current_user)
    else
      @quotes = Quote.where(public: true)
    end
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = current_user.quotes.build(quote_params)
    @quote.author = "Anonymous" if @quote.author.empty?
    @quote.public = true if current_user.role?(:super_admin)
    if @quote.save
      redirect_to quotes_path, notice: 'Yeah! Done!'
    else
      render 'new', notice: "Emmmm... not really... can't do it..."
    end
  end

  def show
    # authorize! :read, @quote
  end

  def edit
    # authorize! :edit, @quote
  end

  def update
    # authorize! :update, @quote
    if @quote.update quote_params
      redirect_to quotes_path, notice: 'Yay! Quote saved'
    else
      render 'edit'
    end
  end

  def destroy
    # authorize! :destroy, @quote
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
