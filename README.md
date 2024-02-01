# Analisi delle Malattie Renali

In questo progetto mi sono concentrata sull'analisi dei dati relativi alle malattie renali, con l'obiettivo di identificare i fattori che influenzano la probabilità di sviluppare una malattia renale cronica. Utilizzando il linguaggio di programmazione R e specifici pacchetti per l'analisi dei dati, ho eseguito diverse operazioni di pre-elaborazione, analisi esplorativa, e modellazione statistica.

## Preparazione dei Dati

I dati sono stati caricati utilizzando la libreria `readxl` dal seguente link: [Chronic Kidney Disease Dataset](https://archive.ics.uci.edu/ml/datasets/Chronic_Kidney_Disease). Successivamente, ho pulito il dataset rimuovendo tutte le osservazioni con valori mancanti, utilizzando la funzione `na.omit`. Il dataset finale per l'analisi comprende 157 soggetti.

## Analisi Esplorativa

Ho condotto un'analisi descrittiva sulle variabili chiave: età, pressione sanguigna, albumina e zucchero nel sangue. Il campione analizzato ha un'età media di 49.5 anni, con una pressione sanguigna media di 73.95 mmHg, un livello medio di albumina di 0.78 g/dL, e un livello medio di zucchero di 0.24 unità rispetto a un massimo di 5. Inoltre, il 73.2% del campione non è affetto da malattie renali croniche.

## Analisi di Correlazione

Ho esplorato le correlazioni tra la variabile dipendente (presenza di malattia renale cronica) e le variabili indipendenti (età, pressione sanguigna, albumina e zucchero). L'albumina mostra una forte correlazione (0.93) con la presenza di malattie renali croniche, suggerendo un significativo impatto predittivo.

## Modelli di Regressione

Per predire la probabilità di malattie renali croniche, ho utilizzato modelli di regressione lineare, progressivamente aggiungendo variabili di controllo per valutare il loro impatto. Il modello iniziale (m0) include solo l'albumina, evidenziando una significativa relazione con la presenza di malattie renali. L'aggiunta di ulteriori variabili (zucchero, pressione sanguigna, età) ha portato a variazioni minime nella capacità esplicativa del modello.

## Conclusioni

L'analisi ha evidenziato l'importanza dell'albumina e, in misura minore, dell'età come predittori della malattia renale cronica. Le altre variabili, pur non risultando significative nei modelli avanzati, hanno mostrato un potenziale impatto positivo sulla probabilità di sviluppare la malattia. Ricerche future potrebbero beneficiare dall'esplorazione di ulteriori variabili socio-demografiche e dall'adozione di modelli statistici più complessi.
