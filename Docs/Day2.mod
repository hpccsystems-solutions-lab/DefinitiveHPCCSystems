//Import:ecl:Labs.DEDUP_ALL_Example
MyRec := RECORD
	STRING1 Value1;
	STRING1 Value2;
END;

SomeFile := GROUP(DATASET([   {'C','G'},
                              {'C','C'},
                              {'A','X'},
                              {'B','G'},
                             {'A','B'}],MyRec),TRUE);

// SomeFile :=  DATASET([{'C','G'},
                      // {'C','C'},//XXX
                      // {'A','X'},//XXX
                      // {'B','G'},
                      // {'A','B'}],MyRec);//XXX


Dedup1 := DEDUP(SomeFile, 
                LEFT.Value2 IN ['G','C','X'] AND 
								     RIGHT.Value2 IN ['X','B','C'] ,ALL);

/*
Processes as:	LEFT   vs. 	RIGHT
				1 (G)		2 (C)		- lose 2 (RIGHT rec)
				1 (G)		3 (X)		- lose 3 (RIGHT rec)
				1 (G)		4 (G)		- keep RIGHT rec 4
				1 (G)		5 (B)		- lose 5 (RIGHT rec)

				4 (G)		1 (G)		- keep RIGHT rec 1 

Result set is:
	Rec#	Value1	Value2
	1		C		G
	4		B		G
*/

Dedup2 := DEDUP(SomeFile, 
                LEFT.Value2 IN ['G','C'] AND 
								RIGHT.Value2 IN ['X','B'] ,ALL);

/*
Processes as:	LEFT   vs. 	RIGHT
				1 (G)		2 (C)		- keep RIGHT rec 2
				1 (G)		3 (X)		- lose 3 (RIGHT rec)
				1 (G)		4 (G)		- keep RIGHT rec 4
				1 (G)		5 (B)		- lose 5 (RIGHT rec)

				2 (C)		1 (G)		- keep RIGHT rec 1
				2 (C)		4 (G)		- keep RIGHT rec 4

				4 (G)		1 (G)		- keep RIGHT rec 1
				4 (G)		2 (C)		- keep RIGHT rec 2

Result set is:
	Rec#	Value1	Value2
	1		C		G
	2		C		C
	4		B		G
*/

Dedup3 := DEDUP(SomeFile, 
                LEFT.Value2 IN ['X','B'] AND 
								RIGHT.Value2 IN ['G','C'],ALL);

/*
Processes as:	LEFT   vs. 	RIGHT
				1 (G)		2 (C)		- keep RIGHT rec 2
				1 (G)		3 (X)		- keep RIGHT rec 3 
				1 (G)		4 (G)		- keep RIGHT rec 4
				1 (G)		5 (B)		- keep RIGHT rec 5

				2 (C)		1 (G)		- keep RIGHT rec 1
				2 (C)		3 (X)		- keep RIGHT rec 3
				2 (C)		4 (G)		- keep RIGHT rec 4
				2 (C)		5 (B)		- keep RIGHT rec 5

				3 (X)		1 (G)		- lose 1 (RIGHT rec)
				3 (X)		2 (C)		- lose 2 (RIGHT rec)
				3 (X)		4 (G)		- lose 4 (RIGHT rec)
				3 (X)		5 (B)		- keep RIGHT rec 5

				5 (B)		3 (X)		- keep RIGHT rec 3
Result set is:
	Rec#	Value1	Value2
	3		A		X
	5		A		B
*/

output(Dedup1);
output(Dedup2);
output(Dedup3);
//Import:ecl:Labs.DEDUP_Example
MyRec := RECORD
	STRING1 Value1;
	STRING1 Value2;
END;

SomeFile := DATASET([{'C','G'},
                     {'C','C'},
                     {'A','X'},
                     {'B','G'},
                     {'A','B'}],MyRec);

Val1Sort := SORT(SomeFile,Value1);
Val2Sort := SORT(SomeFile,Value2);

Dedup1   := DEDUP(Val1Sort,Value1);

/* Result set is:
	Rec#	Value1	Value2
	1		A		X
	2		B		G
	3		C		G
*/
Dedup2 := DEDUP(Val2Sort,LEFT.Value2 = RIGHT.Value2);

/* Result set is:
	Rec#	Value1	Value2
	1		A		B
	2		C		C
	3		C		G
	4		A		X
*/

Dedup3 := DEDUP(Val1Sort,LEFT.Value1 = RIGHT.Value1,RIGHT);

/* Result set is:
	Rec#	Value1	Value2
	1		A		B
	2		B		G
	3		C		C
*/

Dedup4 := DEDUP(Val2Sort,LEFT.Value2 = RIGHT.Value2,RIGHT);

/* Result set is:
	Rec#	Value1	Value2
	1		A		B
	2		C		C
	3		B		G
	4		A		X
*/

output(Dedup1);
output(Dedup2);
output(Dedup3);
output(Dedup4);
//Import:ecl:Labs.FETCH_Example
IMPORT $;
Person := $.File_People;
OUTPUT(Person,NAMED('Original_File'));
PtblRec := RECORD
  STRING2  State  := Person.state;
  STRING20 City   := Person.city;
  STRING25 Lname  := Person.lastname;
  STRING15 Fname  := Person.firstname;
	STRING1  Gender := Person.Gender;
END;

DataFile := '~BFTEMP::TestFetch';
KeyFile  := '~BFTEMP::TestFetchKey';

PtblOut := OUTPUT(TABLE(Person(Lastname[1..3]='Wik'),PtblRec),,DataFile,OVERWRITE,NAMED('WikTable'));

Ptbl_Plus := DATASET(DataFile,
		                 {PtblRec,UNSIGNED8 RecPos {VIRTUAL(fileposition)}},
		                 THOR);

AlphaInStateCity := INDEX(Ptbl_Plus,
				                  {state,city,lname,fname,RecPos},
				                  KeyFile);

Bld := BUILD(AlphaInStateCity,OVERWRITE);


// AlphaPeople := FETCH(Ptbl_Plus, 
    										 // AlphaInStateCity(WILD(state),
    																			// WILD(city),
    																			// KEYED(Lname='Wikoff')
   																			// ), 
             					 // RIGHT.RecPos);

 

										 
AlphaPeople := FETCH(Ptbl_Plus, 
             					 AlphaInStateCity(Lname='Wikoff'), 
            						 RIGHT.RecPos);										 





OutFile := OUTPUT(CHOOSEN(AlphaPeople,10),NAMED('FETCH_Output10'));
Test := AlphaInStateCity(State = 'MI');

SEQUENTIAL(PtblOut,Bld,OutFile);
Test;

//Import:ecl:Labs.File_LookupCSZ
EXPORT File_LookupCSZ := MODULE
  EXPORT Layout := RECORD
   UNSIGNED4  CSZ_ID;
   STRING20   City;
   STRING2    State;
   UNSIGNED3  ZipCode;
   END;

  SHARED Filename := '~CLASS::NCF::OUT::LookupCSZ';
  EXPORT File     := DATASET(Filename,Layout,THOR);
  EXPORT FilePlus := DATASET(Filename,
	                          {Layout, UNSIGNED8 recpos {virtual(fileposition)}},THOR);
  														 
  EXPORT IDX_st_city := INDEX(FilePlus,
                             {State,City,recpos},
                             '~CLASS::BMF::KEY::LookupCSZ');
END;
//Import:ecl:Labs.JOIN_Example
MyRec := RECORD
	STRING1 Value1;
	STRING1 Value2;
END;

LeftFile := DATASET([{'C','A'},
                     {'X','B'},
                     {'A','C'}],MyRec);

RightFile := DATASET([{'C','X'},
                      {'B','Y'},
                      {'A','Z'}],MyRec);

MyOutRec := RECORD
	STRING1 Value1;
	STRING1 LeftValue2;
	STRING1 RightValue2;
END;

MyOutRec JoinThem(MyRec L, MyRec R) := TRANSFORM
	SELF.Value1      := IF(L.Value1<>'', L.Value1, R.Value1);
	SELF.LeftValue2  := L.Value2;
	SELF.RightValue2 := R.Value2;
END;

InnerJoinedRecs := JOIN(LeftFile,RightFile,
                        LEFT.Value1 = RIGHT.Value1,
											JoinThem(LEFT,RIGHT));
LOutJoinedRecs :=  JOIN(LeftFile,RightFile,
                        LEFT.Value1 = RIGHT.Value1,
											JoinThem(LEFT,RIGHT),LEFT OUTER);
ROutJoinedRecs :=  JOIN(LeftFile,RightFile,
                        LEFT.Value1 = RIGHT.Value1,
											JoinThem(LEFT,RIGHT),RIGHT OUTER);
FOutJoinedRecs := JOIN(LeftFile,RightFile,
					                LEFT.Value1 = RIGHT.Value1,
											   JoinThem(LEFT,RIGHT),FULL OUTER);
LOnlyJoinedRecs := JOIN(LeftFile,RightFile,
	 				                 LEFT.Value1 = RIGHT.Value1,
												  JoinThem(LEFT,RIGHT),LEFT ONLY);
ROnlyJoinedRecs := JOIN(LeftFile,RightFile,
	 				                 LEFT.Value1 = RIGHT.Value1,
												  JoinThem(LEFT,RIGHT),RIGHT ONLY);
FOnlyJoinedRecs := JOIN(LeftFile,RightFile,
	 				                 LEFT.Value1 = RIGHT.Value1,
												  JoinThem(LEFT,RIGHT),FULL ONLY);


OUTPUT(InnerJoinedRecs,,NAMED('Inner'));
OUTPUT(LOutJoinedRecs,,NAMED('LeftOuter'));
OUTPUT(ROutJoinedRecs,,NAMED('RightOuter'));
OUTPUT(FOutJoinedRecs,,NAMED('FullOuter'));
OUTPUT(LOnlyJoinedRecs,,NAMED('LeftOnly'));
OUTPUT(ROnlyJoinedRecs,,NAMED('RightOnly'));
OUTPUT(FOnlyJoinedRecs,,NAMED('FullOnly'));


/* InnerJoinedRecs result set is: 
	Rec#	Value1	LeftValue2	RightValue2
	1		A		C			Z	
	2		C		A			X
 
LOutJoinedRecs result set is:
	Rec#	Value1	LeftValue2	RightValue2
	1		A		C			Z	
	2		C		A			X
	3		X		B			

ROutJoinedRecs result set is:
	Rec#	Value1	LeftValue2	RightValue2
	1		A		C			Z	
	2		B					Y			
	3		C		A			X

FOutJoinedRecs result set is:
	Rec#	Value1	LeftValue2	RightValue2
	1		A		C			Z
	2		B					Y	
	3		C		A			X
	4		X		B			

LOnlyJoinedRecs result set is:
	Rec#	Value1	LeftValue2	RightValue2
	1		X		B			

ROnlyJoinedRecs result set is:
	Rec#	Value1	LeftValue2	RightValue2
	1		B					Y

FOnlyJoinedRecs result set is:
	Rec#	Value1	LeftValue2	RightValue2
	1		B					Y	
	2		X		B			
*/



//Import:ecl:Labs.PROJECT_Example
 MyRec := RECORD
	STRING1 Value1;
	STRING1 Value2;
END;

SomeFile := DATASET([{'C','G'},
                     {'C','C'},
                     {'A','X'},
                     {'B','G'},
                     {'A','B'}],MyRec);

MyOutRec := RECORD
	myRec.Value1;    //no default value
	SomeFile.Value2; //default value - PROJECT does not care!
	STRING4 CatValues;
  //Record below for TABLE in Exercise 4B
	// UNSIGNED4 RecID := 0; 
	// $.File_Accounts.File;
END;

MyOutRec CatThem(SomeFile Le, INTEGER Cnt) := TRANSFORM
	SELF.CatValues := Le.Value1 + Le.Value2 + '-' + Cnt;
	// SELF := Le;									
 SELF.value1 := Le.value1;
 SELF.value2 := Le.value2;
END;

CatRecs := PROJECT(SomeFile,CatThem(LEFT,COUNTER));
OUTPUT(CatRecs);

/* CatRecs result set is:
	Rec#	Value1	Value2	CatValues
	1		C		G		CG-1
	2		C		C		CC-2
	3		A		X		AX-3
	4		B		G		BG-4
	5		A		B		AB-5
*/
//Import:ecl:Labs.SORT_Example
MyRec := RECORD
	STRING1 Value1;
	STRING1 Value2;
END;

SomeFile := DATASET([{'C','G'},
					             {'C','C'},
					             {'A','X'},
					             {'B','G'},
					             {'A','B'}],MyRec);
					 
SortedRecs  := SORT(SomeFile,Value1);
SortedRecs1 := SORT(SomeFile,Value1,Value2);
SortedRecs2 := SORT(SomeFile,-Value1,Value2);
SortedRecs3 := SORT(SomeFile,Value1,-Value2);
SortedRecs4 := SORT(SomeFile,-Value1,-Value2);
SortedRecs5 := SORT(SomeFile,Value2,Value1);
SortedRecs6 := SORT(SomeFile,-Value2,Value1);
SortedRecs7 := SORT(SomeFile,Value2,-Value1);
SortedRecs8 := SORT(SomeFile,-Value2,-Value1);
SortedRecs9 := SORT(SomeFile,RECORD);

OUTPUT(SortedRecs);
OUTPUT(SortedRecs1);
OUTPUT(SortedRecs2);
OUTPUT(SortedRecs3);
OUTPUT(SortedRecs4);
OUTPUT(SortedRecs5,{Value2,Value1});
OUTPUT(SortedRecs6,{Value2,Value1});
OUTPUT(SortedRecs7,{Value2,Value1});
OUTPUT(SortedRecs8,{Value2,Value1});
OUTPUT(SortedRecs9);
/*
SortedRecs1 results in:
	Rec#	Value1	Value2
	1		A		B
	2		A		X
	3		B		G
	4		C		C
	5		C		G

SortedRecs2 results in:
	Rec#	Value1	Value2
	1		C		C
	2		C		G
	3		B		G
	4		A		B
	5		A		X

SortedRecs3 results in:
	Rec#	Value1	Value2
	1		A		X
	2		A		B
	3		B		G
	4		C		G
	5		C		C

SortedRecs4 results in:
	Rec#	Value1	Value2
	1		C		G
	2		C		C
	3		B		G
	4		A		X
	5		A		B
*/
