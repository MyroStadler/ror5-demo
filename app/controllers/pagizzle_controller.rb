class PagizzleController < ApplicationController
    include PagizzleHelper

    def index
        @page_size = params[:page_size].present? ? params[:page_size].to_i.clamp(1, 1000000) : 1000
        last_page_index = get_last_page_index(@page_size)
        @page_index = params[:page_index].present? ? params[:page_index].to_i.clamp(0, last_page_index) : 0

    end
end
