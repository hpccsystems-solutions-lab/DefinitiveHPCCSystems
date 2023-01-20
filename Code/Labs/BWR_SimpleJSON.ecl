JSONString :=
   '{"Row": [{"id": "15520054709326826887", "firstname": "Otilia ", "lastname": "Tuscano ", "middlename": "Figaro",'+ 
   '"namesuffix": " ", "filedate": "19950119", "bureaucode": 575, "maritalstatus": " ",'+ 
   '"gender": "F", "dependentcount": 0, "birthdate": "19750624",'+ 
   '"streetaddress": "30 DWELLY RD ", "city": "MIAMI ", "state": "FL", "zipcode": "33155"}'+
   ']}';


Layout_PeopleFile := RECORD
	UNSIGNED8 ID;
	STRING15  FirstName;
	STRING25  LastName;
	STRING15  MiddleName;
	STRING2   NameSuffix;
  STRING8   FileDate;
	UNSIGNED2 BureauCode;
	// STRING1   MaritalStatus;
	STRING1   Gender;
	// UNSIGNED1 DependentCount;
 STRING8   BirthDate;
 STRING42  StreetAddress;
 STRING20  City;
 STRING2   State;
 STRING5   ZipCode;
END;

ds     := DATASET('~class::bmf::in::peoplefljson',Layout_PeopleFile,JSON('Row'));
OUTPUT(ds);

Layout_JSONFile := RECORD
	UNSIGNED8 ID{XPATH('Row/id')};
	STRING15  FirstName{XPATH('Row/firstname')};
	STRING25  LastName{XPATH('Row/lastname')};
	STRING15  MiddleName{XPATH('Row/middlename')};
	STRING2   NameSuffix;
  STRING8   FileDate;
	UNSIGNED2 BureauCode;
	// STRING1   MaritalStatus;
	STRING1   Gender{XPATH('Row/gender')};
	// UNSIGNED1 DependentCount;
 STRING8   BirthDate;
 STRING42  StreetAddress;
 STRING20  City;
 STRING2   State;
 STRING5   ZipCode{XPATH('Row/zipcode')};
END;


ds2 := FROMJSON(layout_JSONFile,JSONstring);
OUTPUT(ds2);



























/* x1     := DATASET('~test::sample.json::sample.json',json_schema,JSON);
   a      := OUTPUT(x1,,'~test::samplejson::FLATSample');
   x1plus := DATASET('~test::samplejson::FLATSample',{json_schema, UNSIGNED8 RecPtr{virtual(fileposition)}},FLAT);
   datax  := INDEX(x1plus,{email,RecPtr},'~test::sample.json::sample.json.index');
   b      := BUILD(datax);
   filterdata := FETCH(x1plus, datax(email = 'test@test.com'),RIGHT.RecPtr);
   c := filterdata;
   SEQUENTIAL(a,b,OUTPUT(c));
*/






