# encoding:utf-8

require_relative "var_class.rb"
require_relative "func_class.rb"

def gener_filter_file_by(function_name, must_vars, maybe_vars)

	func_name = "static public function #{function_name}PostValid()"
	
	File.open("./filter.txt","w") do |f|

		x = ""
		if must_vars != []
			for i in must_vars do
				x += "self::$ajax['#{i.v_name}'], "
			end
			x[-2] = ""
			x[-1] = ""
		end

		code_str = ""
		code_str += func_name 
		code_str += "\n{\n" 
		code_str += "if (!isset(#{x})) {\n"
		code_str += "    Common::setMsgAndCode('参数格式错误', ErrorCode::ErrorParam);\n"
		code_str += "}\n\n"

		if function_name == 'set'
			code_str += Func_Class.set_function(function_name, must_vars, maybe_vars)
		elsif function_name == 'add'
			code_str += Func_Class.add_function(function_name, must_vars, maybe_vars)
		elsif function_name == 'del'
			code_str += Func_Class.del_function(function_name, must_vars, maybe_vars)
		elsif function_name == 'get'
			code_str += Func_Class.get_function(function_name, must_vars, maybe_vars)
		elsif function_name == 'list'
			code_str += Func_Class.list_function(function_name, must_vars, maybe_vars)
		end
		f.syswrite(code_str)
	end
end

def gener_Filter_file_by(must_vars, maybe_vars)

	File.open("./filter_parent.txt", "w") do |f|

		temp_array = must_vars + maybe_vars
		code_str = ""
		for i in temp_array do
			var_c = Var_Factory.get_var i
			code_str += var_c.func_code
		end 
		f.syswrite(code_str)
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

def main(fucntion_name,must_vars="",maybe_vars="", m="")
	must_array = []
	for i in must_vars do
		must_array.push(i.split())
	end

	must_objects = []
	for i in must_array do
		must_objects.push(Var_Class.new(i[0],i[1]))
	end

	maybe_array = []
	for i in maybe_vars do
		maybe_array.push(i.split())
	end

	maybe_objects = []
	for i in maybe_array do
		maybe_objects.push(Var_Class.new(i[0],i[1]))
	end

	if m == "filter" 
		gener_filter_file_by function_name, must_objects, maybe_objects
	elsif m == "Filter"
		gener_Filter_file_by must_objects, maybe_objects
	else 
		gener_api_json_by must_objects, maybe_objects
	end
end
# print "請輸入函數類型（add、del、set、get、list）: "

# function_name = ((gets.chomp).split)[0]
# function_name = 'get'

# print "請輸入必要參數，名字在前，类型在后，中间空隔隔开（变量之间用,區分）： "

# must_vars = gets.chomp.split(',')
# must_vars = ['biid int']



# print "請輸入可选參數，名字在前，类型在后，中间空隔隔开（变量之间用,區分）： "

# maybe_vars = gets.chomp.split(',')
# maybe_vars = ['li int', 'st str']



# print "\n請輸入必要參數（用空隔區分）: "

# must_vars = Array.new()

# must_vars = gets.split

# print "\n請輸入可選參數（用空隔區分）: "

# maybe_vars = Array.new()

# maybe_vars = gets.split

# gener_filter_file_by function_name, must_vars, maybe_vars

# gener_Filter_file_by must_vars, maybe_vars

# gener_api_json_by must_vars, maybe_vars