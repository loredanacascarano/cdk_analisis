library(readxl)

db=read_excel("/Users/loredanacascarano/Desktop/unicatt/data analisi/cdk_analisis/db.xlsx")
View(db)

####elimino tutti i casi missing dal campione.
#utilizzo na.omit 

db1=na.omit(db)

View(db1)

#il campione è così composto da 157 soggetti.


####statistiche descrittive e la distribuzione di frequenza#####

summary(db1$age)
summary(db1$blood_pressure)
summary(db1$albuin)
summary(db1$sugar)

#il campione analizzato è composto da 157 soggetti che hanno, in media 49.5 anni di età. l'età varia tra 6 e i 83 anni. La distribuzione per
#tale variabile è quasi simmetrica in quanto mediana e media combaciano quasi tra loro.
#per quanto concerne invece le altre variabili di interesse si ha che la pressione media è di 73.95, mentre l'albumina è in media pari a 0.78.
#infine il livello di zuccheri mediamente è basso in quanto il suo valore medio è pari a 0.24 rispetto ad un valore massimo pari a 5.

table(db1$class)

#in merito alla principale variabile di outcomes (class) dalla tabella, si ha che il 73.2% del nostro campione non è affetto da
#disease cronica, mentre la restante parte è composta da soggetti aventi una forma cronica della malattia.


####al fine di alleggerire il dataset per la computazione dei modelli tengo le variabili principali che sono di mio interesse


db2=subset(db1,select= c(age,blood_pressure,albuin,sugar,class))


#####prima di stimare il modello di regressione lineare controllo se esiste, e quanto è forte, la correlazione tra la variabile
#di interesse e le variabili di controllo.

#per far ciò creo una matrice chiamata matricecorr che arrotonda a 2 cifre i coefficienti di correlazione per tutte le variabili presenti
#all'interno del mio dataset (db2)


matricecorr = round(cor(db2), digits = 2)
matricecorr

#la variabile dipendente class è correlata almeno allo 0.30 con tutte le altre variabili.
#Nello specifico è altamente correlata (0.93) con il livello di albumina nel sangue: questa variabile potrebbe avere un ingente impatto all'interno della relazione. 
#Analogamente sugar presenta un indice di correlazione di media intensità (0.51) 
#sottolinea il forte impatto che anche tale variabile potrà avere all'interno del nostro modello.
#età e blood pressure presentano infine valori di correlazione medio-bassi, corrispettivamente 0.30 e 0.32, con la variabile di interesse.

#le correlazioni tra tutte le variabili di controllo difficilmente superano il valore di 0.3 (indice che queste variabili hanno un livello non troppo accentuato di correlazione tra loro, evitando il multicollinearity bias)
#tuttavia sugar e albumina sono correlate tra loro a 0.5. ciò implica che tali variabili potrebbero generare multicollinearity bias ma le considereremo 
#comunque all'interno del nostro modello.


################MODELLI DI REGRESSIONE################

#volendo individuare e riuscire a predire la probabilità che un soggetto sia più o meno affetto da cdd è opportuno utilizzare
#il modello di regressione lineare.
#dal momento che ci sono più variabili di controllo, utilizzo una procedura analitica detta stepwise, ovvero inserisco progressivamente
#le variabili di controllo all'interno del modello al fine di monitorare se e come queste migliorino la spiegazione del nostro

#Considerando che l'albumina rappresenta la variabile indipendente con la maggiore correlazione rispetto alla variabile dipendente y nel mio dataset,
#ho optato per priorizzare l'elaborazione e l'analisi del modello denominato con m0.

m0=lm(db2$class~db2$albuin)
summary(m0)

# Inizialmente, l'analisi rivela che sia l'intercetta che il principale regressore, l'albumina, sono significativi,
# con l'albumina che presenta un p-value quasi nullo. Questo indica che l'effetto dell'albumina sulla variabile dipendente
# è notevolmente significativo e non ascrivibile al caso, consentendo di estendere le inferenze all'intera popolazione di interesse.

# Dal coefficiente β, si evince che un incremento unitario nei livelli di albumina è associato a un aumento di 0.29
# nella probabilità di sviluppare una malattia cronica, sottolineando l'importanza clinica di questo parametro come predittore.

# Inoltre, l'impiego di una sola variabile esplicativa permette al nostro modello di catturare circa l'86% della variabilità
# osservata nel fenomeno studiato, evidenziato da un indice di R-quadrato multiplo pari a 0.86, dimostrando un'elevata capacità
# predittiva del modello considerato.


#inserisco la seconda variabile di interesse (sugar)

m1=lm(db2$class~db2$albuin+db2$sugar)
summary(m1)


# Tale esito potrebbe essere attribuito al fenomeno di multicollinearità tra le due variabili, in cui quella più fortemente correlata con la variabile dipendente (albumina)
# tende a "dominare" in termini di impatto sul modello rispetto alla seconda variabile. Ciò suggerisce che, nonostante l'aggiunta di "sugar" come variabile esplicativa,
# il suo contributo non migliora significativamente la capacità esplicativa del modello a causa della sua ridotta significatività statistica e della possibile
# sovrapposizione informativa con l'albumina.

#aggiungo nuovamente una terza variabile di controllo, come la pressione sanguigna (blood pressure)


m2=lm(db2$class~db2$albuin+db2$sugar+db2$blood_pressure)
summary(m2)

#anche in questo caso la variabile pressione sanguigna sembra non essere significativa all'interno della relazione analizzata, così come non sembra mutare l'indice di bontà del modello (adj-rsquare=)
#ciononostante, seppur non risultino significativi, ciò che possiamo appurare è come (considerando ESCLUSIVAMENTE QUESTO CAMPIONE) l'aumento di zuccheri e pressione sanguigna abbiano un impatto positivo
#sulla probabilità di contrarre cdx

#infine completo il modello comprensivo di tutte le nostre variabili, inserendo quindi la variabile età

m3=lm(db2$class~db2$albuin+db2$sugar+db2$blood_pressure+db2$age)
summary(m3)

#l'inserimento della variabile età, che risulta significativa al 10%, migliora lievemente la capacità esplicativa del modello (r-square adj pari a 0.86)
#dall'analisi dei coefficienti si nota che, rispetto a m(0) l'impatto di albuin cali lievemente (passando a 0.29 circa a 0.28), mentre per quanto riguarda
#la nostra variabile age possiamo appurare come all'aumento di 1 anno d'età la probabilità di contrarre una disease cronica aumenti di 0.002
  
  
#conclusioni#

#l'analisi qui proposta ha voluta analizzare come una serie di fattori quali i livelli di albumina e di zucchero, la pressione del sangue, e l'età potessero
#impattare sulla probabilità di avere o meno una disease cronica ai reni.

#ciò che è merso dalla nostra analisi preliminare è come il campione sia composto prevalentemente da soggetti aventi in media 50 con circa 1 soggetto su 4 (27%)che ha una patologia cronica
#ai reni.

#l'analisi di correlazione ha evidenziato come le variabili sono adeguatamente correlate con la nostra principale variabile di interesse. In particolar modo risulta molto
#significativa la relazione con l'albumina (.92) e lo zucchero (xxx). L'analisi delle correlazioni lascia inoltre intravedere come potrebbe sussistere una distorsione di multicollinearità tra i 
#zucchero e albumina ma, ai fini esplicativi ed esplorativi di cui questo report è oggetto, li includere all'interno del nostro modello.

#l'analisi di regressione stepwise ha evidenziato come fosse l'albumina la principale variabile in grado di contribuire maggiormente alla prevedibilità di essere/non essere malato cronico (m0).
#Nello specifico il primo modello stimato riporta un elevato coefficente R-quadro e la significatività del regresso albumina (altamente significativa essendo prossima allo 0).

#L'inserimento nel modello 2/3 delle altre variabili di controllo non contribuisce a spiegare maggiormente la relazione, in quanto tali coefficienti non risultano significativi all'interno del modello stesso.
#ciononostante se considerassimo validi tali coefficienti, seppur esclusivamente al nostro campione, potremmo evidenziare come questi abbiamo un impatto positivi sulla prob d avere malattie croniche

#infine, inserendo la variabile età, si appura come questa abbia un effetto positivo e significativo sulla nostra y (seppur tale impatto, in termini di significatività non siano alti come albumina) e come questa
#aiuti a spiegare maggiormente la relazione analizzata (l'square adj migliora infatti, seppur lievemente)

