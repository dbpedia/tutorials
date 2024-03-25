source helpers.sh

# CREATE ANNOTATIONS
#####################

# Get the version flag
while getopts v: flag
do
    case "${flag}" in
        v) version=${OPTARG};;
    esac
done

echo "Creating annotations with version: $version";

# List of documents
documents="\
texts/melbourne.txt \
texts/berlin.txt \
texts/san_francisco.txt"

# Clear file
> results/spotlight_annotations_$version.nq

# Iterate the documents
for doc in $documents; do 
  echo "Annotating document: $doc"

  text=$(cat $doc);
  encoded=$(urlencode "$text")

  # Send request to the DBpedia Spotlight API and save to temporary file
  curl -s -X GET "https://api.dbpedia-spotlight.org/en/annotate?text=$encoded&confidence=0.5" -H "accept: application/n-triples" > tmp.nq
  
  # Create Quads in temp file
  # <annotation> <annotates> <topic> <document> .
  sed -i -e 's/..$//' tmp.nq
  sed -i -e "s#\$# <$doc> .#" tmp.nq

  # Write modified temp file to our result file
  cat tmp.nq >> results/spotlight_annotations_$version.nq
done

# Remove the tmp file
rm tmp.nq

# Upload to file server (Github)
git add results/spotlight_annotations_$version.nq
git commit -m 'Added new annotation version'
git push

# Create DataId
template=$(<dataid-template.jsonld)
dataid=${template//%VERSION%/$version}


# Publish to Databus
curl -X POST -H "x-api-key: " \
  -H "Content-Type: application/json" -d "$dataid" "https://databus.dbpedia.org/api/publish"
