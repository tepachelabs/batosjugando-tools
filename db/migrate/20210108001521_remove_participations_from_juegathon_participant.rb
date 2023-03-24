class RemoveParticipationsFromJuegathonParticipant < ActiveRecord::Migration[5.2]
  def change
    # since this column is going to be a relationship, remove it.
    change_table :juegathon_participants do |t|
      t.remove :participations
    end
  end
end
