class RenameServeurToServer< ActiveRecord::Migration
  def change
    rename_table :serveurs, :servers
    rename_column :slots, :serveur_id, :server_id
    rename_column :cards_serveurs, :serveur_id, :server_id
  end
end
