# GPG play image

This image instantiates an environment of 3 users, each with a gpg keypair and ultimate trust between them. Each run is performed in a self-removing container and persisted through a local volume.

Keeping all things as they are, begin with `./init`. 

This will

- clean up the environment (literally `./reset`)

- build the docker image

- run a setup for `$users` declared in the init twice for each user, to ensure they've all encountered each other's keys.

Declared users are *alice, bob, and charlie* .

To step into the environment as *alice*, execute `./run alice` .

Running as any name will create the user and add them to the ring (`./run tim`)

Home directories are stored on the host disk at `./homes`.

Likewise, exporting keys are found at `./keys`, and a shared directory exists at `./data` (which is `/data` within the container). 

The `users` file, initially empty, will be a persistent copy of `/etc/passwd` for reuse.

All passphrases are `abc`, and users are known to each other by username, so

`gpg --encrypt -r bob -r charlie FILE` works.

This is a toy that is useful in playing around with multi-actor encryption.

Good luck, have fun.
