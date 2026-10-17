# Music App Integration TODO

## ✅ Completed
1. Created AudioService with YouTube playback
2. Created SongsData with all songs (3 bhajans + 1 Satcharitra)
3. Added provider package for state management
4. Updated DevotionalMelodies to play real songs

## 🔄 Next Steps

### 1. Update Home Screen
- Connect home screen's player drawer to AudioService
- Show/hide player drawer based on AudioService state
- Display currently playing song info

### 2. Update Player Screen
- Connect to AudioService for real-time updates
- Make progress bar interactive (seek functionality)
- Update play/pause, next, previous, rewind, forward buttons
- Show current song details from AudioService
- Display audio-only YouTube player (hidden)

### 3. Update Parayan Progress Widget  
- Connect "Resume Parayan Audio" button to play Satcharitra
- Use real song data for Saptah Parayan

### 4. Global State Synchronization
- Player drawer on home shows current playing song
- Player screen reflects same state
- Navigation between screens maintains playback

### 5. Features to Implement
- Persist playback state (SharedPreferences)
- Background audio continuation
- Audio focus handling
- Notification controls (optional)

## Song Data
- **Jai Jai Sai**: 5:26 - y2KRU8Avb0A
- **Sainath Tere Hazaron Haath**: 6:45 - DUZt1Wcyfas
- **Sai Baba Bol**: 7:54 - aZaKltXemRs
- **Satcharitra Adhyay 15**: 10:23 - B5Rzf0Ucx7Q
