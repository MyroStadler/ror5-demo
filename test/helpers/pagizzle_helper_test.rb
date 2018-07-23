require "test_helper"
# require 'pagizzle_helper'

class PagizzleHelperTest < ActionView::TestCase
    include PagizzleHelper

    test "returns page index 1" do
        assert_equal 1, get_page_index(10, 10)
    end
    test "returns page index 0" do
        assert_equal 0, get_page_index(10, 9)
    end
    test "no prevs" do 
        assert get_prev_pages(10, 0).empty?
    end
    test "one prev" do 
        assert_equal 1, get_prev_pages(10, 1).count 
    end
    test "one prev is 0" do 
        assert_equal 0, get_prev_pages(10, 1)[0] 
    end
    test "no nexts" do 
        assert get_next_pages(1000, 999).empty?
    end
    test "one next" do 
        assert_equal 1, get_next_pages(1000, 998).count 
    end
    test "one next is 999" do 
        assert_equal 999, get_next_pages(1000, 998)[0] 
    end

    test "no prev jumps for 0" do 
        assert get_prev_jumps(10, 0).empty?
    end
    test "no prev jumps for 9" do 
        assert get_prev_jumps(10, 9).empty?
    end
    test "one prev jump for 10" do 
        assert_equal 1, get_prev_jumps(10, 10).count
    end
    test "one prev jump for 10 is -10 0" do 
        assert_equal -10, get_prev_jumps(10, 10)[0][0]
        assert_equal 0, get_prev_jumps(10, 10)[0][1]
    end
    test "two prev jumps for 100 is -10 90 and -100 0" do 
        prev_jumps = get_prev_jumps(10, 100)
        assert_equal 2, prev_jumps.count
        assert_equal -10, prev_jumps[0][0]
        assert_equal 90, prev_jumps[0][1]
        assert_equal -100, prev_jumps[1][0]
        assert_equal 0, prev_jumps[1][1]
    end

    test "humanized 23 is twenty-three" do 
        assert_equal "twenty-three", get_english_language_number(23)
    end

    test "one item for 1 1" do
        assert_equal 1, get_page_items(1, 0).count
    end
    test "page items for 1 1 is one" do
        assert_equal "one", get_page_items(1, 0)[0]
    end

    test "first page url is as expected" do 
        assert_equal "/?page_size=1000&page_index=0", get_url_for_first_page(1000)
    end

    test "last page url is as expected" do 
        assert_equal "/?page_size=1000&page_index=999", get_url_for_last_page(1000)
    end
end