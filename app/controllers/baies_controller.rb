class BaiesController < ApplicationController

  def show
    @baie = Baie.find(params[:id])
    @salle = @baie.salle
    @serveurs_par_baies ||= {}

    Serveur.joins(:baie)
        .where(baie: @baie)
        .order('baies.ilot ASC, baies.position ASC, serveurs.position desc, serveurs.id desc').each do |s|
      ilot = (s.baie.try(:ilot).present? ? s.baie.ilot.to_s : "non précisé")
      baie = (s.baie.title.present? ? s.baie.title.to_s : "non précisée")
      @serveurs_par_baies[ilot] ||= {}
      @serveurs_par_baies[ilot][baie] ||= []
      @serveurs_par_baies[ilot][baie] << s
    end

    render 'salles/show'
  end

  def edit
    @baie = Baie.find(params[:id])
  end

  def update
    @baie = Baie.find(params[:id])
    respond_to do |format|
      if @baie.update(baie_params)
        format.html { redirect_to salle_path(@baie.salle), notice: 'baie was successfully updated.' }
        format.json { render :show, status: :ok, location: @baie }
      else
        format.html { render :edit }
        format.json { render json: @baie.errors, status: :unprocessable_entity }
      end
    end
  end

  def sort
    params[:baie].each_with_index do |id, index|
      Baie.where(id: id).update_all(position: index+1)
    end if params[:baie].present?
    render nothing: true
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def baie_params
    params.require(:baie).permit(:title)
  end

end
