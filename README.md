# Makeopardy et spørrespill for MAKE NTNU
Makeopardy er et quizspill laget hovedsakelig for å brukes til MAKE NTNU semesterstarter og -avslutninger. Spillet er inspirert av Jeopardy sitt format, der det er flere kategorier med spørsmål, og vanskeligere spørsmål gir flere poeng. I Makeopardy kan man også ha flere sider med spørsmål, og de senere sidene gir flere poeng enn de første. Spillet er laget for å spilles med fem (5) lag.

## Hvordan styre spillet
Ved starten av spillet er det lurt om hvert lag finner på et lagnavn. 
<img width="360" height="400" alt="image" src="https://github.com/user-attachments/assets/25271ec0-00fc-4e01-a47e-108df99076d4" />
For å endre på et lagnavn trykker man på laget sitt felt på høyre side av skjermen. Da vil et tekstfelt dukke opp til høyre for spill-logoen. 
Når navnet er skrivd inn, **trykker man på 'enter' for å bekrefte**.

<img width="720" height="400" alt="image" src="https://github.com/user-attachments/assets/678b45d4-ac22-4ef9-b086-d1bea0b63bb2" />
Etter at alle lagene har fått hvert sitt navn, må det bestemmes hvilket lag som starter. Jeg stemmer for at laget med færrest semestre i MAKE NTNU mellom seg starter. 
Laget som starter velger en kategori og en poengsum, for eksempel "Spill for 300". Spillmesteren trykker da på den relevante spørsmål-knappen. Da dukker spørsmålet opp midt på skjermen.
Laget som først trykker på knappen sin, får mulighet til å svare på spørsmålet. Knappen til lagene er bundet til tallene 0-4, der det øverste laget er 0, og det nederste er 4.
Svaret registreres ved å trykke på svar-knappen etter at et lag har trykket på knappen sin. Hvis svaret er riktig går spillet tilbake til startskjermen, hvis ikke så får et annet lag muligheten til å svare.
Når et spørsmål allerede er besvart, blir knappen til spørsmålet deaktivert.
Etter at det siste spørsmålet på en side er fullført, vil siden automatisk bli erstattet med den neste siden. Når den siste siden er ferdig er spillet ferdig, og vinnerlaget lyses opp på siden av skjermen.

## Hvordan kjøre spillet
Først må spillet lastes ned. [Dette kan gjøres med denne linken](https://github.com/RobeThor/Makeopardy/archive/refs/heads/master.zip) eller ved å trykke "<> Code" så "Download ZIP" som vist på bildet.
<img width="750" height="400" alt="image" src="https://github.com/user-attachments/assets/98981d0c-17c9-447d-a971-25848fae9f5f" />

Når .zip filen er lastet ned å extracted, så inneholder den en drøss med filer. De eneste som er av interesse er "Makeopardy.exe" og "jeopardyFormat.json". 
<img width="429" height="400" alt="image" src="https://github.com/user-attachments/assets/109c1c38-e975-446c-85be-b2cdf41b158a" />
Makeopardy.exe brukes for å kjøre spillet, og jeopardyFormat.json definerer spørsmålene.
For å endre spørsmålene trenger man bare å endre jeopardyFormat.json. Bildet under viser et eksempel på gyldig format med 3 sider.
<img width="327" height="400" alt="image" src="https://github.com/user-attachments/assets/ff53ce25-5834-47f6-9038-12e5da76f550" />
Dette bildet viser en gyldig side. For å få plass på bildet er kategori 2, side 2 og side 3 kollapset, og kategori 1 har kun 2 spørsmål. 
Spillet støtter i teorien et uendelig antall sider (testet opp til 3), med opptil 5 kategorier med opptil 5 spørsmål hver. Spillet gir ikke feilmelding dersom det er for mange kategorier eller spørsmål.

<img width="360" height="159" alt="image" src="https://github.com/user-attachments/assets/3c81911a-fa60-44da-8e04-baa7c2051e6f" />
Hvert spørsmål **må** ha tre (3) svaralternativer, alt1, alt2 og alt3. "correctAlt" definerer hvilket alternativ som er riktig, og må være et heltall mellom 1-3.

<img width="396" height="394" alt="image" src="https://github.com/user-attachments/assets/6b132426-c8f5-4571-af51-52c0a9843cd9" />
Hver kategori **må** ha et kategorinavn og minst ett (1) spørsmål.

<img width="262" height="486" alt="image" src="https://github.com/user-attachments/assets/46b9b807-84ad-4216-8414-8e41e343cab5" />
Det første elementet i JSON filen **må** hete "pages". Det er også svært viktig å opprettholde riktig mengde med krøllparenteser, og at det er komma mellom alle elementer på samme innrykk.

Poengpremiene for hvert spørsmål håndteres automatisk av spillet. På første side er spørsmålene verdt 100-500 poeng, og på senere sider multipliseres poengpremien med sidenummer (200-1000 på side 2, 300-1500 på side 3, etc.).
