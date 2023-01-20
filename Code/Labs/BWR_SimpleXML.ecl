//BWR_SimpleXML
/* <Dataset>
    <area>
     <code>201</code>
     <description>PA Pennsylvania</description>
     <zone>Eastern Time Zone</zone>
    </area>
    <area>
     <code>202</code>
     <description>OH Ohio (Cleveland area)</description>
     <zone>Eastern Time Zone</zone>
    </area>
   </Dataset>
*/

r := RECORD
 INTEGER2  CODE;
 STRING110 description;
 STRING42  zone;
END;
d := DATASET('~CLASS::BMF::IN::timezones',r,XML('Dataset/area'));


d;
