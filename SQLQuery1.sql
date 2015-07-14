               select lt.tBegin , lt.tEnd,c.numUsers
               from tblLabs as l , tblCourse as c , tblLOginTimes as lt, tblUsers as u 
               where l.id=c.Lab and lt.course=c.id and u.course=c.id and l.Id=0  

delete from tblCourse
delete from tblLOginTimes
delete from tblUsers

select * from tblCourse
select * from tblLOginTimes
select * from tblUsers