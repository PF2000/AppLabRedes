select l.name, t.type
from tblLabs as l , tblLabType as t , tblTypes_Labss as tl
where l.Id=tl.IdLab and t.Id = tl.IdType and l.id =0