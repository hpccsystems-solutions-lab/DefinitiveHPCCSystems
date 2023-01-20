//BWR_ComplexXML
/* <dataset>
   <area code="201" description="description" zone="Eastern Time Zone"/>
   <area code="202" description="description" zone="Eastern Time Zone"/>
   </dataset>
*/

r := RECORD
 STRING code{xpath('@code')};
 STRING description{xpath('@description')};
 STRING zone{xpath('@zone')};
END;
d := DATASET('~CLASS::BMF::IN::complextimezones',r,XML('dataset/area'));
OUTPUT(d);

OUTPUT(d,NOXPATH);