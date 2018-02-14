class Keypress
	def get_keypressed
		system("stty raw -echo")
		t = STDIN.getc
		system("stty -raw echo")
		return t
	end
end


