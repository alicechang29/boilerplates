class Playlist {
  constructor(name) {
    this.songs = [];
    this.name = name;
    this.currentSong = null;
    this.songQueue = [];
  }
  addSong(song) {
    return this.songs.push(song);
  }
  removeSong(song) {
    //FIXME: does this work if song is an object?
    return this.songs = this.songs.filter(s => s !== song);
  }
  playSong(song) {
    return this.currentSong = song;
  }
  shuffleSongs() {
    return this.songs = _.shuffle(this.songs);
  }
  getPlaylistName() {
    return this.name;
  }
  setPlaylistName(name) {
    return this.name = name;
  }
  addSongToQueue(song) {
    if (this.songs.includes(song)) {
      return this.songQueue.push(song);
    }
  }
  removeSongFromQueue() {
    return this.playSong(this.songQueue.shift());
  }
}