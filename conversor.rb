class RegNumConversor
    def to_cpf(number)
        rt_str = number.to_s
        if rt_str.match(/\d\d\d\d\d\d\d\d\d\d\d/) && rt_str.size == 11
            frag = rt_str.split(//)
            first_dig = frag[0] + frag[1] + frag[2]
            second_dig = frag[3] + frag[4] + frag[5]
            third_dig = frag[6] + frag[7] + frag[8]
            final_dig = frag[9] + frag[10]
            return "#{first_dig}.#{second_dig}.#{third_dig}-#{final_dig}"
        else
            raise "[ERROR] Invalid Parameter Passed, expecting only 'Numbers'"
        end
    end

    def to_cnpj(number)
        rt_str = number.to_s
        if rt_str.match(/\d\d\d\d\d\d\d\d\d\d\d\d\d/) && rt_str.size == 14
            frag = rt_str.split(//)
            first_dig = frag[0] + frag[1]
            second_dig = frag[2] + frag[3] + frag[4]
            third_dig = frag[5] + frag[6] + frag[7]
            fourth_dig = frag[8] + frag[9] + frag[10] + frag[11]
            final_dig = frag[12] + frag[13]
            return "#{first_dig}.#{second_dig}.#{third_dig}/#{fourth_dig}-#{final_dig}"
        else
            raise "[ERROR] Invalid Parameter Passed, expecting only 'Numbers'"
        end
    end


    def to_rg(number)
        rt_str = number.to_s
        if rt_str.match(/\d\d\d\d\d\d\d\d\w/) && rt_str.size == 9
            frag = rt_str.split(//)
            first_dig = frag[0] + frag[1]
            second_dig = frag[2] + frag[3] + frag[4]
            third_dig = frag[5] + frag[6] + frag[7]
            final_dig = frag[8].upcase
            return "#{first_dig}.#{second_dig}.#{third_dig}-#{final_dig}"
        else
            raise "[ERROR] Invalid Parameter Passed, expecting only 'Numbers' before last digit"
        end
    end

    def to_pis(number)
        rt_str = number.to_s
        if rt_str.match(/\d\d\d\d\d\d\d\d\d\d\d/) && rt_str.size == 11
            frag = rt_str.split(//)
            first_dig = frag[0] + frag[1] + frag[2]
            second_dig = frag[3] + frag[4] + frag[5] + frag[6] + frag[7]
            third_dig = frag[8] + frag[9]
            final_dig = frag[10]
            return "#{first_dig}.#{second_dig}.#{third_dig}-#{final_dig}"
        else
            raise "[ERROR] Invalid Parameter Passed, expecting only 'Numbers'"
        end
    end
end

=begin
conversor = RegNumConversor.new
print "RG: "
rg = gets.chomp.to_s

puts conversor.to_rg(rg)
=end