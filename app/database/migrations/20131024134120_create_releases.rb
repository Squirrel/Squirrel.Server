class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :name
      t.string :version, :null => false
      t.datetime :pub_date
      t.string :notes
      t.string :url, :null => false
    end
  end
end
