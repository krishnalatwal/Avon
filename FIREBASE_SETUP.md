# Firebase manual setup checklist

Project: **avon-b22fd** (console: https://console.firebase.google.com/project/avon-b22fd)

These are steps only you can do in the Firebase console / Apple & Google developer
portals — nothing here involves pasting secrets into chat. Do the "Required now"
section first; the rest is for when we build those sign-in methods later.

## Required now — Email/Password sign-in

1. Open the [Authentication page](https://console.firebase.google.com/project/avon-b22fd/authentication/providers) for the project.
2. Click **Get started** if this is the first provider you're enabling.
3. Click **Email/Password**, toggle it **on**, leave "Email link (passwordless sign-in)" off, click **Save**.

Once this is done, tell me and I'll wire the Create Account button to actually
call Firebase Authentication (`createUserWithEmailAndPassword`).

### Optional, same step
- Decide now whether you want a real verification email sent after sign-up
  (the UI already says "We'll send a verification link to this address.").
  If yes, no console setup needed — I call `sendEmailVerification()` in code.
  Firebase's default email templates work out of the box; customize wording
  later under Authentication → Templates if you want.

## Later — Apple Sign-In

1. Requires a paid Apple Developer account.
2. In the Apple Developer portal: create a **Services ID**, enable **Sign In
   with Apple** on it, and configure its return/redirect URL (Firebase gives
   you the exact URL to paste once you start enabling the provider below).
3. Generate a **Sign In with Apple private key** (Certificates, Identifiers &
   Profiles → Keys) and note the **Key ID** and your **Team ID**.
4. In Firebase console → Authentication → Sign-in method → **Apple**: enable
   it and paste in the Services ID, Team ID, Key ID, and the private key.
5. In Xcode, add the "Sign in with Apple" capability to the Runner target
   (I can do this step once you've done 1–4).

## Later — Google Sign-In

1. In Firebase console → Authentication → Sign-in method → **Google**: enable
   it (Firebase auto-generates the OAuth client IDs).
2. Android: add your debug **and** release SHA-1/SHA-256 certificate
   fingerprints under Project settings → Your apps → the Android app → Add
   fingerprint. Get the debug one by running `cd android && ./gradlew
   signingReport`.
3. iOS config (`REVERSED_CLIENT_ID` URL scheme) — I handle this in code once
   the provider is enabled.

## Later — Phone number sign-in

(Only needed if the "recovery phone" field becomes an actual sign-in method,
not just a backup contact.)

1. Firebase console → Authentication → Sign-in method → **Phone**: enable it.
2. iOS: enable Push Notifications on the app and upload an APNs
   authentication key (Project settings → Cloud Messaging) — needed for
   silent push verification.
3. Android: same SHA fingerprints as the Google step, for Play
   Integrity/SafetyNet checks.
4. Phone auth has a free-tier quota and may require upgrading to the **Blaze**
   (pay-as-you-go) plan at higher volume — your call if/when we get there.

## Optional — only if we persist profile data beyond auth

(Full name, recovery phone, marketing consent, etc. — auth alone only stores
email + password.)

1. Firebase console → Build → Firestore Database → **Create database**, pick
   a location, start in production mode. We'll write the security rules
   together before any writes happen.
