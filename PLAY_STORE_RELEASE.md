# Google Play Production Release

This project can produce a Play Store upload bundle (`.aab`) after release signing is configured.

## 1. Required local files

Place these files in the project root:

- `upload-keystore.jks`
- `keystore.properties`

If you do not have a keystore yet, create one with:

```bat
create_upload_keystore.bat
```

Create `keystore.properties` by copying `keystore.properties.example` and filling the real values:

```properties
storeFile=upload-keystore.jks
storePassword=YOUR_UPLOAD_KEYSTORE_PASSWORD
keyAlias=upload
keyPassword=YOUR_UPLOAD_KEY_PASSWORD
```

You can also use environment variables instead of the file values:

- `ANDROID_KEYSTORE_FILE`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`

## 2. Build the production bundle

Run:

```bat
build_play.bat
```

Output:

- `app\build\outputs\bundle\release\app-release.aab`

`version.properties` is used for Play versioning and the release build auto-increments `VERSION_CODE`.

## 3. Files to prepare for Play Console

Prepare these assets before uploading:

- App icon: `512 x 512` PNG
- Feature graphic: `1024 x 500` PNG
- At least 2 phone screenshots
- Privacy policy URL
- Release notes

Templates are in the `play-store` folder.

## 4. Play Console submission

1. Open Google Play Console.
2. Create or open the app entry.
3. Complete App content, Data safety, and Content rating.
4. Upload `app-release.aab` in `Production`.
5. Add release notes.
6. Review warnings before rollout.

## 5. Current project notes

- Package name: `com.vfq.app`
- App name: `Dclub`
- Target SDK: `34`
- Min SDK: `21`
- Launch URL uses `http`, so `usesCleartextTraffic` is currently enabled in the manifest.

For Play submission, use HTTPS if the backend supports it. Shipping an HTTP-only login/payment flow is a security risk.
