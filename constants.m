set1files = {'data\DSCF4177.jpg', 'data\DSCF4178.jpg', 'data\DSCF4179.jpg',...
             'data\DSCF4180.jpg', 'data\DSCF4181.jpg'};
set1fileMasks = {'data\DSCF4177Mask.jpg', 'data\DSCF4178Mask.jpg', 'data\DSCF4179Mask.jpg', ...
                 'data\DSCF4197Mask.jpg','data\DSCF4198Mask.jpg'};

set2files = {'data\DSCF4195.jpg', 'data\DSCF4196.jpg', 'data\DSCF4197.jpg',...
              'data\DSCF4198.jpg', 'data\DSCF4199.jpg'};
set2fileMasks = {'data\DSCF4195Mask.jpg', 'data\DSCF4196Mask.jpg', 'data\DSCF4197Mask.jpg',...
              'data\DSCF4198Mask.jpg', 'data\DSCF4199Mask.jpg'};

yellow_top_south    = [0,48,67; 32,48,67]; 
yellow_bottom_south = [0,48,48; 32,48,48];
green_top_south      = [16,16,48; 48,16,48];
green_bottom_south   = [16,16,29;  48,16,29];
red_top_south       = [0,0,29; 64,0,29];
red_bottom_south    = [0,0,19; 64,0,19];
blue_top_south      = [0,0,19; 64,0,19];
blue_bottom_south   = [0,0,0; 64,0,0];

P_set1 = [yellow_top_south; yellow_bottom_south;
          green_top_south; green_bottom_south;
          red_top_south; red_bottom_south;
          blue_top_south; blue_bottom_south];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yellow_top_4177    = [384,768; 639,845];
yellow_bottom_4177 = [424,917; 662,989];
green_top_4177      = [343,1172; 599,1269];
green_bottom_4177   = [376,1306; 638,1401];
red_top_4177       = [154,1367; 684,1587];
red_bottom_4177    = [180,1435; 693,1653];
blue_top_4177       = [180,1435; 693,1653];
blue_bottom_4177    = [229,1575; 728,1788;];

Pc1_4177 = [yellow_top_4177; yellow_bottom_4177;
            green_top_4177; green_bottom_4177;
            red_top_4177; red_bottom_4177;
            blue_top_4177; blue_bottom_4177];
Pc1_4177_homog = [Pc1_4177,ones(size(Pc1_4177,1),1)]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

         

yellow_top_4178    = [502,256; 633,350];
yellow_bottom_4178 = [533,393; 659,495];
green_top_4178     = [347,567; 478,680];
green_bottom_4178  = [383,693; 515,817];
red_top_4178       = [203,704; 456,966];
red_bottom_4178    = [229,780; 470,1028];
blue_top_4178      = [229,780; 470,1028];
blue_bottom_4178   = [266,899; 513,1163];

Pc1_4178 = [yellow_top_4178; yellow_bottom_4178;
            green_top_4178; green_bottom_4178;
            red_top_4178; red_bottom_4178;
            blue_top_4178; blue_bottom_4178];
Pc1_4178_homog = [Pc1_4178,ones(size(Pc1_4178,1),1)]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yellow_top_4179    = [484,525; 687,567];
yellow_bottom_4179 = [509,693; 699,736];
green_top_4179     = [361,814; 569,874];
green_bottom_4179  = [386,982; 590,1048];
red_top_4179       = [161,1011; 582,1163];
red_bottom_4179    = [177,1097; 592,1255];
blue_top_4179      = [177,1097; 592,1255];
blue_bottom_4179   = [209,1264; 615,1441];

Pc1_4179 = [yellow_top_4179; yellow_bottom_4179;
            green_top_4179; green_bottom_4179;
            red_top_4179; red_bottom_4179;
            blue_top_4179; blue_bottom_4179];
Pc1_4179_homog = [Pc1_4179,ones(size(Pc1_4179,1),1)]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yellow_top_4180    = [516,1049;896,979];
yellow_bottom_4180 = [550,1248;919,1172];
green_top_4180     = [839,1444;1222,1355];
green_bottom_4180  = [857,1632;1231,1533];
red_top_4180       = [699,1839;1488,1618];
red_bottom_4180    = [708,1927;1492,1707];
blue_top_4180      = [708,1927;1492,1707];
blue_bottom_4180   = [738,2111;1484,1873];

Pc1_4180 = [yellow_top_4180; yellow_bottom_4180;
            green_top_4180; green_bottom_4180;
            red_top_4180; red_bottom_4180;
            blue_top_4180; blue_bottom_4180];
Pc1_4180_homog = [Pc1_4180,ones(size(Pc1_4180,1),1)]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yellow_top_4181    = [1392,1275; 1547,1082];
yellow_bottom_4181 = [1406,1460; 1560,1255];
green_top_4181     = [1844,1450; 1955,1228];
green_bottom_4181  = [1846,1610; 1952,1389];
red_top_4181       = [1968,1792; 2164,1340];
red_bottom_4181    = [1968,1874; 2161,1426];
blue_top_4181      = [1968,1874; 2161,1426];
blue_bottom_4181   = [1962,2050; 2150,1546];

Pc1_4181 = [yellow_top_4181; yellow_bottom_4181;
            green_top_4181; green_bottom_4181;
            red_top_4181; red_bottom_4181;
            blue_top_4181; blue_bottom_4181];
Pc1_4181_homog = [Pc1_4181,ones(size(Pc1_4181,1),1)]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yellow_top_east    = [32,48,67; 32,80,67]; 
yellow_bottom_east = [32,48,48; 32,80,48];
green_top_east      = [48,16,48; 48,48,48];
green_bottom_east   = [48,16,29;  48,48,29];
red_top_east       = [64,0,29; 64,64,29];
red_bottom_east    = [64,0,19; 64,64,19];
blue_top_east      = [64,0,19; 64,64,19];
blue_bottom_east   = [64,0,0; 64,64,0];

P_set2 = [yellow_top_east; yellow_bottom_east;
          green_top_east; green_bottom_east;
          red_top_east; red_bottom_east;
          blue_top_east; blue_bottom_east];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yellow_top_4195    = [758,576; 1039,533];
yellow_bottom_4195 = [774,753; 1054,710];
green_top_4195     = [507,845; 822,790];
green_bottom_4195  = [524,1034; 847,966];
red_top_4195       = [401,1122; 1056,988];
red_bottom_4195    = [412,1224; 1068,1082];
blue_top_4195      = [412,1224; 1068,1082];
blue_bottom_4195   = [447,1430; 1086,1266];

Pc1_4195 = [yellow_top_4195; yellow_bottom_4195;
            green_top_4195; green_bottom_4195;
            red_top_4195; red_bottom_4195;
            blue_top_4195; blue_bottom_4195];
Pc1_4195_homog = [Pc1_4195,ones(size(Pc1_4195,1),1)]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yellow_top_4196    = [642,582; 905,539];
yellow_bottom_4196 = [659,777; 913,731];
green_top_4196     = [466,889; 767,814];
green_bottom_4196  = [484,1097; 790,1006];
red_top_4196       = [443,1204; 1040,1014];
red_bottom_4196    = [458,1318; 1053,1112];
blue_top_4196      = [458,1318; 1053,1112];
blue_bottom_4196   = [487,1556; 1068,1311];

Pc1_4196 = [yellow_top_4196; yellow_bottom_4196;
            green_top_4196; green_bottom_4196;
            red_top_4196; red_bottom_4196;
            blue_top_4196; blue_bottom_4196];
Pc1_4196_homog = [Pc1_4196,ones(size(Pc1_4196,1),1)]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yellow_top_4197    = [708,670; 939,536];
yellow_bottom_4197 = [735,831; 968,694];
green_top_4197     = [587,1077; 834,905];
green_bottom_4197  = [630,1226; 873,1054];
red_top_4197       = [612,1407; 1102,1045];
red_bottom_4197    = [625,1480; 1111,1111];
blue_top_4197      = [625,1480; 1111,1111];
blue_bottom_4197   = [665,1621; 1136,1249];

Pc1_4197 = [yellow_top_4197; yellow_bottom_4197;
            green_top_4197; green_bottom_4197;
            red_top_4197; red_bottom_4197;
            blue_top_4197; blue_bottom_4197];
Pc1_4197_homog = [Pc1_4197,ones(size(Pc1_4197,1),1)]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yellow_top_4198    = [613,774; 825,607];
yellow_bottom_4198 = [647,942; 850,774];
green_top_4198     = [559,1221; 781,1011];
green_bottom_4198  = [602,1383; 819,1163];
red_top_4198       = [636,1581; 1062,1128];
red_bottom_4198    = [661,1661; 1077,1200];
blue_top_4198      = [661,1661; 1077,1200];
blue_bottom_4198   = [701,1810; 1094,1332];

Pc1_4198 = [yellow_top_4198; yellow_bottom_4198;
            green_top_4198; green_bottom_4198;
            red_top_4198; red_bottom_4198;
            blue_top_4198; blue_bottom_4198];
Pc1_4198_homog = [Pc1_4198,ones(size(Pc1_4198,1),1)]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yellow_top_4199    = [745,791; 900,708];
yellow_bottom_4199 = [778,1040; 920,928];
green_top_4199     = [818,1206; 977,1060];
green_bottom_4199  = [847,1478; 999,1294];
red_top_4199       = [1005,1615; 1257,1240];
red_bottom_4199    = [1014,1753; 1274,1343];
blue_top_4199      = [1014,1753; 1274,1343];
blue_bottom_4199   = [1057,2024; 1292,1547];

Pc1_4199 = [yellow_top_4199; yellow_bottom_4199;
            green_top_4199; green_bottom_4199;
            red_top_4199; red_bottom_4199;
            blue_top_4199; blue_bottom_4199];
Pc1_4199_homog = [Pc1_4199,ones(size(Pc1_4199,1),1)]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%