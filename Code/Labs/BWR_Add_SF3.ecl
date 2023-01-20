//BWR_Add_SF3
IMPORT $,STD;
SEQUENTIAL(STD.File.StartSuperFileTransaction(),
           STD.File.AddSuperFile($.File_AllData.DailySF,
                                 '~ecltraining::in::namephonesupd4'),
           STD.File.AddSuperFile($.File_AllData.DailySF,
                                 '~ecltraining::in::namephonesupd5'),
           STD.File.FinishSuperFileTransaction());
