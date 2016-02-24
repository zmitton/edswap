class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]
  # GET /listings
  # GET /listings.json
  def index
    @search = params[:search]
    @listings = Listing.where("body ILIKE ? or subject ILIKE ?" , "%#{@search}%", "%#{@search}%").where(active: true)
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.find(params[:id])
    @author = @listing.author
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    @hash = {lend: false, borrow: false, steal: false, buy: false, sell: false}
  end

  # GET /listings/1/edit
  def edit
    # remove
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      ListingImage.create(precedence: 1, image_path: params[:listing][:listing_image][:image_path] , listing_id: @listing.id ) if params[:listing][:listing_image]
      redirect_to listing_path(@listing.id), notice: 'Listing was successfully created.'
    else
      flash.now[:notice] = @listing.errors.messages
      render "listings/new"
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:subject, :body, :buying, :selling, :lending, :trading, :borrowing, :zip).merge(author_id: current_user.id, active: true)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end
end
