class ProgressBarJob < ApplicationJob
  include CableReady::Broadcaster
  queue_as :default

  def perform
    status = 0
    while status < 100
      status += 10
      cable_ready["ProgressBarChannel"].set_attribute(
        selector: "#progress-bar>div",
        name: "style",
        value: "width:#{status}%"
      )
      cable_ready.broadcast
      sleep 1 # fake some latency
    end
  end
end