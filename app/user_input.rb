class Input

    attr_reader :user_id
    attr_accessor :article_id

    def initialize(user_id)
        @user_id = user_id
    end

    def curated
        list_curated_articles
        print_curated_article_overview(@@article_id)
    end

    def most_liked
        largest = most_liked_num
        id = most_liked_id(largest)
        most_liked_article(id)
    end
    
    def longest
        longest_article(@article_id)
    end

    def search
        search_article(@article_id)
    end

    def favourites
        favourite_articles(@user_id)
    end

    # def add_to_fav
    #     add_article_to_fav(@@article_id, @user_id)
    # end
end