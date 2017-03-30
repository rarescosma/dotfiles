default: install-packages link-config set-shell

server: install-debian-packages link-config set-shell

install-packages: add-repositories
	sudo pacman -Sy yaourt termite infinality-bundle
	yaourt -S --needed --noconfirm `cat packages.txt`

install-debian-packages:
	sudo apt-get update
	sudo apt-get install -y `cat packages-debian.txt`

add-repositories: add-infinality-key
	cat repositories.txt | sudo tee -a /etc/pacman.conf

add-infinality-key:
	sudo dirmngr &
	sleep 1
	sudo pacman-key -r 962DDE58
	sudo pacman-key --lsign-key 962DDE58

link-config:
	stow -t ~ --restow `ls -d */`

set-shell:
	chsh -s `which zsh`
