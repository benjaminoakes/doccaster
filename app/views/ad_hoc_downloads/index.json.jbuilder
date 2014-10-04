json.array!(@ad_hoc_downloads) do |ad_hoc_download|
  json.extract! ad_hoc_download, :id, :name, :url, :seen
  json.url ad_hoc_download_url(ad_hoc_download, format: :json)
end
