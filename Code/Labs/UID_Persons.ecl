IMPORT $;
Persons   := $.File_Persons.File;
PersonRec := $.File_Persons.Layout;

NewPerson := RECORD
  UNSIGNED4 RecID;
	PersonRec;
END;

NewPerson IDRecs(Persons Le,INTEGER Cnt) := TRANSFORM
 SELF.RecID := Cnt;
 SELF       := Le;
END;

EXPORT UID_Persons := PROJECT(Persons,IDRecs(LEFT,COUNTER)) 
                       :PERSIST('~CLASS::BMF::PERSIST::UID_People');