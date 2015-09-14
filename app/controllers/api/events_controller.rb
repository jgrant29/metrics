class API::EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :set_access_control_headers

  def create
    registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])
    if registered_application.nil?
      render json: "unregistered application", status: :unprocessable_entity
    else
      @event = registered_application.events.build(event_params)
        if @event.save
          render json: @event, status: :created
        else
          render @event.errors, status: :unprocessable_entity
        end
      end
    end

    private 
    def event_params
      params.require(:event).permit(:name)
    end
  end

  def set_access_control_headers
    # #1
    headers['Access-Control-Allow-Origin'] = '*'
    # #2
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    # #3
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
  end
end