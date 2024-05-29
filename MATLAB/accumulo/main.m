%%% ALGORITMO PER LA FUNZIONE 
%%% DI ACCUMULO ENERGETICO DEL MODELLO 

%% apro i file .csv
clc; clear all -except prod;
FILE="FinalTabSanpietro.xlsx";
%lettura dei dati dal file specificato sopra
prod = readtable(FILE,"sheet","FinalTab","Range","M2:M8761");
prod = table2array(prod);

%% algoritmo di accumulo 

%grandezze dell'accumulatore        
SOC=zeros(1,length(prod));      %stato di carica
SOC(1)=0;                       %stato di carica iniziale 
Ebess=10;                       %capacità di carica [MWh]
ebess=0;                        %carica batteria [MWh]
eta_car=0.85;                   %efficienza carica
eta_scar=0.85;                  %efficienza scarica
V=10;                           %capacità accumulatore [MWh]
Prod_DSL=zeros(1,length(prod)); %produzione diesel finale 
P_medh=zeros(1,length(prod));   %potenza media oraria scamb        

%primo step iterazione
if prod(1)<0
    Prod_DSL(1)=abs(prod(1));
end

%iterazione per ogni ora
for i=2:(length(prod))

    %possibile accumulo
    if prod(i)<0
        %spazio accumulo
        if SOC(i-1)<1 %carica

            if (1-SOC(i-1))*Ebess>abs(prod(i))*eta_car
                SOC(i)=SOC(i-1)+(abs(prod(i))*eta_car)/Ebess;

            else      %carica massima
                SOC(i)=1;
            end
            
        end
        
    %non possibile accumulo
    else    
        %preleviamo se possibile
        if SOC(i-1)>0
            if (SOC(i-1)*Ebess)>prod(i)/eta_scar
                %prendo carica e non produco con dsl
                SOC(i)=SOC(i-1)-(prod(i))/(Ebess*eta_scar);
            else
                %prendo carica e produco con dsl il resto
                Prod_DSL(i)=prod(i)-(SOC(i-1)*Ebess*eta_scar);
                SOC(i)=0;
            end
        %produzione dsl    
        else
            Prod_DSL(i)=prod(i);
        end
    end

    P_medh(i)=abs(SOC(i)-SOC(i-1))*V;
end 
SOC=SOC';
P_medh=P_medh';
Prod_DSL= Prod_DSL';
%% scrittura dei risutati
t = table(SOC,Prod_DSL);
writetable(t,FILE,"sheet","matlab","Range","B1");
writematrix(max(P_medh),FILE,"sheet","matlab","Range","I4");


Message="DONE!"


