# Idiomatisk Python

Alle språk har sine særegenheter, og bak hvert språk ligger en
filosofi—en tanke om hvordan språket bør brukes.  For å skrive pen kode
er det viktig å kjenne og bruke språkets særegenheter; de uttrykk som er
idiomatiske for språket.

I denne bloggposten skal vi gå nærmere inn på hva idiomatisk Python er.
Denne bloggposten er beregnet for de som kjenner grunnleggende Python,
men krever absolutt ikke at man har kodet mye i språket.

## Hva er Pythonisk kode?

I mange språk er det vanlig å iterere over elementer i lister ved hjelp av ei løkke og en eksplisitt indeks, som her i C:

```c
for (size_t i=0; i < food.length; i++) {
    printf("%s\n", food[i]);
}
```

Dette er også mulig i Python, og kunne vært implementert på denne måten:

```python
i = 0
while i < len(food):
    print food[i]
    i += 1
```

I Python er det imidlertid unødvendig å involvere indekser siden det er et vanlig idiom å iterere over alle elementene i en sekvens direkte:

```python
for piece in food:
    print piece
```

Vi ser at koden umiddelbart blir enklere og penere når vi kvitter oss med den forstyrrende indeksen.
Dette er selvsagt et forenklet eksempel, men illusterer essensen i hva som menes med *pythonisk* kode.
Mens kode som *ikke* er pythonisk gjerne kjennetegnes ved at den virker tungvint eller unødig omfattende og ordrik for en erfaren Python-programmerer, vil pythonisk kode utnytte de verktøyene Python tilbyr på slik måte at den uttrykkes enklest mulig.

## The Zen of Python

Dette er tett knyttet opp mot filosofien om minimalisme og enkelhet som underbygger Python.
Den beste beskrivelsen av denne filosofien er kanskje gitt i The Zen of Python:

    >>> import this
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
[Tankegangen](http://groups.google.com/group/comp.lang.python/msg/e230ca916be58835) går ut på at hvis et objekt støtter den operasjonen vi ønsker å utføre, så er det ikke så farlig hvilken type objektet har:

> *don't check whether it IS-a duck: check whether it QUACKS-like-a duck, WALKS-like-a duck, etc, etc, depending on exactly what subset of duck-like behaviour you need*

La oss for eksempel si at vi har et filobjekt `fil`, og ønsker å skrive til dette.
Ettersom Python er dynamisk typet vil vi ofte ikke kunne være sikre på at `fil` faktisk er av typen `file` før under kjøretid.
En lite pythonisk måte å håndtere dette på vil være å sjekke typen på `fil` før vi skriver til den.

```python
if isinstance(fil, file):
    fil.write(data)
```

Det vi i virkeligheten bryr oss om er egentlig ikke *hva* `fil` er, så lenge det er mulig å skrive til den.

```python
try:
    fil.write(data)
except:
    # håndter feilsituasjon
```

Implementert på denne måten kan `fil` godt være en fysisk fil, en socket, eller noe helt annet, så lenge vi får skrevet dataene våre.

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

På samme måte finnes det metoder for blant annet å overlaste aritmetiske operasjoner, typekonvertering, aksessering av attributter og behandling objekter som sekvenser.
Les [denne fabelaktige guiden](http://www.rafekettler.com/magicmethods.html) for å lære om de mulighetene som finnes.

## Funksjoner er objekter

I Python er alle data representert som [objekter](http://docs.python.org/reference/datamodel.html#objects).
Dette gjelder ikke bare vanlige datastrukturer som tall, strenger og lister, men også som funksjoner, generatorer og klasser.

Som tidligere nevnt bryr vi oss sjeldent om hvilke typer vi jobber med i pythonisk kode, så lenge de har de egenskapene vi trenger.
Den egenskapen vi trenger fra noe vi vil behandle som en funksjon er at den *kan kalles*.

Python inkulderer flere typer objekter med denne egenskapen.
Dette gjelder naturligvis både brukerdefinerte og innebygde funksjoner og metoder, men også iteratorer og generatorer (som vi kommer nærmere tilbake til i del 2 av denne blogg-serien).
Klasser kan også kalles, noe som gjerne fører til at en instans av klassen returneres.

I tillegg til dette kan noen ganger også instanser kalles som om de var funksjoner.
Dette kan vi oppnå ved å benytte en av de *magiske metodene* diskutert over.
Hvis en klasse implementerer en metode som heter `__call__`, så kan instanser av denne klassen kalles på samme måte som funksjoner.

```python
>>> class Foo():
...     def __call__(self):
...         return "bar"
...
>>>
>>> # kaller selve klassen, og får en instans returnert
>>> foo = Foo()
>>> foo
<__main__.Foo instance at 0xb72b9e2c>
>>>
>>> # kaller instansen, som fører til at __call__-metoden kjøres
>>> foo() 
'bar'
```

## `with`-uttrykk

Et vanlig mønster en møter er en variasjon over:

```python
# noe settes opp
try:
    # utfør operasjon
except:
    # noe rives ned
```
        
Det som settes opp og rives ned kan for eksempel være en fil, en databasetilkobling som åpnes og lukkes, eller en databasetransaksjon som må committes eller rulles tilbake.
For å slippe dette mønsteret støtter mange av Pythons innebygde klasser [with-uttrykk](http://docs.python.org/reference/compound_stmts.html#with). For [fil-objekter](http://docs.python.org/library/stdtypes.html#file-objects) kan vi da skrive:

```python
with open(filnavn) as f:
    # utfør operasjon med f
```

i stedet for:

```python
f = open(filnavn)
try:
    # utfør operasjon med f
finally:
    f.close()
```

Dette kan være nyttig i alle situasjoner der man ønsker å behandle feilhåndtering mer sømløst.
Et annet eksempel er låser:

```python
lock = threading.Lock()
with lock:
    # ikke-trådsikker kode..
```

For å støtte `with` er det nok at en klasse implementere metodene [`__enter__` og `__exit__`](http://docs.python.org/reference/datamodel.html#with-statement-context-managers).
For mer informasjon om `with`, sjekk ut [denne bloggposten](http://effbot.org/zone/python-with-statement.htm).

## Gettere og settere

Klasser med private felter som eksponeres ved hjelp av enkle get- og
set-metoder er et vanlig pattern i mange språk, men det er absolutt *ikke* pythonisk!
Som Phillip J. Eby uttrykker det i [Python Is Not Java](http://dirtsimple.org/2004/12/python-is-not-java.html):

> *In Java, you have to use getters and setters because using public fields gives you no opportunity to go back and change your mind later to using getters and setters. So in Java, you might as well get the chore out of the way up front. In Python, this is silly, because you can start with a normal attribute and change your mind at any time, without affecting any clients of the class.*

Så lenge alt vi trenger er å lese og skrive verdien til et attributt, er det ikke behov for gettere og settere i Python.
Dersom vi på et tidspunkt få behov for mer, kan vi for eksempel benytte Pythons innebyggde [`property`-funksjon](http://docs.python.org/library/functions.html#property) til å erstatte attributtet med metodekall.

La oss ta et eksempel. Vi har behov for å representere vinkler, og lager oss den enkleste tenklige klassen: `Vinkel` med attributtet `grader`.

```python
class Vinkel:
    def __init__(self, grader):
        self.grader = grader
```

Vi bruker attributtet direkte:

```python
>>> v = Vinkel(90)
>>> print v.grader
90
>>> v.grader = 60
>>> print v.grader
60
```

Dersom vi så bestemmer oss for å representere vinkler med radianer internt, kan vi benytte `property`:

```python
import math

class Vinkel:
    def __init__(self, grader):
        self.grader= grader
        
    def set_grader(self, grader):
        self.radianer = grader * (math.pi/180)
        
    def get_grader(self):
        return self.radianer * (180/math.pi)
        
    grader = property(get_grader, set_grader)
```

I koden over har vi definert metodene `get_grader` og `set_metoder` for å håndtere konverteringen til og fra radianer.
Ved hjelp av kallet til `property` fungerer `grader`-attributtet nå som en front for de nye getter- og setter-metodene.
Utenfra ser klassen helt lik ut:

```python
>>> v = Vinkel(90)
>>> print v.grader
90
>>> v.grader = 60
>>> print v.grader
60
```

`property`-funksjonen tar fire argumenter, der alle unntatt det første er valgfritt: `fget`, `fset`, `fdel`, `doc`. 
De tre første argumentene er funksjoner for å henholdsvis *lese*, *skrive*, og *slette* attributtet.
Det siste argumentet er attributtets dokumentasjonstreng.

Det er også mulig å benytte `property` som en såkalt *dekorator*, noe som lar oss skrive klassen vår om til følgende:

```python
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
```

## Oppsummering

For å skrive god *pythonisk* kode er det viktig å kjenne språket og de verktøyene en har til rådighet.
Målet er rett og slett å skrive så enkel og lettlest kode som mulig.

Denne bloggposten har tatt for seg noen konsepter som er idiomatiske for Python, blant duck typing, magiske metoder og with-uttrykk.
I to kommende bloggposter skal vi gå nærmere inn på noen temaer som er sentrale når en arbeider i Python.
Del 2 vil fokusere på lister, iteratorer og generatorer, mens vi i del 3 tar en nærmere titt på bruk av funksjoner i Python.

---

Magnus Haug / Kjetil Valle  
Bekk Consulting AS
