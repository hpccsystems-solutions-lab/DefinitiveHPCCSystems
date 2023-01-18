IMPORT $;
Persons := $.File_Persons.File;
c1 := COUNT(Persons(DependentCount=0));
// c1 := 432521;

c2 := COUNT(Persons);

c3 := ((c2-c1)/c2)*100.0;

d := DATASET([{'Total Records',c2},
              {'Recs=0',c1},
              {'Population Pct',c3}],
              {STRING15 valuetype,INTEGER val});
OUTPUT(d);