# CDW21 Tutorial Resources

## Running a local Databus
[https://github.com/dbpedia/databus](https://github.com/dbpedia/databus)

```
cd databus
docker-compose up
```

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
