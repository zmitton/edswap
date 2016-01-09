class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.find(params[:id])
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    name = "#{SecureRandom.uuid}.#{params[:listing][:picture].original_filename.split(".").last}"
    path = File.join("public#{ListingImage.directory}", name)
    File.open(path, "wb") { |f| f.write(params[:listing][:picture].read) }
    flash[:notice] = "File uploaded"

    @listing = Listing.new(listing_params)

    if @listing.save
      image = ListingImage.create(filename: name, listing_id: @listing.id)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:author, :type, :subject, :body)
    end
end
