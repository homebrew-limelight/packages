cd misc

url="$(curl -s https://api.github.com/repos/opensight-cv/rusty-engine/releases/latest | jq -r '.["assets"][]["browser_download_url"]' | grep armhf)"
curl -LO $url

cd ..
mv misc/rusty-engine*armhf.deb packages/
