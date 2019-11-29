# encoding:utf-8
class Var_Class
	attr_reader :v_name, :v_type, :is_id
	def initialize(v_name, v_type)
		@v_name = v_name
		@v_type = v_type
		@is_id = does_name_have_id ? true : false
		@is_list = does_name_have_list ? true : false
	end

	def does_name_have_id ()
		if (@v_name =~ /(.*)id$/i)
			return true
		else
			return false
		end
	end

	def does_name_have_list ()
		if (@v_name =~ /(.*)list$/i)
			return true
		else
			return false
		end
	end

	def func_code
		return ""
	end
end

class Var_int < Var_Class
	def func_code
		code_str =  "protected static function #{@v_name}Valid()\n{\n"
		code_str += "    $#{@v_name} = self::Valid(self::$ajax['#{@v_name}'],);\n"
		code_str += "    if (!$#{@v_name}) {\n"
		code_str += "        Common::setMsgAndCode('#{@v_name} 参数值非法', ErrorCode::InvalidParam);\n"
		code_str += "    }\n"
		code_str += "    return $#{@v_name};\n"
		code_str += "}\n\n"
		return code_str
	end
end

class Var_str < Var_Class
	def func_code
		code_str =  "protected static function #{@v_name}Valid()\n{\n"
		code_str += "    $#{@v_name} = self::stringValid(self::$ajax['#{@v_name}'], , );\n"
		code_str += "    if (!$#{@v_name}) {\n"
		code_str += "        Common::setMsgAndCode('#{@v_name} 参数值非法', ErrorCode::InvalidParam);\n"
		code_str += "    }\n\n"
		code_str += "    return $#{@v_name};\n"
		code_str += "}\n\n"
		return code_str
	end
end

class Var_id < Var_Class
	def func_code
		code_str =  "protected static function #{@v_name}Valid($#{@v_name}, $bool=false)\n"
		code_str += "{\n"
		code_str += "    $filter = [];\n"
		code_str += "    $filter['#{@v_name}'] = $#{@v_name};\n"
		temp_name = @v_name.sub(/id/, '')
		code_str += "    $#{temp_name}M = new xxModel();\n"
		code_str += "    $#{temp_name} = $#{temp_name}M -> get($filter);\n"
		code_str += "    if (!$#{temp_name}) {\n"
		code_str += "        Common::setMsgAndCode('#{@v_name} 参数值非法', ErrorCode::InvalidParam);\n"
		code_str += "    }\n"
		code_str += "    if ($bool) {\n"
		code_str += "        return $#{temp_name};\n"
		code_str += "    }\n"
		code_str += "    return $#{@v_name};\n"
		code_str += "}\n\n"
		return code_str
	end
end

class Var_list < Var_Class
	def func_code
		code_str =  "protected static function #{@v_name}Valid()\n{\n"
		code_str += "    $#{@v_name} = self::$ajax['#{@v_name}'];\n"
		code_str += "    foreach ($#{@v_name} as $i) {\n"
		code_str += "        $t = self::Valid();\n"
		code_str += "    }\n"
		code_str += "    self::$param['#{@v_name}'] = $#{@v_name};\n"
		code_str += "}\n"
	end
end

class Var_Factory
	def Var_Factory.get_var (var_c)

		if var_c.is_id == true
			return Var_id.new var_c.v_name, var_c.v_type
		end

		if var_c.v_type == "int"
			return Var_int.new var_c.v_name, var_c.v_type
		elsif var_c.v_type == "str" || var_c.v_type == "string"
			return Var_str.new var_c.v_name, var_c.v_type
		else 
			p "#{var_c.v_name} no type"
			exit
		end

	end 
end

# v_name = "testi"

# if (v_name =~ /(.*)id/i)
# 	puts "ojbk"
# else
# 	puts "erro"
# end

# v = Var_Class.new('testid', 'int')
# puts v.v_name('another name')
# puts v.is_id
# v.v_name = "another name"
# # puts v.get_name

# a = "tetid"
# b = a.sub(/id/i,"")
# puts b

# puts a