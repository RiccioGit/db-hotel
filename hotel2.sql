GOAL:

GROUP BY

    • Conta gli ospiti raggruppandoli per anno di nascita:

    SELECT YEAR(date_of_birth) AS 'anno_di_nascita', COUNT(*) AS 'numero_ospiti'
    FROM ospiti
    GROUP BY YEAR(date_of_birth);

    • Somma i prezzi dei pagamenti raggruppandoli per status:

    SELECT status, SUM(price) AS 'somma_pagamenti'
    FROM pagamenti
    GROUP BY status;

    • Conta quante volte è stata prenotata ogni stanza:

    SELECT stanza_id, COUNT(*) AS 'numero_prenotazioni'
    FROM prenotazioni
    GROUP BY stanza_id;

    • Fai una analisi per vedere se ci sono ore in cui le prenotazioni sono più frequenti

    SELECT HOUR(created_at) AS 'ora_prenotazione', COUNT(created_at) AS 'numero_prenotazioni'
    FROM prenotazioni
    GROUP BY HOUR(created_at)
    ORDER BY COUNT(created_at) DESC;


JOIN

    • Come si chiamano gli ospiti che hanno fatto più di due prenotazioni?

    SELECT COUNT(T1.ospite_id) AS 'num_prenotazioni', T2.name, T2.lastname
    FROM prenotazioni_has_ospiti AS T1
      JOIN ospiti AS T2
        ON T1.ospite_id = T2.id
    GROUP BY T1.ospite_id
    HAVING COUNT(T1.ospite_id) > 2

    • Stampare tutti gli ospiti per ogni prenotazione

    SELECT T1.prenotazione_id, T2.name, T2.lastname
    FROM prenotazioni_has_ospiti AS T1
    	LEFT JOIN ospiti AS T2
        ON T1.ospite_id = T2.id;

    • Stampare Nome, Cognome, Prezzo e Pagante per tutte le prenotazioni fatte a Maggio 2018

    SELECT T3.name, T3.lastname, T2.price,
          T1.created_at AS 'data_prenotazione'
    FROM prenotazioni AS T1
      JOIN pagamenti AS T2
        ON T1.id = T2.prenotazione_id
      JOIN paganti AS T3
    	  ON T2.pagante_id = T3.id
    WHERE YEAR(T1.created_at) = 2018 AND MONTH(T1.created_at) = 5
    ORDER BY T1.created_at;

    • Fai la somma di tutti i prezzi delle prenotazioni per le stanze del primo piano

    SELECT T3.floor, SUM(T1.price) AS 'totale'
    FROM pagamenti AS T1
      JOIN prenotazioni AS T2
        ON T1.prenotazione_id = T2.id
      JOIN stanze AS T3
    	  ON T2.stanza_id = T3.id
    WHERE T3.floor = 1;

    • Prendi i dati di fatturazione per la prenotazione con id=7

    SELECT T1.prenotazione_id AS 'prenotazione',
          T2.name, T2.lastname, T2.address, T1.price
    FROM pagamenti AS T1
      JOIN paganti AS T2
        ON T1.pagante_id = T2.id
    WHERE T1.prenotazione_id = 7;

    • Le stanze sono state tutte prenotate almeno una volta? (Visualizzare le stanze non ancora prenotate)

    SELECT T2.id, T2.room_number, T2.floor, T2.beds
    FROM prenotazioni AS T1
    RIGHT JOIN stanze AS T2
    	ON T1.stanza_id = T2.id
    WHERE T1.stanza_id IS NULL;
