# Idiomatisk Python - del 1 av 3

Alle språk har sine særegenheter, med sine styrker og svakheter. 
Bak et hvert språk ligger en filosofi—en tanke om hvordan språket bør brukes.
Dette reflekteres gjerne i hvilke konstruksjoner og konsepter språket tilbyr.
For å skrive pen kode er det viktig å kjenne og bruke språkets særegenheter; de uttrykk som er idiomatiske for språket.

Dette er første del i en serie på 3 bloggposter om idiomatisk Python.
I denne delen tar vi for oss begrepet *Pythonisk kode* og diskuterer en rekke konsepter som underbygger dette.
Del 2 kommer til å ta for seg sekvenser og lister, og gå igjennom hvordan Python legger opp til å arbeide med slike på en god måte.
I den siste posten skal vi ta en nærmere titt på funksjoner i Python, og hva disse kan brukes til.

Bloggpostene er delvis basert på [del 2](http://magnhaug.github.com/BEKK-Python-Kurs/slides/del2.html#1) av BEKKs [kursserie om Python](https://github.com/bekkopen/BEKK-Python-Kurs) på NTNU, og er derfor beregnet på lesere som kjenner grunnleggende Python uten å være godt kjent med språket.

## Hva er Pythonisk kode?

Pythonisk kode er kode som bruker vanlige idiomer i Python på en god måte, i stedet for å implementere koden ved hjelp av konsepter og teknikker som er vanligere i andre språk.

Dette kan illustreres med et enkelt eksempel hentet fra Pythons [offisielle ordliste](http://docs.python.org/glossary.html#term-pythonic).
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
> — Abelson & Sussman, Structure and Interpretation of Computer Programs

Dette oppnår vi altså i Python ved å kjenne språket, og bruke de konstruktene som tilbys på riktig måte.
Vil du lese mer inneholder [denne stackoverflow-posten](http://stackoverflow.com/questions/228181/the-zen-of-python) gode diskusjoner og beskrivelser, og du kan også ta en titt på [eksempler på alle uttrykkene](http://artifex.org/~hblanks/talks/2011/pep20_by_example.html) fra Zen of Python.

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

### EAFP over LBYL

Et par akronymer som gjerne trekkes frem i forbindelse med duck typing er [EAFP (Easier to Ask Forgivness than Permission)](http://docs.python.org/glossary.html#term-eafp) og [LBYL (Look Before You Leap)](http://docs.python.org/glossary.html#term-lbyl).
EAFP dreier seg om å forsøke å gjennomføre det en ønsker, uten å på forhånd sjekke alle mulige ting som kan gå galt.
I stedet for å forsøke å forhindre alle feil, håndteres de dersom de skulle oppstå.

Duck typing er altså et eksempel på EAFP.
Det regnes generelt som mer pythonisk å følge EAFP, men ikke glem at det viktigste alltid er at koden blir lesbar og forståelig.

## Magiske metoder

Magiske metoder, eller [special method names](http://docs.python.org/reference/datamodel.html#specialnames) som de heter i Pythons offisielle dokumentasjon, er et kraftfullt verktøy som det er vel verdt å lære å bruke. 
Disse metodene lar oss implementere egendefinert oppførsel for mange av Pythons innebygde operasjoner.

Den første "magiske" metoden nye Python-programmerer blir introdusert for er gjerne `__init__`, som lar oss definere initialiseringen av et objekt.
I tillegg finnes `__new__` og `__del__` som henholdsvis instansierer objektet og kalles når objektet slettes ved garbage collection.

Den virkelige nytten til de magiske metodene ligger likevel i at de lar oss lage egendefinerte objekter oppføre seg som innebygde typer.
Et vanlig eksempel er sammenlikning av to objekter.
Ved å implementere én enkelt metode, `__cmp__(self, other)`, støtter klassen sammenlikning på alle de vanlige måtene slik som `==`, `!=`, `<` og `>`.

På samme måte finnes det metoder for å overlaste aritmetiske operasjoner, typekonvertering, aksessering av atributter, behandling objekter som sekvenser, og mer.
Listen over tilgjengelige metoder er langt mer omfattende enn vi kan dekke i denne bloggposten.
Les heller videre på  [denne fabelaktige guiden](http://www.rafekettler.com/magicmethods.html) for å lære om de mulighetene som finnes.

## Funksjoner er objekter

I Python er alle data representert som [objekter](http://docs.python.org/reference/datamodel.html#objects).
Dette gjelder ikke bare vanlige datastrukturer som tall, strenger og lister, men også som funksjoner, generatorer og klasser.

Som tidligere nevnt bryr vi oss skjeldent om hvilke typer vi jobber med i pythonisk kode, så lenge de har de egenskapene vi trenger.
Den egenskapen vi trenger fra noe vi vil behandle som en funksjon er at den *kan kalles*.

Python inkulderer flere typer objekter med denne egenskapen.
Dette gjelder naturligvis både brukerdefinerte og innebygde funksjoner og metoder, men også iteratorer og generatorer (som vi kommer nærmere tilbake til i del 2 av denne blogg-serien).
Klasser kan også kalles, noe som gjerne fører til at en instans av klassen returneres.

I tillegg til dette kan noen ganger også instanser kalles som om de var funksjoner.
Dette kan vi oppnå ved å benytte en av de *magiske metodene* diskutert over.
Hvis en klasse implementerer en metode som heter `__call__`, så kan instanser av denne klassen kalles på samme måte som funksjoner.

    >>> class Foo():
    ...     def __call__(self):
    ...         return "bar"
    ...
    >>> foo = Foo()
    >>> foo
    <__main__.Foo instance at 0xb72b9e2c>
    >>> foo()
    'bar'

## `with`-uttrykk

Et veldig vanlig mønster en ofte møter i mange kontekster er en variasjon over følgende.

    # noe settes opp
    try:
        # utfør operasjon
    except:
        # noe rives ned
        
Det som settes opp og rives ned kan for eksempel være en fil eller databasetilkobling som åpnes og lukkes.
I stedet for at man skal tvinges til å gjøre dette overalt i koden, støtter mange av Pythons innebygde klasser et [with-uttrykk](http://docs.python.org/reference/compound_stmts.html#with).

Et eksempel er [fil-objekter](http://docs.python.org/library/stdtypes.html#file-objects), som lar oss skrive

    with open(filnavn) as f:
        # utfør operasjon med f

i stedet for

    f = open(filnavn)
    try:
        # utfør operasjon med f
    finally:
        f.close()

Det er også mulig å lage sine egne klasser som støtter `with`.
Dette gjøres ved å la klassen implementere metodene [`__enter__` og `__exit__`](http://docs.python.org/reference/datamodel.html#with-statement-context-managers) som begge er eksempler på *magiske metoder* beskrevet over.
For mer informasjon om hvordan dette fungerer, se [denne bloggposten](http://effbot.org/zone/python-with-statement.htm).

## Gettere og settere

Klasser med private felter som eksponeres ved hjelp av enkle get- og set-metoder er et vanlig pattern i mange språk.
Dette anses *ikke* for å være pythonisk!
Joda, det er viktig med enkapsulering, men et lass med gettere og settere for alle tenkelige attributter er ikke nødvendig for å oppnå dette. 
Som Phillip J. Eby uttrykker det i [Python Is Not Java](http://dirtsimple.org/2004/12/python-is-not-java.html):

> *In Java, you have to use getters and setters because using public fields gives you no opportunity to go back and change your mind later to using getters and setters. So in Java, you might as well get the chore out of the way up front. In Python, this is silly, because you can start with a normal attribute and change your mind at any time, without affecting any clients of the class.*

Gettere og settere kan være nyttige, men aldri før det er behov for dem.
Så lenge alt vi trenger er å lese og skrive verdien til et enkelt attributt, bør vi nøye oss med nettopp dét.
Skulle vi på et senere tidspunkt få behov for noe mer fancy kan vi benytte Pythons innebyggde [`property`-funksjon](http://docs.python.org/library/functions.html#property) til å erstatte attributtet med metodekall.

La oss ta et eksempel. Vi har behov for å representere vinkler, og lager oss den enkleste tenklige klassen: `Vinkel` med attributtet `grader`.

    class Vinkel:
        def __init__(self, grader):
            self.grader = grader

Klassen benyttes som en kan forvente:

    >>> v = Vinkel(90)
    >>> print v.grader
    90
    >>> v.grader = 60
    >>> print v.grader
    60

Alt er fryd og gammen helt til det plutselig blir bestemt at vinkler internt skal representeres som radianer. Vi har plutselig behov for at vinkelens grader aksesseres via metodekall; `property` to the rescue!

    import math
    
    class Vinkel:
        def __init__(self, grader):
            self.grader= grader
            
        def set_grader(self, grader):
            self.radianer = grader * (math.pi/180)
            
        def get_grader(self):
            return self.radianer * (180/math.pi)
            
        grader = property(get_grader, set_grader)

I koden over har vi definert metodene `get_grader` og `set_metoder` for å håndtere konverteringen til og fra radianer.
Kallet til `property` forkler disse som vårt gode gamle `grader` attributt.
Utenfra ser klassen derfor fullstendig lik ut:

    >>> v = Vinkel(90)
    >>> print v.grader
    90
    >>> v.grader = 60
    >>> print v.grader
    60

`property`-funksjonen tar fire argumenter, der alle untatt det første er valgfritt: `fget`, `fset`, `fdel`, `doc`. 
De tre første argumentene er funksjoner for å henholdsvis *lese*, *skrive*, og *slette* attributtet.
Det siste argumentet er attributtets dokumentasjonstreng.

Det er også mulig å benytte `property` som en såkalt *dekorator*, noe som lar oss skrive klassen vår om til følgende.

    import math

    class Vinkel:
        def __init__(self, grader):
            self.grader = grader
            
        @property
        def grader(self):
            return self.radianer * (180/math.pi)

        @grader.setter
        def grader(self, grader):
            self.radianer = grader * (math.pi/180)

I del 3 av denne serien med bloggposter kommer vi til å gå nærmere inn på hva dekoratorer er, hvordan disse fungerer, og hva de kan brukes til.
Stay tuned!

## TODO: Flere ting som kan nevnes?

- conditional assignments: 
  - `x = 3 if (y == 1) else 2` → *x er 3 hvis y er 1, eller er den 2*
- forskjellige collections (i tillegg til `dict`, `list` og `set`): 
  - `namedtuple`, `deque`, `Counter`, `OrderedDict`, `defaultdict`
- strengformatering
- script-kode i moduler:
  - `if __name__ == '__main__'`
- `__future__`

---

Magnus Haug / Kjetil Valle
