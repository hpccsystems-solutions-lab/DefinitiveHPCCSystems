layout_accts := RECORD
 UNSIGNED8 personid;
 STRING8   reportdate;
 STRING2   industrycode;
 STRING8   opendate;
 UNSIGNED4 highcredit;
 UNSIGNED4 balance;
 UNSIGNED2 terms;
 STRING20  accountnumber;
 STRING8   lastactivitydate;
END;

layout_person := RECORD
 UNSIGNED8 id;
 STRING15  firstname;
 STRING25  lastname;
 STRING15  middlename;
 STRING2   namesuffix;
 STRING8   filedate;
 // STRING1   maritalstatus;
 STRING1   gender;
 // UNSIGNED1 dependentcount;
 STRING8   birthdate;
 STRING42  streetaddress;
 STRING20  city;
 STRING2   state;
 STRING5   zipcode;
 DATASET(layout_accts) childaccts{xpath('childaccts/Row'),maxCount(120)};
END;

ds := DATASET('~CLASS::BMF::IN::NestedChildXML',layout_person,XML('dataset/person'));
OUTPUT(ds);
OUTPUT(ds,,'~a::BMF::NestedOutputTestXML',OVERWRITE);