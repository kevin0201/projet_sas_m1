/*creation de la library de travail qui contiendra tout les tables et autres données*/
libname prosas "C:\Users\Kevin BAMOUNI\Documents\SAS";
/*cette étape data permet une création et un remplissage direct de la table portefeuille*/
/*creation de la table pf qui contien le portefeuille client*/
/*Import de données du portofolio via proc import au choix; soit via l'étape data précédente*/
/*l'avantage de l'étape date est qu'elle permet une plus grande portabilité du projet contrairement au proc import 
qui utilise des chemins d'accès sachant ces chemins peuvent varier d'un ordinnateur à un autre*/
PROC IMPORT datafile="C:\Users\Kevin BAMOUNI\Documents\SAS\sasdonnees.xls"
OUT=prosas.pf2
DBMS=XLS
replace;
SHEET=liabilities_portfolio;
run;
/* proc sort pour effectuer un tri croissant du portofolio par id*/
proc sort data=prosas.pf;/*on effectue un tri sur les id, tri ascendant*/
by id;
run;
/*import de la table de mortalite, via une etape data manuelle. proc import*/
data prosas.mortality;
input x lx dx px:numx2.4 qx:numx2.6;
cards;
0 100000 489 0.9951 0.004890
1 99511 38 0.9996 0.000382
2 99473 27 0.9997 0.000271
3 99446 22 0.9998 0.000221
4 99424 18 0.9998 0.000181
5 99406 16 0.9998 0.000161
6 99390 14 0.9999 0.000141
7 99376 13 0.9999 0.000131
8 99363 13 0.9999 0.000131
9 99350 12 0.9999 0.000121
10 99338 13 0.9999 0.000131
11 99325 13 0.9999 0.000131
12 99312 16 0.9998 0.000161
13 99296 20 0.9998 0.000201
14 99276 26 0.9997 0.000262
15 99250 37 0.9996 0.000373
16 99213 50 0.9995 0.000504
17 99163 66 0.9993 0.000666
18 99097 82 0.9992 0.000827
19 99015 94 0.9991 0.000949
20 98921 101 0.9990 0.001021
21 98820 104 0.9989 0.001052
22 98716 104 0.9989 0.001054
23 98612 103 0.9990 0.001044
24 98509 103 0.9990 0.001046
25 98406 103 0.9990 0.001047
26 98303 105 0.9989 0.001068
27 98198 107 0.9989 0.001090
28 98091 109 0.9989 0.001111
29 97982 112 0.9989 0.001143
30 97870 114 0.9988 0.001165
31 97756 117 0.9988 0.001197
32 97639 122 0.9988 0.001250
33 97517 129 0.9987 0.001323
34 97388 139 0.9986 0.001427
35 97249 149 0.9985 0.001532
36 97100 161 0.9983 0.001658
37 96939 174 0.9982 0.001795
38 96765 189 0.9980 0.001953
39 96576 207 0.9979 0.002143
40 96369 228 0.9976 0.002366
41 96141 254 0.9974 0.002642
42 95887 281 0.9971 0.002931
43 95606 311 0.9967 0.003253
44 95295 343 0.9964 0.003599
45 94952 377 0.9960 0.003970
46 94575 411 0.9957 0.004346
47 94164 444 0.9953 0.004715
48 93720 476 0.9949 0.005079
49 93244 508 0.9946 0.005448
50 92736 540 0.9942 0.005823
51 92196 575 0.9938 0.006237
52 91621 612 0.9933 0.006680
53 91009 651 0.9928 0.007153
54 90358 693 0.9923 0.007669
55 89665 736 0.9918 0.008208
56 88929 778 0.9913 0.008749
57 88151 822 0.9907 0.009325
58 87329 869 0.9900 0.009951
59 86460 922 0.9893 0.010664
60 85538 980 0.9885 0.011457
61 84558 1044 0.9877 0.012347
62 83514 1115 0.9866 0.013351
63 82399 1193 0.9855 0.014478
64 81206 1280 0.9842 0.015762
65 79926 1374 0.9828 0.017191
66 78552 1474 0.9812 0.018765
67 77078 1577 0.9795 0.020460
68 75501 1685 0.9777 0.022318
69 73816 1797 0.9757 0.024344
70 72019 1914 0.9734 0.026576
71 70105 2035 0.9710 0.029028
72 68070 2156 0.9683 0.031673
73 65914 2277 0.9655 0.034545
74 63637 2398 0.9623 0.037682
75 61239 2521 0.9588 0.041167
76 58718 2646 0.9549 0.045063
77 56072 2769 0.9506 0.049383
78 53303 2892 0.9457 0.054256
79 50411 3021 0.9401 0.059927
80 47390 3156 0.9334 0.066596
81 44234 3288 0.9257 0.074332
82 40946 3400 0.9170 0.083036
83 37546 3474 0.9075 0.092527
84 34072 3497 0.8974 0.102636
85 30575 3471 0.8865 0.113524
86 27104 3397 0.8747 0.125332
87 23707 3272 0.8620 0.138018
88 20435 3097 0.8484 0.151554
89 17338 2874 0.8342 0.165763
90 14464 2612 0.8194 0.180586
91 11852 2326 0.8037 0.196254
92 9526 2028 0.7871 0.212891
93 7498 1729 0.7694 0.230595
94 5769 1438 0.7507 0.249263
95 4331 1165 0.7310 0.268991
96 3166 917 0.7104 0.289640
97 2249 700 0.6888 0.311249
98 1549 517 0.6662 0.333764
99 1032 369 0.6424 0.357558
100 663 253 0.6184 0.381599
101 410 166 0.5951 0.404878
102 244 105 0.5697 0.430328
103 139 64 0.5396 0.460432
104 75 36 0.5200 0.480000
105 39 20 0.4872 0.512821
106 19 10 0.4737 0.526316
107 9 5 0.4444 0.555556
108 4 2 0.5000 0.500000
109 2 1 0.5000 0.500000
110 1 1 0.0000 1.000000
;
run;
/*Import de données de la table de mortalité via proc import au choix; soit via l'étape data précédente*/
PROC IMPORT datafile="C:\Users\Kevin BAMOUNI\Documents\SAS\sasdonnees.xls"
OUT=prosas.mortality2
DBMS=XLS
replace;
SHEET=mortality_law;
run;


/* consideration du portefeuille des femmes; observations où le genre=1*/
data prosas.pff;
set prosas.pf;
where (gender=1);
run;
/*statistique descriptive du portefeuille des femmes.*/
proc means data=prosas.pff;
var Reserve;
title 'Statistique descriptive de la table : prosas.pff';
run;

/* consideration du portefeuille des hommes; observations où le genre=0*/
data prosas.pfh;
set prosas.pf;
where (gender=0);
run;
/*statistique descriptive du portefeuille des hommes.*/
proc means data=prosas.pfh;
var Reserve;
title 'Statistique descriptive de la table : prosas.pfh';
run;
/* consideration du portefeuille à premiums fixe; observations où le premium type=fixe*/
data prosas.pffixe;
set prosas.pf;
where (Premiums_type=:"Fixe");
run;
/*MACRO QUI EFFECTUE UNE PROC MEANS SUR LA TABLE PASSé EN PARAMETRE*/
%macro statmeans(table);
proc means data=&table;
var Reserve;
title 'Statistique descriptive de la table : '&table;
run;
%mend;
%statmeans(prosas.pffixe);/*STATIStique descriptive par proc means du portefeuille des premiums de tipe fixe*/
/* consideration du portefeuille à premiums level; observations où le premium type=level*/
data prosas.pflevel;
set prosas.pf;
where (Premiums_type=:"Level");
run;
%statmeans(prosas.pflevel);/*STATIStique descriptive par proc means du portefeuille des premiums de tipe flevel*/
/*Execution de procedure univariate sur les reserves pour observé les statisqtiques descriptives des hommes*/
/*execution d'un test de normalité*/
%macro statdes(table);
proc univariate data=&table;
var Reserve;
title 'Statistique descriptive de la table : '&table;
run;
%mend;
%statdes(prosas.pfh);
/*Execution de procedure univariate sur les reserves pour observé les statisqtiques descriptives des femmes*/
/*execution d'un test de normalité*/
%statdes(prosas.pff);

/*Execution de procedure univariate sur les reserves pour observé une analyse descriptive du portefeuille*/
/*execution complete de la proc univariate par l'option ALL*/
proc univariate normal data=prosas.pf;
var Reserve;
title 'Statistique descriptive de la table : prosas.pf';
run;

/*Apres avoir exécuté la proc univariate supposons que les reserve suivent une loi normale
et chaque reserve suit une loi normale, la somme de variables gaussiennes est une variable gaussienne dont
dont les parametres sont les sommes des parametres des variables additionnées*/
/*distribution gaussienne de 10 valeurs representant les reserves totales sur 10 ans*/
/*la variable project contient la projection de la solle de sreserve sur 10 ans*/
%macro loin(j);/*creation d'une variable aléatoire de loi normale*/
data prosas.annee&j;
x = RAND('normal',1202392734,100);
run;
%mend;
%macro projectloin;/*création de variables de loi normale*/
%do i=1 %to 10;
%loin(&i);
%end;
%mend;
%projectloin;/*projection des reserve sur ans*/
/*nous allons maintenant simuler les sorties du portefeuille, en evaluant à l'aide d'une loi de poisson
le nombre d'individu pouvant quitter le portefeuille sur 10 ans,pour cela nous supposons une moyenne de 100 sur les 10 ans*/
data prosas.totalout(drop=i);
x=0;
do i=1 to 10;
	x=x+rand('poisson',100);/* la dernière observation est le total de clients out du portefeuille sur 10 ans*/
	output;
  end;
run;
/*calcul des premiums sur 10 ans en tenant compte des premiums au bout de 10 ans sans tenir compte des sorties du portefeuille*/
data prosas.reservlev(drop=i);
set prosas.pflevel;
do i=1 to 10;
	premiums10=AnnualPremiums+AnnualPremiums*(0.95)**i;/* premiums10 designe le total des premiums sur 10 ans*/
end;
Reservean10=Reserve+premiums10;/* total reserve plus premiums de type level sur 10 ans, reserves au bout de 10 ans*/
run;
data prosas.reservfix;
set prosas.pffixe;
premiums10=AnnualPremiums*10;/* premiums10 designe le total des premiums sur 10 ans*/
Reservean10=Reserve+premiums10;/* total reserve plus premiums de type level sur 10 ans, reserves au bout de 10 ans*/
run;
/*creation de la table PF10ans qui va contenir le resultat du portefeuille dans 10 ans sans sorties du portefeuille*/
data prosas.pf10ans;
set prosas.reservfix;
run;
/*Concatenation de la table reservfix et reservlev qui contiendra l'ensemble du portefeuille dans 10 ans*/
proc datasets library=prosas;
append base=prosas.pf10ans data=prosas.reservlev force;
run;
proc sort data=prosas.pf10ans;/*on effectue un tri sur les id, tri ascendant*/
by id;
run;
/*Etude de statistique descriptive sur le portefeuille dans 10 ans et comparaison*/
proc means data=prosas.pf10ans;
var Reservean10;
title 'Statistique descriptive de la table : prosas.pf10ans';
run;
proc means data=prosas.pf;
var Reserve;
title 'Statistique descriptive de la table : prosas.pf';
run;
proc univariate normal data=prosas.pf10ans;
var Reservean10;
title 'Statistique descriptive de la table : prosas.pf10ans';
run;
/*Proc export pour exporter le portofolio projeté dans 10 ans dans un classeur excel en vu d'effectuer certains calculs supplémentaires*/
proc export data=prosas.pf10ans
outfile='C:\Users\Kevin BAMOUNI\Documents\SAS\prosas.xls'
DBMS=xls
replace;
sheet=pf10ans;
run;
proc export data=prosas.pf
outfile='C:\Users\Kevin BAMOUNI\Documents\SAS\prosas.xls'
DBMS=xls
replace;
sheet=pf;
run;
proc export data=prosas.mortality
outfile='C:\Users\Kevin BAMOUNI\Documents\SAS\prosas.xls'
DBMS=xls
replace;
sheet=mortalitylaw;
run;

