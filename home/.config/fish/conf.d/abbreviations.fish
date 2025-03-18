#!/usr/bin/env fish

abbr --add wget -- wget -q -c -w 3 --show-progress

if type -q bat
	abbr --add cat -- bat
end

if type -q cargo
	abbr --add ca -- cargo
end

if type -q docker
	abbr --add dc -- docker compose
end

if type -q eza
	abbr --add l -- eza -1
	abbr --add la -- eza -la
	abbr --add lat -- eza -laT
	abbr --add ll -- eza -l
	abbr --add lr -- eza -lR
	abbr --add ls -- eza
	abbr --add lt -- eza -lT
end

if type -q git
	abbr --add g -- git
	abbr --add ga -- git add
	abbr --add gaf -- git fzf-add
	abbr --add gap -- git add --patch
	abbr --add gb -- git branch
	abbr --add gba -- git branch --all --verbose
	abbr --add gbD -- git branch -D
	abbr --add gbd -- git branch --delete
	abbr --add gbm -- git branch --move
	abbr --add gbr -- git branch --remote
	abbr --add gc -- git commit --verbose
	abbr --add gca -- git commit --all --verbose
	abbr --add gcam -- git commit --all --message
	abbr --add gch -- git checkout
	abbr --add gcm -- git commit --message
	abbr --add gcp -- git cherry-pick
	abbr --add gd -- git diff
	abbr --add gdc -- git diff --cached
	abbr --add gdt -- git difftool
	abbr --add gf -- git fetch
	abbr --add gfa -- git fetch --all
	abbr --add gfm -- git pull
	abbr --add gfr -- git pull --rebase
	abbr --add gl -- git log
	abbr --add glg -- git lg
	abbr --add glga -- git lg --all
	abbr --add glgs -- git lg -10
	abbr --add gm -- git merge --no-ff
	abbr --add gmf -- git merge --ff-only
	abbr --add gms -- git merge --squash
	abbr --add gmt -- git mergetool
	abbr --add gp -- git push --follow-tags
	abbr --add gpa -- git push --all --follow-tags
	abbr --add gpt -- git push --tags
	abbr --add gr -- git reset
	abbr --add grb -- git rebase
	abbr --add gri -- git rebase --interactive
	abbr --add grp -- git reset --patch
	abbr --add gS -- git status
	abbr --add gs -- git status --short
	abbr --add gSa -- git status -uall
	abbr --add gsa -- git status -uall --short
	abbr --add gt -- git stash
	abbr --add gta -- git stash apply
	abbr --add gtl -- git stash list
	abbr --add gtp -- git stash pop
end

if type -q paru
	abbr --add pacman -- paru
end

if type -q nvim
	abbr --add vim -- nvim
	abbr --add vimc -- cd ~/.config/nvim \&\& nvim
end

if type -q wl-copy && type -q wl-paste
	abbr --add xc -- wl-copy
	abbr --add xp -- wl-paste
end

if type -q terraform
	abbr --add tf -- terraform
	abbr --add tfa -- terraform apply
	abbr --add tfap -- terraform apply terraform.tfplan
	abbr --add tfp -- terraform plan -out terraform.tfplan
	abbr --add tfw -- terraform workspace
end
