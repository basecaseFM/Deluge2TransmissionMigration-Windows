# run 'Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;' to make scripts executable

# Change YOUR USERNAME to the user folder you are working with
$username="YOUR USERNAME"

# set path transmission-remote
# This is the standard install location, change if installed in different location
$TR_REMOTE="C:\Program Files\Transmission\transmission-remote.exe"

#set path for torrents

$deluge_torrents_dir="C:\Users\$username\AppData\Roaming\deluge\state\"


python 'C:\Program Files\Deluge\unpickle.py' | Out-File -FilePath "C:\Users\$username\Documents\hash-paths.txt"



$FilePath = "C:\Users\$username\Documents\hash-paths.txt"
$torrent_data = Import-Csv -Path $FilePath -Header "hash","path"
$torrent_data | Format-Table
foreach($row in $torrent_data) {
    $hash=$row.hash
    $hash=$hash.Trim()
    $torrent_path=$row.path
    $torrent_for_hash=$deluge_torrents_dir+$hash
    $torrent_for_hash=$torrent_for_hash+'.torrent'
    Write-Host $torrent_for_hash
    & "C:\Program Files\Transmission\transmission-remote.exe" -a $torrent_for_hash -w "$torrent_path"
    & "C:\Program Files\Transmission\transmission-remote.exe" -t $hash -v
}