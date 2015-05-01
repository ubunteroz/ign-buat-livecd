%define name ign-buat-livecd
%define release ign10
%define version 0.2
%define license MIT
%define url http://igos-nusantara.or.id
%define group System Environment/Base
%define _binaries_in_noarch_packages_terminate_build 0

Summary:Buat LiveCD IGOS Nusantara
Name:%{name}
Version:%{version}
Release:%{release}
License:%{license}
Group:%{group}
URL:%{url}
BuildRoot:%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
Source:%{name}_%{version}.tar.gz
Requires:rsync
Requires:xorriso
Requires:squashfs-tools
Requires:anaconda
BuildArch:noarch
%description
Buat LiveCD IGOS Nusantara

%prep
%setup -q -n %{name}

%install
install -d -m 755 $RPM_BUILD_ROOT/usr/bin
install -d -m 755 $RPM_BUILD_ROOT/usr/share/buat-livecd
cp -rf ign-buat-livecd $RPM_BUILD_ROOT/usr/bin/
cp -rf buat-livecd/* $RPM_BUILD_ROOT/usr/share/buat-livecd/

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%dir
%config %attr(0755,root,root)
/usr/bin/ign-buat-livecd
/usr/share/buat-livecd/*

%changelog
* Mon Jan 19 2015 Surya Handika Putratama <ubunteroz@gmail.com>
- Add --fast mode (use GZIP compression for mksquashfs)
- Add interactive shell (--modify)
- Add --help and --version display
- Silent rsync output
- More informative log
- Use xorriso instead of genisoimage
- Fix path-related issues, use readlink to convert relative to absolute path

* Thu Jan 8 2015 Surya Handika Putratama <ubunteroz@gmail.com>
- First Build