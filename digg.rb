require './notice'
class Digg < Notice
    attr_reader :title, :author, :date, :url
end