class AddTestTags < ActiveRecord::Migration
  def self.up
    tag = Tag.create(:name => "soft_sf",
                     :description => "Niente techno-babble")
    tag.reviews << Review.find_by_original_title("Dune")
    tag.reviews << Review.find_by_original_title("Dispossessed")
                     
    tag = Tag.create(:name => "alieni",
                     :description => "Alieni")
    tag.reviews << Review.find_by_original_title("Dispossessed")
  end

  def self.down
    Tag.delete_all
  end
end
