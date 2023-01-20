//BWR_Add_SF2
IMPORT $,STD;
Daily := $.File_AllData.DailySF;
SEQUENTIAL(
 STD.File.StartSuperFileTransaction(),
 STD.File.AddSuperFile(Daily,'~ecltraining::in::namephonesupd2'),
 STD.File.AddSuperFile(Daily,'~ecltraining::in::namephonesupd3'),
 STD.File.FinishSuperFileTransaction()
 );
