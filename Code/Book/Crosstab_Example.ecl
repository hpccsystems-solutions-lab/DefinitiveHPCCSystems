IMPORT BWR_Training_Examples AS X;
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
OUTPUT(MyTable);
OUTPUT(SORT(MyTable,Value1));

/* MyTable result set is:
	Rec#	Value1	GrpCount	GrpSum
	1		C		2			3
	2		A		2			8
	3		B		1			4
*/

 r := RECORD
  X.File_people.LastName;
  X.File_people.Gender;
  GrpCnt := COUNT(GROUP);
  MaxLen := MAX(GROUP,LENGTH(TRIM(X.File_people.firstname)));
 END;
   
 tbl := TABLE(X.File_People,r,LastName,Gender);
 OUTPUT(tbl);
 stbl := SORT(tbl,-Maxlen);
 stbl;
 firstnameval := X.file_people(lastName = 'Saron',Gender = 'M');
 firstnameval;
 firstname14 := X.file_people(LENGTH(TRIM(X.File_people.firstname)) = 14);
 firstname14;
