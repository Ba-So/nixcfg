self: super: {
  tree-sitter-updated = super.tree-sitter.overrideAttrs (
    oldAttrs: {
      postInstall = ''PREFIX=$out make install'';
    }
  );
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (
    oldAttrs: rec {
      name = "neovim-stable";
      version = "v0.10.0";
      src = self.fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        rev = "v0.10.0";
        sha256 = "145mzl1pzqy0ic9gm0322z9ssvbyj0v9xiqs7k0wmi8b0590xg8s";
      };

      nativeBuildInputs = with self.pkgs; [ unzip cmake pkg-config gettext tree-sitter-updated ];
    }
  );
}
