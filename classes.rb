class Pessoa
    attr_accessor :name, :surname, :age, :cpf, :rg
    def initialize(name, surname, age, cpf, rg)
        @name = name
        @surname = surname
        @age = age
        @cpf = cpf
        @rg = rg
    end
end

class Aluno < Pessoa;end

class Professor < Pessoa
    attr_accessor :discipline
end
    

