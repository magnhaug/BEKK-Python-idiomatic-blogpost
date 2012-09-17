# Idiomatisk Python - del 2 av 3

# Lister og sekvenser

En stor del av det vi programmerer omhandler å på én eller annen måte behandler sekvenser av data. I klassiske imperative språk kan det å jobbe med lister og sekvenser være ganske slitsomt, om man først har hatt gleden av å jobbe en stund med et mer moderne språk. I denne bloggposten vil vi vise ved eksempel hvilke mekanismer Python tilbyr for å jobbe med sekvenser av data, og hvilke fordeler dette gir.

## List comprehensions

List comprehensions er en konsis syntaks for å lage eller transformere lister.
Ved hjelp av list comprehensions kan man enkelt iterere over eksisterende sekvenser, transformere og filtrere elementene, og lagre resultatet som en ny liste.

Den viktigste fordelen med list comprehensions i forhold til å lage lister på vanlig måte ved hjelp av for-løkker er at koden blir kortere og mer lettlest, og dermed enklere å feilsøke eller verifisere.
Som en bonus kan også list comprehensions ha bedre ytelse enn vanlige for-løkker i mange tilfeller.

Syntaksen for å skrive list comprehensions er som følger.

```python
resultat = [uttrykk for element in liste if betingelse]
```

`uttrykk` evalueres for hver iterasjon av `for element in liste`, og resultatet av dette havner som et element i `resultat`. 
Det siste leddet, `if betingelse` er valgfritt, og lar oss ekskludere elementer vi ikke ønsker å ta med i lista.
Resultatet lagres her i `resultat`-listen.

### Et enkelt eksempel

La oss ta utgangspunkt i kodesnutten under.
Her itererer vi over de 100 første heltallene, og lagrer alle kvadrattall som er delelige på 7 i en ny liste.

```python
>>> resultat = []
>>> for i in range(100):
...     if i**2 % 7 == 0:
...         resultat.append(i**2)
... 
>>> resultat
[0, 49, 196, 441, 784, 1225, 1764, 2401, 3136, 3969, 4900, 5929, 7056, 8281, 9604]
```

Denne koden kan gjøres mye penere ved hjelp av list comprehensions:

```python
>> [i**2 for i in range(100) if i**2 % 7 == 0]
[0, 49, 196, 441, 784, 1225, 1764, 2401, 3136, 3969, 4900, 5929, 7056, 8281, 9604]
```
    
Kodesnuttene over utrykker nøyaktig det samme, men den siste benytter et vanlig idiom i Python og blir dermed kortere og langt mer lettlest.

### Comprehensions med nøstede løkker

List comprehensions kan også gjøres med nestede for-løkker, ved å liste disse etter hverandre i uttrykket.

I eksempelet under lister vi opp alle permutasjoner av bokstavene x, y og z.

```python
>>> [a + b + c for a in "xyz" for b in "xyz" for c in "xyz"]
['xxx', 'xxy', 'xxz', 'xyx', 'xyy', 'xyz', 'xzx', 'xzy', 'xzz', 'yxx', 'yxy', 'yxz', 'yyx', 'yyy',
 'yyz', 'yzx', 'yzy', 'yzz', 'zxx', 'zxy', 'zxz', 'zyx', 'zyy', 'zyz', 'zzx', 'zzy', 'zzz']
```

I dette tilfellet kan vi altså eliminiere tre nestede for-løkker, og samtidig øke lesbarheten.
Vær imidlertid varsom med å ta dette for langt.
Håpløst komplekse list comprehensions som gjør for mye på en gang er gjerne vanskeligere å lese enn de tilsvarende nøstede for-løkkene, og strider dermed mot tankegangen i Zen of Python!

I eksempelet over kan det forøvrig bemerkes at vi itererer over bokstavene i en streng på samme måte som vi vanligvis itererer over elementer i en liste.
Dette er et godt eksempel på [duck typing](http://en.wikipedia.org/wiki/Duck_typing), et viktig prinsipp i Python.
Duck typing er tanken om at det det som betyr noe ikke er hvilken type noe har, men hva du kan gjøre med det--i dette tilfellet iterering.

### Nøstede list comprehensions

I tillegg til å lage list comprehensions med nøstede for-løkker kan vi også lage nøstede list comprehensions.
Dette gjør vi enkelt og greit ved å erstatte et del-uttrykk fra det originale comprehension-uttryket med en ny list comprehension.

Eksempelet under viser hvordan vi kan bruke dette til å generere gangetabllen for tallene fra 1 til 10.

```python
>>> from pprint import pprint
>>>
>>> tabell = [[i*j for i in range(1,11)] for j in range(1,11)]
>>> pprint(tabell)
[[1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
 [2, 4, 6, 8, 10, 12, 14, 16, 18, 20],
 [3, 6, 9, 12, 15, 18, 21, 24, 27, 30],
 [4, 8, 12, 16, 20, 24, 28, 32, 36, 40],
 [5, 10, 15, 20, 25, 30, 35, 40, 45, 50],
 [6, 12, 18, 24, 30, 36, 42, 48, 54, 60],
 [7, 14, 21, 28, 35, 42, 49, 56, 63, 70],
 [8, 16, 24, 32, 40, 48, 56, 64, 72, 80],
 [9, 18, 27, 36, 45, 54, 63, 72, 81, 90],
 [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]]
```

### Comprehensions for Set og Dictionaries

Fra Python 2.7 finnes det også tilsvarende comprehensions for set og dictionaries.

For set comprehension er syntaksen helt tilsvarende list comprehension, med unntak av at firkantparentesene er byttet ut med krøllparenteser.

```python
>>> [i % 3 for i in range(10)]
[0, 1, 2, 0, 1, 2, 0, 1, 2, 0]
>>> {i % 3 for i in range(10)}
set([0, 1, 2])
```

Dict comprehensions bruker også krøllparenteser, men her må vi oppgi et nøkkel/verdi par i stedet for et enkelt element.
Eksempelet under demonstrerer hvordan vi kan lage en dict som kobler *i* og den tilhørende toer-potensen *2*<sup>*i*</sup>.

```python
>>> {i: 2**i for i in range(10)}
{0: 1, 1: 2, 2: 4, 3: 8, 4: 16, 5: 32, 6: 64, 7: 128, 8: 256, 9: 512}
```

I tillegg til disse finnes det også en liknende notasjon som bruker vanlige parenteser.
Men for å lære om denne må vi først se nærmere på iteratorer og generatorer.

## Iteratorer og generatorer

Iteratorer er kanskje ikke veldig spennende, men det er en viktig byggesten.
Flere av de python-elementene vi allerede kjenner kan fungere som iteratorer..
F.eks. lister:

```python
>>> items = [1, 4, 5]
>>> it = iter(items)
>>> it.next()
1
>>> it.next()
4
>>> it.next()
5
>>> it.next()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
StopIteration
>>>
```

Syntaktisk sukker

```python
>>> items = [1, 4, 5]
>>> for i in items:
...     print i,
...
1 4 5
```

La oss implementere en iterator selv:

```python
class countdown(object):
    def __init__(self,start):
        self.count = start
    def __iter__(self):
        return self
    def next(self):
        if self.count <= 0:
            raise StopIteration
        r = self.count
        self.count -= 1
        return r
```

Og bruke den:

```python
>>> c = countdown(5)
>>> for i in c:
...     print i,
...
5 4 3 2 1
```

Dette var mye styr, kan det gjøres enklere? Yep, med generatorer:

```python
def countdown(i):
    while i > 0:
        yield i
        i -= 1
```

Resultat:

```python
>>> for i in countdown(5):
...     print i,
...
5 4 3 2 1
```

### Hva er nytteverdien?

Uendelige lister, store datamengder:

```python
>>> from itertools import count
>>> c = count()
>>> c.next()
0
>>> c.next()
1
>>> c.next()
2
```

Hvordan holder man en uendelig liste i minne? Det går rett og slett ikke an -- man er nødt til å jukse litt og generere dataene på farten. Og det noe generatorer er virkelig gode til.

# Generator expressions

List comprehensions kan automagisk skrives som en generator:

```python
>>> liste = [i for i in range(10)]
>>> print liste
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
>>> for i in liste:
...   print i,
... 
0 1 2 3 4 5 6 7 8 9
>>> for i in liste:
...   print i,
... 
0 1 2 3 4 5 6 7 8 9
```

&nbsp;

```python
>>> generator = (i for i in range(10))
>>> print generator
<generator object <genexpr> at 0x10ff3e410>
>>> for i in generator:
...   print i,
... 
0 1 2 3 4 5 6 7 8 9
>>> for i in generator:
...   print i,
... 
```

Hva skjedde her?

### Fordeler

- Er mer kompakte (men kan være mindre fleksible) enn vanlige generatorer med yield.
- Er mer minnevennlige enn lister.
  - Uendelig lange lister passer dårlig i minnet...
- Som skapt for input til metoder som arbeider på elementer enkeltvis. (Da kan vi også droppe et sett parenteser.)

```python
sum(x for x in range(100000) if x % 2 == 0)
```

### Ulemper

- Kan ikke itereres over flere ganger.
- Kan ikke bruke indeksering/slicing eller de vanlige liste-metodene (`append`, `insert`, `count`, `sort`, etc).


### Oppgaver:

1. Lag en list comprehension som lister opp alle partall under 20, og print dem
1. Lag et generator expression som gjør det samme. Print dem.
1. Lag en generator som lister opp ALLE partall.
1. Lag et generator expression som lister opp ALLE partall.
1. Print de første 20 av dem, f.eks. slik:  
    `print [alle_partall.next() for i in xrange(20)]`
1. Lag en generator som generer tall-sekvensen 1, -1, 2, -2, 3, -3, ...
1. Lag en generator som genererer fibonacci-tallene.
   Bruk denne til å finne det 100 000'ende fibonacci-tallet.

### Løsninger:

Lag en list comprehension som lister opp alle partall under 20, og print dem

```python
>>> partall = [i for i in xrange(20) if i % 2==0]
>>> for i in partall:
...   print i, 
... 
0 2 4 6 8 10 12 14 16 18
```

Lag et generator expression som gjør det samme. Print dem.

```python
>>> partall = (i for i in xrange(20) if i % 2==0)
>>> for i in partall:
...   print i, 
... 
0 2 4 6 8 10 12 14 16 18
```

Lag en generator som lister opp ALLE partall.

```python
>>> def allepartall():
...     i = 0
...     while True:
...         if i % 2 == 0:
...             yield i
...         i += 1
```

Lag et generator expression som lister opp ALLE partall.

```python
>>> from itertools import count
>>> allepartall = (i for i in count() if i % 2 == 0)
```

Lag en generator som generer tall-sekvensen 1, -1, 2, -2, 3, -3, ...

```python
>>> def plusminus():
...     i = 1
...     while True:
...             yield i
...             yield -i
...             i += 1
```

Lag en generator som genererer fibonacci-tallene.  
Bruk denne til å finne det 100 000'ende fibonacci-tallet.

```python
>>> def fib():
...     a, b = 1, 1
...     yield a
...     while True:
...             yield a
...             a, b = a+b, a
>>> a = fib()
>>> for i in xrange(100000):
...     result  = a.next()
```

## Oppsummering

- *List comprehensions* er en hendig syntaks for å lage/filtrere/mutere lister.
- *Generatorer* gir oss muligheten til å generere (uendelig) lange sekvenser uten at disse må lagres i minnet.
  - Generator-uttrykk er en kompakt og konsis syntaks for å lage generatorer.

---

Magnus Haug / Kjetil Valle  
Bekk Consulting AS
