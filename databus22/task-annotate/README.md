# Task 2 - Annotate

## Setup

* Start a local Databus
* Create an account an claim a namespace

## Creating the Annotations

To create the annotations for the example documents run 
```
bash annotate.sh
```

This will send multiple requests to the DBpedia Spotlight API and create an N-Quads document in `text/spotlight_annotations.nq`.

The result should look like this: [text/spotlight_annotations.nq](https://raw.githubusercontent.com/dbpedia/tutorials/master/cdw21/texts/spotlight_annotations.nq).

## Starting the triple store
[https://github.com/dbpedia/virtuoso-sparql-endpoint-quickstart](https://github.com/dbpedia/virtuoso-sparql-endpoint-quickstart)

```
cd store
docker-compose up
```

## Queries for Verification

```
SELECT DISTINCT ?document WHERE {
  GRAPH ?document { ?s <http://www.w3.org/2005/11/its/rdf#taIdentRef> ?o }
  ?o <http://www.w3.org/2003/01/geo/wgs84_pos#lat> ?lat .
  FILTER(?lat < 0)
}
```

```
SELECT DISTINCT ?document WHERE {
  GRAPH ?document { ?s <http://www.w3.org/2005/11/its/rdf#taIdentRef> ?o }
  ?o <http://www.w3.org/2003/01/geo/wgs84_pos#long> ?long .
  FILTER(?long > 0 && ?long < 20)
}
```
