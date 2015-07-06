class ShortUrlsController < ApplicationController
  def show
    @short_url = ShortUrl.find_by_base62_id!(params[:base62_id])

    redirect_to @short_url.original_url, status: 301
  end

  def new
    @short_url = ShortUrl.new
  end

  def create
    @short_url = ShortUrl.new(short_url_params)

    if @short_url.save
      flash.now[:notice] = 'Short URL was successfully created.'
      @shortened_url = @short_url.url_for_host(root_url)
      @short_url = ShortUrl.new
    else
      flash.now[:error] = 'Could not create short URL.'
    end

    render :new
  end

  private

  # Only allow a trusted parameter "white list" through.
  def short_url_params
    params.require(:short_url).permit(:original_url)
  end
end
