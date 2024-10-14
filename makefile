setup:
	cd files && stow -t ~ stow

stow:
	cd files && stow --verbose --target=$$HOME --restow .

delete:
	cd files && stow --verbose --target=$$HOME --delete .
