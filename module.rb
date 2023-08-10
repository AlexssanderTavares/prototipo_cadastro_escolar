require 'cpf_cnpj'
require 'mysql2'
require_relative "classes.rb"
require_relative "conversor.rb"

module CAD
    DB = Mysql2::Client.new(
        :host => "localhost",
        :username => "",
        :password => "",
        :database => "cadastro_escolar"
    )
    CONVERSOR = RegNumConversor.new
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
        rgProfessor = CONVERSOR.to_rg(rg_professor)
        print "Qual a disciplina do professor: "
        disciplina = gets.chop.to_s
        professor = Professor.new(nome_professor, sn_professor, idade_professor, cpfProfessor, rgProfessor)
        professor.discipline = disciplina
        puts "Novo Registro de Professor! \n|Nome: #{professor.name}|Sobrenome: #{professor.surname}|Idade: #{professor.age}|CPF: #{professor.cpf}|RG: #{professor.rg}|Disciplina: #{professor.discipline}|\n"

        register = DB.query("insert into professores(name_professor, surname_professor, age_professor, cpf_professor, rg_professor, discipline) values('#{professor.name}','#{professor.surname}',#{professor.age},'#{professor.cpf}','#{professor.rg}','#{professor.discipline}')")
    end
    
    def cadastrar_aluno
        print "Digite o nome do Aluno: "
        nome_aluno = gets.chomp.to_s
        print "Digite o sobrenome do Aluno: "
        sn_aluno = gets.chomp.to_s
        print "Digite a idade do Aluno: "
        idade_aluno = gets.chomp.to_i
        print "Digite o CPF do Aluno: "
        cpf_aluno = gets.chomp.to_s
        cpf1 = CPF.new(cpf_aluno)
        cpfAluno = cpf1.formatted
        print "Digite o RG do Aluno: "
        rg_aluno = gets.chomp.to_s
        rgAluno = CONVERSOR.to_rg(rg_aluno)
        aluno = Aluno.new(nome_aluno, sn_aluno, idade_aluno, cpfAluno, rgAluno)
        puts "Novo Registro de Aluno! \n|Nome: #{aluno.name}|Sobrenome: #{aluno.surname}|Idade: #{aluno.age}|CPF: #{aluno.cpf}|RG: #{aluno.rg}|"

        register = DB.query("insert into alunos(name_aluno, surname_aluno, age_aluno, cpf_aluno, rg_aluno) values('#{aluno.name}','#{aluno.surname}',#{aluno.age},'#{aluno.cpf}','#{aluno.rg}')")
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
                rws = DB.query("select * from alunos where name_aluno = '#{name.capitalize}'").each do |rows|
                    puts "|ID: #{rows["id_aluno"]}|NOME: #{rows["name_aluno"]}|SOBRENOME:#{rows["surname_aluno"]}|IDADE:#{rows["age_aluno"]}|CPF:#{rows["cpf_aluno"]}|RG:#{rows["rg_aluno"]}|"
                end
            when 2 
                print "Digite o CPF do Aluno: "
                codAluno = gets.chomp.to_s
                formatingCPF = CPF.new(codAluno)
                cpfs = formatingCPF.formatted
                rws = DB.query("select * from alunos where cpf_aluno = '#{cpfs}'").each do |rows|
                    puts "|ID: #{rows["id_aluno"]}|NOME: #{rows["name_aluno"]}|SOBRENOME:#{rows["surname_aluno"]}|IDADE:#{rows["age_aluno"]}|CPF:#{rows["cpf_aluno"]}|RG:#{rows["rg_aluno"]}|"
                end
            when 3
                print "Digite o RG do Aluno: "
                src_rgs = gets.chomp.to_s
                rgs = CONVERSOR.to_rg(src_rgs)
                rws = DB.query("select * from alunos where rg_aluno = '#{rgs}'").each do |rows|
                    puts "|ID: #{rows["id_aluno"]}|NOME: #{rows["name_aluno"]}|SOBRENOME:#{rows["surname_aluno"]}|IDADE:#{rows["age_aluno"]}|CPF:#{rows["cpf_aluno"]}|RG:#{rows["rg_aluno"]}|"
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
                rws = DB.query("select * from alunos where name_professor = '#{name.capitalize}'").each do |rows|
                    puts "|ID: #{rows["id_professor"]}|NOME: #{rows["name_professor"]}|SOBRENOME:#{rows["surname_professor"]}|IDADE:#{rows["age_professor"]}|CPF:#{rows["cpf_professor"]}|RG:#{rows["rg_professor"]}|DISCIPLINA: #{rows["discipline"]}|"
                end
            when 2 
                print "Digite o CPF do Professor: "
                codProfessor = gets.chomp.to_s
                formatingCPF = CPF.new(codProfessor)
                cpfs = formatingCPF.formatted
                rws = DB.query("select * from alunos where cpf_professor = '#{cpfs}'").each do |rows|
                    puts "|ID: #{rows["id_professor"]}|NOME: #{rows["name_professor"]}|SOBRENOME:#{rows["surname_professor"]}|IDADE:#{rows["age_professor"]}|CPF:#{rows["cpf_professor"]}|RG:#{rows["rg_professor"]}|DISCIPLINA: #{rows["discipline"]}|"
                end
            when 3
                print "Digite o RG do Professor: "
                src_rgs = gets.chomp.to_s
                rgs = CONVERSOR.to_rg(src_rgs)
                rws = DB.query("select * from alunos where rg_professor = '#{rgs}'").each do |rows|
                    puts "|ID: #{rows["id_professor"]}|NOME: #{rows["name_professor"]}|SOBRENOME:#{rows["surname_professor"]}|IDADE:#{rows["age_professor"]}|CPF:#{rows["cpf_professor"]}|RG:#{rows["rg_professor"]}|DISCIPLINA: #{rows["discipline"]}|"
                end
            when 4
                break
            end
        end
    end
    #mostra listas de alunos e professores cadastrados
    def mostrar_alunos
        puts "Lista de alunos: \n\n"
        rws = DB.query("select * from alunos").each do |rows|
            puts "|ID: #{rows["id_aluno"]}|NOME: #{rows["name_aluno"]}|SOBRENOME: #{rows["surname_aluno"]}|IDADE: #{rows["age_aluno"]}|CPF: #{rows["cpf_aluno"]}|RG: #{rows["rg_aluno"]}|"
        end
    end

    def mostrar_professores
        puts "Lista de professores: \n\n"
        rws = DB.query("select * from professores").each do |rows|
            puts "|ID: #{rows["id_professor"]}|NOME: #{rows["name_professor"]}|SOBRENOME: #{rows["surname_professor"]}|IDADE: #{rows["age_professor"]}|CPF: #{rows["cpf_professor"]}|RG: #{rows["rg_professor"]}|DISCIPLINA: #{rows["discipline"]}|"
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
                id = gets.chomp.to_i
                puts "Qual campo deseja editar?\n
                1. Nome
                2. Idade
                3. CPF
                4. RG
                5. Cancelar/Sair \n"
                option3 = gets.chomp.to_i
                case option3
                when 1
                    print "Para editar o nome, basta digitá-lo e pressionar Enter (caso não queira alterar o nome, basta pressionar Enter): "
                    nome = gets.chomp.to_s
                    novo_registro = nome.empty? ? nil : nome.capitalize
                    novo_nome = novo_registro
                    rw = DB.query("update alunos set name_aluno = '#{novo_nome}' where id_aluno = #{id}")
                when 2
                    print "Para editar a idade, basta digitá-lo e pressionar Enter (caso não queira alterar a idade, basta pressionar Enter): "
                    idade = gets.chomp.to_i
                    novo_registro = idade.to_s.empty? ? nil : idade
                    nova_idade = novo_registro
                    rw = DB.query("update alunos set age_aluno = #{nova_idade.to_i} where id_aluno = #{id}")
                when 3 
                    print "Para editar o CPF, basta digitá-lo e pressionar Enter (caso não queira alterar o CPF, basta pressionar Enter): "
                    cpf = gets.chomp.to_i
                    altCPF = CPF.new(cpf)
                    novo_registro = cpf.to_s.empty? ? cpf : altCPF.formatted
                    novo_cpf = novo_registro
                    rw = DB.query("update alunos set cpf_aluno = '#{novo_cpf}' where id_aluno = #{id}")
                when 4
                    print "Para editar o RG, basta digitá-lo e pressionar Enter (caso não queira alterar o RG, basta pressionar Enter): "
                    rg = gets.chomp.to_s
                    altRG = CONVERSOR.to_rg(rg)
                    novo_registro = rg.empty? ?  rg : altRG
                    novo_rg = novo_registro
                    rw = DB.query("update alunos set rg_aluno = '#{novo_rg}' where id_aluno = #{id}")
                when 5
                    break
                end
            when 2
                mostrar_professores
                print "Escolha um contato da lista através do seu número de registro: "
                id = gets.chomp.to_i
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
                    nome = gets.chomp.to_s
                    novo_registro = nome.empty? ? nil : nome.capitalize
                    novo_nome = novo_registro
                    rw = DB.query("update alunos set name_professor = '#{novo_nome}' where id_professor = #{id}")
                when 2
                    print "Para editar a idade, basta digitá-lo e pressionar Enter (caso não queira alterar a idade, basta pressionar Enter): "
                    idade = gets.chomp.to_i
                    novo_registro = idade.to_s.empty? ? nil : idade
                    nova_idade = novo_registro
                    rw = DB.query("update alunos set age_professor = #{nova_idade.to_i} where id_professor = #{id}")
                when 3
                    print "Para editar o nome, basta digitá-lo e pressionar Enter (caso não queira alterar a disciplina, basta pressionar Enter): "
                    disciplina = gets.chomp.to_s
                    novo_registro = disciplina.empty? ? nil : disciplina.capitalize
                    nova_disciplina = novo_registro
                    rw = DB.query("update alunos set discipline = '#{nova_disciplina}' where id_professor = #{id}")
                when 4 
                    print "Para editar o CPF, basta digitá-lo e pressionar Enter (caso não queira alterar o CPF, basta pressionar Enter): "
                    cpf = gets.chomp.to_i
                    altCPF = CPF.new(cpf)
                    novo_registro = cpf.to_s.empty? ? cpf : altCPF.formatted
                    novo_cpf = novo_registro
                    rw = DB.query("update alunos set cpf_professor = '#{novo_cpf}' where id_professor = #{id}")
                when 5
                    print "Para editar o RG, basta digitá-lo e pressionar Enter (caso não queira alterar o RG, basta pressionar Enter): "
                    rg = gets.chomp.to_s
                    altRG = CONVERSOR.to_rg(rg)
                    novo_registro = rg.empty? ?  rg : altRG
                    novo_rg = novo_registro
                    rw = DB.query("update alunos set rg_professor = '#{novo_rg}' where id_professor = #{id}")
                when 6
                    break
                end
            when 3
                break
            end
        end
    end
    def menu
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
                puts "Opção inválida!\n"
            end
        end
    end
end