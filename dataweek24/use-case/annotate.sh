source helpers.sh

## HOW TO RUN
# ./annotate.sh -v 1.0


# CREATE ANNOTATIONS
#####################

git update-index --assume-unchanged annotate.sh
# to reverse: git update-index --no-assume-unchanged annotate.sh


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
automobile-industry-texts/article1.txt \
automobile-industry-texts/article2.txt \
automobile-industry-texts/article3.txt \
automobile-industry-texts/article4.txt \
automobile-industry-texts/article5.txt \
automobile-industry-texts/article6.txt \
automobile-industry-texts/article7.txt \
automobile-industry-texts/article8.txt \
automobile-industry-texts/article9.txt \
automobile-industry-texts/article10.txt \
automobile-industry-texts/article11.txt \
automobile-industry-texts/article12.txt \
automobile-industry-texts/article13.txt \
automobile-industry-texts/article14.txt \
automobile-industry-texts/article15.txt \
automobile-industry-texts/article16.txt \
automobile-industry-texts/article17.txt \
automobile-industry-texts/article18.txt \
automobile-industry-texts/article19.txt \
automobile-industry-texts/article20.txt"

# Clear file
> results/spotlight_annotations_$version.nq

# Iterate the documents
for doc in $documents; do 
  echo "Annotating document: $doc"

  text=$(cat $doc);
  encoded=$(urlencode "$text")

  # Send request to the DBpedia Spotlight API and save to temporary file
  curl -s -X GET "https://api.dbpedia-spotlight.org/en/annotate?text=$encoded&confidence=0.5" -H "accept: application/n-triples" > tmp.nt
  
  # Create Quads in temp file
  # <annotation> <annotates> <topic> <document> .
#  sed -i -e 's/..$//' tmp.nq
#  sed -i -e "s#\$# <$doc> .#" tmp.nq
  if [ -f "tmp.nt" ]; then
    docname="http://dataweek.de/$(basename "$doc")"
    echo "$docname"
    sed -i '' "s|http://www.dbpedia-spotlight.com/|$docname|g" tmp.nt
    # Write modified temp file to our result file
    cat tmp.nt >> results/spotlight_annotations_$version.nt
  else
    echo "Error: tmp.nt file not found."
  fi
done

# Remove the tmp file
rm tmp.nt

# Upload to file server (Github)
git add results/spotlight_annotations_$version.nt
git commit -m 'Added new annotation version'
git push

# Create DataId
template=$(<dataid-template.jsonld)
dataid=${template//%VERSION%/$version}


# Publish to Databus
# Note: provide your API KEY, get it via https://databus.dbpedia.org/USERNAME#settings
curl -X POST -H "x-api-key: f2555932-e4c5-4c0e-bc29-f94a979ec5de" \
  -H "Content-Type: application/json" -d "$dataid" "https://databus.dbpedia.org/api/publish"
