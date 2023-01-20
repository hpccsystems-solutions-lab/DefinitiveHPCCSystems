//BWR_Add_SF1
IMPORT $,STD;

SEQUENTIAL
 (STD.File.StartSuperFileTransaction(),
  STD.File.AddSuperFile($.File_AllData.AllDataSF,$.File_AllData.WeeklySF),
  STD.File.AddSuperFile($.File_AllData.AllDataSF,$.File_AllData.DailySF),
  STD.File.AddSuperFile($.File_AllData.AllDataSF,'~ecltraining::in::namephonesupd1'),
  STD.File.FinishSuperFileTransaction()
 );