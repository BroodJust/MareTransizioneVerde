import math
contatore=0
infile= open('Datawindwavetab_SanPietro.csv','r')
line=infile.readline()
diz={}
data= []
while line!='':                         #leggo i file del vento e prendo i dati necessari 
    
    if contatore==0:
        contatore += 1 
        line=infile.readline()
        continue
    else:
        diz={}                                  #distribuisco i dati in liste di dizionari
        line=line.rstrip('\n').split(",")
        diz['Date,Time']=line[0]
        diz['wind speed']=round(float(line[1]),2)
        diz['Power']= 0
        diz['correct cp']= 0
        data.append(diz)
        
    line=infile.readline()

infile.close()
pwr= 0

n_cp= input('Please insert turbine data file (with .csv):')             #inserisco i dati della turbina per ricavare cp
turb_data= open(n_cp)
lne= turb_data.readline()
counter=0
sve= {}
cp_data= []
while lne!='':
    lne=lne.rstrip('\n').split(',')
    if counter==0:
        counter+=1
       
    else:
        sve={}
        sve['speed']=float(lne[0])
        sve['Cp_value']=float(lne[2]) 
        cp_data.append(sve) 
    lne= turb_data.readline()
turb_data.close()
max_pwr= float(input('Insert rated power:'))
sp_rate= float(input('Insert rated wind speed:'))

for d in range(0,len(data)):
    Flag=True    
    act_speed=round(data[d]['wind speed'],2) 
    sto=0                        #inserisco il cp giusto per ogni velocità del vento
    for t in range(0,len(cp_data)):                             #ATTENZIONE: APPROSSIMAZIONE CP dell'ordine dell'unità (n) poiche vi è scostamento minimo con termini del tipo n.5
        glt=round(cp_data[t]['speed'],2)
        if sto<=act_speed and act_speed<=glt:            
            val_medio= round(((glt-sto)*0.5) +sto,2)
            #if l!=sp_rate:
            if act_speed<=val_medio:
                data[d]['correct cp']=prec['Cp_value']
            elif act_speed> val_medio:
                data[d]['correct cp']=cp_data[t]['Cp_value']
            #elif l==sp_rate:
                #data[d]['correct cp']=prec['Cp_value']
        sto=glt    
        prec=cp_data[t]


sp_in= float(input('Insert cut in wind speed:'))
sp_out= float(input('Insert cut out wind speed:'))
raggio= int(input('Insert Rotor Diameter:'))/2
rho= 1.225
pi= math.pi
somma=0

for l in range(0,len(data)):
    an=data[l]
    w_speed=an['wind speed']
    #cp=0.44                     #in questa sezione è possibile usare sia il cp costante che quello variabile
    cp= an['correct cp']
    if w_speed< sp_in or w_speed>= sp_out:         #anche se nel file sono già contenute potenze, faccio controllo e approssimo le  velocità alla seconda cifra decimale
        pwr= 0
        cf= pwr/max_pwr
        
    elif w_speed>=sp_in and w_speed<sp_rate:
        pwr=round((0.5*rho*pi*(raggio**2)*cp*(w_speed**3))/1000,2)
        if pwr>=max_pwr:
            pwr= max_pwr
        cf= pwr/max_pwr
    elif w_speed>=sp_rate and w_speed<sp_out:
        pwr=round(max_pwr,2)
        cf= pwr/max_pwr
    an['Power']=pwr
    an['Capacity factor']=cf
    somma+=cf
    
media= somma/len(data)
print('Capacity Factor:',media)



import csv          #scrivo il csv
import os

output_dir = 'output'
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

with open(os.path.join(output_dir, 'SanPietro_power_data1.5MW.csv'), 'w', newline='') as outfile:
    fieldnames = ['Date,Time', 'wind speed', 'Power','correct cp','Capacity factor']
    writer = csv.DictWriter(outfile, fieldnames=fieldnames)

    writer.writeheader()

    for row in data:
        writer.writerow(row)
        .1






#valore sopra- valore sotto /2 -+ valore sotto