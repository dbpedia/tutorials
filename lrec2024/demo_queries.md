## Use Case WordNet + Associations
### Get word definitions from WordNet
```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX wn: <https://globalwordnet.github.io/schemas/wn#>
PREFIX ontolex: <http://www.w3.org/ns/lemon/ontolex#> 

SELECT (STR(?w) as ?word) (GROUP_CONCAT(?def, "\n") as ?definitions)
WHERE {
	?cf ontolex:writtenRep ?w .
	?sid ontolex:canonicalForm ?cf .
	?sid ontolex:sense ?s .
	?s ontolex:isLexicalizedSenseOf ?ss .
	?ss wn:definition ?d .
	?d rdf:value ?def .
	FILTER (STR(?w) = "dog")
} GROUP BY ?w

```
### Get word associations from EAT
```sparql
PREFIX eat: <http://www.eat.rl.ac.uk/>
PREFIX a: <https://w3id.org/associations/vocab#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?word (GROUP_CONCAT(?resps, "\n") AS ?associations)  {
	?stim rdfs:label ?s_lab .
	?resp rdfs:label ?r_lab .
	?assoc a:response ?resp .	
	?assoc a:stimulus ?stim .
	BIND (SUBSTR(?s_lab, 31) AS ?word) .
	BIND (SUBSTR(?r_lab, 31) AS ?resps) .
	FILTER (STR(?word) = "cat") .         
} GROUP BY (?word)
```
### Get definitions of a word and its associations
```sparql
PREFIX eat: <http://www.eat.rl.ac.uk/>
PREFIX a: <https://w3id.org/associations/vocab#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX wn: <https://globalwordnet.github.io/schemas/wn#>
PREFIX ontolex: <http://www.w3.org/ns/lemon/ontolex#> 

SELECT ?word ?definitions (GROUP_CONCAT(?resps, "\n") AS ?associations)  {
    {	
		SELECT ?w (GROUP_CONCAT(?def, "\n") as ?definitions)
		WHERE {
			?cf ontolex:writtenRep ?w .
			?sid ontolex:canonicalForm ?cf .
			?sid ontolex:sense ?s .
			?s ontolex:isLexicalizedSenseOf ?ss .
			?ss wn:definition ?d .
			?d rdf:value ?def .
			FILTER (STR(?w) = "dog")
		} GROUP BY ?w
    }
	?stim rdfs:label ?s_lab .
	?resp rdfs:label ?r_lab .
	?assoc a:response ?resp .	
	?assoc a:stimulus ?stim .
	BIND (SUBSTR(?s_lab, 31) AS ?word) .
	BIND (SUBSTR(?r_lab, 31) AS ?resps) .
	FILTER (?word = ?w) . 
} GROUP BY ?word ?definitions
```


