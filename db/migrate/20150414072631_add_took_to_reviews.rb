class AddTookToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :took, :string
  end
end
