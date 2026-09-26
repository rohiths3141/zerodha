# CONTINUE — Zerodha Bug Bounty Session Handoff

> Handoff for resuming this authorized Zerodha bug-bounty engagement on a new Kali install.
> Paste the **Resume prompt** (bottom) into Claude Code from `/home/kali/zerodha` on the new box.

## 0. Authorization & rules (read first)
- Authorized participant in the **Zerodha Broking Ltd** bug bounty program.
- Full scope + severity table: `claude-state/memory/zerodha-bounty-scope.md` (restored to Claude memory by `setup.sh`).
- **In scope:** `*.zerodha.com`, `api.kite.trade`, `*zerodhacapital.com`, `*.zerodha.net` (internal), listed mobile apps.
- **Hard rules:** no DoS/DDoS, no social engineering, no physical, no OOS hosts. Every finding needs a working PoC + repro.
- **OOS hosts** (never touch): developers.kite.trade, sensibull/sentinel/smallcase.zerodha.com, all Varsity, kite.trade/forum.
- **Parked (needs user decision):** varsity.zerodha.com, varsity-assets.zerodha.com — do NOT test until confirmed.

## 1. Resume steps on the new machine
```bash
cd /home/kali/zerodha          # keep this exact path (Claude memory slug depends on it)
./setup.sh                     # restores memory + reinstalls jadx/apktool
```
Requires: openjdk (java), curl, unzip. Install with `sudo apt install -y default-jdk unzip` if missing.

## 2. What's been done
- **Recon (passive):** 156 subdomains → 152 in-scope after filtering. See `recon/` and `notes/recon-summary.md`.
- **Key learning:** Cloudflare fronts nearly everything; aggressive rate limits (hit 429s on light probing). Keep testing manual/paced. No mass scanning.
- **Decision:** Start with **mobile static analysis** (Coin/Pulse APK — both *High* engagement, fully offline, no WAF/rate-limit interference).
- **Tooling installed:** jadx 1.5.0 + apktool 2.9.3 (`tools/bin/`).
- **Blocked on:** user to provide the APK (pull from own device).

## 3. Next steps (mobile-first plan)
1. Get APK into `apps/coin/` or `apps/pulse/`:
   `adb shell pm path com.zerodha.coin` (or `com.zerodha.pulse`) → `adb pull <paths>` (base + splits).
2. `tools/bin/apktool d apps/<app>/base.apk -o apps/<app>/decompiled`
   - Review `AndroidManifest.xml`: exported components, `android:debuggable`, `usesCleartextTraffic`, `allowBackup`, deep-link/intent-filters, custom permissions.
   - Review `res/xml/network_security_config.xml`.
3. `tools/bin/jadx -d apps/<app>/jadx-out apps/<app>/base.apk`
   - Grep for secrets/keys, hardcoded URLs/endpoints, Firebase configs, S3/GCS buckets.
   - Review WebViews (`addJavascriptInterface`, `setJavaScriptEnabled`, `loadUrl`), crypto usage, auth/token handling, exported-component logic.
   - NOTE: SSL-pinning/root-detection *bypass* is OOS — look for *logic* flaws, not bypass.
4. Triage each candidate against the P1–P5 table; only real, reproducible impact gets written up.

## 4. Other avenues (later / on user steer)
- **Web JS/source-map analysis** of kite/console (passive) — leaked endpoints/keys/debug flags.
- **Kite Connect API** (api.kite.trade) authz/IDOR/logic — ONLY with user's own account/API key (in-scope = your own data). User said they'll provide creds when needed.
- **streak.zerodha.com** — the one in-scope host NOT behind Cloudflare (direct-served); careful manual look.

## 5. Repo hygiene
- `tools/`, APKs, decompiled output, and any creds are **git-ignored** — re-fetch via `setup.sh`, never commit secrets.
- Repo must stay **PRIVATE** (contains recon of a third party's infra).

---
### Resume prompt (paste into Claude Code on the new box)
> Continue the authorized Zerodha bug bounty engagement. Read `/home/kali/zerodha/CONTINUE.md` and `claude-state/memory/zerodha-bounty-scope.md`, then pick up at "Next steps (mobile-first plan)". Recon is done; we're on mobile static analysis of the Coin/Pulse APK. I'll drop the APK in `apps/coin` or `apps/pulse`. Keep to scope, no DoS/social-engineering, PoC required for any finding.
