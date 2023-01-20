IMPORT $,STD;
SEQUENTIAL(
  OUTPUT($.File_AllData.AllDataDS,,$.File_AllData.Base2,overwrite),
  STD.File.StartSuperFileTransaction(),
   STD.File.ClearSuperFile($.File_AllData.AllDataSF),
   STD.File.ClearSuperFile($.File_AllData.WeeklySF),
   STD.File.ClearSuperFile($.File_AllData.DailySF),
   STD.File.AddSuperFile($.File_AllData.AllDataSF,$.File_AllData.WeeklySF), 
   STD.File.AddSuperFile($.File_AllData.AllDataSF,$.File_AllData.DailySF),
   STD.File.AddSuperFile($.File_AllData.AllDataSF,$.File_AllData.Base2),
  STD.File.FinishSuperFileTransaction());