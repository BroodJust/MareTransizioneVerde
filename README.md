# MareTransizioneVerde
Il mare e la transizione verde (Grandi Sfide - Energia). Maggiori informazioni sul [sito](https://didattica.polito.it/pls/portal30/gap.pkg_guide.viewGap?p_cod_ins=01DEDMN&p_a_acc=2024&p_header=S&p_lang=&multi=N).

Sono in seguito riportati i programmi usati per la modellazione energetica delle isole di Tahiti(FR) e San Pietro(IT).

## MATLAB
- Approssimazione della potenza prodotta dalla pala eolica:
  tramite la curva di potenza è stato possibile interpolare i dati del vento ed ottenere una approssimazione della
  potenza prodotta ogni ora 

- Approssimazione della potenza prodotta dal _wave energy converter_:
  tramite la _power matrix_ è stato possibile interpolare i dati relativi al moto ondoso ed ottenere un'approssimazione della
  potenza prodotta ogni ora

- Accumulo dell'energia non consumata: tramite un algoritmo si è modellato un modello di accumulo energetico
  con l'obbiettivo limitare le quote di energia persa.

## DOCUMENTAZIONE
I file .csv relativi alle prestazioni delle pale eoliche sono consultabili presso: [NREL/tubine-models](https://github.com/NREL/turbine-models).

I dati della risorsa solare sono scaricabili presso: [PVGIS 5.2](https://re.jrc.ec.europa.eu/pvg_tools/en/)

I dati della risorsa eolica e marina sono scaricabili presso: [ERA5](https://climate.copernicus.eu/climate-reanalysis)
