source helpers.sh

# CREATE ANNOTATIONS
#####################

# List of documents
documents="\
https://raw.githubusercontent.com/dbpedia/tutorials/master/cdw21/texts/melbourne.txt \
https://raw.githubusercontent.com/dbpedia/tutorials/master/cdw21/texts/berlin.txt \
https://raw.githubusercontent.com/dbpedia/tutorials/master/cdw21/texts/san_francisco.txt"

# Clear file
> spotlight_annotations.nt

for doc in $documents; do 
  echo "Annotating document: $doc"
  text=$(curl -s $doc);
  encoded=$(urlencode "$text")
  curl -s -X GET "https://api.dbpedia-spotlight.org/en/annotate?text=$encoded&confidence=0.5" -H "accept: application/n-triples" > tmp.nt
  sed -i -e "s#^#<$doc> #" tmp.nt
  cat tmp.nt >> spotlight_annotations.nt
done

rm tmp.nt
