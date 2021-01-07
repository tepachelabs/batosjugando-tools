class Juegathon::Event < ApplicationRecord
  has_many :participations,
           foreign_key: 'juegathon_events_id',
           class_name: 'Juegathon::Participations'
  has_many :participants,
           through: :participations,
           source: :juegathon_participant
end
