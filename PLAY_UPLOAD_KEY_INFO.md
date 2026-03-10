# Play Upload Key Info

Use the same upload key for all future Google Play updates of this app.

## App identity

- App name: `Dclub`
- Package name: `com.vfq.app`

## Upload key files

- Keystore file: `upload-keystore-v2.jks`
- Properties file: `keystore.properties`
- Key alias: `upload`

## Certificate fingerprints

- SHA1: `37:56:A0:6B:00:CA:A2:6B:6B:84:41:40:B3:01:4A:32:A3:64:A6:D8`
- SHA256: `A1:09:8F:39:28:0E:FC:6B:CD:F5:D1:28:BD:0C:29:12:51:CB:87:72:73:BF:1E:5E:A9:78:EF:21:61:8F:92:71`

## Current production bundle

- File: `app\build\outputs\bundle\release\app-release.aab`
- Version code: `6`
- Version name: `1.0.0`

## Required backup

Back up these items outside this project:

- `upload-keystore-v2.jks`
- The keystore password
- The key password
- The alias name `upload`

If you lose the upload keystore, future Play Store updates become much harder and may require Play App Signing recovery steps.
