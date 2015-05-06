class RemoveTookFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :took, :string
  end
end
