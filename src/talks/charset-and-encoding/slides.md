
# Firkanter og spørsmålstegn

> En oppdagelsesreise inn i tegnsettenes og enkodingenes verden

<a href="mailto:torstein@conduct.no">torstein@conduct.no</a>

---

## Mål
- Forståelse for hva et tegnsett er
- Forståelse for hva en enkoding er
- Kunne skille enkodingproblemer med visningsproblemer
- Avlive 3 myter

---

### Skulle det ikke ha stått "Kjører" her?

> KjÃ¸rer

og andre spørsmål

---

Det kommer en *Quiz* til slutt, så følg med!

---

## Lynkurs: tegnsett og enkodinger

Eller "character sets & encodings" som det heter på nynorsk

---

###  American Standard Code for Information Interchange

<img src="usa-uk.jpg" alt="usa &amp; uk"/>

- Genial standard
- ...så lenge du er engelsktalende

---

### ASCII - for nerder
- 7 bits
- Et tegn tilsvarer en tallverdi, f.eks.:

```

Tegn | Desimal | Binær         |
A    | 65      | 1 0 0 0 0 0 1 |
B    | 66      | 1 0 0 0 0 1 0 |
```

Storbokstav verdi + 32 = liten bokstav verdi:
```

Tegn | Desimal | Binær         |
a    | 97      | 1 1 0 0 0 0 1 |
b    | 98      | 1 1 0 0 0 1 0 |
```

Genialt!

---

### Og så kom europeerne

<img src="columbus.jpg" alt="Columbus"/>

Man trengte nye bokstaver som ikke fantes fra før

---

### Og så kom europeerne - II

- ...men det var fullt i herberget (alle de 127 rommene var fulle)
- ...så de la på en 0 til

> **0** 1 0 0 0 0 0 1

---

### 256 tegn, haraball!

---

### Og så kom asiatene

<img src="dragon.png" alt="Dragon"/>

> 你好嗎？

---

### Mye tull

- Mange lagde sine egne tegnsett
- Inkompatible over hele linja

---

### Endelig orden: Unicode

- Plass til alle tegn og bokstaver i alle døde og nålevende språk
  (har i dag over 110 000 tegn)
- Og ledige rom hvis noen skulle finne på å stikke innom

---

### Unicode er et tegnsett

- En tabell med tallverdier (codepoints) og navn på alle bokstavene og
tegn i hele verden

- engelsk: character set, charset


---

### Unicode eksempler

- Tegnet "Ω" har verdien 937 og navnet "GREEK CAPITAL LETTER OMEGA"

- Tegnet for "Å" har verdien 197 og navnet "LATIN CAPITAL LETTER A WITH
RING ABOVE"


---

### Hvordan finne Unicode nummeret til et tegn

For eksempel "~" (tilde)?

Verdensveven: [Unicode Character Table](http://unicode-table.com/en/)

Java:

    String c = "~";
    int unicodeCodepoint = (int) c.charAt(0);

JavaScript:

    var c = "~";
    var unicodeCodepoint = c.codePointAt(0);

Emacs:

    M-x describe-char

---

### UTF-8

- Har tatt verden med storm
- ASCII kompatibel
- Oppfunnet av Ken Thompson i 1992 mens han spiste på restaurant

---

### UTF-8 - for nerder

- En ASCII streng enkodet i UTF-8 har **0** som første bit

- Killer feature #2 lett å navigere inne i en bit-strøm for å finne
  forrige tegn.

- Et Unicode tegn kan enkodes med opptil **4** bytes:

```
11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
```

---

### Forskjellen på Unicode og UTF-8

- Unicode er en tabell med tallverdier og navn for alle tegn i hele
verden.

- UTF-8 er en av flere måter å oversette en Unicode tallverdi til bytes

---

### Ærr'e så fa'li 'a?

- UTF-8 : ASCII-kompatibel
- UTF-16 : **ikke** ASCII-kompatibel (Windows & Java)
- UTF-32 : **ikke** ASCII-kompatibel

---

## Tegnsett & encoding i Java, HTML, HTTP & venner

---

### Java

[Javas interne representasjon av strenger er Unicode](https://docs.oracle.com/javase/7/docs/technotes/guides/intl/overview.html)
(med UTF-16 enkoding)

    final String name = getNameFromFacebook(id);

---

### Flex & ActionScript

- [Default enkoding i Flex](https://www.adobe.com/support/documentation/en/flex/1/internationalization_flex_short/internationalization_flex_short9.html)
er UTF-8.

- Du kan overstyre dette i MXML-fila:
  ```<?xml version="1.0" encoding="iso-8859-1"?>```

- Eller editoren din kan spesifisere encoding når den skriver
fila ved å brenne det fast i selve fila, en såkalt BOM.

---

### Sa du BOM?

- BOM er noe vi kan bruke hvis vi ikke kan/vil skrive enkodinga i
selve fila.

- F.eks. når vi skriver en tekst fil

- Eksempel på en [UTF-8-enkodet fil uten BOM](hello-without-bom.txt)

- Eksempel på en [UTF-8-enkodet fil med BOM](hello-with-bom.txt)

---

### XML

    <?xml version="1.0" encoding="utf-8"?>

- [XML-spesifikasjonen](http://www.w3.org/TR/xml/#charencoding)
bestemmer at standard enkoding er
[UTF-8](http://en.wikipedia.org/wiki/UTF-8)

- Alle XML-parsere må som et minimum støtte UTF-8

---

### HTTP

Når vi surfer på [facebook.com](http://facebook.com) eller skriver
Java-kode som konsumerer REST, RPC over HTTP og SOAP tjenester sier
serveren ifra hvilket enkoding innholdet er oversatt med (serialisert
som):

    $ GET http://vg.no
    [..]
    Content-Type: text/html; charset=iso-8859-1

<img src="facebook.png" alt="facebook"/>

---

### HTML

Inne i HTML-siden er det også viktig at enkodingen er riktig for at
innholdet skal _vises_ riktig i nettleseren:

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

---

### Kjøremiljø

I tillegg til hvordan dataene er lagret og serialisert, må vi som
brukere også ha feiet for egen dør

- Skrifttyper (fonter)

---

### Kjøremiljø - for nerder

#### JVM parametere

```

-Dsun.jnu.encoding=utf-8
-Dfile.encoding=utf-8
```

#### JDBC connection string

    jdbc:jtds:sybase://db01:4100/mydb?characterEncoding=utf8

#### UNIX locale
```

$ export LC_ALL=en_GB.utf8
$ export LANG=en_GB.utf8
```
---

### Myth #1

> Enkoding på Java-fila bestemmer hvordan dataene som strømmer
> igjennom denne Java-komponenten blir skrevet til databasen.

---

### Myth #1 busted

Fil-encoding styrer hvordan tegnene i selve (Java)-fila blir lagret:
```
/**
 * @author Søren Westergård
 */
 final static String PRODUKT = "UFØ";
```

Data-encoding styrer hvordan _dataene_ som (Java)-fila
skriver/returnerer blir tolket.
```
database.writeData(data, Encoding.UTF-8);
```

---

### Myth #2

> Enkodingen internt i system X påvirker dataene den sender ut og
> hvordan vi lagrer disse i vårt system.

---

### Myth #2 busted

Det er irrelevant at P360 lagrer dataene sine med
[Windows 1252](http://en.wikipedia.org/wiki/Windows-1252) så lenge
P360 webservicen vi snakker med serverer XML enkodet som
[UTF-8](http://no.wikipedia.org/wiki/UTF-8).

---

## Databasen

- Mange databaser i Europa kjørte (og flere kjører fremdeles) med
  [ISO-8859-1](http://no.wikipedia.org/wiki/ISO_8859-1) tegnsett.
- Dersom den får noe som ikke dekkes opp av
  [ISO-8859-1](http://no.wikipedia.org/wiki/ISO_8859-1), f.eks. "*–*"
  ([Unicode](http://no.wikipedia.org/wiki/Unicode) navn "EN DASH",
  lang bindestrek), vil databasen gi en feil.

<a href="different-encodings.svg">
<img src="different-encodings.svg" "different encodings"/>
</a>


```
Bruker (ok!) => Flex (ok!) => BlazeDS (ok!) => Java (ok!) => Database (BANG!)
```

---

## Myth #3

> Ikke-støttede tegn skrevet fra en batch får batchen til å feile
> fordi vi ikke har Java-kode som ```catch```-er en ```SQLException```
> eller vi mangler Spring Batch konfigurasjon.

---

## Myth #3 busted

> Nei, det feiler fordi Spring Batch selv oppfatter at det kom en
> uforutsett Hibernate feil i databaselaget og avbryter kjøringen.

---

## Quiz

---

### Unicode er ....

1. En encoding
2. Et tegnsett

---

### UTF-8 er ....

1. En encoding
2. Et tegnsett

---

### Kan man lagre "Alfa og Ω" i Databasen?

1. Ja
2. Nei

---

### Hvis du ser firkanter istedet for bokstaver så er det fordi ...

1. Dataene er lagret i en enkoding og forsøkt vist med en annen
2. Tegnsettet brukt ved lagring av dataene hadde ikke støtte for bokstaven
2. Fonten du bruker (f.eks. "Times New Roman")  mangler en bokstav

---

### Hvis Java-fila mi har Windows 1252 encoding, blir æ, ø og å skrevet riktig til databasen?

1. Ja
2. Nei
3. Det kommer an på databasen og hvordan JDBC kobler seg til den

---

### Hva har skjedd her?

> KjÃ¸rer

1. Du mangler en font til å vise bokstaven etter "Kj".
2. Det er ikke samsvar med hvordan dataene er lagret og hvordan de
   vises frem

---

## Oppsummering - for alle

- Ser du **firkanter** er det fordi at fonten du bruker ikke har
  støtte for bokstaven (men _alt er i orden med systemet_).

- Ser du takras som **KjÃ¸rer** er det fordi noe har gått feil med
enkodingen et eller annet sted i systemet du bruker.

---

## Oppsummering - for alle - II

- Hvilke tegnsett og enkoding tredjepartssystemer bruker internt
  er irrelevant, det som betyr noe er hvordan dataene _transporteres_
  mellom systemene.

---

## Oppsummering - for nerder

- Unicode og UTF-8 er ikke det samme (siden 1992)
- Character set (tegnsett) og encoding (enkoding) er ikke det samme.
- Bruk [UTF-8](http://no.wikipedia.org/wiki/UTF-8) encoding overalt:
  file encoding, data encoding, JDBC connection strings, UNIX locales.

---

## Q?

---

## Videre fordypning

-
  [UTF-8 and Unicode FAQ for Unix/Linux](http://www.cl.cam.ac.uk/~mgk25/unicode.html):
  meget grundig og god innføring i tegnsett og enkodinger.

- [Unicode Character Table](http://unicode-table.com/en/): lar deg
  visuelt utforske hele Unicode-tabellen

- [UTF-8](http://en.wikipedia.org/wiki/UTF-8) på Wikipeidia

---

# Fine
