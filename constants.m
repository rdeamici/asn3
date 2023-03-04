set1files = {'data\DSCF4177.jpg', 'data\DSCF4178.jpg', 'data\DSCF4179.jpg',...
             'data\DSCF4180.jpg','data\DSCF4186.jpg', 'data\DSCF4187.jpg'};
set1fileMasks = {'data\DSCF4177Mask.jpg', 'data\DSCF4178Mask.jpg', 'data\DSCF4179Mask.jpg', ...
                 'data\DSCF4180Mask.jpg','data\DSCF4186Mask.jpg', 'data\DSCF4187Mask.jpg'};

set2files = {};
set2fileMasks = {};

yellow_bottom_3d = [0,48,48; 32,48,48; 32,80,48];
yellow_top_3d    = [0,48,67; 32,48,67; 32,80,67]; 
blue_bottom_3d   = [0,0,0;  64,0,0;  64,64,0];
blue_top_3d      = [0,0,19; 64,0,19; 64,64,19];
red_bottom_3d    = [0,0,19; 64,0,19; 64,64,19];
red_top_3d       = [0,0,29; 64,0,29; 64,64,29];

P = [yellow_bottom_3d; yellow_top_3d;
     blue_bottom_3d; blue_top_3d;
     red_bottom_3d; red_top_3d];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yellow_bottom_4177 = [424,912; 661,994; 841,823];
yellow_top_4177    = [383,771; 634,848; 815,680];
blue_bottom_4177   = [229,1566; 727,1785; 1073,1337];
blue_top_4177      = [180,1446; 699,1662; 1053,1228];
red_bottom_4177    = [180,1446; 699,1662; 1053,1228];
red_top_4177       = [149,1370; 681,1595; 1042,1151];

Pc1_4177 = [yellow_bottom_4177; yellow_top_4177; 
            blue_bottom_4177; blue_top_4177; 
            red_bottom_4177; red_top_4177];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yellow_bottom_4178 = [];
yellow_top_4178    = [];
blue_bottom_4178   = [];
blue_top_4178      = [];
red_bottom_4178    = [];
red_top_4178       = [];

Pc1_4178 = [yellow_bottom_4178; yellow_top_4178;
            blue_bottom_4178; blue_top_4178;
            red_bottom_4178; red_top_4178];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yellow_bottom_4179 = [];
yellow_top_4179    = [];
blue_bottom_4179   = [];
blue_top_4179      = [];
red_bottom_4179    = [];
red_top_4179       = [];

Pc1_4179 = [yellow_bottom_4179; yellow_top_4179;
            blue_bottom_4179; blue_top_4179;
            red_bottom_4179; red_top_4179];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yellow_bottom_4180 = [];
yellow_top_4180    = [];
blue_bottom_4180   = [];
blue_top_4180      = [];
red_bottom_4180    = [];
red_top_4180       = [];

Pc1_4180 = [yellow_bottom_4180; yellow_top_4180;
            blue_bottom_4180; blue_top_4180;
            red_bottom_4180; red_top_4180];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yellow_bottom_4186 = [];
yellow_top_4186    = [];
blue_bottom_4186   = [];
blue_top_4186      = [];
red_bottom_4186    = [];
red_top_4186       = [];

Pc1_4186 = [yellow_bottom_4186; yellow_top_4186;
            blue_bottom_4186; blue_top_4186;
            red_bottom_4186; red_top_4186];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yellow_bottom_4187 = [];
yellow_top_4187    = [];
blue_bottom_4187   = [];
blue_top_4187      = [];
red_bottom_4187    = [];
red_top_4187      = [];

Pc1_4187 = [yellow_bottom_4187; yellow_top_4187;
            blue_bottom_4187; blue_top_4187;
            red_bottom_4187; red_top_4187];
