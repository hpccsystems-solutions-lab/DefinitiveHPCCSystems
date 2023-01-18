//Import:ecl:Labs.Crosstab_Example
IMPORT $;
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

//Import:ecl:Labs.File_Accounts
EXPORT File_Accounts := MODULE
EXPORT Layout := RECORD
 UNSIGNED8 PersonId;
 STRING8   ReportDate;
 STRING2   IndustryCode;
 UNSIGNED4 Member;
 STRING8   OpenDate;
 STRING1   TradeType;
 STRING1   TradeRate;
 UNSIGNED1 Narr1;
 UNSIGNED1 Narr2;
 UNSIGNED4 HighCredit;
 UNSIGNED4 Balance;
 UNSIGNED2 Terms;
 UNSIGNED1 TermTypeR;
 STRING20  AccountNumber;
 STRING8   LastActivityDate;
 UNSIGNED1 Late30Day;
 UNSIGNED1 Late60Day;
 UNSIGNED1 Late90Day;
 STRING1   TermType;
END;


EXPORT File := DATASET('~CLASS::BMF::Intro::Accounts',Layout,CSV);
END;
//Import:ecl:Labs.File_Persons
EXPORT File_Persons := MODULE
EXPORT Layout := RECORD
 UNSIGNED8 ID;
 STRING15  FirstName;
 STRING25  LastName;
 STRING15  MiddleName;
 STRING2   NameSuffix;
 STRING8   FileDate;
 UNSIGNED2 BureauCode;
 STRING1   MaritalStatus;
 STRING1   Gender;
 UNSIGNED1 DependentCount;
 STRING8   BirthDate; //YYYYMMDD
 STRING42  StreetAddress;
 STRING20  City;
 STRING2   State;
 STRING5   ZipCode;
END;

EXPORT File := DATASET('~CLASS::BMF::Intro::Persons',Layout,THOR);
END;
