%%% ALGORITMO PER APPROX DEL MOTO ONDOSO 
%%% E DELL'ENERGIA PRODOTTA
%% apertura dei file i file 
clc; clear all;

%indicare lo sheet per scegliere l'isola
SHEET="Tahiti";
x=readtable("tabella_onde.xlsx","Sheet","Power Matrix","Range","C2:AI2");
x=table2array(x);
y=readtable("tabella_onde.xlsx","Sheet","Power Matrix","Range","B3:B29");
y=table2array(y);
y=y';
P=readtable("tabella_onde.xlsx","Sheet","Power Matrix","Range","C3:AI29");
P=table2array(P);

%% Analisi
[x,y]=meshgrid(x,y);

%importazione dei dati 
xq=readtable("tabella_onde.xlsx","Sheet",SHEET,"Range","B3:B8761");
xq=table2array(xq);
xq=xq';
yq=readtable("tabella_onde.xlsx","Sheet",SHEET,"Range","C3:C8761");
yq=table2array(yq);
yq=yq';
xq=diag(xq);        
yq=diag(yq);

%interpolazione dei dati
tq = interp2(x,y,P,xq,yq,"linear");
max=76891.20;
Tq=diag(tq);
CF=Tq./max;

%esportazione dei dati 
writematrix(Tq,"tabella_onde.xlsx","Sheet",SHEET,"Range","M2");
writematrix(CF,"tabella_onde.xlsx","Sheet",SHEET,"Range","N2");


%% grafico 
%si graficano n punti per non sovraccaricare il calcolatore
n=2500;
X=diag(xq);
Y=diag(yq);
X=X(1:n,:);
Y=Y(1:n,:);
Tq=Tq(1:n,:);

figure
surf(x,y,P);
title("Power Matrix (W) PeWEC");
colorbar;
hold on 
plot3(X,Y,Tq,"rx");
legend("","Power from interpol.")
xlabel('T(s)');
ylabel('H(m)');

 

