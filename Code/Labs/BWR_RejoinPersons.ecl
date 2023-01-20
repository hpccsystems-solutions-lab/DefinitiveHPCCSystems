IMPORT $,Std;
$.File_Persons.Layout Bulkup($.File_Persons_Slim.Layout Le,
                             $.File_LookupCSZ.Layout Ri) := TRANSFORM
 SELF.zipcode        := IF(Ri.zipcode=0,'',INTFORMAT(Ri.zipcode,5,1));
 SELF.FileDate       := IF(Le.FileDate=0,'',(STRING8)Le.FileDate);
 SELF.BirthDate      := IF(Le.BirthDate=0,'',(STRING8)Le.BirthDate);
 // SELF.MaritalStatus  := '';
 // SELF.DependentCount := 0;
 SELF.FirstName      := Std.Str.ToTitleCase(Le.FirstName);
 SELF.LastName       := Std.Str.ToTitleCase(Le.LastName);
 SELF.MiddleName     := Std.Str.ToTitleCase(Le.MiddleName);
 SELF.NameSuffix     := Std.Str.ToTitleCase(Le.NameSuffix);
 SELF := Ri;
 SELF := Le;
END;
BulkRecs := JOIN($.File_Persons_Slim.File,
                 $.File_LookupCSZ.File,
                 LEFT.CSZ_ID=RIGHT.CSZ_ID,
                 Bulkup(LEFT,RIGHT),LEFT OUTER,LOOKUP);
OUTPUT(BulkRecs,,'~CLASS::BMF::OUT::Persons_Rejoined',overwrite);