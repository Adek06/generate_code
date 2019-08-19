# encoding:utf-8
class Func_Class
    def Func_Class.set_function(func_name, must_vars, maybe_vars)
        code_str = ""
        id_var = must_vars[0]
        temp_name = id_var.v_name.sub(/[()]id/, '')
        code_str += "#{temp_name} = #{id_var.v_name}Valid(self::$ajax[#{id_var.v_name}], true);\n\n"
        
        for i in maybe_vars do
            code_str += "if (isset(self::$ajax['#{i.v_name}'])) {\n"
            code_str += "    $#{i.v_name} = self::#{i.v_name}Valid();\n"
            code_str += "    if ($#{temp_name}['#{i.v_name}'] == $#{i.v_name}) {\n"
            code_str += "        Common::setMsgAndCode('#{i.v_name} 参数值错误', ErrorCode::InvalidParam);\n"
            code_str += "    }\n\n"
            code_str += "    self::$param['#{i.v_name}'] = $#{i.v_name};\n"
            code_str += "}\n\n"
        end

        code_str += "if (count(self::$param) === 0) {\n"
        code_str += "    Common::setMsgAndCode('没有任何修改', ErrorCode::BadParam);\n"
        code_str += "}\n"

        code_str += "self::$param['#{id_var.v_name}'] = $#{temp_name}['#{id_var.v_name}'];"

        code_str += "\nreturn ;\n"

        code_str += BIG_PARA_RIGHT
        return code_str
    end

    def Func_Class.get_function(func_name, must_vars, maybe_vars)
        code_str = ""
        for i in must_vars do
            if i.is_id
                code_str += "self::$param['#{i.v_name}'] = #{i.v_name}Valid(self::$ajax['#{i.v_name}'], false);\n\n"
            else 
                code_str += "self::$param['#{i.v_name}'] = #{i.v_name}Valid();\n\n"
            end
        end

        for i in maybe_vars do
            if i.is_id
                code_str += "if (isset(self::$ajax['#{i.v_name}'])) {\n    self::$param['#{i.v_name}'] = self::#{i.v_name}Valid(self::$ajax['#{i.v_name}'], false);\n}\n"
            else 
                code_str += "if (isset(self::$ajax['#{i.v_name}'])) {\n    self::$param['#{i.v_name}'] = self::#{i.v_name}Valid();\n}\n"
            end
        end

        code_str += "\nreturn ;\n\n"

        code_str += "}\n"
    end
end