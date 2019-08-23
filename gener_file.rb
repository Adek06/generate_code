#encoding:utf-8

print "請輸入模块名字： "

file_name = gets.chomp()

# file_name = "jointsale attention"

def gener_file_by file_name, module_folder, content=""
    begin
        if content == ""
            File.open("./#{module_folder}/#{file_name}.php","w") do |f|
                f.syswrite("")
            end
        else
            File.open("./#{module_folder}/#{file_name}.php","w") do |f|
                f.syswrite(content.gsub!(/(\#\{.*?\})/) {|word| file_name })
            end
        end
    rescue => exception
        #puts exception
        Dir.mkdir("./#{module_folder}")
        retry
    end
    puts "生成了 #{file_name}.php"
end

def upper_first_alphabet word
    word = word.sub(/\b(\w)/) {|word| word.upcase }
    return word
end

model_model = ""
arr = IO.readlines("./model_model.txt")
for i in arr do
    model_model += i
end

cFilter_model = ""
arr = IO.readlines("./cFilter_model.txt")
for i in arr do
    cFilter_model += i
end

controller_model = ""
arr = IO.readlines("./controller_model.txt")
for i in arr do
    controller_model += i
end

filter_model = ""
arr = IO.readlines("./filter_model.txt")
for i in arr do
    filter_model += i
end

file_name = file_name.split(" ")

temp_name = ""
for i in file_name do
    temp_name += upper_first_alphabet i
end

gener_file_by temp_name, "Filter", cFilter_model

gener_file_by temp_name, "models", model_model

temp_name = ""
for i in file_name do
    temp_name += i
end
temp_name = upper_first_alphabet temp_name

gener_file_by temp_name, "module", controller_model

gener_file_by temp_name+"filter", "module", filter_model
