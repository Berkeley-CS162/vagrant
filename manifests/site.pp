node default {

    Exec {
        path => [
            '/usr/local/sbin',
            '/usr/local/bin',
            '/usr/sbin',
            '/usr/bin',
            '/sbin',
            '/bin'
        ]
    }

    $home = "/home/vagrant"

    # Configure apt

    class { "apt":
        update => {
            frequency => 'daily',
        },
    }

    include apt::update

    Exec['apt_update'] -> Package <| |>

    # Install some required packages

    package {[
            "ack-grep",
            "binutils",
            "cgdb",
            "clang",
            "clang-format",
            "cmake",
            "exuberant-ctags",
            "g++",
            "gcc",
            "gdb",
            "git",
            "jupyter",
            "libxrandr-dev",
            "libncurses5",
            "libncurses5-dev",
            "qemu",
            "silversearcher-ag",
            "tmux",
            "valgrind",
            "autoconf",
            "wget",
            "python3",
            "python3-pip",
            "libjson-c-dev",
            "libfuse-dev",
            "sudo",
            "glibc-doc",
            "libx32gcc-4.8-dev",
            "libc6-dev-i386",
        ]:
          ensure => installed;
        [
          "matplotlib",
          "numpy",
          "grpcio",
          "grpcio-tools",
        ]:
          ensure   => installed,
          provider => pip3,
          require  => Package[python3-pip];
    }

    # Clone the skeleton files

    Vcsrepo {
        provider => git,
        require  => Package[git],
        user     => vagrant,
        group    => vagrant,
    }

    file {
        "$home/code/":
            ensure => directory,
            owner  => vagrant,
            group  => vagrant;
    }
    ->
    vcsrepo {
        "$home/code/group":
            ensure => present,
            source => "https://github.com/Berkeley-CS162/group0.git",
            remote => staff;
        "$home/code/personal":
            ensure => present,
            source => "https://github.com/Berkeley-CS162/student0.git",
            remote => staff;
    }

    # Set up some project support stuff

    class { ["cs162::bochs", "cs162::golang", "cs162::shell"]:
        home_directory => $home,
        owner          => vagrant,
        group          => vagrant,
    }

    include cs162::samba

    file {
        "/usr/bin/qemu":
            ensure => "/usr/bin/qemu-system-x86_64";
    }

}
