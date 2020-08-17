class CreateJuegathonParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :juegathon_participants do |t|
      t.string :name
      t.string :avatar_url
      t.string :description
      t.string :email
      t.string :favorite_game
      t.string :twitter_username
      t.string :twitch_username
      t.string :other_link

      t.timestamps
    end
  end
end
