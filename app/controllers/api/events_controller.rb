module Api
  class EventsController < ApplicationController
    before_action :set_event, only: %i[ show update destroy ]
    before_action :authorized, except: [:all]
    # GET /events
    # GET /events.json
    def index
      @events = Event.find_by(user_id: @current_user.id)
      render json: @events, status: :ok
    end

    #シンプルに全てのeventsをloginなしで確認する用
    def all
      @events = Event.all
      render json: @events
    end

    # GET /events/1
    # GET /events/1.json
    def show
      render json: @event, status: :ok
    end

    # POST /events
    # POST /events.json
    def create
      puts @current_user
      @event = @current_user.events.new(event_params)
      if @event.valid?
        render json: @event
      else
        render json: @event.errors, status: :unprocessable_entity
      end
      # if @event.save
      #   payload = {user_id:@event.id}
      #   token = encode_token(payload)
      #   render json: {user:@event, token: token}, status: :created, location: api_event_url(@event)
      # else
      #   render json: {errors:@event.errors }, status: :unprocessable_entity
      # end
    end

    # PATCH/PUT /events/1
    # PATCH/PUT /events/1.json
    def update
      if@event.update(event_params)
        render :show, status: :ok, location: api_event_url(@event)
      else
        render json:@event.errors, status: :unprocessable_entity
      end
    end

    # DELETE /events/1
    # DELETE /events/1.json
    def destroy
    @event.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_event
      @event = Event.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def event_params
        params.require(:event).permit(:title, :memo, :date)
      end
  end
end
