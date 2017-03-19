class ComputersController < ApplicationController
  before_action :set_computer, only: [:show, :edit, :update, :destroy]

  # GET /computers
  def index
    @computers = Computer.order(params[:order]).all
  end

  # GET /computers/1
  def show
  end

  # GET /computers/new
  def new
    @computer = Computer.new
  end

  # GET /computers/1/edit
  def edit
  end

  # POST /computers
  def create
	  @computer = Computer.new(computer_params.merge(:user_id => current_user.id))

    if @computer.save
      redirect_to @computer, notice: 'Computer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /computers/1
  def update
    if @computer.update(computer_params.merge(:user_id => current_user.id))
      redirect_to @computer, notice: 'Computer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /computers/1
  def destroy
    @computer.destroy
    redirect_to computers_url, notice: 'Computer was successfully destroyed.'
  end

  def new_import
  end

  def import
    if params[:file].present?
      content = params[:file][:content]
      log =  ""
      line_num = 0
      content.read.split("\n").each do |line|
        line_num += 1
        city, warranty, vendor, serial_number = line.split(',')
        warranty = warranty == 'true'
        computer = Computer.new :city => city, :warranty => warranty, :vendor => vendor, :serial_number => serial_number, :user_id => current_user.id
        if computer.save
          log += "Naimportován computer se sériovým číslem #{serial_number}\n"
        else
          log += "Chyba při importu na řádku #{line_num}:#{line} #{computer.errors.full_messages}"
        end
      end
      flash[:notice] = log
      redirect_to computers_path
    else
      flash[:alert] = 'Nenahrán žádný soubor'
      redirect_to new_import_computers_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_computer
      @computer = Computer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def computer_params
      params.require(:computer).permit(:city, :warranty, :vendor, :serial_number)
    end
end
