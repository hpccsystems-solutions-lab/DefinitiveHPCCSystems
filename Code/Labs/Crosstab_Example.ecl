﻿IMPORT $;
Persons := $.File_Persons.File;

 MyRec := RECORD
  STRING1  Value1;
  STRING1  Value2;
  INTEGER1 Value3;
 END;
 SomeFile := DATASET([{'C','G',1},
                      {'C','G',6},
                      {'C','C',2},
                      {'A','X',3},
                      {'B','G',4},
                      {'A','B',5}],MyRec);
 MyOutRec := RECORD
   SomeFile.Value1;
   ValCount := COUNT(GROUP);
   GrpSum   := SUM(GROUP,SomeFile.Value3);
   AveSum   := AVE(GROUP,SomeFile.Value3);
 END;
MyTable := TABLE(SomeFile,MyOutRec,Value1);
OUTPUT(MyTable,NAMED('CT1'));
OUTPUT(SORT(MyTable,Value1),NAMED('CT1ByVal1'));

/* MyTable result set is:
	Rec#	Value1	GrpCount	GrpSum
	1		C		2			3
	2		A		2			8
	3		B		1			4
*/

 r := RECORD
  Persons.LastName;
  Persons.Gender;
  GrpCnt := COUNT(GROUP);
  MaxLen := MAX(GROUP,LENGTH(TRIM(Persons.FirstName)));
 END;
   
 tbl := TABLE(Persons,r,LastName,Gender);
 OUTPUT(tbl,NAMED('CrossTabRaw'));
 stbl := SORT(tbl,-Maxlen);
 OUTPUT(stbl,NAMED('ByLength'));
 firstnameval := $.File_Persons.File(lastName = 'Saron',Gender = 'M');
 OUTPUT(firstnameval,NAMED('Saron'));
 firstname14 := $.File_Persons.File(LENGTH(TRIM($.File_Persons.File.firstname)) = 14);
 OUTPUT(firstname14,NAMED('LongFirstNames'));
