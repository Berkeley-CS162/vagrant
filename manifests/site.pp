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
            "curl",
            "exuberant-ctags",
            "g++",
            "gcc",
            "gdb",
            "gdb-multiarch",
            "git",
            "jupyter",
            "libxrandr-dev",
            "libncurses5",
            "libncurses5-dev",
            "qemu",
            "qemu-system-i386",
            "texinfo",
            "silversearcher-ag",
            "tmux",
            "vim",
            "valgrind",
            "autoconf",
            "wget",
            "python3",
            "python3-pip",
            "python-is-python3",
            "libjson-c-dev",
            "libfuse-dev",
            "sudo",
            "glibc-doc",
            "libx32gcc-10-dev-i386-cross",
            "libc6-dev-i386-cross",
            "libtiff5-dev",
            "libjpeg8-dev",
            "libopenjp2-7-dev",
            "zlib1g-dev",
            "libfreetype6-dev",
            "liblcms2-dev",
            "libwebp-dev",
            "tcl8.6-dev",
            "tk8.6-dev",
            "python3-tk",
            "libharfbuzz-dev",
            "libfribidi-dev",
            "libxcb1-dev",
            "fzf",
            "openssh-server",
            "man",
            "file",
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
            branch => "main",
            remote => staff;
        "$home/code/personal":
            ensure => present,
            source => "https://github.com/Berkeley-CS162/student0.git",
            remote => staff;
        "$home/.fzf":
            ensure => present,
            source => "https://github.com/junegunn/fzf.git",
            remote => "origin",
            revision => "0.25.0";
    }
    ->
    # Set up some project support stuff
    class { ["cs162::bochs", "cs162::golang", "cs162::shell", "cs162::rustlang"]:
        home_directory => $home,
        owner          => vagrant,
        group          => vagrant,
    }

    include cs162::samba

    file { "/usr/bin/qemu":
        ensure => 'link',
        target => "/usr/bin/qemu-system-x86_64",
    }

}
