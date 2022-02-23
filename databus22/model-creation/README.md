# Model Creation

Run

```
docker run -v ./spotlight/wdir:/model-quickstarter/wdir -v ./spotlight/data:/model-quickstarter/data -v ./spotlight/models:/model-quickstarter/models -it dbpediaspotlight/model-quickstarter bash
```

Then

```
cd model-quickstarter/
```

Start the process by running

```
./index_db.sh -b en/ignore.list wdir en_US en/stopwords.list English models/en
```



