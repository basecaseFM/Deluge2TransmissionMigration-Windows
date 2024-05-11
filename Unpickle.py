
import deluge
import pickle
state_pickle = open ("torrents.state", "rb")
state_contents = pickle.load(state_pickle)
state_pickle.close()

for torrent in state_contents.torrents:
	print(torrent.torrent_id,",",torrent.save_path)
