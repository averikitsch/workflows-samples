
#!/bin/bash


# Validates the JSON Schemas are valid.
# Must be run from the repo's root folder.

# Install JSON schema schema
# mkdir -p tmp
# curl -o tmp/jsonschema-schema.json http://json-schema.org/draft-04/schema

# # Validate every schema
# JSON_SCHEMAS=$(find . -name "*.json")
# while IFS= read -r line ; do
#   npx ajv-cli@v5.0.0 validate -s tmp/jsonschema-schema.json -d $line;
#   # ajv validate -s tmp/jsonschema-schema.json -d $line;
# done <<< "$JSON_SCHEMAS"



wc -l invalid.txt 

rm invalid.txt
# npm install -g ajv-cli
ajv compile -s workflows.json
ajv validate -s workflows.json -d cheatsheet.yaml

SAMPLES=$(find ../src -name "*.yaml")
for sample in $SAMPLES
do
  ajv validate -s workflows.json -d $sample
  if [[ $? -ne 0 ]]; then
    echo $sample >> invalid.txt
  fi

done
wc -l invalid.txt 