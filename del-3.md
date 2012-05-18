# Idiomatisk Python - del 3 av 3

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

Siden funksjoner kan behandles som vanlige dataelement kan vi også gi dem nye navn ved å tilordne dem til variabler.
Eksempelet under lager et alias til Pythons innebygde `len`-funksjon.

    >>> listelengde = len
    >>> listelengde([1,2,3])
    3

Ettersom funksjoner kan definers inne i andre funksjoner, og kan tilordnes navngitte variabler, er det kanskje ikke så overaskende at de også kan brukes som argumenter og returverdier.
Dette gjøres på lik linje med alt annet som sendes inn og ut av funksjoner.
Funksjoner som får inn eller returnerer andre funksjoner kalles *høyere ordens funksjoner*.

Et argument som er en funksjon er ikke mer spesielle enn andre argumenter, bortsett fra at i dette tilfellet er det et argument som tilfeldigvis kan kalles.

    >>> def foo():
    ...     print "HAI from foo, kthxbye"
    ... 
    >>> def bar(fn):
    ...     fn()
    ... 
    >>> bar(foo)
    HAI from foo, kthxbye

På tilsvarende måte er funksjoner som returneres en vanlig retur av et navn som tilfeldigvis tilhører en funksjon.

    >>> def bar():
    ...     def foo():
    ...             print "Greetings from foo"
    ...     return foo
    ... 
    >>> fn = bar()
    >>> fn()
    Greetings from foo

En siste egenskap med funksjoner er at de, som annen data, kan lagres som del av datastrukturer.
Eksempelet under viser en dictionary med funksjoner som verdier.

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

La oss oppsummere egenskapene til *førsteklasses* funksjoner. 
En funksjon i Python kan...

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

Syntax: 


    lambda args: uttrykk

Vanlig funksjon:


    >>> def funksjonen_min(num):
    ...     return num * 2
    ...
    >>> funksjonen_min(3)
    6

Lambda:


    >>> lambdaen_min = lambda num: num * 2
    >>> lambdaen_min(3)
    6

Som alle andre funksjoner kan også lambaer brukes som argumenter.

    >>> def double( num ):
    ...     return num * 2
    ... 
    >>> map(double, range(10))
    [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]

Dette blir ofte mer konsist med en lambda:

    >>> map(lambda num : num * 2, range(10))
    [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]

Akkurat dette tilfellet blir kanskje vel så pent med en list comprehension:

    >>> [num * 2 for num in range(10)]
    [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]

### Oppgaver

1. Lag en funksjon som regner ut gjennomsnittet av to tall, som den får som parametre.
1. Gjør om denne til en lambda.
1. Utvid lambda-funksjonen til å regne ut gjennomsnittet av en liste med tall.
1. Lag en funksjon make_adder(x), som returnerer en funksjon.  
  Den returnerte funksjonen skal legge til x til et tall.
1. Skriv kode som bruker make_adder.

### Løsninger

Lag en funksjon som regner ut gjennomsnittet av to tall, som den får som parametre.

    def avg(a, b):
        return (a+b)/2

Gjør om denne til en lambda.

    avg = lambda a, b: (a+b)/2

Utvid lambda-funksjonen til å regne ut gjennomsnittet av en liste med tall.

    avg = lambda alle_tall : sum(alle_tall) / len(alle_tall)

Lag en funksjon make_adder(x), som returnerer en funksjon.  
  Den returnerte funksjonen skal legge til x til et tall.

    >>> def make_adder(x):
    ...     def fn(y):
    ...             return y+x
    ...     return fn

Skriv kode som bruker make_adder.

    >>> add_two = make_adder(2)
    >>> add_two(40)
    42

## Dekoratorer

En dekorator lar oss endre hvordan en funksjon oppfører seg, uten at vi er nødt til å gjøre endringer i selve funksjonen.

Dekoratorer kan for mange være ganske vanskelige å bli helt komfortable med, selv om de ikke bygger på mer enn det vi allerede har vært igjennom.
Dette gjelder kanskje spesielt når vi kommer til dekoratorer som tar argumenter.
Det er likevel vel verdt å bruke tiden det tar å opparbeide forståelsen, ettersom det gir god innsikt i hvordan høyere ordens funksjoner fungerer, og dekoratorer i seg selv kan være et veldig nyttig verktøy.

Eksempler på praktisk bruk av dekoratorer finner en mange steder, slik som i webrammeverk som [flask](http://flask.pocoo.org/docs/patterns/viewdecorators/) og [django](https://docs.djangoproject.com/en/dev/topics/http/decorators/), testrammeverket [unittest](http://docs.python.org/library/unittest.html#skipping-tests-and-expected-failures), eller som [innebygde funksjoner i språket](http://docs.python.org/library/functions.html#property).

### Syntaks

Syntaktisk minner Python-dekoratorer en del om annotasjoner i Java.

    @dekorator
    def funksjon():
        pass

I virkeligheten er `@dekorator`-syntaksen kun [sukker](http://en.wikipedia.org/wiki/Syntactic_sugar).
Eksempelet over kunne like gjerne vært skrevet på følgende måte, med vanlige funksjonskall.

    def funksjon():
        pass
    funksjon = dekorator(funksjon)
    
Det som skjer er altså at funksjonen først defineres på vanlig måte.
Deretter sendes den som argument til dekoratoren som returnerer en ny funksjon.
Den nye funksjonen tilordnes, og erstatter, så navnet til den opprinnelige funksjonen.

En dekorator er altså ikke noe annet enn en høyere ordens funksjon.
Den tar inn en funksjon, modifiserer eller erstatter funksjoen, og returnerer en erstatning for den opprinnelige funksjonen.
En typisk dekorator vil vanligvis se omtrent ut som følger.

    def dekorator(fn):
        def ny_fn():
            # Her kan vi gjøre hva vi vil!
            # Vanligvis inkluderer det et kall til fn().
        return ny_fn

(I praksis kan også klasser brukes til å lage dekoratorer, ettersom funksjoner egentlig er objekter av typen `function`.
For å forenkle ting holder vi oss til dekoratorer basert på vanlige funksjoner her.)

Dekorator-funksjonen kan definere funksjonalitet som skal skje før/etter at den dekorerte funksjonen kalles.
Den kan også la være å kalle den dekorerte funksjonen i det hele tatt, endre på argumentene den får inn, og så videre.

### Et enkelt eksempel 

La oss ta for oss et enkelt eksempel for å se hva som foregår.

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

Som vi ser blir `dekorator()` kalt umiddelbart etter definisjonen av `test()`.
Dette gjøres av python for å få laget en ny funksjon som erstatter `test` -- i dette tilfellet `wrapper` som ble definert inne i dekoratoren.
Når vi så kaller `test()` ser vi at vi i virkeligheten kaller `wrapper`.

### Eksempel: Dekorator som teller antall argumenter en funksjon får inn:

Vi fortsetter med et litt mer reelt eksempel; en dekorator som printer antall argumenter en hvilken som helst dekorert funksjon får inn.

For å kunne dekorere alle typer funksjoner, med ulike antall argumenter, må vi passe på at også funksjonen dekoratoren returerer håndterer dette.
Det løser vi ved å la `wrapper` ta variabelt antall argumenter ved hjelp av `*args` og `**kwargs`.

    def tell_argumenter(fn):
        def wrapper(*args, **kwargs):
            antall = len(args) + len(kwargs)
            print "fikk inn %d argumenter" % antall
            return fn(*args, **kwargs)
        return wrapper
    
`wrapper` gjør ellers ikke noe mer magisk enn å summere antall argumenter, printe dette, og kalle videre til den dekorerte funksjonen.
Legg også merke til at vi returerer resultatet fra `fn()`, slik at den dekorerte funksjonen beholder returverdien den ellers ville hatt.

For å teste dekoratoren lager vi en funksjon som tar inn variabelt antall argumenter, og kaller denne.

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

### Stacking av dekoratorer

Vi er heller ikke begrenset til å bruke en dekorator per funksjon.
Det fungerer fint å stacke dekoratorer på hverandre som følger.

    @dekorator1
    @dekorator2
    def funksjon():
        pass
    
På samme måte som ved én dekorator blir dette omgjort til funksjonskall av python.
Dekoratorene evalueres slik at de nederste dekorator-funksjonene kalles først.
Eksempelet over kan dermed skrives om på denne måten:

    def funksjon():
        pass
    funksjon = dekorator1(dekorator2(funksjon))

### Flere eksempler

Vi fortsetter med noen flere eksempler, for å vise forskjellige bruksområder der dekoratorer kan være passende.

#### `@ignore`

Dekoratorer som `@ignore` kjenner vi typisk fra testrammeverk, og brukes gjerne til å fortelle rammeverket at en test ikke skal kjøres.
Her er en variant som fører til at den dekorerte funksjonen ikke gjør noen verdens ting.

    def ignore(fn):
        def wrapper(*args, **kwargs):
            pass
        return wrapper


#### `@deprecated`

En annen dekorator som mange gjerne kjenner, for eksempel som annotasjon i Java, er `@deprecated`.
Denne er ment for å informere utviklere om at de bruker gamle utdaterte funksjoner, og skriver ut en advarsel om dette.

    def deprecated(fn):
        def wrapper(*args, **kwargs):
            print "Warning: '%s' is deprecated!" % fn.__name__
            return fn(*args, **kwargs)
        return wrapper

#### `@timed`

Ofte, spesielt under utvikling, kan man være interessert i å finne ut hvor lang tid det tar å utføre et funksjonskall.
I slike tilfeller kan en dekorator som `@timed` være grei å ha.

    from time import time

    def timed(fn):
        def wrapper(*args, **kwargs):
            start = time()
            resultat = fn(*args, **kwargs)
            print "brukte %f sekunder" % (time() - start)
            return resultat
        return wrapper

#### `@memoize`

En annen mulig applikasjon av dekoratorer er for å cache returverdier fra funksjoner.
Slik lagring og gjennbruk av delløsninger kalles gjerne *memoisering*, og kan drastisk redusere kjøretid i mange tilfeller.

La oss ta utgangspunkt i den følgende implementasjonen av fibonacci.

    def fib(a):
        if a in (0,1): return a
        return fib(a-1) + fib(a-2)

Dette er åpenbart en veldig naiv løsning, med antall rekursive kall til `fib` økende eksponensielt med *n*.
Hvis vi dekorerer `fib` med følgende dekroator, vil i stedet antall `fib`-kal kun øke linjært.

    def memoize(fn):
        cache = {}
        def wrapper(arg):
            if arg in cache:
                return cache[arg]
            else:
                cache[arg] = fn(arg)
                return cache[arg]
        return wrapper

### Wraps

Dekoratorene vi har skrevet til nå erstatter funksjonene våre med nye funksjoner.
Vi har dermed endret på hvordan den dekorerte funksjonen ser ut utenfra, ved å endre navn, doc-string, etc.

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
        
Dette kan vi passende nok løse ved hjelp av enda en dekorator!

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

### Dekoratorer med input

Det er også mulig å lage dekoratorer som tar inn argumenter.

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

Her er `gjenta` egentlig en funksjon som genererer dekoratorer. `gjenta(4)` lager dekoratoren som gjentar funksjonen 4 ganger, som brukes til å dekorere `spam`. Tilsvarende uten det syntaktiske sukkeret blir:

    >>> def spam():
    ...     return "spam"
    ... 
    >>> spam = gjenta(4)(spam)
    >>> spam()
    ['spam', 'spam', 'spam', 'spam']

## Oppsummering

- *Funksjoner* er førsteklasses i Python, og kan derfor:
  - Defineres inne i andre funksjoner.
  - Brukes som argumenter og returverdier fra andre funksjoner.
  - Tilordnes variabler.
  - Lagres i datastrukturer.
- *Lambdaer* er enlinjes funksjoner uten navn.
- *Dekoratorer* lar oss endre funksjonalitet på eksisterende funksjoner uten å endre dem direkte.
  - Dekoratorene erstatter den dekorerte funksjonen med en ny funksjon.
  - I praksis bare hendig syntax for å benytte høyere ordens funksjoner.

---

Magnus Haug / Kjetil Valle
