require_relative './notice'
class Mashable < Notice
    attr_reader :title, :author, :date, :url
end