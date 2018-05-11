class InmessagesController < ApplicationController
  def new
   @message = Inmessage.new
  end

  def create
    @message = Inmessage.new(params[:inmessage])
    if @message.save
      nameParts = @message.name.split(" ")
      firstname = nameParts[0].capitalize
       UserMailer.contact_reply(@message, firstname).deliver
       UserMailer.contact_us(@message).deliver
      flash[:notice] = ""
      if user_signed_in?
        redirect_to "/controls", notice: "Message sent! Thanks #{firstname} for contacting us."
      else
        redirect_to "/contact-us", notice: "Message sent! Thanks #{firstname} for contacting us."
      end
    else
      render "new"
    end
  end
end

