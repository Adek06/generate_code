# encoding:utf-8
class Var_Class
	def initialize(v_name, v_type)
		@v_name = v_name
		@v_type = v_type
		@is_id = does_name_have_id ? true : false
	end

	def does_name_have_id ()
		if (@v_name =~ /(.*)id/i)
			return true
		else
			return false
		end
	end

	def is_id(*v)
		if v == []
			@is_id
		end
		@is_id = v
	end

	def v_name(*v)
		if v == []
			return @v_name
		end 
		@v_name = v
	end

	# def v_type(*v)
	# 	if v == []
	# 		return @v_type
	# 	end 
	# 	@v_type = v
	# end

	def v_type
		@v_type
	end

	def func_code
		return ""
	end
end

class Var_int < Var_Class
	def func_code
		code_str = "protected static function #{@v_name}Valid()\n{\n"
		code_str += "if () {\n    Common::setMsgAndCode('#{@v_name} 参数值非法', ErrorCode::InvalidParam);\n}\n"
		code_str += "\nreturn ;\n}\n"
	end
end

class Var_Factory
	def Var_Factory.get_var (var_c)
		print var_c.v_type
		if var_c.v_type == "int"
			return Var_int.new var_c.v_name, var_c.v_type
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
# puts v.get_name