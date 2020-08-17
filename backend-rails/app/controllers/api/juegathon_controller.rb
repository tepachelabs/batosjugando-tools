class Api::JuegathonController < ApplicationController
  def participants
    @participants = Juegathon::Participant.all
    respond_to do |format|
      format.json
    end
  end
end
