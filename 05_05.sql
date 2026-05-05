use [ConsultasSQL26.1]

select * from aproveitamentos

select AVG(apr_nota) Media, COUNT(*) QTD
from aproveitamentos


select AVG(apr_nota) Media, COUNT(*) QTD
from aproveitamentos
where alu_rm = 3


select AVG(apr_nota) Media, COUNT(*) QTD
from aproveitamentos
where alu_rm = 3 and apr_ano = 2024


select AVG(apr_nota) Media, COUNT(*) QTD
from aproveitamentos
where alu_rm = 3 and apr_ano = 2024 and apr_sem = 1


select AVG(apr_nota) media, COUNT (*) Qtd
from aproveitamentos
where dis_codigo = 7


select AVG(apr_nota) media, COUNT (*) Qtd
from aproveitamentos
where dis_codigo = 7 and apr_ano = 2024 and apr_sem = 1

--------------------------------------------------------------

select AVG (apr_nota) Media from aproveitamentos

select AVG (apr_nota) media from aproveitamentos
where dis_codigo = 1

select AVG (apr_nota) media from aproveitamentos
where dis_codigo in (3,7)


select * from aproveitamentos
where dis_codigo in (3,7)
group by dis_codigo

select * from aproveitamentos

select dis_codigo, apr_ano, AVG(apr_nota) Media, COUNT(*) qtd from aproveitamentos
where dis_codigo in (3,7)
group by dis_codigo, apr_ano