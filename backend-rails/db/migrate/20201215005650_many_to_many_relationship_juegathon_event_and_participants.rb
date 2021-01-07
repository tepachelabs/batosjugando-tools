class ManyToManyRelationshipJuegathonEventAndParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :juegathon_participations do |t|
      t.belongs_to :juegathon_participants, foreign_key: true
      t.belongs_to :juegathon_events, foreign_key: true
      t.timestamps
    end
  end
end
