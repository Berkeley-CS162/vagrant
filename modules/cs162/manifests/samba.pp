class cs162::samba {

    package { "samba":
        ensure => installed;
    }

    file { "/etc/samba/smb.conf":
        ensure  => file,
        content => template("cs162/samba/smb.conf"),
        require => Package[samba];
    }

    service { "smbd":
        ensure    => running,
        require   => Package[samba],
        subscribe => File["/etc/samba/smb.conf"];
    }

    # Idempotent, so no harm in running every time
    exec { "set vagrant samba password":
        command => "echo \"vagrant\nvagrant\n\" | smbpasswd -a vagrant",
        require => Service[smbd],
        user    => root;
    }

}
