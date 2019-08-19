# encoding:utf-8

BIG_PARA_LEFT = "\n{\n"

BIG_PARA_RIGHT = "\n}\n"

require_relative "test_class.rb"

def gener_filter_file_by(function_name, must_vars, maybe_vars)
	
	File.open("./filter.txt","w") do |f|

		x = ""
		for i in must_vars do
			x += "self::$ajax['#{i.v_name}'],"
		end
		x[-1] = ""
		
		func_name = "static public function #{function_name}PostValid()"

		wait_write = func_name + BIG_PARA_LEFT + "if (!isset(#{x})) {\n    Common::setMsgAndCode('参数格式错误', ErrorCode::ErrorParam);\n}\n\n"
		
		for i in must_vars do
			wait_write += "self::$param['#{i.v_name}'] = #{i.v_name}Valid();\n\n"
		end

		for i in maybe_vars do
			wait_write += "if (isset(self::$ajax['#{i.v_name}'])) {\n    self::$param['#{i.v_name}'] = self::#{i.v_name}Valid();\n}\n"
		end

		wait_write += "\n\nreturn ;"

		wait_write += BIG_PARA_RIGHT

		f.syswrite(wait_write)

	end
end

def gener_Filter_file_by(must_vars, maybe_vars)

	File.open("./filter_parent.txt", "w") do |f|

		temp_array = must_vars + maybe_vars

		for i in temp_array do
			var_c = Var_Factory.get_var i
			f.syswrite(var_c.func_code)
		end 

	end
end

def gener_api_json_by(must_vars, maybe_vars)

	File.open("./api_doc.json","w") do |f|

		f.syswrite("{\n")
		
		for i in must_vars do
			f.syswrite(%Q{"#{i.v_name}": "#{i.v_type}, 必填,",\n})
		end 


		for i in maybe_vars do
			f.syswrite(%Q{"#{i.v_name}": "#{i.v_type}, 选填,",\n})
		end 
		
		f.syswrite("}")

	end

end

print "請輸入函數類型（get、del、set、get）: "

# function_name = ((gets.chomp).split)[0]

function_name = 'get'

print "請輸入必要參數，名字在前，类型在后，中间空隔隔开（变量之间用,區分）： "

# must_vars = gets.chomp.split(',')

must_vars = ['bi int']

must_array = []
for i in must_vars do
	must_array.push(i.split())
end

must_objects = []
for i in must_array do
	must_objects.push(Var_Class.new(i[0],i[1]))
end

print(must_objects)

print "請輸入可选參數，名字在前，类型在后，中间空隔隔开（变量之间用,區分）： "

# maybe_vars = gets.chomp.split(',')

maybe_vars = ['li int']

maybe_array = []
for i in maybe_vars do
	maybe_array.push(i.split())
end

maybe_objects = []
for i in maybe_array do
	maybe_objects.push(Var_Class.new(i[0],i[1]))
end

print(maybe_objects)

gener_filter_file_by function_name, must_objects, maybe_objects

gener_Filter_file_by must_objects, maybe_objects

gener_api_json_by must_objects, maybe_objects

# print "\n請輸入必要參數（用空隔區分）: "

# must_vars = Array.new()

# must_vars = gets.split

# print "\n請輸入可選參數（用空隔區分）: "

# maybe_vars = Array.new()

# maybe_vars = gets.split

# gener_filter_file_by function_name, must_vars, maybe_vars

# gener_Filter_file_by must_vars, maybe_vars

# gener_api_json_by must_vars, maybe_vars