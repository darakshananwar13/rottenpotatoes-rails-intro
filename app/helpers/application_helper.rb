module ApplicationHelper
    def helper(sort_column)
        if(params[:sort_column]==sort_column)
            return 'hilite'
        end
        if(session[:sort_column]==sort_column)
            return 'hilite'
        end
    end
end
