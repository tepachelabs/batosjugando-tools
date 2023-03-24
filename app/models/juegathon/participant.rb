class Juegathon::Participant < ApplicationRecord
  has_many :participations,
           foreign_key: 'juegathon_participants_id',
           class_name: 'Juegathon::Participations'
  has_many :events,
           through: :participations,
           source: :juegathon_event
end
