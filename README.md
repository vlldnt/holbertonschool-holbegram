# Holbegram - Instagram Clone

> **Last Project of the Year** | Holberton School

A fully functional Instagram clone developed with **Flutter** and **Firebase**.

---

## Quick Demo

```
INSTALLATION  →  LAUNCH  →  TESTING
```

**Estimated time: 5-10 minutes**

---

## Features

| Feature | Status | Description |
|---------|--------|-------------|
| Authentication | Complete | Sign up and login with Firebase |
| Create Posts | Complete | Upload images from gallery |
| Feed | Complete | Display all posts |
| Bookmarks/Favorites | Complete | Save favorite posts |
| Search | Complete | Browse posts in grid |
| User Profile | Complete | Avatar, stats, personal posts |
| Cloudinary | Complete | High-quality image storage |
| Logout | Complete | Secure logout |

---

## Quick Start

### Step 1: Install Flutter (5 min)

```bash
# Check if Flutter is installed
flutter --version

# If not, download it here:
# https://flutter.dev/docs/get-started/install
```

### Step 2: Clone the repository (1 min)

```bash
git clone https://github.com/vlldnt/holbertonschool-holbegram.git
cd holbertonschool-holbegram/holbegram
```

### Step 3: Install dependencies (2 min)

```bash
flutter pub get
```

### Step 4: Run the app (2 min)

```bash
# On emulator
flutter run

# OR on real device
flutter devices        # List your devices
flutter run -d <id>   # Run on device
```

---

## Firebase Configuration (Required!)

**The app does not work without Firebase!**

### Who should do this?

- **Reviewer** -> **Create your own Firebase project**

### How to configure:

1. **Create a Firebase Project**
   - Go to: https://console.firebase.google.com
   - Click "Create a project"
   - Name it: `holbegram-test`

2. **Enable Authentication**
   - Build -> Authentication
   - Sign-in method -> Email/Password
   - Click "Enable"

3. **Create Firestore Database**
   - Build -> Firestore Database
   - Click "Create Database"
   - Mode: **Test** (for testing)

4. **Download configuration files**
   - Project Settings -> Settings
   - Android: Download `google-services.json`
     - Place in: `android/app/`
   - iOS: Download `GoogleService-Info.plist`
     - Place in: `ios/Runner/`

5. **Re-run the app**
   ```bash
   flutter run
   ```

---

## Complete Testing Guide

### Test 1: Create Account

```
1. Signup screen -> Enter your information
   Email: test@example.com
   Password: password123

2. Click "Sign Up"

3. PASS if redirected to Feed
```

### Test 2: Create a Post

```
1. Feed tab -> Click + icon (top-right)

2. Select an image

3. Enter text: "My first post!"

4. Click "Post"

5. PASS if post appears at top of Feed
```

### Test 3: Bookmark System

```
1. Feed tab

2. Click bookmark icon
   -> Icon becomes filled and blue

3. Go to Favorites tab

4. PASS if saved post appears here

5. Click bookmark again -> Post disappears
```

### Test 4: Profile

```
1. Profile tab

2. Verify:
   - Photo (circle) on left
   - Name below
   - Stats on right (Posts, Followers, Following)
   - Grid 3x3 of your posts

3. Click logout icon (top-right)

4. PASS if redirected to login
```

### Test 5: Search

```
1. Search tab

2. PASS if:
   - Images in 2-3 column grid
   - Scroll works
   - No errors
```

### Test 6: Re-login

```
1. Logout (Profile -> logout icon)

2. Login with:
   Email: test@example.com
   Password: password123

3. PASS if logged in to Feed
```

---

## Interface Screenshots

### Feed Page
```
+---------------------+
| Holbegram      +  O |  <- AppBar
+---------------------+
| O username          |
|   Caption text...   |
| +-------+           |
| |       |           |  Image
| |       |           |
| +-------+           |
| [heart] [comment]...|
| 123 Liked           |
+---------------------+
| [Next post...]      |
+---------------------+
```

### Profile Page
```
+---------------------+
| Profile         [X] |  <- Logout icon
+---------------------+
| O    | Posts:    5  |
| Name | Followers: 0 |
|      | Following: 0 |
+---------------------+
| [] [] []  <- 3x3    |
| [] [] []            |
| []                  |
+---------------------+
```

---

## Project Architecture

```
holbegram/
|
+-- lib/
    +-- main.dart                    <- Entry point
    |
    +-- screens/
    |   +-- login_screen.dart        <- Login
    |   +-- signup_screen.dart       <- Sign up
    |   +-- home.dart                <- Main navigation
    |   |
    |   +-- pages/
    |       +-- feed.dart            <- Feed
    |       +-- search.dart          <- Search
    |       +-- add_image.dart       <- Create post
    |       +-- favorite.dart        <- Bookmarks
    |       +-- profile_screen.dart  <- Profile
    |       |
    |       +-- methods/
    |           +-- favorites_service.dart
    |           +-- post_storage.dart
    |
    +-- models/
    |   +-- user.dart                <- User model
    |   +-- post.dart                <- Post model
    |
    +-- providers/
    |   +-- user_provider.dart       <- State management
    |
    +-- methods/
        +-- auth_method.dart         <- Authentication
|
+-- pubspec.yaml                     <- Dependencies
```

---

## Technologies Used

| Technology | Version | Purpose |
|------------|---------|---------|
| Flutter | 3.0+ | UI Framework |
| Firebase Auth | ^4.15 | Authentication |
| Firestore | ^4.14 | Database |
| Provider | ^6.0 | State management |
| Image Picker | ^1.0 | Image selection |
| Cloudinary | - | Image storage |

---

## Review Checklist

Before validation, verify:

- [ ] Firebase is configured
- [ ] `flutter pub get` runs without error
- [ ] `flutter run` works
- [ ] Test 1: Signup/Login - PASS
- [ ] Test 2: Create post - PASS
- [ ] Test 3: Bookmarks - PASS
- [ ] Test 4: Profile - PASS
- [ ] Test 5: Search - PASS
- [ ] Test 6: Logout - PASS
- [ ] No errors in logs
- [ ] Images display correctly
- [ ] Navigation is smooth

---

## Troubleshooting

| Error | Solution |
|-------|----------|
| Firebase not initialized | Check `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) |
| Firestore permission denied | Go to Firebase Console -> Firestore Rules -> Test mode |
| Image picker error | Check permissions in `pubspec.yaml` |
| App crashes on startup | Run `flutter clean` then `flutter pub get` |
| Build fails | Check Flutter version: `flutter --version` |

### Debug Mode

```bash
# View logs in real-time
flutter logs

# Full rebuild
flutter clean
flutter pub get
flutter run
```

---

## Contact & Support

**Author**: Adrien Vieilledent
Email: vieilledent.adrien@gmail.com
GitHub: @vlldnt (https://github.com/vlldnt)

---

## Important Notes for Reviewers

1. **Firebase is REQUIRED** - Create your own project to test
2. **Test Mode** - Use test mode for Firestore (more permissive)
3. **Sync Delay** - Firestore may take 1-2 seconds to sync
4. **Images** - Images come from Cloudinary (high bandwidth)
5. **Emulator** - Recommended for best experience

---

## Project Status: COMPLETE & FUNCTIONAL

Good testing!
