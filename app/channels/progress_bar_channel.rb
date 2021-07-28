class ProgressBarChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ProgressBarChannel"
  end
end