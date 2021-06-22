class MailsController < ApplicationController
    
    def new
        @mail = Mail.new
    end
    
    def create
        @mail = Mail.new(mail_params)
        @mail.user_id = current_user.id
        
       
        if @mail.save
        
        NoticeEventMailer.notice_event_email(@mail).deliver
        redirect_to mail_path(@mail)
        else
          @mail = Mail.new
          render :new
        end
    end
    
    def show
        @mail = Mail.find(params[:id])
    end
    
    private
    def mail_params
      params.require(:mail).permit(:title, :content)
    end
end
