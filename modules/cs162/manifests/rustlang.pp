class cs162::rustlang($home_directory, $owner, $group) {
    Package<| |>
    ->
    exec { "install rustlang":
        cwd     => $home_directory,
        user    => $owner,
        command => "curl -k https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain 1.66.1 2>/dev/null",
        creates => "$home_directory/.cargo/bin",
    }

}
