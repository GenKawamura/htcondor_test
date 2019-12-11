
[ $# -eq 0 ] && echo "$0 [ui|wn]" && exit 0

case $1 in
    ui)
	TYPE=ui
	;;
    wn)
	TYPE=wn
	;;
    *)
	echo "set ui or wn"
	exit -1
esac


version=$(echo $OS_VERSION | perl -pe "s/^(.).*/\1/g")
[ -z "$version" ] && . /etc/os-release && version=$VERSION_ID

cp -v config/htcondor-stable-rhel${version}.repo /etc/yum.repos.d

yum clean all
rpm --import http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor

yum -y --nogpgcheck install condor-procd condor-external-libs condor-bosco condor-classads condor-python condor

## Copyting config
cp -v config/condor_config.$TYPE /etc/condor/condor_config
cp -v config/condor_ssh_to_job_sshd_config_template /etc/condor/
cp -v config.d/* /etc/condor/config.d

service condor restart
