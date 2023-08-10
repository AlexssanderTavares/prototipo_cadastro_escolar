require 'cpf_cnpj'
require 'mysql2'
require_relative "classes.rb"

module CAD
    DB = Mysql2::Client.new(
        :host => "localhost",
        :username => "root",
        :password => "7296",
        :database => "cadastro_escolar"
    )

    def rgConvert(x)
        if x.size == 9
            array = x.split(//)
            arr1 = array[0] + array[1]
            arr2 = array[2] + array[3] + array[4]
            arr3 = array[5] + array[6] + array[7]
            arr4 = array[8]
            rgFormat = arr1 + "." + arr2 + "." + arr3 + "-" + arr4
        else
            puts "Numero invalido"
        end
    end
    #cadastro alunos e professores
    def cadastrar_professor
        print "Digite o nome do Professor: "
        nome_professor = gets.chomp.to_s
        print "Digite o sobrenome do Professor: "
        sn_professor = gets.chomp.to_s
        print "Digite a idade do Professor: "
        idade_professor = gets.chomp.to_i
        print "Digite o CPF do Professor: "
        cpf_professor = gets.chomp.to_s
        cpf2 = CPF.new(cpf_professor)
        cpfProfessor = cpf2.formatted
        print "Digite o RG do Professor: "
        rg_professor = gets.chomp.to_s
        rgProfessor = rgConvert(rg_professor)
        print "Qual a disciplina do professor: "
        disciplina = gets.chop.to_s
        professor = Professor.new(nome_professor, sn_professor, idade_professor, cpfProfessor, rgProfessor)
        professor.discipline = disciplina
        puts "Novo Registro: |#{professor.name}|#{professor.surname}|#{professor.age}|#{professor.cpf}|#{professor.rg}|#{professor.discipline}|\n"

        register = DB.query("insert into professores(name_professor, surname_professor, age_professor, cpf_professor, rg_professor, discipline) values('#{professor.name}','#{professor.surname}',#{professor.age},'#{professor.cpf}','#{professor.rg}','#{professor.discipline}')")
    end
    
    def cadastrar_aluno
        _aluno = Aluno.new
        print "Digite o nome completo do Aluno: "
        nome_aluno = gets.chomp.to_s
        print "Digite a idade do Aluno: "
        idade_aluno = gets.chomp.to_i
        print "Digite o CPF do Aluno: "
        cpf_aluno = gets.chomp.to_s
        cpf1 = CPF.new(cpf_aluno)
        cpfAluno = cpf1.formatted
        print "Digite o RG do Aluno: "
        rg_aluno = gets.chomp.to_s
        @lista_alunos[@count1] = {numRegistro: @count1, nomeAluno: nome_aluno, idadeAluno: idade_aluno, cpfAluno: cpfAluno, rgAluno: rgConvert(rg_aluno)}
        _aluno.numRegistro = @lista_alunos[@count1][:numRegistro]
        _aluno.nomeAluno = @lista_alunos[@count1][:nomeAluno]
        _aluno.idadeAluno = @lista_alunos[@count1][:idadeAluno]
        _aluno.cpfAluno = @lista_alunos[@count1][:cpfAluno]
        _aluno.rgAluno = @lista_alunos[@count1][:rgAluno]
        @count1 +=1
    end
    #busca alunos e professores atraves de entrada de dados
    def busca_aluno
        loop do
            puts "Escolha uma das formas para buscar o Aluno na lista: "
            puts "
            1. Nome
            2. CPF
            3. RG
            4. Cancelar"
            print "Opção: "
            opcao = gets.chomp.to_i
            case opcao
            when 1
                print "Digite o nome do Aluno: "
                name = gets.chomp.to_s
                @lista_alunos.each do |names|
                    if names[:nomeAluno].downcase.include?(name.downcase)
                        puts "#{names[:numRegistro]} - #{names[:nomeAluno]} - #{names[:idadeAluno]} - #{names[:cpfAluno]} - #{names[:rgAluno]}"
                    end
                end
            when 2 
                print "Digite o CPF do Aluno: "
                codAluno = gets.chomp.to_s
                formatingCPF = CPF.new(codAluno)
                cpfs = formatingCPF.formatted
                @lista_alunos.each do |cpf|
                    if cpf[:cpfAluno].include?(cpfs)
                        puts "#{cpf[:numRegistro]} - #{cpf[:nomeAluno]} - #{cpf[:idadeAluno]} - #{cpf[:cpfAluno]} - #{cpf[:rgAluno]}"
                    end
                end
            when 3
                print "Digite o RG do Aluno: "
                src_rgs = gets.chomp.to_s
                rgs = rgConvert(src_rgs)
                @lista_alunos.each do |rg|
                    if rg[:rgAluno].include?(rgs)
                        puts "#{rg[:numRegistro]} - #{rg[:nomeAluno]} - #{rg[:idadeAluno]} - #{rg[:cpfAluno]} - #{rg[:rgAluno]}"
                    end
                end
            when 4
                break
            end
        end
    end
    
    def busca_professor
        loop do
            puts "Escolha uma das formas para buscar o Professor na lista: "
            puts "
            1. Nome
            2. CPF
            3. RG
            4. Cancelar"
            print "Opção: "
            opcao = gets.chomp.to_i
            case opcao
            when 1
                print "Digite o nome do Professor: "
                name = gets.chomp.to_s
                @lista_professores.each do |names|
                    if names[:nomeProfessor].downcase.include?(name.downcase)
                        puts "#{names[:numRegistro]} - #{names[:nomeProfessor]} - #{names[:idadeProfessor]} - #{names[:cpfProfessor]} - #{names[:rgProfessor]} - #{names[:disciplina]}"
                    end
                end
            when 2 
                print "Digite o CPF do Professor: "
                codProfessor = gets.chomp.to_s
                formatingCPF = CPF.new(codProfessor)
                cpf = formatingCPF.formatted
                @lista_professores.each do |cpfs|
                    if cpfs[:cpfProfessor].include?(cpf)
                        puts "#{cpfs[:numRegistro]} - #{cpfs[:nomeProfessor]} - #{cpfs[:idadeProfessor]} - #{cpfs[:cpfProfessor]} - #{cpfs[:rgProfessor]} - #{cpfs[:disciplina]}"
                    end
                end
            when 3
                print "Digite o RG do Professor: "
                rgs = gets.chomp.to_s
                @lista_Professores.each do |rg|
                    if rg[:rgProfessor].include?(rgs)
                        puts "#{rg[:numRegistro]} - #{rg[:nomeProfessor]} - #{rg[:idadeProfessor]} - #{rg[:cpfProfessor]} - #{rg[:rgProfessor]} - #{rg[:disciplina]}"
                    end
                end
            when 4
                break
            end
        end
    end
    #mostra listas de alunos e professores cadastrados
    def mostrar_alunos
        puts "Lista de alunos: \n"
        @lista_alunos.each do |profiles|
            puts "|Número Registro: #{profiles[:numRegistro]} |Nome: #{profiles[:nomeAluno]} |Idade: #{profiles[:idadeAluno]} |CPF: #{profiles[:cpfAluno]} |RG: #{profiles[:rgAluno]} |"
        end
    end

    def mostrar_professores
        puts "Lista de professores: \n"
        @lista_professores.each do |profiles|
        puts "|Número Registro: #{profiles[:numRegistro]} |Nome: #{profiles[:nomeProfessor]} |Idade: #{profiles[:idadeProfessor]} |CPF: #{profiles[:cpfProfessor]} |RG: #{profiles[:rgProfessor]} |Disciplina: #{profiles[:disciplina]}"
        end
    end
    #editar contato
    def editar_contato
        loop do
            puts "Escolha a lista onde o contato desejado se encontra: \n
            1. Lista de Alunos
            2. Lista de Professores
            3. Cancelar/Sair\n"
            print "Opção: "
            option = gets.chomp.to_i
            case option
            when 1
                mostrar_alunos
                print "Escolha um contato da lista através do seu número de registro: "
                option2 = gets.chomp.to_i
                @lista_alunos.each do |registro|
                    if registro[:numRegistro] == option2
                        puts "Qual campo deseja editar?\n
                        1. Nome
                        2. Idade
                        3. CPF
                        4. RG
                        5. Cancelar \n"
                        option3 = gets.chomp.to_i
                        case option3
                        when 1
                            print "Para editar o nome, basta digitá-lo e pressionar Enter (caso não queira alterar o nome, basta pressionar Enter): "
                            novo_nome = registro[:nomeAluno]
                            registro[:nomeAluno] = gets.chomp.to_s
                            registro[:nomeAluno] = registro[:nomeAluno].empty? ? novo_nome : registro[:nomeAluno]
                        when 2
                            print "Para editar a idade, basta digitá-lo e pressionar Enter (caso não queira alterar a idade, basta pressionar Enter): "
                            nova_idade = registro[:idadeAluno]
                            registro[:idadeAluno] = gets.chomp.to_s
                            registro[:idadeAluno] = registro[:idadeAluno].empty? ? nova_idade : registro[:idadeAluno]
                        when 3 
                            print "Para editar o CPF, basta digitá-lo e pressionar Enter (caso não queira alterar o CPF, basta pressionar Enter): "
                            novo_cpf = registro[:cpfAluno]
                            registro[:cpfAluno] = gets.chomp.to_s
                            altCPF = CPF.new(registro[:cpfAluno])
                            registro[:cpfAluno] = registro[:cpfAluno].empty? ? novo_cpf : altCPF.formatted
                        when 4
                            print "Para editar o RG, basta digitá-lo e pressionar Enter (caso não queira alterar o RG, basta pressionar Enter): "
                            novo_rg = registro[:rgAluno]
                            registro[:rgAluno] = gets.chomp.to_s
                            newRG = rgConvert(registro[:rgAluno])
                            registro[:rgAluno] = registro[:rgAluno].empty? ? novo_rg : newRG
                        when 5
                            break
                        end
                    end
                end
            when 2
                mostrar_professores
                print "Escolha um contato da lista através do seu número de registro: "
                option2 = gets.chomp.to_i
                @lista_professores.each do |registro|
                    if registro[:numRegistro] == option2
                        puts "Qual campo deseja editar? \n
                        1. Nome
                        2. Idade
                        3. Disciplina 
                        4. CPF
                        5. RG
                        6. Sair/Cancelar\n"
                        print "Opção: "
                        option3 = gets.chomp.to_i
                        case option3
                        when 1
                            print "Para editar o nome, basta digitá-lo e pressionar Enter (caso não queira alterar o nome, basta pressionar Enter): "
                            novo_nome = registro[:nomeProfessor]
                            registro[:nomeProfessor] = gets.chomp.to_s
                            registro[:nomeProfessor] = registro[:nomeProfessor].empty? ? novo_nome : registro[:nomeProfessor]
                        when 2
                            print "Para editar a idade, basta digitá-lo e pressionar Enter (caso não queira alterar a idade, basta pressionar Enter): "
                            nova_idade = registro[:idadeProfessor]
                            registro[:idadeProfessor] = gets.chomp.to_i
                            registro[:idadeProfessor] = registro[:idadeProfessor].empty? ? nova_idade : registro[:idadeProfessor]
                        when 3
                            print "Para editar o nome, basta digitá-lo e pressionar Enter (caso não queira alterar a disciplina, basta pressionar Enter): "
                            nova_disciplina = registro[:disciplina]
                            registro[:disciplina] = gets.chomp.to_s
                            registro[:disciplina] = registro[:disciplina].empty? ? nova_disciplina : registro[:disciplina]
                        when 4 
                            print "Para editar o CPF, basta digitá-lo e pressionar Enter (caso não queira alterar o CPF, basta pressionar Enter): "
                            novo_cpf = registro[:cpfProfessor]
                            registro[:cpfProfessor] = gets.chomp.to_s
                            altCPF = CPF.new(registro[:cpfProfessor])
                            registro[:cpfProfessor] = registro[:cpfProfessor].empty? ? novo_cpf : altCPF.formatted
                        when 5
                            print "Para editar o RG, basta digitá-lo e pressionar Enter (caso não queira alterar o RG, basta pressionar Enter): "
                            novo_rg = registro[:rgProfessor]
                            registro[:rgProfessor] = gets.chomp.to_s
                            newRG = rgConvert(registro[:rgProfessor])
                            registro[:rgProfessor] = registro[:rgProfessor].empty? ? novo_rg : newRG
                        when 6
                            break
                        end
                    end
                end
            when 3
                break
            end
        end
    end
    def menu
=begin
        @lista_alunos = []
        @lista_professores = []
        @count1 = 0
        @count2 = 0
=end
        loop do
            puts "Bem vindo ao CAD de Alunos e Professores, escolha uma das seguintes opções:\n\n"
            puts "1. Cadastrar Aluno"
            puts "2. Cadastrar Professor"
            puts "3. Mostrar Lista de alunos cadastrados"
            puts "4. Mostrar Lista de professores cadastrados"
            puts "5. Localizar Aluno cadastrado."
            puts "6. Localizar Professor cadastrado."
            puts "7. Editar contato"
            puts "8. Sair \n\n"
            print "Opção: "
            
            option = gets.chomp.to_i

            case option
            when 1
                cadastrar_aluno
            when 2
                cadastrar_professor
            when 3
                mostrar_alunos
            when 4
                mostrar_professores
            when 5
                busca_aluno
            when 6
                busca_professor
            when 7
                editar_contato
            when 8
                break
            else
                puts "Opção inválida!"
            end
        end
    end
end