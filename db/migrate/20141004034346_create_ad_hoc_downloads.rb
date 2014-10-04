class CreateAdHocDownloads < ActiveRecord::Migration
  def change
    create_table :ad_hoc_downloads do |t|
      t.string :name
      t.text :url
      t.boolean :seen

      t.timestamps
    end
  end
end
