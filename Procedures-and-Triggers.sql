show databases;
use company;

/*Quantidade de funcionários por departamento*/
create view view_funcionario_por_departamento as
select count(e.ssn) as "Quantidade de Funcionários",d.dname as Departamento  from employee as e, departament as d where e.dno = d.dnumber group by d.dname;

select * from view_funcionario_por_departamento;

/*Lista de departamentos e seus gerentes*/
create view view_departamento_e_gerentes as
Select d.dname as Departamento, concat(e.Fname," ",e.Lname) as "Gerente do Departamento"  from employee as e, departament as d where d.mgr_ssn = e.ssn;

select * from view_departamento_e_gerentes;

/*Projetos com maior número de empregados*/
create view view_projetos_mais_empregados as
select p.pname as "Nome Projeto", count(e.ssn) as "Quantidade funcionários" from employee as e, project as p where e.dno  = p.dnum  group by p.pname;

select * from view_projetos_mais_empregados;

/*Lista de projetos, departamentos e gerentes*/
create view view_projetos_departamentos_gerentes as
select pname as Projeto, dname as Departamento, concat(fname," ",lname) as Gerente from departament 
	inner join employee on ssn = mgr_ssn
    inner join project on dnumber = dnum;
    
select * from view_projetos_departamentos_gerentes;

/*Quais empregados possuem dependentes e se são gerentes*/
create view view_dependents_se_gerentes as
select concat(fname," ",lname) "Nome do funcionário" ,dependent_name "Nome do dependente", if( ssn = mgr_ssn , "sim","não") as Gerente, dname as Departamento
		from employee 
        inner join dependent on ssn = essn
        inner join departament on dno = dnumber;
        
select * from view_dependents_se_gerentes;

/*Criando novos usuários*/
create user "usuarioAdm"@localhost identified by "123";
create user "usuarioRH"@localhost identified by "123";
create user "usuarioX"@localhost identified by "123";
create user "usuarioY"@localhost identified by "123";
create user "usuarioZ"@localhost identified by "123";

/*Atribuindo privilégios*/
grant all privileges on company.* to "usuarioAdm"@localhost;/** não consegui fazer*/
grant all privileges on company.view_funcionario_por_departamento to "usuarioRH"@localhost;
grant all privileges on company.view_projetos_departamentos_gerentes to "usuarioX"@localhost;
grant all privileges on company.view_projetos_mais_empregados to "usuarioY"@localhost;
grant all privileges on company.view_dependents_se_gerentes to "usuarioZ"@localhost;

/*Para que as mudanças tenham efeito imediatamente*/
flush privileges; 

/*Verificando os privilégios*/
show grants for "usuarioX"@localhost;

/*Trigger para verificar se o endereço está nulo*/
# Criar triggers de inserção e deleção

delimiter $
create trigger value_check after insert on employee
	for each row
	BEGIN    
			if(new.Address is null) then
				insert into user_messages(message,ssn) values (concat("Atualize seu endereço: ", new.Fname), new.Ssn);
			else
				insert into user_messages (message,ssn) values(concat("Inserido com sucesso: ", new.Fname), new.Ssn);
			end if;
	END;
$	
delimiter ;

drop trigger value_check;

delimiter //
create trigger employee_demitidos before delete on employee for each row
begin
	insert into employee_demitidos(ssn,fname,lname,dno)values(old.ssn,old.fname,old.lname,old.dno);
end;
// 
delimiter ;


select * from departament;
select * from employee;
select * from project;
select * from works_on;
select * from dependent;
select * from user_messages;
select * from employee_demitidos;

delete from employee where address = null;

