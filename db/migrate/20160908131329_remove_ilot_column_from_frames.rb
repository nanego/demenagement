class RemoveIlotColumnFromFrames < ActiveRecord::Migration
  def change
    remove_column :frames, :ilot, :integer
    remove_column :frames, :room_id, :integer
  end
end
