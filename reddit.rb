require_relative './notice'
class Reddit < Notice
    attr_reader :title, :author, :date, :url
end