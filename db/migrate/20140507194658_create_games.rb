class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player_1_id
      t.integer :player_2_id
      t.text :board
      t.integer :player_turn
      t.string :game_name

      t.timestamps
    end
  end
end
