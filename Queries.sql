-- Parte 1 – Criando índices em Banco de Dados 

-- Criação de índices para consultas para o cenário de company com as perguntas (queries sql) para recuperação de informações. Sendo assim, dentro do script será criado os índices com base na consulta SQL.  

CREATE INDEX index_ssn_employee on employee (SSN) using hash;
CREATE INDEX index_dept_locations on dept_locations (dlocation) using hash;
CREATE INDEX index_pname_project on project (Pname) using hash;


-- Quais os dados mais relevantes no contexto 

-- Lembre-se da função do índice... ele impacta diretamente na velocidade da buca pelas informações no SGBD. Crie apenas aqueles que são importantes. Sendo assim, adicione um README dentro do repositório do Github explicando os motivos que o levaram a criar tais índices. Para que outras pessoas possam se espelhar em seu trabalho, crie uma breve descrição do projeto. 
-- Quais os dados mais acessados ?
-- tabela employee, ssn (criar índice), foi escolhido esse dado por ser a forma mais fácil de identificar o funcionário.
-- tabela dept_locations, Dlocation (criar índice), foi escolhido esse dado por ser um dado de localização.
-- tabela project, Pname (criar índice), foi escolhido esse dado pois identifica o nome do projeto.
 

-- Perguntas:  

-- Qual o departamento com maior número de pessoas? 
select dname, count(Dname) from departament, employee where Dnumber = Dno group by Dname limit 1;

-- Quais são os departamentos por cidade? 
select d.dname as departamento, c.dlocation as cidade from departament as d, dept_locations as c where d.Dnumber = c.Dnumber ;

-- Relação de empregrados por departamento 
select d.dname as departamento, concat(e.Fname," ",e.lname) as "nome completo" from departament d, employee e where d.Dnumber = e.Dno order by d.dname, e.Fname;
 
/*

Parte 2 - Utilização de procedures para manipulação de dados em Banco de Dados 

Objetivo:  

Criar uma procedure que possua as instruções de inserção, remoção e atualização de dados no banco de dados. As instruções devem estar dentro de estruturas condicionais (como CASE ou IF).  

Além das variáveis de recebimento das informações, a procedure deverá possuir uma variável de controle. Essa variável de controle irá determinar a ação a ser executada. Ex: opção 1 – select, 2 – update, 3 – delete. 

 
*/
delimiter \\
CREATE PROCEDURE manipulation_company(
	 opcao int
)
 BEGIN
		
	if opcao = 1 then  
		select "insert - comando para inserir na tabela";
	elseif opcao = 2 then
		select "update - comando para fazer alteração e ou atualização da tabela";
	elseif opcao = 3 then
		select "Delete - comando para excluir um registro da tabela ou para excluir a tabela ";
	else
		select "Opcão inválida";
    end if;
END; \\
delimiter ;

/*Comando para fazer a chamada para Procedure*/
call manipulation_company(1);

/*Comando para excluir a Procedure*/
drop procedure manipulation_company;

