BootStrap: debootstrap
OSVersion: trusty
MirrorURL: http://us.archive.ubuntu.com/ubuntu/

%environment
    PATH="/apps/miniconda/bin:$PATH"

%runscript
    exec graftM "$@"

%post
    echo "Hello from inside the container"
    sed -i 's/$/ universe/' /etc/apt/sources.list

    #essential stuff
    apt -y --force-yes install git sudo man vim build-essential wget unzip curl autoconf libtool pkg-config subversion
   
    mkdir /apps
    cd /apps
 
    #bioconda GOOOD
    wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
    bash Miniconda2-latest-Linux-x86_64.sh -b -p /apps/miniconda
    rm Miniconda2-latest-Linux-x86_64.sh
    sudo ln -s /apps/miniconda/bin/python2.7 /usr/bin/python
    PATH="/apps/miniconda/bin:$PATH"

    conda update --prefix /apps/miniconda conda
    conda config --prepend channels conda-forge
    conda config --prepend channels bioconda

    conda install -y -c bioconda graftm

    #so we dont get those stupid perl warnings
    locale-gen en_US.UTF-8
    #cleanup    
    conda clean -a -y

    #create a directory to work in
    mkdir /work
    #so we dont get those stupid worning on hpc/pbs
    mkdir /extra
    mkdir /xdisk

#%test
