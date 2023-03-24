class AddIndexToEmailJuegathonParticipant < ActiveRecord::Migration[5.2]
  def change
    add_index :juegathon_participants, :email
  end
end
