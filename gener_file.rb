#encoding:utf-8

print "請輸入模块名字： "

# file_name = gets.chomp()

file_name = "jointsale attention"

def gener_file_by file_name, module_folder
    begin
        File.open("./#{module_folder}/#{file_name}.php","w") do |f|
            f.syswrite("")
        end
    rescue => exception
        puts exception
        Dir.mkdir("./#{module_folder}")
        retry
    end
end

def upper_first_alphabet word
    word = word.sub(/\b(\w)/) {|word| word.upcase }
    return word
end

file_name = file_name.split(" ")

temp_name = ""
for i in file_name do
    temp_name += upper_first_alphabet i
end
gener_file_by temp_name, "Filter"

gener_file_by temp_name, "models"

temp_name = ""
for i in file_name do
    temp_name += i
end
puts temp_name
temp_name = upper_first_alphabet temp_name
gener_file_by temp_name, "module"

gener_file_by temp_name+ "filter","module"
