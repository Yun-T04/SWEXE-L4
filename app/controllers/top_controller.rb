class TopController < ApplicationController
    def main
        if session[:login_uid]
            render "main"
        else
            render "login"
        end
    end
    
    def login
        #if params[:uid] == 'kindai' and params[:pass] == 'sanriko'
        user = User.find_by(uid: params[:uid])
        
        if user and BCrypt::Password.new(user.pass) == params[:pass]
            #logger.debug "-" * 50
            #logger.debug user
            session[:login_uid] = params[:uid]
            redirect_to top_main_path
        else
            render "error", status:422
        end
    end
    
    def logout
        session.delete(:login_uid)
        redirect_to root_path
    end
end


# 動作方法
# rails generate model user uid:string pass:string
# rails db:migrat
# rails c
# 3.2.2 :001 > User.create(uid:"a", pass:"b")



#pass.rbの内容をtop_controller.rbのdef loginに入れ込む必要あり。
#rails c
#userのさくせい
#user = User.create(uid: 'testuser', pass: BCrypt::Password.create('password123'))
#user = User.new(uid: 'testuser')
#user.password = 'password123'
#user.save