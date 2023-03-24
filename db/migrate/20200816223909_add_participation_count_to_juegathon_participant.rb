class AddParticipationCountToJuegathonParticipant < ActiveRecord::Migration[5.2]
  def change
    add_column :juegathon_participants, :participations, :integer, default: 0
  end
end
