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
        always_apt_update => true,
    }

    include apt::update

    Exec['apt_update'] -> Package <| |>

    # Install some required packages

    package {[
            "binutils",
            "bochs",
            "cgdb",
            "cmake",
            "g++",
            "gcc",
            "gdb",
            "git",
            "libxrandr-dev",
            "libncurses5",
            "libncurses5-dev",
            "qemu",
            "tmux",
        ]:
        ensure => installed,
    }

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
            source => "git://github.com/Berkeley-CS162/group0.git",
            remote => staff;
        "$home/code/personal":
            ensure => present,
            source => "git://github.com/Berkeley-CS162/ta.git",
            remote => staff;
    }

    file {
        "/usr/bin/qemu":
            ensure => "/usr/bin/qemu-system-x86_64";
    }

}
