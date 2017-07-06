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

