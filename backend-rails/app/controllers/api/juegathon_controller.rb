class Api::JuegathonController < ApplicationController
  def participants
    @participants = Juegathon::Participant.includes(:participations).all
    @events = fill_events

    respond_to do |format|
      format.json
    end
  end

  private

  def fill_events
    events = Hash.new
    Juegathon::Event.all.each do |event|
      events[event.id] = event.name
    end

    events
  end
end
