
#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 domain.com"
    exit 1
fi

domain=$1
outdir="recon-$domain"
mkdir -p "$outdir"

echo "[*] [+] Collecting subdomains ..."
amass enum -passive -d "$domain" -o "$outdir/amass.txt"
subfinder -d "$domain" -o "$outdir/subfinder.txt"
assetfinder --subs-only "$domain" > "$outdir/assetfinder.txt"

cat "$outdir"/*.txt | sort -u > "$outdir/all_subs.txt"

echo "[*] [+] Checking alive subdomains ..."
httpx-toolkit -l "$outdir/all_subs.txt" -silent -o "$outdir/alive.txt"

if [ ! -s "$outdir/alive.txt" ]; then
    echo "[!] No alive subdomains found. Exiting."
    exit 1
fi

echo "[*] [+] Gathering URLs (gau & waybackurls) ..."
cat "$outdir/alive.txt" | gau > "$outdir/gau.txt"
cat "$outdir/alive.txt" | waybackurls > "$outdir/wayback.txt"
cat "$outdir/gau.txt" "$outdir/wayback.txt" | sort -u > "$outdir/all_urls.txt"

echo "[*] [+] Tech stack detection (whatweb) ..."
while read -r line; do
    whatweb "$line" >> "$outdir/tech.txt"
done < "$outdir/alive.txt"

echo "[*] [+] Fuzzing common dirs/files (dirsearch, top 20) ..."

for url in $(head -20 "$outdir/alive.txt"); do
    dirsearch -u "$url" -e php,html,js,zip,env,txt -x 400,403,404 -q --format=simple -o "$outdir/dirsearch-$(echo $url | sed 's/https\?:\/\///g').txt"
done

echo "[*] [+] Recon finished for $domain."
echo "[*] Outputs in $outdir/"
