class GamesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create, :update]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])
    # @games = Game.order('RANDOM()').limit(3)
  end

  def complete
    game = Game.find(params[:game_id])
    game.update_attribute(:completions, game.completions + 1)
    flash[:notice] = "You completed a level, congrats"
    redirect_to root_path
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
    @game = current_user.games.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @game = current_user.games.new(game_params)
    @game.setup_map(params[:game][:map], params[:width])

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      @game = current_user.games.find_by_token(params[:token])
      @game.update_attributes(game_params)
      @game.setup_map(params[:game][:map], params[:width])
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:name, :map)
    end
end
