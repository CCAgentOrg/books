## Jan Parichay: The Definitive Reference

## India's Citizen Identity Layer and the Pensioner Life Certificate (2014-2026)

**Research compiled July 2026**

---


# Chapter 1: What Is Jan Parichay? The National Single Sign-On

**In plain language:** Jan Parichay is a single login system for Indian government services. Instead of remembering dozens of separate usernames and passwords for different government websites, a citizen can use one set of credentials. It is the citizen-facing half (G2C) of a wider government single sign-on built by MeitY and NIC; the sibling for government employees is called Parichay (G2G). MeriPehchaan is the umbrella brand for both.

### 1.1 One Login, Many Services

A single sign-on (SSO) lets a user authenticate once and then access many applications without logging in again to each. Jan Parichay is India's government version of this for citizens — it is described as the National Single Sign-On (NSSO).[^1][^3] A citizen who has created a Jan Parichay identity can use it across participating services such as transport applications and MyGov.[^4]

### 1.2 Two Halves: Parichay (G2G) and Jan Parichay (G2C)

NIC operates two related platforms. **Parichay** is for government employees and authorises access to NIC services based on the user's department and government email (nic.in / gov.in).[^2] **Jan Parichay** is for citizens, and authorises access to citizen-centric services based on identifiers such as Aadhaar, PAN, mobile, email, or driving licence.[^2] Both are multilingual and share the same authentication framework.

### 1.3 Why It Matters

For citizens, the promise is simple: prove who you are once, then use many services. For government service owners, it removes the need to build and secure an authentication system for every service.[^1] The trade-off — concentration of identity in one place — is the subject of later chapters.

### 1.4 Position in India's DPI Stack

Jan Parichay sits above foundational identity (Aadhaar) and alongside data-exchange layers (DigiLocker, e-Pramaan) within the MeriPehchaan family.[^3] It is a building block of "login-light" government services aimed at the next wave of users.

### * ELI6 — Explain Like I'm 6 (Plus Positive/Negative Analysis)

**What this chapter means in simple words:** Imagine every government website made you create a new username and password. Tiring, right? Jan Parichay is one key that opens many government doors. There is a version for citizens (Jan Parichay) and a version for government staff (Parichay). The brand covering both is MeriPehchaan.

**[+] The Positive — What Works Well**

- **Less password fatigue**: One login for many services.
- **Saves government effort**: Each department need not build its own login.
- **Multilingual**: Designed for India's languages.

**[-] The Negative — What's Wrong or Missing**

- **One point of failure**: If the single login fails, many services fail.
- **Concentration risk**: One identity store becomes a high-value target.
- **Citizen visibility lacking**: You cannot easily see what the system knows about you.

---


# Chapter 2: The Identity Layer Beneath It — Aadhaar, PAN, Mobile, Email

**In plain language:** Jan Parichay does not create a new identity number. Instead it recognises you using identifiers you already have — your Aadhaar, your PAN tax number, your mobile number, your email (even a Gmail or Yahoo address), or your driving licence. It links these together so one login can stand for many. This is convenient, but it also means a lot of your identities get tied to a single account.

### 2.1 Many Keys, One Door

Jan Parichay can uniquely identify a user from "diverse attributes like aadhaar / PAN / Mobile / any email etc."[^2] This is the core design choice: rather than issue a fresh ID, the system resolves an existing identity from whichever anchor the citizen presents. Email is notably allowed to be a public address such as Gmail or Yahoo, not only a government one.[^2]

### 2.2 Within the MeriPehchaan Family

MeriPehchaan lets a user create "a single online identity" and offers access via **DigiLocker**, **e-Pramaan**, and **Jan Parichay**.[^3] DigiLocker supplies document verification, e-Pramaan supplies government-employee digital signing, and Jan Parichay supplies citizen SSO. Together they form a credential hub.

### 2.3 Jan Parichay Is Not Aadhaar

A common confusion: Jan Parichay is not a replacement for Aadhaar. Aadhaar is the foundational identity number; Jan Parichay is a login service that can use Aadhaar (among other anchors) to verify you.[^2][^29] A citizen without Aadhaar can still use Jan Parichay via PAN, mobile, email, or driving licence. This matters for inclusion — but only if those alternates are truly supported end to end.

### 2.4 The Convenience-versus-Lock-in Trade

Resolving many identities into one account is convenient and reduces repeated KYC. But it also creates a single profile: if one anchor (say, a mobile number) changes, access to many services can break simultaneously.[^2] The citizen bears the risk of that coupling; the benefit accrues to service owners who no longer manage auth.

### * ELI6 — Explain Like I'm 6 (Plus Positive/Negative Analysis)

**What this chapter means in simple words:** Jan Parichay does not give you a new ID card. It just connects IDs you already have — Aadhaar, PAN, phone, email, licence — so one login works for many places. It is not the same as Aadhaar. Handy, but if one of those IDs changes, a lot of doors can stop opening at once.

**[+] The Positive — What Works Well**

- **Uses existing IDs**: No new number to memorise.
- **Not Aadhaar-only**: Alternatives exist for the Aadhaar-excluded.
- **Less repeated KYC**: One check can serve many services.

**[-] The Negative — What's Wrong or Missing**

- **Single profile risk**: Many IDs linked in one place.
- **Cascade failure**: One changed anchor can lock out many services.
- **Asymmetry**: Service owners gain most; citizens carry the risk.

---


# Chapter 3: How Jan Parichay Works — Architecture and Integration

**In plain language:** Under the hood, Jan Parichay is an authentication service with three notable features. It requires a second step to log in (multi-factor). It can restrict where and for which service a login works (geofencing and per-service authorization). And it offers three standard ways for a government service to plug in (Open API, SAML, OAuth2). A separate phone app provides the second factor.

### 3.1 Multi-Factor by Design

Jan Parichay offers multi-factor authentication as a core benefit for both users and application administrators.[^1] The second factor can be a one-time code on the linked mobile or email, or the **Parichay Authenticator** app, which provides token-based or tap-based two-step verification.[^7]

### 3.2 Geofencing and Per-Service Authorization

The platform "complies with global security standards including two-step multifactor authentication, geofencing, per service authorization, pluggable auth stores."[^2] Geofencing can restrict access by location; per-service authorization means a login is scoped to the specific service, not a blanket pass. These are strong controls — and, from a citizen view, also levers that can be used to limit access.

### 3.3 Three Integration Methods

A service that wants to use Jan Parichay chooses one of three methods via the partners framework: **Open API**, **SAML 2.0**, or **OAuth2.0**.[^6] SAML and OAuth are global SSO standards, which lowers lock-in for service developers. The client fills a requirements form, receives a "JanParichay Proxy," and configures its service.[^6] The end-user manual documents these flows for citizens and integrators.[^5]

### 3.4 Analytical Dashboard and Real-Time Auditing

For application owners, Jan Parichay provides an analytical dashboard.[^1] For security, it supports "alerts on security-related activities, and auditing accounts in real-time."[^2] Real-time auditing is a genuine strength — if it is actually surfaced to citizens or their representatives, not only to administrators.

### 3.5 The Parichay Authenticator

The Authenticator app turns a phone into the second factor via a time-based token or a tap confirmation, avoiding dependence on SMS (which can fail in low coverage).[^7] For government employees this is already standard; citizen uptake via Jan Parichay is the open question.

### * ELI6 — Explain Like I'm 6 (Plus Positive/Negative Analysis)

**What this chapter means in simple words:** Jan Parichay is built with good locks: a second step to log in, the ability to limit where and which service you can use, and three standard ways for government apps to connect. A phone app gives you the second step. The question is who gets to see the security logs — the government, or you.

**[+] The Positive — What Works Well**

- **Strong second factor**: MFA is built in, not bolted on.
- **Standard methods**: SAML/OAuth mean less developer lock-in.
- **Real-time auditing**: Suspicious activity can be caught live.

**[-] The Negative — What's Wrong or Missing**

- **Geofencing cuts both ways**: Can block legitimate access.
- **Audit not citizen-facing**: Logs may stay internal.
- **SMS fallback weak**: Rural users need the app, which they may not have.

---


# Chapter 4: The Life Certificate Problem — Why Pensioners Must Prove They Are Alive

**In plain language:** A pension is paid only while the pensioner is alive. So every year, pensioners must submit a "life certificate" to confirm they are living, or the pension stops. Before digital, this meant travelling to a bank or office, standing in a queue, and getting a signature from an authorised officer. For the old, the sick, or those living far away, this was a real burden.

### 4.1 The Annual Proof-of-Life Requirement

Most government and many private pensions require an annual life certificate, typically due by 30 November, with an early window from 1 October for those aged 80 and above.[^9][^24] The certificate is the trigger for continued pension disbursement.

### 4.2 The Pre-Digital Burden

Physically, the pensioner (or a family pensioner) had to appear before an authorised officer — often a bank manager — who signed the certificate.[^10] For a person in their 70s or 80s, possibly ill, possibly living away from the disbursing branch, this was a yearly ordeal of travel and queues.

### 4.3 Who Bears It

The requirement falls on central government pensioners, state government pensioners, EPFO (Employees' Provident Fund) pensioners, defence pensioners, and family pensioners.[^8][^16] State government pensioners are a large and often under-reported cohort, and many states run their own pension systems with separate rules.

### 4.4 Why It Is a Consumer-Protection Issue

A missed or rejected certificate stops the money. The cost of failure is existential for someone whose only income is the pension. Any design that makes submission hard therefore directly harms the most vulnerable users — which is why the digital life certificate is both a blessing and a test.

### 4.5 Where Jan Parichay Fits

Jan Parichay is the citizen SSO; the life certificate is a flagship service that sits on the Aadhaar-based identity layer. This book uses the life certificate as the clearest window into how India's citizen identity layer actually serves (or fails) real people.[^1][^9]

### * ELI6 — Explain Like I'm 6 (Plus Positive/Negative Analysis)

**What this chapter means in simple words:** To keep getting a pension, a person must prove each year "I am still alive." Long ago this meant a trip to the bank to get a signature. If you are old, sick, or far away, that trip is hard — and if you miss it, your money can stop. That is why making it digital matters so much.

**[+] The Positive — What Works Well**

- **Clear rule**: The annual check protects the pension fund from fraud.
- **Now digital**: No mandatory physical trip in most cases.
- **Early window for 80+**: Super-seniors get an October start.[^24]

**[-] The Negative — What's Wrong or Missing**

- **High stakes**: A missed certificate stops the only income.
- **Uneven rules**: State pensioners face separate, less visible systems.
- **Assumes access**: Digital assumes a phone, Aadhaar, and coverage.

---


# Chapter 5: Jeevan Pramaan — The Aadhaar-Based Digital Life Certificate

**In plain language:** Jeevan Pramaan is the government's digital life certificate. Launched in 2014, it lets a pensioner prove they are alive using Aadhaar — by fingerprint, iris, or (since 2021) a face scan on a phone — instead of travelling to an office. Over 12 crore certificates have been filed since launch.

### 5.1 Launch and Mandate

Jeevan Pramaan was launched on 10 November 2014 by the Prime Minister; it was built by the Department of Electronics and IT (now MeitY) as a Digital India initiative.[^10][^9] It is "a biometric enabled digital service for pensioners" of central, state, or other government organisations.[^8]

### 5.2 How It Differs from Paper

A Jeevan Pramaan is created from self-declared information plus Aadhaar authentication, and is stored on a common portal that pension disbursing agencies can access directly — removing the need for physical presence.[^9] The pensioner receives an SMS with a transaction id and can download a PDF copy later.[^27]

### 5.3 The Ecosystem

Four actors: the **Sanctioning Authority** that issues the Pension Payment Order (PPO); the **Pension Disbursing Agency (PDA)** — bank, post office, or treasury — that pays; **Jeevan Pramaan Centres / CSCs** that assist; and the pensioner.[^9] The DLC is generated at the portal and pulled by the PDA to release pension.

### 5.4 Face Authentication (2021)

On 29 November 2021 a face-authentication app was launched, letting pensioners submit via a phone camera with no separate biometric device.[^9][^21] This was the single biggest inclusion win — it reached people with worn fingerprints and no RD-registered scanner.

### 5.5 Channels

Jeevan Pramaan is available via its website, Android app, UMANG, banks, post offices / IPPB (including doorstep by postmen and Gramin Dak Sevaks), and CSCs.[^9][^25][^27]

### * ELI6 — Explain Like I'm 6 (Plus Positive/Negative Analysis)

**What this chapter means in simple words:** Jeevan Pramaan is the digital "I am alive" proof. Instead of going to the bank, a pensioner confirms identity with Aadhaar — fingerprint, eye scan, or (since 2021) a selfie-style face scan on a phone. Over 12 crore have been done. The pension office then fetches the certificate online.

**[+] The Positive — What Works Well**

- **No travel needed**: Submit from home or a nearby centre.
- **Face scan option**: Helps those with worn fingerprints.[^21]
- **Many channels**: App, UMANG, bank, post, CSC.[^27]

**[-] The Negative — What's Wrong or Missing**

- **Aadhaar-gated**: Depends on Aadhaar being correct and linked.
- **Onboarding gate**: Only if your sanctioning authority is onboarded.[^26]
- **PDF-only proof**: Download depends on SMS/email reaching you.

---


# Chapter 6: The Technology of a Digital Life Certificate

**In plain language:** Making a digital life certificate is a short choreography: the pensioner opens the app, confirms who they are with Aadhaar (fingerprint, iris, or face), and the system issues a certificate tied to their PPO. The pension disbursing agency then fetches it. But it only works if the pensioner's sanctioning authority is onboarded, and biometric failures are common.

### 6.1 Authentication Modes

The app works using Aadhaar-based face, fingerprint, or iris authentication.[^26] Fingerprint or iris need a Registered Device (RD) service — which encrypts biometrics — and a physical scanner; face needs only the AadhaarFaceRD app on a phone.[^21][^26]

### 6.2 The PPO and Onboarding Gate

A DLC is generated against a Pension Payment Order. Critically, "only those pensioners whose Pension Sanctioning Authority is onboarded onto JeevanPramaan can avail this facility."[^26] If a pensioner's authority is not onboarded, no DLC — a hard inclusion cliff.

### 6.3 The Repository

Certificates are stored on the common Jeevan Pramaan portal; the PDA downloads the DLC to process and release pension.[^9] This central store is efficient but also a single point of sensitivity (see the privacy chapter).

### 6.4 Rejections and Failures

DLCs are rejected for data mismatches (name, PPO, Aadhaar) or incomplete biometric verification.[^19][^20] The EPFO dashboard exposes rejection reasons and DLCs pending more than five days — but only interactively, not as a clean public CSV.[^19]

### 6.5 The 2022-2023 Infrastructure Finding

Academic study of the rollout noted that fingerprint capture failed for a significant share of pensioners compared with iris readers, pointing to real device-quality and physiology problems in the field.[^22]

### * ELI6 — Explain Like I'm 6 (Plus Positive/Negative Analysis)

**What this chapter means in simple words:** To make the certificate, the pensioner confirms identity with Aadhaar, and the system ties it to their pension record (PPO). The bank then pulls it. But two traps: your pension office must be "onboarded" or it will not work, and fingerprint scanners often fail for older hands.

**[+] The Positive — What Works Well**

- **Self-service**: No officer signature required.
- **Multiple modes**: Face avoids scanner needs.[^21]
- **Instant storage**: PDA fetches it the same cycle.

**[-] The Negative — What's Wrong or Missing**

- **Onboarding cliff**: Un-onboarded authorities = no DLC.[^26]
- **Biometric fragility**: Worn prints fail often.[^22]
- **Opaque rejections**: Reasons buried in a dashboard.[^19]

---


# Chapter 7: The Annual DLC Campaigns — From 1.0 to 4.0

**In plain language:** Every November the government runs a national drive to help pensioners file their life certificates, using banks, post offices, CSCs, and doorstep postmen. The drives have grown fast: from about 1.15 crore certificates in Campaign 2.0 (2023) to roughly 1.6-1.9 crore in Campaign 4.0 (2025). Face scans now dominate.

### 7.1 Campaign Cadence

The Department of Pension and Pensioners' Welfare runs a nationwide DLC campaign each November, covering thousands of districts and subdivisions.[^11][^13][^30]

### 7.2 The Numbers

- **Campaign 2.0**: 1.15 crore DLCs (38.47 lakh central, 16.15 lakh state, 50.91 lakh EPFO); state leaders Maharashtra 5.07 lakh, Uttar Pradesh 4.55 lakh, West Bengal 2.65 lakh.[^16]
- **Campaign 3.0** (Nov 2024): 1.62 crore submissions across 845 cities/districts.[^13] Indian Express reported 1.47 crore in the prior campaign with 45.46 lakh central government pensioners.[^14]
- **Campaign 4.0** (Nov 2025): reported between 1.54 crore and over 1.91 crore; 57 lakh central government pensioners.[^11][^12]

Note the spread in reported Campaign 4.0 figures (1.54 vs 1.91 crore) across government and media sources — a reminder that headline DLC counts are not audited to a single standard.

### 7.3 Face Authentication Takes Over

In FY25-26, 1.90 crore DLCs were generated (to 24 March 2026), of which 1.15 crore used face authentication (~60.5 per cent).[^15][^24] Face auth has gone from a niche option to the default mode in a few years.

### 7.4 Super-Seniors

In FY25-26, 1.41 crore certificates came from super-seniors (aged 80+), the group most likely to be excluded by travel or biometrics — evidence the doorstep and face modes are reaching them.[^24]

### 7.5 Channels at Scale

Campaigns mobilise 19 pension-disbursing banks, IPPB, pensioners' welfare associations, CSCs, and postmen for doorstep service. Over 7 lakh pensioners have used the IPPB doorstep DLC service.[^16][^25]

### * ELI6 — Explain Like I'm 6 (Plus Positive/Negative Analysis)

**What this chapter means in simple words:** Every November India holds a big push so pensioners can file their life proof. Each year more join: about 1.15 crore in 2023, near 2 crore in 2025. Most now just use a face scan on a phone. Even people over 80 are doing it in large numbers.

**[+] The Positive — What Works Well**

- **Scale proven**: ~2 crore a year now.[^15]
- **Face scan default**: Reaches the less mobile.[^24]
- **Doorstep option**: Postmen come to you.[^25]

**[-] The Negative — What's Wrong or Missing**

- **Conflicting counts**: 1.54 vs 1.91 crore for one campaign.[^11][^12]
- **No audit standard**: Headline numbers are not reconciled.
- **Campaign-dependence**: Adoption clusters in November pushes.

---


# Chapter 8: National Adoption Data

**In plain language:** At the national level, Jeevan Pramaan is huge: over 12 crore life certificates filed since 2014, with close to 2 crore in the latest year alone. Most are now done by face scan on a phone. But the government publishes headline totals, not reconciled per-state or per-mode breakdowns you can download.

### 8.1 Headline Totals

The portal reports 12.25 crore DLCs submitted since 2014.[^8] In FY25-26 (to 24 March 2026) 1.90 crore were generated, of which 1.15 crore used face authentication.[^15][^24] Cumulative scale: 12+ crore in just over a decade.

### 8.2 Mode Split

Face authentication is now the majority mode (~60.5 per cent of FY25-26 DLCs).[^24] Fingerprint and iris remain for those who prefer or require them, but face has overtaken them for reach.

### 8.3 Super-Seniors

1.41 crore DLCs in FY25-26 came from pensioners aged 80+, about a quarter of all submissions — a strong inclusion signal for the oldest users.[^24]

### 8.4 Channels of Submission

DLCs are submitted via the app/website, UMANG, bank branches, post offices / IPPB (including doorstep by postmen and Gramin Dak Sevaks), and CSCs.[^9][^25][^27] Over 7 lakh pensioners have used the IPPB doorstep service.[^16][^25]

### 8.5 What Is NOT Published

There is no official downloadable dataset that reconciles: per-state totals, per-mode counts by state, rejection rates by cause, or time-to-clear for pending DLCs. The EPFO dashboard shows some of this interactively but not as open data.[^19] This gap is the reason Chapter 9 presents fragmented datasets with explicit scope labels.

### * ELI6 — Explain Like I'm 6 (Plus Positive/Negative Analysis)

**What this chapter means in simple words:** Nationally, Jeevan Pramaan is enormous — over 12 crore certificates in total, almost 2 crore last year, and most now by face scan. But the government shares big totals, not the detailed breakdowns (by state, by reason for rejection) you could check yourself.

**[+] The Positive — What Works Well**

- **Massive reach**: 12+ crore cumulative.[^8]
- **Face majority**: ~60 per cent now face-based.[^24]
- **Oldest included**: 1.41 crore from 80+.[^24]

**[-] The Negative — What's Wrong or Missing**

- **No open per-state data**: Can't download it.[^19]
- **No rejection breakdown**: Reasons stay internal.
- **Totals only**: Little accountability detail.

---


# Chapter 9: Survey of Jeevan Pramaan Across States

**In plain language:** There is no single official table that ranks Indian states by digital life certificates. The data exists only in fragments — a doorstep-post dataset, a campaign leaderboard, and a scattered state compilation. This chapter presents each fragment with its scope, then reads what the fragments together suggest, and names the data void.

### 9.1 The Core Problem: No Reconciled State Dashboard

India publishes no unified, downloadable per-state DLC statistic. What exists are separate releases with different scopes. Presenting any one as "the state ranking" would be misleading. Each table below is labelled by scope.[^16][^18][^19]

### 9.2 Dataset A — Doorstep DLCs via India Post (IPPB)

Scope: Jeevan Pramaan Patra disbursed at the doorstep by Postmen and Gramin Dak Sevaks through the India Post Payments Bank network. Total reported: 705,564.[^17]

| State / UT | Doorstep DLCs (IPPB) |
|-----------|----------------------|
| Maharashtra | 96,548 |
| Tamil Nadu | 90,929 |
| Telangana | 76,950 |
| Andhra Pradesh | 66,238 |
| Kerala | 62,306 |
| Karnataka | 60,991 |
| Uttar Pradesh | 47,336 |
| West Bengal | 38,387 |
| Gujarat | 36,072 |
| Odisha | 12,315 |
| Delhi | 16,711 |
| Punjab | 9,619 |

This is one channel only (doorstep post). High counts for Maharashtra, Tamil Nadu, Telangana, Andhra, and Kerala partly reflect postal network density and state pensioner populations — not necessarily higher digital adoption per capita.

### 9.3 Dataset B — DLC Campaign 2.0 State Leaders

Scope: nationwide campaign 2.0; only the top three states were published.[^16]

| State | DLCs (Campaign 2.0) |
|-------|---------------------|
| Maharashtra | 5.07 lakh |
| Uttar Pradesh | 4.55 lakh |
| West Bengal | 2.65 lakh |

### 9.4 Dataset C — Reported State-wise DLC Counts (2021-22 and 2022-23)

Scope: a staffnews compilation of state-wise Jeevan Pramaan counts (likely central/EPFO pensioner subset); totals 4,54,316 (2021-22) and 5,27,286 (to 31 Oct 2022).[^18]

| State | 2021-22 | 2022-23 (to 31 Oct) |
|-------|---------|---------------------|
| Tamil Nadu | 68,818 | 238,811 |
| Maharashtra | 60,918 | 51,352 |
| Andhra Pradesh | 46,165 | 29,793 |
| Kerala | 36,066 | 30,773 |
| Gujarat | 24,262 | 16,475 |
| Uttar Pradesh | 21,931 | 16,103 |

Note the sharp rise for Tamil Nadu between years — likely a campaign push or a reporting change, not a real 3x adoption jump. Treat as indicative, not comparable.

### 9.5 Dataset D — EPFO Jeevan Pramaan Dashboard (office level)

Scope: EPFO field-office level DLC received / approved / rejected / digital, by year. Available interactively; not a clean CSV.[^19] This is the only official per-state source, and its inaccessibility as open data is itself a transparency gap.

### 9.6 Reading the Map

Across fragments, Maharashtra, Tamil Nadu, Uttar Pradesh, West Bengal, Kerala, Andhra Pradesh, and Telangana recur as high-volume states. But the absence of per-capita figures, of state-government-pensioner breakouts, and of a common baseline means we cannot rank states fairly. The real finding is the data void, not a leaderboard.

### 9.7 Why the Void Matters

Without reconciled state data, governments cannot target low-adoption states, researchers cannot measure exclusion, and pensioners cannot benchmark their disbursing agency. A public, downloadable per-state DLC dashboard should be a minimum transparency standard.[^19]

### * ELI6 — Explain Like I'm 6 (Plus Positive/Negative Analysis)

**What this chapter means in simple words:** You might expect a neat list of "which state does best." It does not exist. The government publishes bits — postmen's doorstep counts, a campaign top-three, a scattered compilation — but nothing you can fairly rank. So the honest answer is: we can't rank states, and that gap is the story.

**[+] The Positive — What Works Well**

- **Fragments exist**: Some state data is published.[^17][^18]
- **Recurring leaders**: MH, TN, UP, WB, KL show up often.
- **EPFO dashboard**: Per-state data exists, at least interactively.[^19]

**[-] The Negative — What's Wrong or Missing**

- **No single dashboard**: Can't compare states fairly.
- **Scope mismatch**: Each dataset measures something different.
- **Not open data**: EPFO numbers not downloadable.[^19]

---


# Chapter 10: Exclusion and Failure Modes

**In plain language:** The digital life certificate helps millions, but it fails the people least able to cope. Worn fingerprints, a face the camera will not recognise, a name that does not match across databases, or a pension office that never joined the system — any of these can block a certificate and freeze a pension. The failures are not random; they cluster among the old, the poor, and the remote.

### 10.1 Biometric Failure — The Known Weak Spot

Academic and government studies have long noted that fingerprint capture for digital life certificates fails more often than iris, especially for manual labourers with worn prints and for the elderly.[^22] Face authentication (Chapter 5) was introduced precisely to bypass this — yet face auth has its own failure list.

### 10.2 The Twelve Face-Authentication Failure Reasons

An Economic Times compilation lists a dozen reasons a Jeevan Pramaan face authentication can fail, including poor lighting, mismatched Aadhaar photo (age, appearance), device or network issues, and cases where face auth is simply not permitted (e.g., certain re-employed or family pensioners).[^20] For a bedridden 85-year-old, several of these can apply at once.

### 10.3 The Onboarding Gate, Again

Even a perfect biometric is useless if the pensioner's **Sanctioning Authority is not onboarded** onto Jeevan Pramaan. The app explicitly warns: "Only those pensioners whose Pension Sanctioning Authority is onboarded onto JeevanPramaan can avail this facility."[^26] This silent gate excludes people through no fault of their own.

### 10.4 Data Mismatch Rejections

Rejections also arise from mundane mismatches — a name spelled differently in Aadhaar vs the PDA record, or a PPO number transcription error.[^20] The pensioner typically learns of the rejection only after the pension stops, with little guidance on the exact fix.

### 10.5 The Last Ten Per Cent

Digital systems are judged by averages, but pensions are a matter of every individual's survival. A 95 per cent success rate still leaves 5 per cent — potentially millions — facing a frozen income. The people in that tail are disproportionately the oldest, poorest, and most isolated. No official publication reports this tail size.[^8][^15]

### * ELI6 — Explain Like I'm 6 (Plus Positive/Negative Analysis)

**What this chapter means in simple words:** The digital certificate is great — until it is not. If your fingerprints are worn, your face will not scan, your photo looks different from years ago, or your pension office never joined the system, it can fail. And when it fails, your pension can stop. The people this hurts most are the oldest and weakest.

**[+] The Positive — What Works Well**

- **Face auth reduces one failure type**: Camera mode helps those with bad fingerprints.
- **Assisted channels exist**: CSCs and postmen can help the struggling.
- **Problem is documented**: The 12 failure reasons are at least named in the press.

**[-] The Negative — What's Wrong or Missing**

- **Failures hit the vulnerable**: Old, poor, remote users bear the risk.
- **Onboarding gate is invisible**: Many do not know their office is not on the system until they fail.
- **Rejection is silent**: You often learn only when the pension stops.
- **The tail is unmeasured**: No one publishes how many are left behind.

---


# Chapter 11: Privacy, Consent, and Concentration Risk

**In plain language:** Two identity systems sit under this book. Jeevan Pramaan stores a "proof of life" tied to Aadhaar in a central repository. Jan Parichay is a single login that can span many government services. Each is convenient; together they create a concentrated record of who a citizen is, where they are, and whether they are alive. The privacy law meant to govern this — the DPDP Act 2023 — is in force but its enforcement board is not yet operational.

### 11.1 The Proof-of-Life Repository

Every DLC is stored centrally and readable by the pension disbursing agency.[^9] That means a database exists correlating Aadhaar, PPO, bank, and a recurring "alive" signal. The citizen cannot easily see, correct, or delete their entry. The repository is a high-value target and a single point of sensitivity.

### 11.2 Jan Parichay as a Correlation Engine

Jan Parichay's design — one identity resolving Aadhaar, PAN, mobile, email, and driving licence, with geofencing and per-service authorization — is, from a surveillance view, a correlation engine.[^2] Used well, it removes repeated identity proofing. Used without strict limits, it builds a unified profile of a citizen's government interactions that the citizen cannot inspect.

### 11.3 Consent That Is Not Informed

Aadhaar authentication for a DLC is a one-time consent at the moment of authentication. It does not amount to an ongoing, legible understanding of what is stored, who reads it, or for how long.[^29] Jan Parichay's consent model is similarly opaque to the average user — convenience is the default, and opt-out is not a visible choice.[^3]

### 11.4 The DPDP Gap

The Digital Personal Data Protection Act, 2023 provides the legal frame, but its enforcement body — the Data Protection Board — was not operational as of mid-2026, leaving a real gap between right and remedy.[^28] For a pensioner whose proof-of-life data is mishandled, the practical recourse is unclear.

### 11.5 The Consumer Bottom Line

Convenience and concentration are two sides of the same design. The citizen gains ease of access and loses visibility and control. A reference work should state it plainly: the identity layer is powerful, but the accountability layer has not kept pace.[^2][^28]

### * ELI6 — Explain Like I'm 6 (Plus Positive/Negative Analysis)

**What this chapter means in simple words:** When you file your life certificate, the government keeps a note that you are alive, linked to your Aadhaar and bank. And the single login (Jan Parichay) can connect many of your government identities into one profile. That is handy, but it also means a lot of your private information sits in one place, and you cannot easily see or fix it. The privacy law exists, but the referee that enforces it is not yet at work.

**[+] The Positive — What Works Well**

- **Less repeated proofing**: One identity check spares citizens endless form-filling.
- **Legal frame exists**: The DPDP Act 2023 at least names citizens' data rights.
- **Security features present**: MFA and auditing are designed in from the start.

**[-] The Negative — What's Wrong or Missing**

- **Central proof-of-life store**: A single database links Aadhaar, pension, and "alive" status.
- **No citizen visibility**: You cannot easily see or correct your own entry.
- **Consent is shallow**: A one-tap auth is not informed, ongoing consent.
- **Enforcement gap**: The DPDP Board is not operational, so rights lack a live referee.

---


# Chapter 12: Governance, Audits, and Accountability

**In plain language:** Who is responsible when the life certificate system fails a pensioner? The answer is split across at least four bodies — MeitY/NIC (builds Jan Parichay), the Department of Pension and Pensioners' Welfare (runs the DLC campaigns), UIDAI (runs Aadhaar), and the CAG (audits). That split makes accountability diffuse. Independent audit of Jeevan Pramaan exists but is thin, and citizen-facing performance data is not published.

### 12.1 The Institutional Map

| Body | Role |
|------|------|
| **MeitY / NIC** | Builds and operates Jan Parichay / MeriPehchaan[^1][^2] |
| **DoPPW** | Runs DLC campaigns, sets pensioner policy[^11][^15] |
| **UIDAI** | Provides Aadhaar authentication underlying DLC[^29] |
| **CAG / IAAD** | Audits government pension processes, incl. Jeevan Pramaan[^23] |

### 12.2 Audit Presence — and Its Limits

The Indian Audit and Accounts Department has issued guidance on submitting the life certificate through Jeevan Pramaan, indicating official adoption inside government pension offices.[^23] But a full performance audit of Jeevan Pramaan's exclusion, rejection, and redress outcomes is not in the public domain in the way CAG audits other schemes. The absence is itself a finding.

### 12.3 The Reconciliation Gap

As Chapter 7 showed, campaign totals from PIB, DD News, and newspapers do not reconcile, and no reconciled dashboard exists.[^11][^12][^15] A citizen or researcher cannot independently verify the government's own claims. This is a transparency failure distinct from any technical one.

### 12.4 Redress Is Unclear

When a DLC is rejected or a pension frozen, the path to fix it is not standardised across central, state, EPFO, and family pensions. The assisted channels (CSC, postman) help with generation but not with adjudicating a rejection. There is no published, unified grievance mechanism for "my life certificate failed."

### 12.5 What Accountability Would Look Like

A consumer-facing reference sets the bar: (1) a reconciled, downloadable per-state, per-mode, per-pension-type DLC dashboard; (2) published rejection and exclusion rates; (3) a unified grievance and appeal right; (4) a live Data Protection Board to enforce the DPDP Act.[^19][^28]

### * ELI6 — Explain Like I'm 6 (Plus Positive/Negative Analysis)

**What this chapter means in simple words:** If your life certificate goes wrong, it is hard to know who to blame. One team built the login, another runs the pension drive, another runs Aadhaar, and another is supposed to audit. That splitting makes it easy for no one to be clearly responsible. And the government's own numbers do not always add up.

**[+] The Positive — What Works Well**

- **Roles are defined**: At least we know which body does what.
- **Audit body engaged**: CAG/IAAD has touched the process.
- **Channels for help exist**: CSCs and postmen can assist with filing.

**[-] The Negative — What's Wrong or Missing**

- **Diffuse accountability**: Split ownership blurs who fixes failures.
- **No full performance audit**: Exclusion and rejection are not publicly audited.
- **Numbers don't reconcile**: Official totals disagree with each other.
- **No clear appeal**: A rejected pensioner has no standard fix-it path.

---


# Chapter 13: The Future — Identity Layer as Backbone, and What Must Change

**In plain language:** Jan Parichay is meant to become the single login for many citizen services — transport, MyGov, and more. The life certificate is the stress test: a high-stakes service for the most vulnerable users. If the identity layer can carry the life certificate fairly, it can carry the rest. If it cannot, expanding it only multiplies the harm. This chapter sets out what should change for the consumer.

### 13.1 Jan Parichay's Expanding Footprint

Jan Parichay is explicitly positioned for citizen services such as transport applications and MyGov, with more departments expected to integrate via the partners framework.[^4][^6] As that footprint grows, the life certificate remains the clearest example of a service where failure is not inconvenient — it is existential.

### 13.2 The Life Certificate as Canary

A canary in a coal mine warns before the whole mine is dangerous. The DLC is the canary for India's citizen identity layer: it serves the old, the remote, and the low-literacy, exactly the groups an expanding SSO will also need to reach. What is learned — and fixed — here should shape the broader rollout.[^1][^3]

### 13.3 What Should Change

CashlessConsumer's prescription, drawn from the evidence in this book:

1. **Publish a reconciled dashboard** — per state, per mode, per pension type, downloadable as CSV.[^19]
2. **Measure and report exclusion** — rejection and failure rates by demographic, not just headline counts.[^8]
3. **Guarantee an offline / human fallback** — no pensioner should be left with only a failing digital path.[^22]
4. **Create a unified grievance and appeal right** — one place to fix a rejected certificate across all pension types.[^12]
5. **Give citizens data access** — view, correct, and delete one's proof-of-life and SSO profile.[^2][^28]
6. **Operationalise the DPDP Board** — rights need a live referee.[^28]

### 13.4 The Standard to Hold

Jan Parichay and Jeevan Pramaan are genuinely useful. The standard is simple: a citizen identity layer earns trust only when the people it is hardest to serve are served, when its numbers are verifiable, and when a person locked out can get back in. On those tests, the work is unfinished.[^1][^15]

### * ELI6 — Explain Like I'm 6 (Plus Positive/Negative Analysis)

**What this chapter means in simple words:** Jan Parichay wants to become the one login for lots of government services. The life certificate is the hardest test of that idea, because it serves the oldest and weakest people, and failure means no pension. If the government gets the life certificate right, it can get the rest right too. If not, growing the system just spreads the problem.

**[+] The Positive — What Works Well**

- **Ambitious and useful goal**: One login for many services reduces real burden.
- **Proven at scale**: Crores of life certificates show the core works.
- **Face auth is a model**: Inclusive design here can inform other services.

**[-] The Negative — What's Wrong or Missing**

- **Expansion before fixes**: The hard problems (exclusion, redress) are unsolved.
- **No verifiable data**: Citizens cannot check the government's claims.
- **No offline guarantee**: The most vulnerable can be stranded digitally.
- **No citizen data rights**: You cannot see or fix your own identity profile.

---


# Appendices

### Appendix A: Complete Timeline

| Date | Event | Source |
|------|-------|--------|
| 10 Nov 2014 | Jeevan Pramaan (Digital Life Certificate) launched by the Prime Minister | [^10] |
| 29 Nov 2021 | Face Authentication-based life certificate app launched | [^9] |
| 2019-2020 (approx) | MeriPehchaan / Jan Parichay National Single Sign-On operational (MeitY/NIC); precise public launch date not centrally published | [^1][^2][^3] |
| 2023 | DLC Campaign 2.0 — 1.15 crore certificates | [^16] |
| Nov 2024 | DLC Campaign 3.0 — 1.62 crore submissions, 845 cities/districts | [^13] |
| Nov 2025 | DLC Campaign 4.0 — reported 1.54-1.91 crore certificates | [^11][^12] |
| FY 2025-26 | 1.90 crore DLCs generated (to 24 Mar 2026); 1.41 crore by super-seniors (80+) | [^15][^24] |

### Appendix B: Integration and Ecosystem Directory

**Jan Parichay / MeriPehchaan (National Single Sign-On)**

| Component | Detail |
|-----------|--------|
| Integration methods | Open API, SAML 2.0, OAuth2.0 (via jppartners framework) | [^6] |
| Second-factor app | Parichay Authenticator — token and tap 2-step verification | [^7] |
| Identity anchors | Aadhaar, PAN, Mobile, Email (incl. public addresses), Driving Licence | [^2] |
| Security features | Multi-factor auth, geofencing, per-service authorization, real-time auditing | [^2] |
| Sibling services | DigiLocker, e-Pramaan, Jan Parichay (selectable identity providers) | [^3] |

**Jeevan Pramaan (Digital Life Certificate) ecosystem**

| Actor | Role |
|-------|------|
| Sanctioning Authority | Issues the Pension Payment Order (PPO) |
| Pension Disbursing Agency (PDA) | Bank / post office / treasury that releases pension |
| Jeevan Pramaan Centres / CSCs | Assisted generation points |
| Pensioner | Authenticates via fingerprint, iris, or face |

Channels: Jeevan Pramaan website, Android app, UMANG, banks, post offices / IPPB (incl. doorstep by postmen and Gramin Dak Sevaks), CSCs.[^9][^25][^27]

### Appendix C: Key Statistics Summary

| Statistic | Value | Source |
|-----------|-------|--------|
| Cumulative DLCs since 2014 | 12.25 crore | [^8] |
| DLCs in FY 2025-26 (to 24 Mar 2026) | 1.90 crore | [^15] |
| Of which via face authentication | 1.15 crore (~60.5 per cent) | [^15][^24] |
| Super-seniors (80+) DLCs, FY25-26 | 1.41 crore | [^24] |
| DLC Campaign 2.0 state leaders | Maharashtra 5.07L, UP 4.55L, WB 2.65L | [^16] |
| Doorstep DLCs via India Post (IPPB) | 705,564 (total) | [^17] |
| Only official per-state source | EPFO Jeevan Pramaan dashboard (interactive, not CSV) | [^19] |

**State snapshot (indicative, mixed scopes — see Chapter 9):**

| State | Doorstep DLCs (IPPB) | Campaign 2.0 (lakh) |
|-------|----------------------|---------------------|
| Maharashtra | 96,548 | 5.07 |
| Tamil Nadu | 90,929 | - |
| Uttar Pradesh | 47,336 | 4.55 |
| West Bengal | 38,387 | 2.65 |
| Kerala | 62,306 | - |
| Andhra Pradesh | 66,238 | - |
| Telangana | 76,950 | - |

### Appendix D: Glossary

| Term | Definition |
|------|------------|
| **Aadhaar** | 12-digit unique identity number issued by UIDAI |
| **AadhaarFaceRD** | Aadhaar face capture service enabling camera-only authentication |
| **CSC** | Common Service Centre — village-level assisted government service point |
| **DLC** | Digital Life Certificate — the Jeevan Pramaan output |
| **DoPPW** | Department of Pension and Pensioners' Welfare |
| **DPDP** | Digital Personal Data Protection Act, 2023 |
| **EPFO** | Employees' Provident Fund Organisation |
| **Geofencing** | Restricting service access to defined geographic boundaries |
| **IPPB** | India Post Payments Bank — delivers doorstep DLC service |
| **Jan Parichay** | G2C (citizen) single sign-on under MeriPehchaan |
| **Jeevan Pramaan** | Aadhaar-based Digital Life Certificate for pensioners |
| **MeitY** | Ministry of Electronics and Information Technology |
| **MeriPehchaan** | Brand name for India's National Single Sign-On |
| **MFA** | Multi-Factor Authentication |
| **NIC** | National Informatics Centre — builds Parichay / Jan Parichay |
| **NSSO** | National Single Sign-On |
| **OAuth2.0** | Authorization framework used by Jan Parichay integration |
| **PDA** | Pension Disbursing Agency — pays the pension |
| **PPO** | Pension Payment Order — the sanctioning record a DLC is generated against |
| **RD Service** | Registered Device service — encrypts biometrics for Aadhaar auth |
| **SAML 2.0** | Security assertion markup used for SSO federation |
| **Sanctioning Authority** | Body that issues the PPO to a pensioner |
| **SSO** | Single Sign-On |
| **UIDAI** | Unique Identification Authority of India |
| **UMANG** | Unified Mobile Application for New-age Governance — government services app |

---


# References

[^1]: Digital India / MeitY, "JanParichay-Meri Pehchaan, National Single Sign-On." https://www.digitalindia.gov.in/initiative/janparichay-meri-pehchaan-the-national-single-sign-on

[^2]: National Informatics Centre, "Parichay" project page — G2G Parichay and G2C Jan Parichay; multilingual SSO; attributes Aadhaar/PAN/Mobile/Email/Driving Licence; MFA, geofencing, per-service authorization. https://www.nic.in/project/parichay

[^3]: MeriPehchaan — National Single Sign-On (NSSO) overview, Government of India. https://meripehchaan.gov.in

[^4]: JanParichay official — About Us (G2C SSO for transport, MyGov, and other citizen services). https://janparichay.meripehchaan.gov.in/v1/pehchaan/about-us.html

[^5]: JanParichay — End-User Manual (PDF). https://janparichay.meripehchaan.gov.in/v1/pehchaan/User%20Manual.pdf

[^6]: JanParichay Partners — Integration framework (Open API, SAML 2.0, OAuth2.0). https://jppartners.meripehchaan.gov.in

[^7]: Parichay Authenticator — Google Play (2-step verification, token and tap authentication). https://play.google.com/store/apps/details?id=com.nic.parichayauthenticator

[^8]: Jeevan Pramaan portal — homepage counters (12.25 crore Digital Life Certificates submitted since 2014). https://jeevanpramaan.gov.in/v1.0

[^9]: Digital India, "Jeevan Pramaan" initiative page — biometric, Aadhaar-based; Face Authentication life certificate app launched 29 Nov 2021. https://www.digitalindia.gov.in/initiative/jeevan-pramam

[^10]: Wikipedia, "Jeevan Pramaan" — launched 10 November 2014 by the Prime Minister; built by Department of Electronics and IT. https://en.wikipedia.org/wiki/Jeevan_Pramaan

[^11]: Press Information Bureau, "Nationwide Digital Life Certificate Campaign 4.0" (1-30 Nov 2025); references Campaign 3.0 at 1.62 crore. https://www.pib.gov.in/PressReleasePage.aspx?PRID=2186239

[^12]: DD News, "Nationwide Digital Life Certificate Campaign 4.0" (over 1.91 crore DLCs; 57 lakh central government pensioners). https://ddnews.gov.in/en/nationwide-digital-life-certificate-campaign-4-0-to-be-held-from-november-1-to-30

[^13]: Press Information Bureau, "DLC Campaign 3.0" (Nov 2024, 845 cities/districts, 1.62 crore submissions). https://www.pib.gov.in/PressReleasePage.aspx?PRID=2155929

[^14]: The Indian Express, "In 'life certificate' month, how Govt's Jeevan Pramaan has been faring" (1.47 crore in last year's campaign; 45.46 lakh central government pensioners). https://indianexpress.com/article/explained/in-life-certificate-month-how-govts-jeevan-pramaan-has-been-faring-9672250

[^15]: The Hindu, "Pensioners generated 1.9 crore digital life certificates in 2025-26" (1.90 crore, 1 Apr 2025-24 Mar 2026; 1.15 crore via face authentication). https://www.thehindu.com/news/national/pensioners-generated-19-crore-digital-life-certificates-in-2025-26-govt/article70811073.ece

[^16]: The Economic Times, "Pensioners generate 1.15 crore digital life certificates" (DLC Campaign 2.0; Maharashtra 5.07 lakh, UP 4.55 lakh, West Bengal 2.65 lakh; 38.47L central, 16.15L state, 50.91L EPFO). https://economictimes.indiatimes.com/industry/banking/finance/insure/pensioners-generate-1-15-crore-digital-life-certificates-centre/articleshow/105654530.cms

[^17]: GConnect, "Disbursement of Jeevan Pramaan Patra through Postmen and Gramin Dak Sevaks" (IPPB doorstep; total 705,564). https://www.gconnect.in/news/disbursement-jeevan-pramaan-patra-postmen-gramin-dak-sevaks.html

[^18]: StaffNews, state-wise Jeevan Pramaan Patra 2021-22 and 2022-23 (up to 31 Oct 2022); totals 4,54,316 and 5,27,286. https://www.staffnews.in/2021/12/disbursement-of-jeevan-pramaan-patra-through-postmen.html

[^19]: EPFO Jeevan Pramaan Dashboard (state-wise DLC status, pending, rejection reasons). https://mis.epfindia.gov.in/JeevanPramaan/

[^20]: The Economic Times, "12 reasons face authentication can fail when submitting Jeevan Pramaan." https://m.economictimes.com/wealth/save/digital-life-certificate-12-reasons-face-authentication-can-fail-when-submitting-jeevan-pramaan/articleshow/105590324.cms

[^21]: Jeevan Pramaan Face App installation manual (AadhaarFaceRD; face/finger/iris). https://jeevanpramaan.gov.in/newassets/jpdocs/JeevanPramaan_FaceApp_3.6_Installation.pdf

[^22]: SCMS journal, "Digital Life Certificate: Facilitating Pension Disbursement in India" (fingerprint vs iris infrastructure issues). https://www.scms.edu.in/uploads/journal/articles/article_18.pdf

[^23]: Comptroller and Auditor General of India, "Submission of Life Certificate through Jeevan Pramaan" (Indian Audit and Accounts Department). https://cag.gov.in/uploads/ae_notices/AeNotices-06724a2c3208f53-23839932.pdf

[^24]: Outlook Money, "Over 1.4 million super seniors generated online Jeevan Pramaan Patra in FY25-26" (1.41 crore super-seniors; ~60.5 per cent face auth). https://www.outlookmoney.com/retirement/digital-life-certificate-over-14-million-super-seniors-generated-online-jeevan-pramaan-patra-in-fy25-26

[^25]: Press Information Bureau, "Digital Life Certificate can now be made at doorstep through Postman" (IPPB; viewable T+1). https://www.pib.gov.in/PressReleasePage.aspx?PRID=2189435

[^26]: Jeevan Pramaan app — Google Play (face/finger/iris; only onboarded Sanctioning Authorities). https://play.google.com/store/apps/details?id=com.aadhaar.life

[^27]: UMANG — Jeevan Pramaan service. https://web.umang.gov.in/landing/department/jeevan-pramaan.html

[^28]: MeitY, Digital Personal Data Protection Act, 2023. https://www.meity.gov.in/digital-personal-data-protection-act-2023

[^29]: UIDAI — Aadhaar authentication ecosystem. https://uidai.gov.in

[^30]: Department of Pension and Pensioners' Welfare / Pensioners' Portal (central pensioner DLC integration, Face_JP guidance). https://pensionersportal.gov.in


# About This Book

## What This Book Is

This book is the definitive reference on Jan Parichay (Meri Pehchaan) — India's National Single Sign-On — and the service that most stresses its promises: the Digital Life Certificate (Jeevan Pramaan) that every pensioner must submit each year to keep their pension alive. It covers the full stack: the identity layer, the authentication architecture, the law, the adoption data, a state-by-state survey, the exclusion risks, and the governance gaps.

## What This Book Is Not

This is not a vendor manual. It is not a government white paper. It is not marketing material for the digital identity industry. It maintains a critical, independent perspective throughout, naming what works and what does not.

## The CashlessConsumer Lens

CashlessConsumer is a fintech and DPI research publication that examines digital financial infrastructure from the consumer's perspective. Every analysis in this book asks: *Does this increase or reduce the user's agency? Is the power balance fair? Who benefits and who bears the risk?*

## How to Read This Book

- **New to Jan Parichay?** Start with Chapter 1. The ELI5 summaries at each chapter are written for you.
- **Technical reader?** Focus on Chapter 2 (identity attributes), Chapter 3 (architecture), and Chapter 6 (DLC technology).
- **Policy or welfare administrator?** Chapters 7, 8, and 9 (campaigns, national data, state survey) are for you.
- **Concerned about rights?** Chapters 10, 11, and 12 cover exclusion, privacy, and accountability.
- **Short on time?** Read the ELI5 summaries throughout, plus the Assessment section at the end of each chapter.

## Edition

First edition, compiled July 2026. This is a living document — corrections, updates, and new chapters will be published as the ecosystem evolves.

## License

CC BY-NC-SA 4.0. You are free to share and adapt this work for non-commercial purposes, with attribution.


# About the Author

**CashlessConsumer** is a fintech and digital public infrastructure researcher. Through the CashlessConsumer newsletter and DPI Watch publication, they cover India's digital payments landscape, Aadhaar, UPI, ONDC, account aggregators, and the regulatory framework around digital identity.

The author runs automated content operations on Zo Computer, self-hosts AI tools for research and production, and maintains a strong interest in open data, public transit, Tamil language, and free (freedom) code.

Published works appear at:
- [CashlessConsumer Newsletter](https://newsletter.cashlessconsumer.in)
- [DPI Watch](https://newsletter.cashlessconsumer.in)
- [GitHub](https://github.com/CashlessConsumer)


