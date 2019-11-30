#encoding:utf-8

# file_name = "jointsale attention"

def gener_file_by file_name, module_folder, content=""
    begin
        if content == ""
            File.open("./#{module_folder}/#{file_name}.php","w") do |f|
                f.syswrite("")
            end
        else
            if file_name.kind_of?(Array)
                temp_name = ""
                for i in file_name do
                    temp_name += upper_first_alphabet i
                end
                file_name = upper_first_alphabet temp_name.downcase
                class_name = temp_name.sub(/Filter$/, '')
            else
                class_name = file_name
            end
            File.open("./#{module_folder}/#{file_name}.php","w") do |f|
                f.syswrite(content.gsub!(/(\#\{.*?\})/) {|word| class_name })
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

print "請輸入模块名字： "

file_name = gets.chomp()

file_name = file_name.split(" ")

temp_name = ""
for i in file_name do
    temp_name += upper_first_alphabet i
end

gener_file_by temp_name, "Filter", cFilter_model

gener_file_by temp_name, "models", model_model

gener_file_by file_name, "module", controller_model

file_name << "filter"
gener_file_by file_name, "module", filter_model
