require 'colorize'
require 'date'
require_relative './request'
require_relative './notice'
require_relative './reddit'
require_relative './mashable'
require_relative './digg'
# require_relative './utils/keypress'

class ReaderRss
    # attr_accessor :reddit, :mashable, :digg, :all
    def initialize()
        @reddit = []
        @mashable = []
        @digg = []
        @all = []
    end

    def get_keypressed
		system("stty raw -echo")
		t = STDIN.getc
		system("stty -raw echo")
		return t
	end

    def main_menu()
        system("clear")
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        puts "-------------------------------                               " + "Lector Rss".colorize(:light_yellow) + "                                    -----------------------------------"
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        puts "-------------------------------                     " + "Seleccione la pagina que desea ver".colorize(:light_yellow) + "                      -----------------------------------"
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        puts "-------------------------------                            " + "1 - Reddit.com".colorize(:light_cyan) + "                                   -----------------------------------"
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        puts "-------------------------------                            " + "2 - Mashable.com".colorize(:yellow) + "                                 -----------------------------------"
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        puts "-------------------------------                            " + "3 - Digg.com".colorize(:blue) + "                                     -----------------------------------"
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        puts "-------------------------------                            " + "4 - Por Fecha".colorize(:green) + "                                    -----------------------------------"
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        puts "-------------------------------                            " + "5 - Salir".colorize(:red) + "                                        -----------------------------------"
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        opc = get_keypressed   
        case opc
            when "1" then
                system("clear")
                create_reddit(search_reddit())
                print_reddit()
            when "2" then
                system("clear")
                create_mashable(search_mashable())
                print_mashable()
            when "3" then
                system("clear")
                create_digg(search_digg())
                print_digg()
            when "4" then
                system("clear")    
                print_all()    
            when "5" then
                system("clear")
                puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
                puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
                puts "-------------------------------                               " + "Hasta Luego".colorize(:red) + "                                   -----------------------------------"
                puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
                puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
            else
                main_menu
        end
    end

    def search_reddit()
        reddit = Request.new()                                 
        reddit.connect('https://www.reddit.com/.json')
    end

    def search_mashable()
        mashable = Request.new()
        mashable.connect('http://mashable.com/stories.json')
    end

    def search_digg()
        digg = Request.new()
        digg.connect('http://digg.com/api/news/popular.json')
    end

    def create_reddit(posts)
        reddit = posts["data"]["children"]
        @reddit = reddit.map{|notice|
            title = notice["data"]["title"]
            author = notice["data"]["author"]
            date = notice["data"]["created"]
            url = "https://www.reddit.com#{notice["data"]["permalink"]}"
            Reddit.new(title, author, Time.at(date).strftime("%d/%m/%Y"), url) 
        }
    end

    def create_mashable(posts)
        mashable = posts["new"]
        @mashable = mashable.map{|notice|
            title = notice["title"]
            author = notice["author"]
            date = notice["post_date"]
            url = notice["link"]
            Mashable.new(title, author, Date.rfc3339(date).strftime("%d/%m/%Y"), url)
        }
    end

    def create_digg(posts)
        digg = posts["data"]["feed"]
        @digg = digg.map{|notice|
            title = notice["content"]["title_alt"]
            author = notice["content"]["author"]
            date = notice["date"]
            url = notice["content"]["url"]
            Digg.new(title, author, Time.at(date).strftime("%d/%m/%Y"), url)   
        }
    end

    def print_notices(notices,color,category)
        page = 0
        count = 0
        loop do
            puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
            puts "---------------------------------------                    " + "Noticias #{category}".colorize(color) + "                 -------------------------------------------"
            puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
            notices.each_index{|notice|
                if notice >= page && notice <= (page+3) then
                    puts
                    puts "-----------------------------------------------------------   " + "Noticia N° #{count += 1}".colorize(color) + "   -----------------------------------------------------------------"
                    puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
                    puts "Titulo: ".colorize(color) + "#{notices[notice].title}"
                    puts "Autor:  ".colorize(color) + "#{notices[notice].author}"
                    puts "Fecha:  ".colorize(color) + "#{notices[notice].date}"
                    puts "URL:    ".colorize(color) + "#{notices[notice].url}"
                    puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
                end
                
            }
            page += 4
            
            puts
            puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
            puts "------------------------------------------      " + "Presione Enter para pasar a la siguiente pagina".colorize(:light_yellow) + "      ------------------------------------------"
            puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
            gets.chomp
            system("clear")
            break if (page > notices.length-1)
        end
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        puts "------------------------------------------      " + "Presiones cualquier tecla para regresar al menu".colorize(:light_yellow) + "      ------------------------------------------"
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
        get_keypressed   
        main_menu
    end

    def print_reddit()
        print_notices(@reddit,:light_cyan, "de Reddit.com  ")
    end

    def print_mashable()
        print_notices(@mashable, :yellow, "de Mashable.com")
    end

    def print_digg()
        print_notices(@digg, :blue, "de Digg.com    ")
    end

    def print_all()
        create_reddit(search_reddit())
        create_mashable(search_mashable())
        create_digg(search_digg())
        array = []
        array.concat(@reddit,@mashable,@digg)
        @all = array
        @all.sort!{|x,y|
            y.date <=> x.date
        }
        print_notices(@all, :green, "Por Fecha      ")
    end
    
end

my_reader = ReaderRss.new()
my_reader.main_menu


