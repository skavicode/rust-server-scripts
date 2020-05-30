# Rust (the game) Server Scripts

Can be used to run Rust servers on your local windows machine. Designed to make
it easy to run multiple different servers with different configs without
interfering with each other.

This is intended for personal testing, not for hosting. If you need help making
scripts for hosting, maybe you shouldn't be hosting...

## Status

This works as of 2020-05-30. Modded means Oxide.

## How to install

Just copy the files into a directory, like, anywhere. Everything will be created
in that directory. Think about space, obviously.

## How it works

There is a separate `update_rustserver_something.bat` file for each type of
Rust server you might want to try:

- vanilla
- modded
- staging
- aux01 - this is currently (2020-05-30) the beta for vehicles

To install the server, you'll need to the update script for the type of server
you want.

**NB** is you want to update modded, first update vanilla, then modded. Modded
works by copying vanilla, then installing Oxide into it.

## Setting up servers

There is a default server script for each server type:

- `aux01_default.bat`
- `modded_default.bat`
- `staging_default.bat`
- `vanilla_default.bat`

If you run any of these (after updating, of course), it will start the
respective server. The file name is split into 2 parts, delimited by `_`.
The first part is the server type. Just use one of the 4 above. The second part
if the server identity. Like a unique name for each server. It should contain
only letters, numbers and dots. **Don't put dashes, underscore or space in the
server identity.**

To create a new server, just copy and paste the script and rename the server
identity part of the file name.

eg:
-	`aux01_foobar.bat` will create a new server for the `aux01` beta branch,
	with server identify: `foobar`.
-	`modded_test.a.bat` will create a new server for the normal release branch,
	with Oxide installed, with server identity `test.a`.
-	`vanilla_xyz.bat` will create a new vanilla server for the normal release
	branch, with server identity `xyz`.
-	`modded_some thing (Copy 1).bat` will not work because you can't fucking
	read.

## Directories

There will be a directory for each server type that you update.
eg: `rustserver_modded`. That directory contains the server software. Inside
that directory will be another directory names `server`. Inside that will be a
separate directory for each server identity for that server type.

eg:

| Script name | Server type | Server identify | Directory |
| --- | --- | --- | --- |
`vanilla_something.bat` | `vanilla` | `something` | `rustserver_vanilla\server\something`
`staging_testing.xyz.bat` | `staging` | `testing.xyz` | `rustserver_staging\server\testing.xyz`
`modded_building.bat` | `modded` | `building` | `rustserver_modded\server\building`

For modded, the Oxide directory will be inside the server directory.

## Default config

Inside the `defaultcfg` directory is a `server.cfg` and `users.cfg` with default
config that will be copied to each new server you create, to save you manually
setting up the same shit each time.

`users.cfg` should look like:

```
ownerid 1234567890 "name" "reason"
```

Replace `1234567890` with your actual steam id.