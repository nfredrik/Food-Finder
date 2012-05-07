require 'restaurant'
class Guide
	
	class Config
		@@actions = [ 'list', 'find', 'add', 'quit']
		def self.actions; @@actions; end
	end
	
def initialize(path=nil)
	# Locatate rest text file 
	Restaurant.filepath = path
	if Restaurant.file_usable?
		puts "You have an existing restaurant file!"
	elsif Restaurant.create_file
		puts "We have created a new restaurant file!"
	else
		puts "Exiting. \n\n"
		exit!
	end
end
	
	def launch!
		introduction
		result = nil
		until result == :quit
			action = get_action
			result = do_action(action)
		end
		conclusion		
	end
	
	def get_action
		action = nil
		until	Guide::Config.actions.include?(action) 
			puts "Please choose one of the these actions: " + Guide::Config.actions.join(", ") if action
			print "> "
			user_response = gets.chomp
			action = user_response.downcase.strip
		end
			return action
	end
	
	
	def do_action(action)
		case action
		when 'list'
			puts 'listing...'
		when 'find'
			puts 'finding...'
		when 'add'
			add
		when 'quit'
			return :quit
		else
			puts "\n I don't understand that command. \n"
		end
	end
	
	def add
		puts "\n ADD A RESTAURANT \n"
		restaurant = Restaurant.build_using_questions
		if restaurant.save
			puts "\n Restaurant Added\n\n"
		else
			puts "\n Save Error: Restaurant not added. \n\n"
		end
	end
	
	def introduction
		puts "\n\n <<< Welcome to the food finder >>> \n\n" 
		puts "This is an interactive guide to help you get fat. \n\n"
	end
	
	def conclusion
		puts "\n<<< Goodbye and Bon Appetite! >>> \n\n\n"
	end
end


















