%define _binaries_in_noarch_packages_terminate_build 0

Summary: Buat LiveCD IGOS Nusantara
Name: ign-buat-livecd
Version: 0.5
Release: 1%{?dist}
License: MIT
Group: System Environment/Base
URL: http://igos-nusantara.or.id
Source: https://github.com/ubunteroz/ignsdk-debian/archive/%{version}/ign-buat-livecd-%{version}.tar.gz
Requires: rsync
Requires: xorriso
Requires: squashfs-tools
Requires: anaconda
BuildArch: noarch

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
* Fri Apr 1 2016 Surya Handika Putratama <ubunteroz@gmail.com>
- Add comments to source code
- Don't show error if neither YUM nor DNF is exist

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
