{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # Go toolchain (requires 1.24+)
          go

          # Build tools
          pkg-config

          # Graphics/GUI dependencies for Fyne
          libGL
          libGLU
          libglvnd  # GL headers for CGO compilation
          xorg.libXxf86vm
          xorg.libXcursor
          xorg.libXrandr
          xorg.libXinerama
          xorg.libXi
          xorg.libX11
          glfw

          # GTK3 (needed by sqweek/dialog for native dialogs)
          gtk3

          # Runtime dependencies
          lpac
          fontconfig
        ];

        # Ensure CGO can find the libraries
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
          pkgs.libGL
          pkgs.libGLU
          pkgs.xorg.libXxf86vm
          pkgs.xorg.libXcursor
          pkgs.xorg.libXrandr
          pkgs.xorg.libXinerama
          pkgs.xorg.libXi
          pkgs.xorg.libX11
          pkgs.glfw
          pkgs.fontconfig
          pkgs.gtk3
        ];

        shellHook = ''
        '';
      };
    };
}
