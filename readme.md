# Pi-Mine
&emsp; The console mine delver, all in Armv7 Assembly! (No external libraries that are made by other people) The game was made for the Raspberry Pi 2 on the Raspbian Jessie operating system.
## Building Pi-Mine
&emsp; Download or clone `https://github.com/BitBlitObviMormon/Pi-Mine.git` and then open its directory in the terminal. Run the `make` command and wait for it to finish building. If the build was successful then you will get two executable files, `mine` and `mine-server. mine` is the Pi-Mine client and `mine-server` is Pi-Mine's server. You'll need both in order to run the Pi-Mine client correctly.
## Running Pi-Mine
&emsp; Type `make runClient` in the terminal to build and run the client; type `make runServer` to build and run the server. If the files are already built then you can run `mine` and `mine-server` directly.
## Makefile commands
`make:` builds the client, server, and all of the libraries
`make clean:` Deletes all built files as well as backup files (emacs leaves a ton of backups around)
`make todo:` Shows a list of files with the word "todo" in it.
`make runClient:` Builds and runs the client "mine" and its libraries
`make runServer:` Builds and runs the server "mine-server" and its libraries
