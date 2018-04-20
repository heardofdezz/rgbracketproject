class TournoisController < ApplicationController
  def new
    @tournoi = Tournoi.new
  end

  def create

     @tournoi = Tournoi.new(payload: JSON.parse(params[:payload]))
    if @tournoi.save
      redirect_to root_url
        flash[:success] = "Your tournament bracket has been validated!"
      else
        redirect_to malesingle_url
      end
  end
  private
    # Never trust parameters from the scary internet
    def tournoi_params
      params.require(:tournoi).permit(:payload)
     end
end
