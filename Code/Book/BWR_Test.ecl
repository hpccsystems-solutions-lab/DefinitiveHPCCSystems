IMPORT $; 
// $.File_Yellow.File_201701; 
OUTPUT($.File_Yellow.File_201701,,'~d2tec::dg::yellow_tripdata_2017-01.csv',OVERWRITE); 
// $.File_Yellow.File_201702; 
OUTPUT($.File_Yellow.File_201702,,'~d2tec::dg::yellow_tripdata_2017-02.csv',OVERWRITE); 


// $.File_Yellow.SuperFile;

// COUNT($.File_Yellow.File_201701 + $.File_Yellow.File_201702); 
// COUNT($.File_Yellow.SuperFile);


//run the generated ECL 
// OUTPUT($.fnMAC_Profile($.File_Yellow.SuperFile),,'~File_Yellow::Profile::SuperFile_' + (STRING8)Std.Date.Today(), NAMED('ProfileInfo'), OVERWRITE);


//run the Data Patterns Profile
// IMPORT DataPatterns;
// DataPatterns.Profile($.File_Yellow.Superfile);