class Juegathon::Participations < ApplicationRecord
  belongs_to :juegathon_event,
             foreign_key: 'juegathon_events_id',
             :class_name => 'Juegathon::Event'

  belongs_to :juegathon_participant,
             foreign_key: 'juegathon_participants_id',
             :class_name => 'Juegathon::Participant'
end
