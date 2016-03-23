require "localization_check/version"
require "colorize"

def check_within_directory(files)
	
	keys = Hash.new
	files.each do |file|
		f = File.open(file)
		contents = f.read
		f.close
		if ! contents.valid_encoding?
		  contents = contents.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
		end
		lines = contents.split(";")
		lines.each do |line|
			lineArray = line.split("=")
			if lineArray.count == 2 
				key = /\".+\"/.match(lineArray[0]).to_s
				key[0] = ''
				if key.length > 1
					key[key.length-1] = ''
					
					if keys[key].nil?
						keys[key] = []
					end
					keys[key].push(file)
				end
			end
		end
	end
	
	keys.each do |key, value|
		if value.uniq.count != files.uniq.count
			missing_names = []
			files.each do |file1|
				found = false
				value.each do |file2|
					if file1 == file2
						found = true
						break;
					end
				end
				if !found
					missing_names.push(file1)			
				end
			end
			puts "no locale for key '#{key}' in #{missing_names}".red
		end
		
		value.detect do |k|
		if value.count(k) > 1 
			puts "duplicate locale for key '#{key}' in #{k}".red
		end
	end

	end
end

def check_localizations

	files = Dir.glob("**/Localizable.strings")
	
	by_parent_directory = Hash.new

	files.each do |file|
		dir = File.dirname(file)
		top_dir = File.dirname(dir)
		if by_parent_directory[top_dir].nil?
			by_parent_directory[top_dir] = []
		end
		by_parent_directory[top_dir].push(file)
	end
	
	by_parent_directory.each {|key, value| check_within_directory(value) }
	

end