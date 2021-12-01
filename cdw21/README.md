# CDW21 Tutorial Resources

## Running a local Databus

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

The result should look like this: (text/spotlight_annotations.nt)[https://raw.githubusercontent.com/dbpedia/tutorials/master/cdw21/texts/spotlight_annotations.nt].

## Starting the triple store

```
cd store
docker-compose up
```