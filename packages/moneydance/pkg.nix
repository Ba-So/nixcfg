# For Inspiration check out :
# https://cinfinitekind.com/stabledl/current/moneydance_linux_amd64.sh
# 
{ fetchurl
, 
#Stuff needed
}:

let
  # Other Prerequisites
in
# Actual Build
stdenv.mkDerivation rec {
  pname = "moneydance";
  version = "???";

  src = fetchurl {
    url = "https://infinitekind.com/stabledl/current/moneydance_linux_amd64.deb";
    # Get via `nix-prefetch-url`
    sha256 = "1abbrz1kcxzd72xrx29k1a3llbnvfqvlf9d1xwv4gbd5rk1742rk";
  };
  
  # Stuff needed for the compilation
  nativeBuildInputs = [
  ];

  # Unpack the .dep package downloaded above
  unpackPhase = ''dpkg -x $src'';

  # Build-Phase
  buildPhase = '''';

  # Installation Phase
  installPhase = '''';

  # Meta-Information on Package
  meta = with lib; {
    decription = "A Personal Finance Tool";
    homepage = "https://infinitekind.com/moneydance";
    license = licenses.proprietary;
    maintainers = with maintainers; [ bastiansommerfeld ];
    platfroms = "x86_64-linux";
  }; 
}

