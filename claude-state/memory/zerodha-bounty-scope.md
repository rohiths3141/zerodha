---
name: zerodha-bounty-scope
description: "Scope, out-of-scope, and rules for the user's authorized Zerodha bug bounty engagement"
metadata:
  node_type: memory
  type: project
  originSessionId: 4beff2e0-8a44-4192-b7e2-70b4dfddf74c
  modified: 2026-09-26T06:17:42.689Z
---

The user is a participant in the **Zerodha Broking Limited** bug bounty program (authorized security testing). Working dir: `/home/kali/zerodha`.

**In scope:**
- `*.zerodha.com/*` (wildcard web) — High
- `https://api.kite.trade` (Kite Connect API) — Moderate
- `*zerodhacapital.com/*` — Low
- `*.zerodha.net/*` (Zerodha Internal) — Moderate
- Mobile apps (Play/App Store): Kite (Low), Coin (High), Pulse (High) Android; Kite iOS (Low), Coin iOS (Moderate)

**Out of scope (assets):** `zerodha.com/varsity/*`, `varsitylive.zerodha.com`, all Varsity apps, `kite.trade/forum/*`, `developers.kite.trade/*` (login page), SubStack newsletters, `sensibull.zerodha.com`, `sentinel.zerodha.com`, `smallcase.zerodha.com`.

**Out of scope (issue types):** DoS/DDoS (strictly prohibited), social engineering/phishing, physical attacks, third-party components not under Zerodha control, rate-limit (unless business/data loss), email spoofing on non-sending domains, CSP opinions, clickjacking on non-sensitive pages, WordPress/wp-json, SSL pinning / root-jailbreak bypass, known CVEs without PoC, missing cookie flags / HTTP headers unless clear impact, API key disclosure unless clear impact. Reports need a clear PoC + repro steps.

**Severity:** P1 super-user/infra/codebase; P2 bulk PII or permanent account access; P3 impersonate/hijack logins; P4 minor misconfig; P5 informational.

**Why:** Defines what testing is authorized and what findings are reportable.
**How to apply:** Keep all recon/testing to in-scope assets; never touch out-of-scope hosts; never run DoS or social-engineering techniques; every finding needs a working PoC and repro. Note `developers.kite.trade` is OUT of scope even though `*.kite.trade`-style assets exist — check host against this list before testing.
