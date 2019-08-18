# encoding:utf-8

BIG_PARA_LEFT = "\n{\n"

BIG_PARA_RIGHT = "\n}\n"

def gener_filter_file_by(function_name, must_vars, maybe_vars)
	
	File.open("./filter.txt","w") do |f|

		x = ""
		for i in must_vars do
			x += "self::$ajax['#{i}'],"
		end
		x[-1] = ""
		
		func_name = "static public function #{function_name}PostValid()"

		wait_write = func_name + BIG_PARA_LEFT + "if (!isset(#{x})) {\n    Common::setMsgAndCode('参数格式错误', ErrorCode::ErrorParam);\n}\n\n"
		
		for i in must_vars do
			wait_write += "self::$param['#{i}'] = #{i}Valid();\n\n"
		end

		for i in maybe_vars do
			wait_write += "if (isset(self::$ajax['#{i}'])) {\n    self::$param['#{i}'] = self::#{i}Valid();\n}\n"
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
			f.syswrite("protected static function #{i}Valid()\n{\n")
			f.syswrite("if () {\n    Common::setMsgAndCode('#{i} 参数值非法', ErrorCode::InvalidParam);\n}\n")
			f.syswrite("\nreturn ;\n}\n")
		end 

	end
end

def gener_api_json_by(must_vars, maybe_vars)

	File.open("./api_doc.json","w") do |f|

		f.syswrite("{\n")
		
		for i in must_vars do
			f.syswrite(%Q{"#{i}": ", 必填,",\n})
		end 


		for i in maybe_vars do
			f.syswrite(%Q{"#{i}": ", 选填,",\n})
		end 
		
		f.syswrite("}")

	end

end

print "請輸入函數類型（get、del、set、get）: "

function_name = ((gets.chomp).split)[0]

# print "\n請輸入必要參數（用空隔區分）: "

# must_vars = Array.new()

# must_vars = gets.split

# print "\n請輸入可選參數（用空隔區分）: "

# maybe_vars = Array.new()

# maybe_vars = gets.split

# gener_filter_file_by function_name, must_vars, maybe_vars

# gener_Filter_file_by must_vars, maybe_vars

# gener_api_json_by must_vars, maybe_vars