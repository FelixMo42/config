{ pkgs } :

pkgs.neovim.override {
	vimAlias = true;

	configure = {
		customRC = builtins.readFile ./vimrc;

		packages.myVimPackage = with pkgs.vimPlugins; { start = [
			deoplete-nvim
			LanguageClient-neovim
			nerdcommenter
			fzf-vim
			vim-racer
			vim-nix
		]; };
	};
}
