require 'humanize'

module PagizzleHelper
    @@UBOUND = 999999;
    def get_first_index(page_size, page_index)
        return (page_size * page_index).to_i
    end
    def get_last_index(page_size, page_index)
        return ((page_size * page_index) + page_size - 1).to_i
    end
    def get_page_index(page_size, item_index)
        return (item_index / page_size).floor.to_i
    end
    def get_last_page_index(page_size)
        self::get_page_index(page_size, @@UBOUND)
    end
    def get_prev_pages(page_size, current_page_index)
        if current_page_index <= 0 
            return []
        end
        all_prevs = (0..(current_page_index-1).to_i).to_a
        return all_prevs.last(9)
    end
    def get_next_pages(page_size, current_page_index)
        last_page_index = self::get_last_page_index(page_size)
        if current_page_index >= last_page_index
            return []
        end
        all_nexts = ((current_page_index+1).to_i..last_page_index).to_a
        return all_nexts.first(9)
    end
    def get_prev_jumps(page_size, current_page_index)
        jumps = [-10,-50,-100,-500,-1000,-5000,-10000,-50000,-100000,-500000]
        return self::get_jumps(page_size, current_page_index, jumps)
    end
    def get_next_jumps(page_size, current_page_index)
        jumps = [10,50,100,500,1000,5000,10000,50000,100000,500000]
        return self::get_jumps(page_size, current_page_index, jumps)
    end
    def get_jumps(page_size, current_page_index, jump_amounts)
        last_page_index = self::get_last_page_index(page_size)
        options = []
        jump_amounts.each do |n| 
            jump_to = current_page_index + n
            options << [n, jump_to] unless (jump_to < 0 || jump_to > last_page_index)
        end
        return options
    end

    def get_page_items(page_size, page_index)
        first_index = self::get_first_index(page_size, page_index).clamp(0, @@UBOUND)
        last_index = self::get_last_index(page_size, page_index).clamp(0, @@UBOUND)
        # remember the number that is the item is the index + 1
        return (first_index..last_index).to_a.map { |n| self::get_english_language_number(n + 1) } 
    end
    def get_english_language_number(n)
        n.humanize
    end

    def get_url_for_first_page(page_size) 
        "/?page_size=#{page_size.to_i}&page_index=0"
    end
    def get_url_for_last_page(page_size) 
        last_page_index = self::get_last_page_index(page_size)
        "/?page_size=#{page_size.to_i}&page_index=#{last_page_index}"
    end
end