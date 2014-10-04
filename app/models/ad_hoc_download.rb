class AdHocDownload < ActiveRecord::Base
  validates_presence_of :url

  def name
    self[:name].blank? ? basename : self[:name]
  end

  def basename
    File.basename(url)
  end
end
