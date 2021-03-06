{ stdenv, fetchurl, autoreconfHook }:

stdenv.mkDerivation rec {
  name = "acpid-2.0.29";

  src = fetchurl {
    url = "mirror://sourceforge/acpid2/${name}.tar.xz";
    sha256 = "1zq38al07z92r2md18zivrzgjqnn7m2wahdpgri6wijwjwkknl2q";
  };

  nativeBuildInputs = [ autoreconfHook ];

  # remove when https://sourceforge.net/p/acpid2/code/merge-requests/1/ is merged
  postPatch = ''
    substituteInPlace configure.ac \
      --replace "AC_FUNC_MALLOC" "" \
      --replace "AC_FUNC_REALLOC" "" \
      --replace "strrchr strtol" "strrchr strtol malloc realloc"
  '';

  meta = with stdenv.lib; {
    homepage = http://tedfelix.com/linux/acpid-netlink.html;
    description = "A daemon for delivering ACPI events to userspace programs";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
}
