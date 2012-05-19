# Idiomatisk Python - del 1 av 3

Alle språk har sine særegenheter, med sine styrker og svakheter. 
Bak et hvert språk ligger en filosofi—en tanke om hvordan språket bør brukes.
Dette reflekteres gjerne i hvilke konstruksjoner og konsepter språket tilbyr.
For å skrive pen kode er det viktig å kjenne og bruke språkets særegenheter; de uttrykk som er idiomatiske for språket.

Dette er første del i en serie på 3 bloggposter om idiomatisk Python.
I denne delen tar vi for oss begrepet *Pythonisk kode* og diskuterer en rekke konsepter som underbygger dette.
Del 2 kommer til å ta for seg sekvenser og lister, og gå igjennom hvordan Python legger opp til å arbeide med slike på en god måte.
I den siste posten skal vi ta en nærmere titt på funksjoner i Python, og hva disse kan brukes til.

Bloggpostene er basert på [del 2](http://magnhaug.github.com/BEKK-Python-Kurs/slides/del2.html#1) av BEKKs [kursserie om Python](https://github.com/bekkopen/BEKK-Python-Kurs) på NTNU, og er derfor beregnet på lesere som kjenner grunnleggende Python uten å være godt kjent med språket.

## Hva er Pythonisk kode?

Pythonisk kode er kode som bruker vanlige idiomer i Python på en god måte, i stedet for å implementere koden ved hjelp av konsepter og teknikker som er vanligere i andre språk.

Dette kan illustreres med et enkelt eksempel hentet fra Pythons [offesielle ordliste](http://docs.python.org/glossary.html#term-pythonic).
I mange språk er det vanlig å iterere over elementer i lister ved hjelp av ei løkke og en eksplisitt indeks.

        for (int i=0; i<food.length; i++) {
            System.out.println(food[i]);
        }

Dette er også mulig i Python, og kunne vært implementert på denne måten:

        i = 0
        while i < len(food):
            print food[i]
            i += 1

I Python er det imidlertid unødvendig å involvere indekser for dette siden det er et vanlig idiom å iterere over alle elementene i en sekvens direkte.
 
    for piece in food:
        print piece

Vi ser at koden umiddelbart blir enklere og penere ved at vi kvitter oss med den forstyrrende indeksen.
Dette er selvsagt et overforenklet eksempel, men illusterer godt essensen i hva som menes med *pythonisk* kode.
Mens kode som *ikke* er pythonisk gjerne kjennetegnes ved at den virker tungvint eller unødig omfattende og ordrik for en erfaren Python-programmerer, vil pythonisk kode utnytte de verktøyene Python tilbyr på slik måte at den uttrykkes enklest mulig.

Det er, for eksempel, pythonisk å utnytte mulighetene til Pythons datastrukturer på en ren og lesbar måte, eller å basere seg på duck typing i stedet for å eksplisitt sjekke typer før en utfører operasjoner.
Et annet eksempel er å strukturere kode på enklest mulig måte — alt trenger ikke være klasser, men klasser bør brukes der det gir mening.

## The Zen of Python

Dette er tett knyttet opp mot filosofien om minimalisme og enkelhet som underbygger Python.
Den beste beskrivelsen av denne filosofien er kanskje gitt i The Zen of Python:

    >> import this
    The Zen of Python, by Tim Peters

    Beautiful is better than ugly.
    Explicit is better than implicit.
    Simple is better than complex.
    Complex is better than complicated.
    Flat is better than nested.
    Sparse is better than dense.
    Readability counts.
    Special cases aren't special enough to break the rules.
    Although practicality beats purity.
    Errors should never pass silently.
    Unless explicitly silenced.
    In the face of ambiguity, refuse the temptation to guess.
    There should be one-- and preferably only one --obvious way to do it.
    Although that way may not be obvious at first unless you're Dutch.
    Now is better than never.
    Although never is often better than *right* now.
    If the implementation is hard to explain, it's a bad idea.
    If the implementation is easy to explain, it may be a good idea.
    Namespaces are one honking great idea -- let's do more of those!

For å oppsummere, det aller viktigste er at kode er enkel og uttrykksfull.
Vi ønsker kode som er så enkel å forstå at den blir vakker.

> *Programs must be written for people to read, and only incidentally for machines to execute.*  
> —Abelson & Sussman, Structure and Interpretation of Computer Programs

Dette oppnår vi altså i Python ved å kjenne språket, og bruke de konstruktene som tilbys på riktig måte.
Vil du lese mer, inneholder [denne stackoverflow-posten](http://stackoverflow.com/questions/228181/the-zen-of-python) diskusjoner og beskrivelser av hva som menes med mange uttrykkene i Zen of Python.

La oss gå videre til å se på noen utvalgte konsepter vi mener er viktige å kjenne for å skrive god pythonisk kode.

## Duck typing

Et viktig konsept som mange prater om i sammenheng med pythonisk kode er *duck typing*.
Tankegangen går ut på at hvis et objekt støtter den operasjonen vi ønsker å utføre, så er det ikke så farlig hvilken type objektet har.

La oss for eksempel si at vi har et filobjekt `fil`, og ønsker å skrive til dette.
Ettersom Python er dynamisk typet vil vi ofte ikke kunne være sikre på at `fil` faktisk er av typen `file` før under kjøretid.
En (lite pythonisk) måte å håndtere dette på vil være å sjekke typen på `fil` før vi skriver til den.

    if isinstance(fil, file):
        fil.write(data)

Det vi i virkeligheten bryr oss om er egentlig ikke *hva* `fil` er, så lenge det er mulig å skrive til den.

    try:
        fil.write(data)
    except:
        # håndter feilsituasjon

Implementert på denne måten kan `fil` godt være en fysisk fil, en socket, eller noe helt annet, så lenge vi får skrevet dataene våre.

Navnet *duck typing* stammer fra en [diskusjon i pythons mailinglister](http://groups.google.com/group/comp.lang.python/msg/e230ca916be58835):

> *don't check whether it IS-a duck: check whether it QUACKS-like-a duck, WALKS-like-a duck, etc, etc, depending on exactly what subset of duck-like behaviour you need*

Et par akronymer som gjerne trekkes frem i forbindelse med duck typing er [EAFP (Easier to Ask Forgivness than Permission)](http://docs.python.org/glossary.html#term-eafp) og [LBYL (Look Before You Leap)](http://docs.python.org/glossary.html#term-lbyl).
EAFP dreier seg om å forsøke å gjennomføre det en ønsker, uten å på forhånd sjekke alle mulige ting som kan gå galt.
I stedet for å forsøke å forhindre alle feil, håndteres de dersom de skulle oppstå.

Duck typing er altså et eksempel på EAFP.
Det regnes generelt som mer pythonisk å følge EAFP, men ikke glem at det viktigste alltid er at koden blir lesbar og forståelig.

## The `with` statement

Noe om ting som støtter with: filer, etc.

Noe om hvordan implementere `__enter__` og `__exit__` selv.

## Gettere og settere

Klasser med private felter, som eksponeres ved hjelp av getter- og setter-metoder er et vanlig pattern i mange språk.
Dette er *ikke* pythonisk!

Joda, det er viktig med enkapsulering, men Python byr på et konstrukt som løser dette på en langt mer elegant måte.

TODO: beskriv `@property`

## Flere ting?

- dictionary get, setdefault, og defaultdict
- strengformatering
- key functions
- python moduler og pakker
- script-kode i moduler

        if __name__ == '__main__':
            # script code here

---

Magnus Haug / Kjetil Valle
