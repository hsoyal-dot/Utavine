# Utavine: Mood-based Music App

**Utavine** is an AI-powered smart music app that recommends music based on your real-time heart rate (from Wear OS smartwatches). By analyzing your BPM through a companion app, VineHeart, and generating mood keywords using Gemini, it provides personalized music experiences.

---

## 📱 Features

- 🔒 Firebase Authentication for user login
- ❤️ Real-time Heart Rate tracking via VineHeart (WearOS companion app)
- 🧠 Gemini API to generate mood keywords based on heart rate
- 🎧 Spotify API integration to search & recommend songs
- ☁️ Supabase for storing user-specific heart rate data
- 🌐 Flutter + Dart + Firebase Auth + Supabase

---

## 💭 How It Works

1. **Heart Rate Tracking:** VineHeart (a Wear OS app) tracks heart rate using `SensorManager`.
2. **Supabase Sync:** Every 60s, it pushes the data (`bpm`, `timestamp`, `user_id`) to Supabase.
3. **User Login:** Users log into Utavine using Firebase Authentication.
4. **Fetch BPM:** Utavine fetches the latest BPM using the logged-in Firebase UID.
5. **AI Mood Matching:** Gemini API converts BPM into keywords (e.g., `"calm", "focus"`).
6. **Spotify Suggestions:** Spotify API returns song suggestions for those keywords.

---

## 🧱 Tech Stack

| Layer | Tech |
|------|------|
| UI | Flutter |
| Mobile Companion | VineHeart- Kotlin-based Wear OS App |
| Backend | Dart, Node.js |
| Auth | Firebase |
| Database | Supabase (PostgreSQL) |
| AI | Google Gemini API |
| Music | Spotify API |

---

## 📂 Folder Structure (Flutter)

```
utavine/
├── lib/
│   ├── data/
│   │   ├── models/
│   │   └── sources/
│   │       ├── api/
│   │       └── services/
│   ├── presentation/
│   │   └── vine_sense/
│   │       ├── bloc/
│   │       └── screens/
│   └── main.dart
└── .env
```

---

## ⚙️ Setup

### 🧩 Firebase Auth (Shared by both apps)
1. Set up Firebase project.
2. Enable Email/Password sign-in method.
3. Add `google-services.json` to both apps.
4. Ensure `firebase_core` & `firebase_auth` are initialized in both apps.

### 📲 VineHeart (Wear OS App)
1. Uses `SensorManager` to read heart rate.
2. Pushes data to Supabase via REST using OkHttp.
3. Requires `.env` setup inside `local.properties`:
   ```properties
   SUPABASE_URL=https://your-instance.supabase.co/rest/v1
   SUPABASE_API_KEY=your-key
   ```

### 🌐 Utavine Mobile App
1. Uses Firebase Auth for login/signup.
2. Reads user UID to fetch `bpm` data from Supabase.
3. Converts BPM to keywords via Gemini.
4. Fetches Spotify songs.

#### `.env` (for Utavine)
```
SUPABASE_URL=https://your-instance.supabase.co/rest/v1
SUPABASE_API_KEY=your-key
SPOTIFY_BASE_URL=http://localhost:3000
GEMINI_API_KEY=your-gemini-key
```

---

## 🚀 Roadmap

- [x] Real-time HR sync via VineHeart
- [x] Firebase Auth login for both apps
- [x] Gemini keyword mapping
- [x] Spotify integration
- [ ] UI/UX polish for VineSense screen
- [ ] Add playlists and like/save feature
- [ ] Push notifications for mood-based music

---

## 👤 Author

**Hemraj Soyal**  (MCA Student at Vellore Institute of Technology)
- 🔗 LinkedIn: [linkedin.com/in/hsoyal-dot](https://www.linkedin.com/in/hsoyal-dot)
- 🔗 GitHub: [github.com/hsoyal-dot](https://github.com/hsoyal-dot)

---