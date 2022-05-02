# Model Creation

Run

```
docker run -v ${PWD}/spotlight/wdir:/model-quickstarter/wdir -v ${PWD}/spotlight/data:/model-quickstarter/data -v ${PWD}/spotlight/models:/model-quickstarter/models -it dbpediaspotlight/model-quickstarter bash
```

Then

```
cd model-quickstarter/
```

Start the process by running

```
./index_db.sh -b en/ignore.list wdir en_US en/stopwords.list English models/en
```



