IMPORT $,STD;

SEQUENTIAL(
  OUTPUT($.File_AllData.DailyDS,,'~CLASS::BMF::OUT::WeeklyRollup',OVERWRITE),
   STD.File.StartSuperFileTransaction(),
    STD.File.AddSuperFile($.File_AllData.WeeklySF,'~CLASS::BMF::out::WeeklyRollup'),
    STD.File.ClearSuperFile($.File_AllData.DailySF),
   STD.File.FinishSuperFileTransaction()
);
	
	
	

