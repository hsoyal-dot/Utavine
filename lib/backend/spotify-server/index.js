const express = require('express');
const axios = require('axios');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

let accessToken = '';
let tokenExpiry = 0;

async function getAccessToken() {
  const now = Date.now();
  if (accessToken && now < tokenExpiry) return accessToken;

  const res = await axios.post(
    'https://accounts.spotify.com/api/token',
    'grant_type=client_credentials',
    {
      headers: {
        Authorization: 'Basic ' + Buffer.from(
          process.env.SPOTIFY_CLIENT_ID + ':' + process.env.SPOTIFY_CLIENT_SECRET
        ).toString('base64'),
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    }
  );

  accessToken = res.data.access_token;
  tokenExpiry = now + res.data.expires_in * 1000;
  return accessToken;
}

app.get('/search', async (req, res) => {
  try {
    const token = await getAccessToken();
    const keyword = req.query.q;
    const result = await axios.get(`https://api.spotify.com/v1/search`, {
      headers: { Authorization: `Bearer ${token}` },
      params: { q: keyword, type: 'track', limit: 10 },
    });

    const songs = result.data.tracks.items.map(track => ({
      id: track.id,
      name: track.name,
      artists: track.artists.map(a => a.name).join(', '),
      albumImage: track.album.images[0]?.url ?? '',
      previewUrl: track.preview_url,
    }));

    res.json(songs);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Spotify server running on port ${PORT}`));