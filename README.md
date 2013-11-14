# NaprawmyTo API

Wstępny draft struktury api w wersji 3

Specyfikacja jest przygotowania z użyciem składni Gherkin

#/api/v3/districts

## GET /api/v3/districts/{district_id}

Zwraca podstawowe informacje o gminie

**Wymagane parametry**

brak

**Opcjonalne parametry**

brak

## GET /api/v3/districts/{district_id}/categories

Zwraca kategorie dostępne w gminie

**Wymagane parametry**

brak

**Opcjonalne parametry**

brak

#/api/v3/alerts

## GET /api/v3/alerts/{alert_id}

Zwraca podstawowe informacje o alercie

    {
        "id": 9999,
        "district_id": 1521,
        "long": XX,
        "lat": XX,
        "description": "Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro. De carne lumbering animata corpora quaeritis."
    }

## GET /api/v3/alerts/{alert_id}/categories

Zwraca kategorie przypisane do alertu

    [
        {
            "id":4,
            "name":"Dziura w drodze",
            "type":"Infrastruktura"
        },
        {
            "id":8,
            "name":"Niebezpieczne miejsce",
            "type":"Bezpieczeństwo"
        }
    ]

## POST /api/v3/alerts

Dodawanie nowego alertu

**Wymagane parametry**

* district_id
* long
* lat
* description

**Opcjonalne parametry**

* categories_ids

**Przykład poprawnej odpowiedzi**

TODO

##/api/v3/search/alerts

### GET /api/v3/search/alerts

**Wymagane parametry**

* long - długość geograficzna
* lat - szerokość geograficzna

**Opcjonalne parametry**

* radius - promień obszaru względem punktów long i lat wyrażony w metrach z którego zwracane są wyniki, domyślnie 1000m
* limit - maksymalna ilość alertów, która zostanie zwrócona przez api. Domyślnie 100, maksymalnie 10000

**Przykład**

    curl -v -X GET http://naprawmyto.pl/api/v3/search/alerts \
        -d {"long": XX,"lat": XX,"radius": 1000}

**Przykład poprawnej odpowiedzi**

TODO

### GET /api/v3/search/districts

Wyświetlanie gmin dostępnych w danym punkcie **Uwaga, może być więcej niż jedna - ukryte gminy**

**Wymagane parametry**

* long - długość geograficzna
* lat - szerokość geograficzna

**Opcjonalne parametry**

brak

**Przykład**

    curl -v -X GET http://naprawmyto.pl/api/v3/search/districts \
        -d {"long": XX,"lat": XX}

**Przykład poprawnej odpowiedzi**

TODO

