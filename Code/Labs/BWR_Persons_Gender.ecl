IMPORT $;
Persons := $.File_Persons.File; 
r := RECORD
  Persons.Gender;
  CNT := COUNT(GROUP);
END;

// EXPORT 
XTAB_Persons_Gender := SORT(TABLE(Persons,r,Gender),Gender);

OUTPUT(XTAB_Persons_Gender);



DISTRIBUTION($.File_Persons.File,maritalStatus,DependentCount);
DISTRIBUTION($.File_Persons.File,MiddleName);




