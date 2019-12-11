

version=$(echo $OS_VERSION | perl -pe "s/^(.).*/\1/g")
[ -z "$version" ] && . /etc/os-release && version=$VERSION_ID

cp -v config/htcondor-stable-rhel${version}.repo /etc/yum.repos.d

yum clean all
rpm --import http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor

yum -y --nogpgcheck install condor-procd condor-external-libs condor-bosco condor-classads condor-python condor

