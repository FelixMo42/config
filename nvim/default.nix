{ stdenv, pkgs, fetchFromGitHub,
  coreutils, findutils, gnugrep, gnused } :

let coc =
  pkgs.vimUtils.buildVimPlugin rec {
    pname = "new-coc";
    version = "v0.80";

    src = fetchFromGitHub {
      owner = "neoclide";
      repo = "coc.nvim";
      rev = "v0.0.80";
      sha256 = "1c2spdx4jvv7j52f37lxk64m3rx7003whjnra3y1c7m2d7ljs6rb";
    };
  }; in


pkgs.neovim.override {
	viAlias = true;
	vimAlias = true;

	configure = {
		customRC = builtins.readFile ./vimrc;

		packages.myVimPackage = with pkgs.vimPlugins; { start = [
			nerdcommenter # better commenting
			fzf-vim       # fuzzy file finding
            coc           # lsp client
            gruvbox       # my theme of choice
		]; };
	};
}
