class Restaurant

        # TODO: Lyfta ut fileops for att vara agnostics?
	@@filepath = nil
	def self.filepath= (path=nil)
		@@filepath = File.join(APP_ROOT, path)
	end
	
	attr_accessor :name, :cuisine, :price

        # TODO: kolla p? exist forst, behovs det forsta?
 	
	def self.file_exists?
		if @@filepath && File.exists?(@@filepath)
			return true
		else
			return false
		end
	end

	def self.file_usable?
		return false unless @@filepath
		return false unless File.exists?(@@filepath)
		return false unless File.readable?(@@filepath)
		return false unless File.writable?(@@filepath)
		return true
	end

	def self.create_file
		File.open(@@filepath, 'w') unless file_exists?
		return file_usable?
	end

	def self.saved_restaurants
		restaurants = []
		if file_usable?
			file = File.new(@@filepath, 'r')
			file.each_line do |line|
				
                                #TODO: smart skapa ett object for varje json, kanske gar att losa med json/openstruct?
				restaurants << Restaurant.new.import_line(line.chomp)
			end
			file.close
		end
		return restaurants
	end

        # TODO: defaults

	def initialize(args={})
		@name    = args[:name] || ""
		@cuisine = args[:cuisine] || ""
		@price   = args[:price] || ""
	end

        # TODO: lasa in json
	def import_line(line)
		line_array = line.split("\t")
		@name, @cuisine, @price = line_array
		return self
	end

	def self.build_using_questions
		args = {}
		
		print "Restaurant name: "
		args[:name] = gets.chomp.strip
		
		print "Cuisine type: "
		args[:cuisine] = gets.chomp.strip
		
		print "Average price: "
		args[:price] = gets.chomp.strip		

		return self.new(args)
	end

	def save
		return false unless Restaurant.file_usable?
		File.open(@@filepath, 'a') do |file|
			file.puts "#{[@name, @cuisine, @price].join("\t")}\n"
		end
		return true
	end
	
end
