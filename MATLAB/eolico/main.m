%%% ALGORIMO PER APPROX DELLE PRESTAZIONI
%%% DELLE PALE EOLICHE

%% apro i file .csv
clc; clear all;
% nome del file da dove estrarre le info sul modulo100
isola = readtable("Datawindwavetab_Tahiti.csv");
v = isola{:,"modulo100"}';
v=round(v,3, "decimals");

% nome del file con info sulla pala eolica
turbine= readtable("turbine8MWh.csv");
wind = turbine{:,"wind"}';
p= turbine{:,"power"}';
cp= turbine{:,"cp"}';

%% analisi
clc; clearvars -except isola v wind cp p turbine;

%potenza prodotta ricavata interpolando i dati 
pprod= pchip(wind,p,v);
pinst=8000;
%calcolo del CF orario
CF= pprod./pinst;    
A=[pprod',CF'];
%esportazione dei dati
writematrix("P_prodotta[MW],CF%","MWprodotta.csv")
writematrix(A,"MWprodotta.csv","Delimiter",",");



%% utile solo per visualizzare quanto è buona l'approssimazione
figure
hold on
plot(wind,p);
plot(v,pprod,"x");
legend("curva prestazioni pala","risultato dell'interpol.");




