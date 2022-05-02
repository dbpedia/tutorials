source helpers.sh

# CREATE ANNOTATIONS
#####################

# List of documents
documents="\
texts/melbourne.txt \
texts/berlin.txt \
texts/san_francisco.txt"

# Clear file
> texts/spotlight_annotations.nq

for doc in $documents; do 
  echo "Annotating document: $doc"

  text=$(cat $doc);
  encoded=$(urlencode "$text")
  curl -s -X GET "https://api.dbpedia-spotlight.org/en/annotate?text=$encoded&confidence=0.5" -H "accept: application/n-triples" > tmp.nq
  
  # Create Quads
  # <annotation> <annotates> <topic> <document> .
  
  sed -i -e 's/..$//' tmp.nq
  sed -i -e "s#\$# <$doc> .#" tmp.nq
  cat tmp.nq >> texts/spotlight_annotations.nq
done

rm tmp.nq
