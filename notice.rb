class Notice
    attr_accessor :title, :author, :date, :url
    def initialize(title, author, date, url)
        @title = title
        @author = author
        @date = date
        @url = url
    end
end