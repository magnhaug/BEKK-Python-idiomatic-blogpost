# Idiomatisk Python - del 1 av 3

TODO: introduksjon.

Bloggposten er basert på [del 2](http://magnhaug.github.com/BEKK-Python-Kurs/slides/del2.html#1) av BEKKs [kursserie om Python](https://github.com/magnhaug/BEKK-Python-Kurs) på NTNU, og er derfor beregnet på lesere som kjenner grunnleggende Python uten å være dypt kjent med språket.

## Hva er Pythonisk kode?

Pythonisk kode er kode som bruker vanlige idiomer i Python på en god måte, i stedet for å implementere koden ved hjelp av konsepter vanligere i andre språk.

Dette kan illustreres med et enkelt eksempel hentet fra Pythons [offesielle ordliste](http://docs.python.org/glossary.html#term-pythonic).
I mange språk er det vanlig å iterere over elementer i lister ved hjelp av en eksplisitt indeks og en for-løkke.
Dette er også mulig i Python, og kan gjøres slik:

    for i in range(len(food)):
        print food[i]

I Python er det imidlertid et vanlig idiom å iterere over alle elementene i en sekvens direkte.
 
    for piece in food:
        print piece

Den beste beskrivelsen av hva idiomatisk Python virkelig dreier seg om er kanskje gitt i The Zen of Python:

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

For å oppsummere dette er noe av det viktigste at kode skal være enkel og uttrykksfull.
Vi ønsker kode som er så enkel å forstå at den blir vakker.
Dette oppnår vi i Python ved å kjenne språket, og bruke de konstruktene som tilbys på riktig måte.
La oss dermed gå videre til å se på noen av de konseptene vi mener er viktige å kunne for å skrive god pythonisk kode.


