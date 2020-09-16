module ApplicationHelper
    def helper(column)
        if(params[:column]==column)
            return 'hilite'
        end
        if(session[:column]==column)
            return 'hilite'
        end
    end
end
