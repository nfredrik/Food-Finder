require 'restaurant'
class Guide
	
	def initialize(path=nil)
		# Locatate rest text file 
		Restaurant.filepath = path
		if Restaurant.file_exists?
			puts "Found file"
		elsif Restaurant.create_file
			puts "Created file"
		else
			puts "Exiting. \n\n"
			exit!
		end
	end
	
	def launch!
		introduction
		# action loops
		#  what do you want to do? - list, find, add, quit
		#  do the action
		# repeate until user quits
		conclusion
	end
	
	def introduction
		puts "\n\n <<< Welcome to the food finder >>> \n\n" 
		puts "This is an interactive guide to help you get fat. \n\n"
	end
	
	def conclusion
		puts "\n<<< Goodbye and Bon Appetite! >>> \n\n\n"
	end
end