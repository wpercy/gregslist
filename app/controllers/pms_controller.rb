class PmsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :show, :index]
  before_action :correct_user,   only: [:show, :destroy]

  def show
     @pm= Pm.find(params[:id])
     @sender= User.find(@pm.sender_id)
     @newpm= current_user.pms.build
     @newpm.recipient_email= @sender.email
  end

  def create
    @pm = current_user.pms.build(pm_params)
    if !User.find_by_email(@pm.recipient_email)
      flash[:failure] = "Invalid email"
      redirect_to index
      return
    end

     @pm.sender_id=params[:sender_id]
     @pm.recipient_id= User.find_by_email(@pm.recipient_email).id
     
   if @pm.save
      flash[:success] = "Message sent" 
    else
      flash[:failure] =  "Message not sent try again"
            end 
       redirect_to index
  end

  def new
    @newpm = current_user.pms.build
    @newpm.recipient_email = User.find(params[:recipient_id]).email
  end

  def index
   	@pms=current_user.pms
  	@newpm= current_user.pms.build
  end

  def destroy
  	Pm.find(params[:id]).destroy
    redirect_to index
  end

private
   def pm_params
      params.require(:pm).permit(:message, :sender_id, :recipient_email, :recipient_id)
    end
     def correct_user
      @user = User.find(Pm.find(params[:id]).recipient_id)
      redirect_to(root_url) unless current_user?(@user)
    end
end
