class Api::JuegathonController < ApplicationController
  def participants
    @participants = Juegathon::Participant.includes(:participations).all.sort_by(&:created_at)
    @events = fill_events

    respond_to do |format|
      format.json
    end
  end

  private

  def fill_events
    events = {}
    Juegathon::Event.all.each do |event|
      events[event.id] = event.name
    end

    events
  end
end
