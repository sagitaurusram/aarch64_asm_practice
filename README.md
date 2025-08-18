# aarch64_asm_practice

The intent of this project is to spin up a arm aarch64 based setup quickly to practice ARM assembly programming.
I used a docker container on Macbook which runs basic linux on aarch64 system ( all emulation ).


Folder structure;
say you are on the path <some_path>/asm_practice where you clone this project;
Dockerfile : ubuntu os and tool list
Makefile   : all commands to build, start, run etc for the docker
ws_shared_with_docker : This is a shared folder between the host ( macbook ) and the ubuntu running on docker container


Using make file:
'make help' to view commands;
make build : to build ubuntu image
make start : to start the container and ubuntu os

if successful the terminal should switch to ubuntu as 'root@15681a0a4cd9:/#'
and ls should show the /work folder


FAQ:
how is the folder 'ws_shared_with_docker' shared?
  While running docker we pass the command "-v ${SHARED_WS}:/work "; This command creates a folder named /work in ubuntu machine in the docker.
  With this structure; we can edit files in the shared folder and it would reflect within the ubuntu machine
  The way I use it is I 'cd ' into <some_path>/asm_practice and then I run 'code .' to start visual code
  there I can see all the files and 'ws_shared_with_docker' within which I add the assembly/ cprograms I want to practice;
  This way, Later when I want to install a new linux or another platform I still have the shared files that I can reuse

