# encoding:utf-8

print "請輸入函數類型（get、del、set、get）: "

function_name = ((gets.chomp).split)[0]

print "\n請輸入必要參數（用空隔區分）: "

must_vars = Array.new()

must_vars = gets.split

print "\n請輸入可選參數（用空隔區分）: "

maybe_vars = Array.new()

maybe_vars = gets.split



File.open("./filter.txt","w") do |f|

	x = ""
	for i in must_vars do
		x += "self::$ajax['#{i}'],"
	end
	x[-1] = ""
	
	f.syswrite("static public function #{function_name}PostValid()\n{\n")

	f.syswrite("if (!isset(#{x})) {\n    Common::setMsgAndCode('参数格式错误', ErrorCode::ErrorParam);\n}\n\n")
	
	for i in must_vars do
		f.syswrite("self::$param['#{i}'] = #{i}Valid();\n\n")
	end

	for i in maybe_vars do
		f.syswrite("if (isset(self::$ajax['#{i}'])) {\n    self::$param['#{i}'] = self::#{i}Valid();\n}\n")
	end

	f.syswrite("\n\nreturn ;\n}")

end

File.open("./filter_parent.txt", "w") do |f|

	temp_array = must_vars + maybe_vars

	for i in temp_array do
		f.syswrite("protected static function #{i}Valid()\n{\nif () {\nCommon::setMsgAndCode('#{i} 参数值非法', ErrorCode::InvalidParam);\n}\n return ;}\n")
	end 

end

File.open("./api_doc.json","w") do |f|

	temp_array = must_vars + maybe_vars

	f.syswrite("{\n")
	
	for i in must_vars do
		f.syswrite(%Q{"#{i}": ", 必填,",\n})
	end 


	for i in maybe_vars do
		f.syswrite(%Q{"#{i}": ", 选填,",\n})
	end 
	
	f.syswrite("}")

end


# protected static function imgValid()
#     {
#         $img = self::stringValid(self::$ajax['img'], 1, 1000);
#         if (!$img) {
#             Common::setMsgAndCode('img参数值非法', ErrorCode::InvalidParam);
#         }

#         return $img;
#     }
