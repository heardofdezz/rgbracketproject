class TicketsController < ApplicationController
  def new
    @ticket = Ticket.new
  end

  def update
  end

  def create
    render json: ticket_params
    @ticket = Ticket.new(ticket_params)

      if @ticket.save
        redirect_to root_url
        flash[:success] = "Bravo!!!!!"
      else
        render root_url
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
  end
  private
  def ticket_params
    params.require(:ticket).permit(:bracket)
  end
end
