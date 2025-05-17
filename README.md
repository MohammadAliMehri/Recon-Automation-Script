# 📋 Recon Automation Script

This is a Bash-based reconnaissance automation script for bug bounty and penetration testing. It collects subdomains, checks which ones are alive, gathers URLs from public archives, detects technologies used by alive hosts, and performs basic directory fuzzing.

This script is **Kali Linux friendly** – all dependencies are either pre-installed or can be easily installed on Kali.

---

## 🚀 Usage

```bash
./auto-recon.sh domain.com
```

All output will be stored in a directory named: `recon-domain.com`.

---

## 🧰 Features

* Passive subdomain enumeration using:

  * `amass`
  * `subfinder`
  * `assetfinder`
* Alive subdomain check with `httpx-toolkit` (⚠️ Not ProjectDiscovery's `httpx`)
* URL collection from:

  * `gau` (GetAllUrls)
  * `waybackurls`
* Technology fingerprinting via `whatweb`
* Directory brute-forcing (top 20 alive subs) using `dirsearch`

---

## 🛠️ Installation (Dependencies)

### ✅ Tools Required

| Tool              | Install Command                                                               |
| ----------------- | ----------------------------------------------------------------------------- |
| amass             | `sudo apt install amass`                                                      |
| subfinder         | `go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest` |
| assetfinder       | `go install github.com/tomnomnom/assetfinder@latest`                          |
| gau               | `go install github.com/lc/gau/v2/cmd/gau@latest`                              |
| waybackurls       | `go install github.com/tomnomnom/waybackurls@latest`                          |
| whatweb           | `sudo apt install whatweb`                                                    |
| dirsearch         | `git clone https://github.com/maurosoria/dirsearch.git`                       |
| **httpx-toolkit** | `sudo apt install httpx-toolkit`                                              |

---

### ⚠️ Important Note on `httpx-toolkit`

This script uses **`httpx-toolkit`**, NOT the more common `httpx` by ProjectDiscovery.

If you're using **Kali Linux**, you can install it with:

```bash
sudo apt install httpx-toolkit
```

Verify it with:

```bash
httpx-toolkit -h
```

✅ This version is compatible with the script and supported in **Kali Linux**.

---

## 📂 Output Files

* `amass.txt`, `subfinder.txt`, `assetfinder.txt`: Raw subdomains from tools
* `all_subs.txt`: Merged and deduplicated subdomains
* `alive.txt`: Subdomains that responded over HTTP/HTTPS
* `gau.txt`, `wayback.txt`, `all_urls.txt`: Discovered URLs
* `tech.txt`: Technology stack info (via `whatweb`)
* `dirsearch-*.txt`: Directory brute-force results

---

## 📌 Notes

* Script focuses on **passive** recon (except `dirsearch`)
* Only **top 20** alive subdomains are fuzzed for performance

---

## 🧪 Sample Run

```bash
chmod +x auto-recon.sh
./auto-recon.sh example.com
```

Output directory will be created: `recon-example.com/`

---

---

## 👤 Author

Recon automation script by [Me](https://github.com/MohammadAliMehri/) – feel free to modify and improve!
