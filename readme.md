# Pi-Mine
&emsp; The console mine delver, all in Armv7 Assembly! (No external libraries that are made by other people) The game was made for the Raspberry Pi 2 on the Raspbian Jessie operating system.
## Building Pi-Mine
&emsp; Download or clone <code>https://github.com/BitBlitObviMormon/Pi-Mine.git</code> and then open its directory in the terminal. Run the <code>make</code> command and wait for it to finish building. If the build was successful then you will get two executable files, <code>mine</code> and <code>mine-server. mine</code> is the Pi-Mine client and <code>mine-server</code> is Pi-Mine's server. You'll need both in order to run the Pi-Mine client correctly.
## Running Pi-Mine
&emsp; Type <code>make runClient</code> in the terminal to build and run the client; type <code>make runServer</code> to build and run the server. If the files were already built then you can just run <code>mine</code> and <code>mine-server</code> directly.
## Makefile commands
<code>make:</code> builds the client, server, and all of the libraries <br>
<code>make clean:</code> Deletes all built files as well as backup files (emacs leaves a ton of backups around) <br>
<code>make todo:</code> Shows a list of files with the word "todo" in it. <br>
<code>make runClient:</code> Builds and runs the client "mine" and its libraries <br>
<code>make runServer:</code> Builds and runs the server "mine-server" and its libraries <br>
