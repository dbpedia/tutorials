source helpers.sh

# CREATE ANNOTATIONS
#####################

# Fetch some example test
text=$(curl -s https://holycrab13.github.io/cdw_demo.txt)
# Url-encode the text
encoded=$(urlencode "$text")
# Send request to spotlight API to get annotated text in the turtle format
annotated=$(curl -s -X GET "https://api.dbpedia-spotlight.org/en/annotate?text=$encoded" -H "accept: text/turtle")
# Write the result to a file
echo $annotated > annotated.ttl
# Additional step: Upload the file!
