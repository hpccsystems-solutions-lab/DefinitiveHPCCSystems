SomeFile := DATASET([{'001','KC','G'}, 
                     {'002','KC','Z'}, 
                     {'003','KC','Z'}, 
                     {'004','KC','C'}, 
                     {'005','KA','X'}, 
                     {'006','KB','A'}, 
                     {'007','KB','G'}, 
                     {'008','KA','B'}],{STRING3 Id, String2 Value1, String1 Value2});

SomeFile1 := SORT(SomeFile, Value1);

DEDUP(SomeFile1, Value1, BEST(Value2));
// Output: 
// id value1 value2
// 008 KA B
// 006 KB A
// 004 KC C

DEDUP(SomeFile1, Value1, BEST(-Value2));
// Output:
// id value1 value2
// 005 KA X
// 007 KB G
// 002 KC Z

DEDUP(SomeFile1, Value1, HASH, BEST(Value2));
// Output: 
// id value1 value2
// 008 KA B
// 006 KB A
// 004 KC C