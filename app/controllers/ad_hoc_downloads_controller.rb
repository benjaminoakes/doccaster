require 'csv'

class AdHocDownloadsController < ApplicationController
  before_action :set_ad_hoc_download, only: [:show, :edit, :update, :destroy]

  # GET /ad_hoc_downloads
  # GET /ad_hoc_downloads.json
  def index
    @ad_hoc_downloads = AdHocDownload.all

    respond_to do |format|
      format.html do
        @ad_hoc_downloads = @ad_hoc_downloads.order('created_at desc')
        render :index
      end

      format.csv do
        @ad_hoc_downloads = @ad_hoc_downloads.where(seen: nil)

        lines = @ad_hoc_downloads.
          map { |d| 
            csv = [d.name, d.url].to_csv
            # Skip instead of choke at the downloader
            csv unless csv.match(/"/)
          }.
          compact

        lines.unshift("name,url\n")

        @ad_hoc_downloads.update_all(seen: true)

        render text: lines.join
      end
    end
  end

  # GET /ad_hoc_downloads/1
  # GET /ad_hoc_downloads/1.json
  def show
  end

  # GET /ad_hoc_downloads/new
  def new
    @ad_hoc_download = AdHocDownload.new
  end

  # GET /ad_hoc_downloads/1/edit
  def edit
  end

  # POST /ad_hoc_downloads
  # POST /ad_hoc_downloads.json
  def create
    @ad_hoc_download = AdHocDownload.new(ad_hoc_download_params)

    respond_to do |format|
      if @ad_hoc_download.save
        format.html { redirect_to @ad_hoc_download, notice: 'Ad hoc download was successfully created.' }
        format.json { render :show, status: :created, location: @ad_hoc_download }
      else
        format.html { render :new }
        format.json { render json: @ad_hoc_download.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ad_hoc_downloads/1
  # PATCH/PUT /ad_hoc_downloads/1.json
  def update
    respond_to do |format|
      if @ad_hoc_download.update(ad_hoc_download_params)
        format.html { redirect_to @ad_hoc_download, notice: 'Ad hoc download was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad_hoc_download }
      else
        format.html { render :edit }
        format.json { render json: @ad_hoc_download.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ad_hoc_downloads/1
  # DELETE /ad_hoc_downloads/1.json
  def destroy
    @ad_hoc_download.destroy
    respond_to do |format|
      format.html { redirect_to ad_hoc_downloads_url, notice: 'Ad hoc download was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad_hoc_download
      @ad_hoc_download = AdHocDownload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_hoc_download_params
      params.require(:ad_hoc_download).permit(:name, :url)
    end
end
