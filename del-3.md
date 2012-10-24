# Funksjoner - Idiomatisk Python del 3

I denne siste delen av vår serie med bloggposter om *idiomatisk Python* ser vi nærmere på bruk av funksjoner i Python.
Vi skal se at funksjoner er mer kraftfulle i Python enn i mange andre objektorientererte språk, som for eksempel Java.
Vi tar også en titt på Pythons anonyme funksjoner, *lambdaer*.
Til sist introduseres *dekoratorer*, en syntaks som legger til rette for å bruke funksjoner til å modifisere andre funksjoners oppførsel.

## Funksjoner

I Python har man stor frihet i hvordan man lager og bruker funksjoner.
Dette kommer av at funksjoner er *førsteklasses* verdier i Python, noe som vil si at funksjoner kan behandles på samme måte som data.

En konsekvens av dette er at vi har muligheten til å definere funksjoner de samme stedene vi tilordner variabler.
Funksjoner kan deklareres på toppnivå, som klasse-metoder, og til og med inne i andre funksjoner.
La oss se et par eksempler.

```python
def funksjon():
    """En helt vanlig funksjon."""
    pass

def ytre():
    def indre():
        """Funksjon definert inne i en annen funksjon."""
        pass

class Foo:
    def bar(self):
        """Metode i en klasse. Kalles som Foo().bar()."""
        pass
```

Siden funksjoner kan behandles som vanlige dataelement kan vi også gi dem nye navn ved å tilordne dem til variabler.
Eksempelet under lager et alias til Pythons innebygde `len`-funksjon.

```python
>>> listelengde = len
>>> listelengde([1,2,3])
3
```

Ettersom funksjoner kan definers inne i andre funksjoner, og kan tilordnes navngitte variabler, er det kanskje ikke så overaskende at de også kan brukes som argumenter og returverdier.
Dette gjøres på lik linje med alt annet som sendes inn og ut av funksjoner.
Funksjoner som får inn eller returnerer andre funksjoner kalles *høyere ordens funksjoner*.

Et argument som er en funksjon er ikke mer spesielle enn andre argumenter, bortsett fra at i dette tilfellet er det et argument som tilfeldigvis kan kalles.

```python
>>> def foo():
...     print "HAI from foo, kthxbye"
... 
>>> def bar(fn):
...     fn()
... 
>>> bar(foo)
HAI from foo, kthxbye
```

På tilsvarende måte er retur av en funksjon en vanlig retur, der navnet som returneres tilfeldigvis kan tilhøre en annen funksjon.

```python
>>> def bar():
...     def foo():
...             print "Greetings from foo"
...     return foo
... 
>>> fn = bar()
>>> fn()
Greetings from foo
```

En siste egenskap med funksjoner er at de, som annen data, kan lagres som del av datastrukturer.
Eksempelet under viser en dictionary med funksjoner som verdier.

```python
>>> def spam(n):
...     return "spam" * n
... 
>>> data = {
...     'lag_spam': spam,
...     'lag_liste': range
... }
>>> data['lag_liste']
<built-in function range>
>>> data['lag_spam'](4)
'spamspamspamspam'
```

La oss oppsummere egenskapene til *førsteklasses* funksjoner. 
En funksjon i Python kan:

1. defineres de fleste steder der en kan tilordne variabler, også inne i andre funksjoner.
1. sendes som argumenter til andre funksjoner.
1. brukes som returverdier fra andre funksjoner.
1. tilordnes variabler etter at den er definert.
1. lagres i datastrukturerer.

## Lambda-funksjoner

En lambda er en anonym funksjon definert med en konsis syntaks.
Lambda-funksjoner er mer begrensede enn funksjoner definert ved hjelp av `def`, men kan deklareres steder hvor det ikke er mulig å opprette slike vanlige funksjoner.
Begrensningene består i at lambdaer ikke kan inneholde statements, og ikke kan spenne over mer enn én linje.

Lambdaer tar inn en (valgfri) liste med parametere, som brukes i uttrykket selve funksjonen består av.
Når lambda-uttrykket er evaluert returneres resultatet implisitt fra funksjonen.

At lambda-funksjoner er anonyme betyr at de kan defineres og kalles uten å være bundet til et variabelnavn.
Man *kan* dog naturligvis også tilordne lambdaer til variabler hvis man ønsker, slik som med vanlige funksjoner.

### Syntaks

Syntaktisk deklareres lambdaer på følgende måte.

```python
lambda arg1, arg2: uttrykk
```

Vi starter altså med nøkkelordet `lambda` etterfulgt av en (valgfri) liste med vilkårlig antall parametere.
Dette er fulgt av et kolon, og deretter et enkelt uttrykk som evalueres og utgjør returverdien til lambda-funksjonen.

Gitt den følgende *vanlige* funksjonen.

```python
def inkrementer(num):
    return num + 1
```

Denne kan skrives om til en lambda, på følgende måte.

```python
inkrementer = lambda num: num + 1
```

### Bruk-og-kast-funksjoner

Styrken til lambdaer ligger i nettopp det at de er anonyme.
Siden de kan opprettes der de skal brukes, er de veldig hendige som bruk-og-kast-funksjoner.

Dette er spesielt aktuelt når vi kaller funksjoner som tar inn funksjoner som argumenter.
Det er flere slike innebygget i språket, hvorav [`map`](http://docs.python.org/library/functions.html#map), [`reduce`](http://docs.python.org/library/functions.html#reduce), og [`filter`](http://docs.python.org/library/functions.html#filter) nok er de som er mest brukte.

For å ta et forholdsvis enkelt eksempel, la oss si vi ønsker å bruke `filter` til å finne partallene i en liste.
Uten bruk av lambdaer må vi først definere en funksjon som forteller oss hvorvidt et gitt tall er partall, og deretter sende denne som argument til `filter`.

```python
>>> def er_partall(x):
...     return x % 2 == 0
... 
>>> filter(er_partall, [4, 8, 15, 16, 23, 42])
[4, 8, 16, 42]
```

Med en lambda definerer vi kun funksjonen akkurat der den trengs.

```python
>>> filter(lambda x: x % 2 == 0, [4, 8, 15, 16, 23, 42])
[4, 8, 16, 42]
```

Brukt riktig kan altså lambdaer ofte hjelpe oss å skrive kode som er både kortere og mer lesbar.
Det er imidlertid viktig å huske på at det er nettopp dette som er det viktigste.
Pythonisk kode bruker lambdaer kun der det passer, og går ikke av veien for å definere funksjoner eksplisitt hvis det øker lesbarheten.

## Dekoratorer

En dekorator er, kort oppsummert, en måte å endre hvordan en funksjon oppfører seg uten å gjøre endringer i selve funksjonen.

Dekoratorer er et konsept det for mange kan være vanskelig å bli helt komfortabel med, selv om det ikke bygger på mer enn det vi allerede har vært igjennom av teori om funksjoner.
Vanskelighetene oppstår kanskje spesielt når vi kommer til dekoratorer som tar argumenter.
Det er likevel vel verdt å bruke tiden det tar å opparbeide forståelsen, ettersom det gir god innsikt i hvordan høyere ordens funksjoner fungerer, og fordi dekoratorer i seg selv kan være et veldig nyttig verktøy.

Eksempler på praktisk bruk av dekoratorer finner en mange steder, slik som i webrammeverk som [Flask](http://flask.pocoo.org/docs/patterns/viewdecorators/) og [Django](https://docs.djangoproject.com/en/dev/topics/http/decorators/), testrammeverket [unittest](http://docs.python.org/library/unittest.html#skipping-tests-and-expected-failures), eller som [innebygde funksjoner i språket](http://docs.python.org/library/functions.html#property).

### Syntaks

Syntaktisk minner Python-dekoratorer en del om annotasjoner i Java.

```python
@dekorator
def funksjon():
    pass
```

I virkeligheten er `@dekorator`-syntaksen kun [sukker](http://en.wikipedia.org/wiki/Syntactic_sugar).
Eksempelet over kunne like gjerne vært skrevet på følgende måte, med vanlige funksjonskall.

```python
def funksjon():
    pass
funksjon = dekorator(funksjon)
```

Det som skjer er altså at funksjonen først defineres på vanlig måte.
Deretter sendes den som argument til dekoratoren som returnerer en ny funksjon.
Den nye funksjonen tilordnes, og erstatter, så navnet til den opprinnelige funksjonen.

En dekorator er altså, som vi ser, en høyere ordens funksjon.
Den tar inn en funksjon, modifiserer eller erstatter funksjoen, og returnerer en erstatning for den opprinnelige funksjonen.
En typisk dekorator vil vanligvis se omtrent ut som følger.

```python
def dekorator(fn):
    def ny_fn():
        # Her kan vi gjøre hva vi vil!
        # Vanligvis inkluderer det et kall til fn().
    return ny_fn
```

(I praksis kan også klasser brukes til å lage dekoratorer, ettersom funksjoner egentlig er objekter av typen `function`.
For å forenkle ting holder vi oss til dekoratorer basert på vanlige funksjoner her.)

Dekorator-funksjonen kan definere funksjonalitet som skal skje før/etter at den dekorerte funksjonen kalles.
Den kan også la være å kalle den dekorerte funksjonen i det hele tatt, endre på argumentene den får inn, og så videre.

### Et enkelt eksempel 

La oss ta for oss et enkelt eksempel for å se hva som foregår.

```python
>>> def dekorator(fn):
...     print "DEKORERER"
...     def wrapper():
...         print "STARTER WRAPPER"
...         fn()
...         print "SLUTTER WRAPPER"
...     return wrapper
... 
>>> @dekorator
... def test():
...     print "TEST"
... 
DEKORERER
>>> test()
STARTER WRAPPER
TEST
SLUTTER WRAPPER
```

Som vi ser blir `dekorator()` kalt umiddelbart etter definisjonen av `test()`.
Dette gjøres av Python for å få laget en ny funksjon som erstatter `test` – i dette tilfellet `wrapper` som ble definert inne i dekoratoren.
Når vi så kaller `test()` ser vi at vi i virkeligheten kaller `wrapper`.

### Eksempel: Dekorator som teller antall argumenter en funksjon får inn:

Vi fortsetter med et litt mer reelt eksempel; en dekorator som printer antall argumenter en hvilken som helst dekorert funksjon får inn.

For å kunne dekorere alle typer funksjoner, med ulike antall argumenter, må vi passe på at også funksjonen som dekoratoren returerer håndterer dette.
Det løser vi ved å la `wrapper` ta variabelt antall argumenter ved hjelp av `*args` og `**kwargs`.

```python
def tell_argumenter(fn):
    def wrapper(*args, **kwargs):
        antall = len(args) + len(kwargs)
        print "fikk inn %d argumenter" % antall
        return fn(*args, **kwargs)
    return wrapper
```

`wrapper` gjør ellers ikke noe mer magisk enn å summere antall argumenter, printe dette, og kalle videre til den dekorerte funksjonen.
Legg også merke til at vi returerer resultatet fra `fn()`, slik at den dekorerte funksjonen beholder returverdien den ellers ville hatt.

For å teste dekoratoren lager vi en funksjon som tar inn variabelt antall argumenter, og kaller denne.

```python
>>> @tell_argumenter
... def foo(*args, **kwargs):
...     pass
... 
>>> foo()
fikk inn 0 argumenter
>>> foo(1, 2, 3)
fikk inn 3 argumenter
>>> foo(1, 2, 3, bar="baz")
fikk inn 4 argumenter
>>> foo(*range(1000000))
fikk inn 1000000 argumenter
```

### Stacking av dekoratorer

Vi er heller ikke begrenset til å bruke en dekorator per funksjon.
Det fungerer fint å stacke dekoratorer på hverandre:

```python
@dekorator1
@dekorator2
def funksjon():
    pass
```

På samme måte som ved én dekorator blir dette omgjort til funksjonskall av Python,
der den nederste dekorator-funksjonen kalles først.
Eksempelet over kan dermed skrives om til:

```python
def funksjon():
    pass
funksjon = dekorator1(dekorator2(funksjon))
```

### Flere eksempler

Vi fortsetter med noen flere eksempler, for å vise forskjellige bruksområder der dekoratorer kan være passende.

#### `@ignore`

Dekoratorer som `@ignore` kjenner vi typisk fra testrammeverk, og brukes gjerne til å fortelle rammeverket at en test ikke skal kjøres.
Her er en variant som fører til at den dekorerte funksjonen ikke gjør noen verdens ting.

```python
def ignore(fn):
    def wrapper(*args, **kwargs):
        pass
    return wrapper
```

#### `@deprecated`

En annen dekorator som mange gjerne kjenner, for eksempel som annotasjon i Java, er `@deprecated`.
Denne er ment for å informere utviklere om at de bruker gamle utdaterte funksjoner, og skriver ut en advarsel om dette.

```python
def deprecated(fn):
    def wrapper(*args, **kwargs):
        print "Warning: '%s' is deprecated!" % fn.__name__
        return fn(*args, **kwargs)
    return wrapper
```

#### `@timed`

Ofte, spesielt under utvikling, kan man være interessert i å finne ut hvor lang tid det tar å utføre et funksjonskall.
I slike tilfeller kan en dekorator som `@timed` være grei å ha.

```python
from time import time

def timed(fn):
    def wrapper(*args, **kwargs):
        start = time()
        resultat = fn(*args, **kwargs)
        print "brukte %f sekunder" % (time() - start)
        return resultat
    return wrapper
```

#### `@memoize`

En annen mulig applikasjon av dekoratorer er for å cache returverdier fra funksjoner.
Slik lagring og gjenbruk av delløsninger kalles gjerne *memoisering*, og kan drastisk redusere kjøretid i mange tilfeller.

La oss ta utgangspunkt i den følgende implementasjonen for å finne Fibonaccitall:

```python
def fib(n):
    if n in (0,1): return n
    return fib(n-1) + fib(n-2)
```

Dette er åpenbart en veldig naiv løsning, der antall rekursive kall til `fib` øker eksponensielt med *n*.
Hvis vi dekorerer `fib` med følgende dekroator, vil i stedet antall `fib`-kall kun øke linjært.

```python
def memoize(fn):
    cache = {}
    def wrapper(arg):
        if arg in cache:
            return cache[arg]
        else:
            cache[arg] = fn(arg)
            return cache[arg]
    return wrapper
```

### Wraps

Dekoratorene vi har skrevet til nå erstatter funksjonene våre med nye funksjoner.
Vi har dermed endret på hvordan den dekorerte funksjonen ser ut utenfra, ved å endre navn, doc-string, etc.

```python
>>> def buu_dekorator(fn):
...     def ny_fn(*args, **kwargs):
...         # noe artig her
...         return fn(*args, **kwargs)
...     return ny_fn
... 
>>> @buu_dekorator
... def foo():
...     """foo sin docstring"""
...     pass
... 
>>> foo.__name__
ny_fn
>>> foo.__doc__
None
```

Dette kan vi passende nok løse ved hjelp av enda en dekorator!

```python
>>> from functools import wraps
>>> 
>>> def yay_dekorator(fn):
...     @wraps(fn)
...     def wrapper(*args, **kwargs):
...         # noe artig her
...         return fn(*args, **kwargs)
...     return wrapper
... 
>>> @yay_dekorator
... def foo():
...     """foo sin docstring"""
...     pass
... 
>>> foo.__name__
foo
>>> foo.__doc__
foo sin docstring
```

### Dekoratorer med input

Hvis vi ser nøye på eksempelet over, ser vi at dekoratoren `functools.wraps` tar inn den opprinnelige funksjonen som et argument.
Dette er ikke noe ekstra magisk, og vi kan også selv lage dekoratorer som aksepterer argumenter.

Vi går rett på et kodeeksempel:

```python
>>> def gjenta(ganger):
...     def generert_dekorator(fn):
...         def wrapper(*args, **kwargs):
...             return [fn(*args, **kwargs) for i in range(ganger)]
...         return wrapper
...     return generert_dekorator
... 
>>> @gjenta(4)
... def spam():
...     return "spam"
... 
>>> spam()
['spam', 'spam', 'spam', 'spam']
```

Her defineres dekoratoren `gjenta`, som tar inn argumentet som forteller hvor mange ganger den dekorerte funksjonen skal gjentas før resultatet av kallene returneres som en liste.

`gjenta` er ikke helt som generatorene vi har laget så langt, men i praksis en funksjon som genererer dekoratorer, slik at `gjenta(4)` lager dekoratoren som gjentar funksjonen fire ganger, som så brukes til å dekorere `spam`. 

Tilsvarende uten det syntaktiske sukkeret:

```python
>>> def spam():
...     return "spam"
... 
>>> spam = gjenta(4)(spam)
>>> spam()
['spam', 'spam', 'spam', 'spam']
```

## Oppsummering

*Funksjoner* er førsteklasses i Python, og kan derfor:

- Defineres inne i andre funksjoner.
- Brukes som argumenter og returverdier fra andre funksjoner.
- Tilordnes variabler.
- Lagres i datastrukturer.

*Lambdaer* er enlinjes funksjoner uten navn.

*Dekoratorer* lar oss endre funksjonalitet på eksisterende funksjoner uten å endre dem direkte.

- Dekoratorene erstatter den dekorerte funksjonen med en ny funksjon.
- I praksis bare hendig syntaks for å benytte høyere ordens funksjoner.

---

Magnus Haug / Kjetil Valle  
Bekk Consulting AS