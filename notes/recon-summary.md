# Zerodha Recon — Summary (as of 2026-09-26)

## Surface
- 156 passive subdomains found; 152 in-scope after filtering OOS (sensibull/smallcase/varsitylive).
- Parked (needs user clarification): varsity.zerodha.com, varsity-assets.zerodha.com
- Almost everything fronted by **Cloudflare** (WAF + CDN + rate limiting).

## Live/interesting (200/401/403)
- 200: careers, chat(.net), fd, fightstocktips, notary, pulse, streak, thedailybrief
- 403 (WAF/blocked): cmr.zerodha.net, osticket.zerodha.net, rb.zerodha.com, um.zerodha.com
- streak.zerodha.com — NOT behind Cloudflare (direct-served) — note for careful review
- 429 on 21 hosts => aggressive rate limiting; must go slow/manual

## Notable host categories (in-scope .net = "Zerodha Internal", Moderate)
- Auth/identity: account, kite, console, signup, otp, zaccount, um (user mgmt)
- Dev/staging/uat: crm.dev, crux*.dev, intranet.dev, ipo.dev, kite-uat-api, signup-uat, crmtest, cmruat, support-test, acoptest, ws-dev
- Infra/self-hosted apps: bitwarden, osticket, matomo, mautic, listmonk, sendy, mailtrain, postal, discuss, chat
- Money/PII flows: cashier, digilocker, aadhaar, pmla, notary, nri, aftermarketreport, cmr

## Constraints learned
- Cloudflare rate limiting is real (429s). Keep requests minimal, paced, manual.
- Rate-limit findings = OOS unless business/data-loss impact. DoS = prohibited.
