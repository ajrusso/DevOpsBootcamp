#!bin/bash

user='user'
password='password'
nexus_ip='192.168.0.1'
node_repo='maven-snapshots'
output_dir='./latestArtifact'

# Fetch download URL
curl -u "$user":"$password" -X GET "http://$nexus_ip:8081/service/rest/v1/components?repository=$node_repo&sort=version" | jq "." > artifact.json
artifactDownloadUrl=$(jq '.items[0].assets[0].downloadUrl' artifact.json --raw-output)

# Fetch latest NodeJS artifact
rm $output_dir/*.jar*
wget -P "$output_dir" --http-user="$user" --http-password=$password $artifactDownloadUrl

# Run the NodeJS application
filename=$(ls $output_dir/*jar*)
if [ -e "$file_path" ]; then
    echo "Found $filename"
    chmod +x $filename
    java -jar $filename
else
    echo ".jar file not found"
fi