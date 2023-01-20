IMPORT $;
EXPORT File_Persons_Slim := MODULE
 EXPORT Layout := RECORD
  RECORDOF($.STD_Persons.File) AND NOT [City,State,ZipCode];
  UNSIGNED4  CSZ_ID;
 END;

 
 EXPORT File := DATASET('~CLASS::BMF::OUT::Persons_Slim',Layout,FLAT);
END; //Comment when adding below (Day 3) 
 
 
 // EXPORT FilePlus := DATASET(Filename,{Layout, UNSIGNED8 recpos {virtual(fileposition)}},FLAT);

 // EXPORT IDX_CSZ_lname_fname := INDEX(FilePlus,
                                     // {CSZ_ID,LastName,FirstName,recpos},
                                      // '~CLASS::BMF::KEY::CSZ_lname_fname');	
 // EXPORT IDX_lname_fname := INDEX(FilePlus,
                                 // {LastName,FirstName,recpos},
                                  // '~CLASS::BMF::KEY::lname_fname'); 
 // END;																	