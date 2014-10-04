require 'csv'

class AdHocDownloadsController < ApplicationController
  before_action :set_ad_hoc_download, only: [:show, :edit, :update, :destroy]

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

  def show
  end

  def new
    @ad_hoc_download = AdHocDownload.new
  end

  def edit
  end

  def create
    @ad_hoc_download = AdHocDownload.new(ad_hoc_download_params)

    respond_to do |format|
      if @ad_hoc_download.save
        format.html { redirect_to ad_hoc_downloads_path, notice: 'Ad hoc download was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @ad_hoc_download.update(ad_hoc_download_params)
        format.html { redirect_to @ad_hoc_download, notice: 'Ad hoc download was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @ad_hoc_download.destroy
    respond_to do |format|
      format.html { redirect_to ad_hoc_downloads_url, notice: 'Ad hoc download was successfully destroyed.' }
    end
  end

  private

  def set_ad_hoc_download
    @ad_hoc_download = AdHocDownload.find(params[:id])
  end

  def ad_hoc_download_params
    params.require(:ad_hoc_download).permit(:name, :url)
  end
end
