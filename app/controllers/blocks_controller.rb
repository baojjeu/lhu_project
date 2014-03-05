class BlocksController < ApplicationController
  before_action :set_block, only: [:show, :edit, :update, :destroy]


  # GET /blocks
  # GET /blocks.json
  def index
    @blocks = Block.all
  end

  # GET /blocks/1
  # GET /blocks/1.json
  def show

    @blocks = Block.where(parent_id: params[:id]).order('name DESC')



    render layout: false
  end

  # GET /blocks/new
  def new
    @block = Block.new
  end

  # GET /blocks/1/edit
  def edit
    @blocks = Block.where(parent_id: params[:id]).order('name DESC')



    render layout: false
  end

  # POST /blocks
  # POST /blocks.json
  def create
    @block = Block.new(block_params)

    respond_to do |format|
      if @block.save
        format.html { render @block, notice: "#{@block.id}" }
        format.json { render action: 'show', status: :created, location: @block }
      else
        format.html { render action: 'new' }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blocks/1
  # PATCH/PUT /blocks/1.json
  def update
    respond_to do |format|
      if @block.update(block_params)
        format.html { redirect_to @block, notice: 'Block was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /blocks/1
  # DELETE /blocks/1.json
  def destroy

    # delete associate block
    Block.where(parent_id: params[:id]).each do |block|
      Block.where(parent_id: block.id).destroy_all
      block.destroy
    end

    # delete the main block
    @block.destroy

    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_block
      @block = Block.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def block_params
      params.require(:block).permit(:name, :left, :top, :width, :height, :space_id, :block_type, :parent_id)
    end
end