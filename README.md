# aarch64_asm_practice

The intent of this project is to spin up an ARM **AArch64**–based setup quickly to practice ARM assembly programming.  
It uses a Docker container on a MacBook that runs a basic Linux system (via emulation).

---

## 📂 Folder Structure

Assuming you cloned the project into `<some_path>/asm_practice`:

- **`Dockerfile`** — Defines Ubuntu OS and required tools  
- **`Makefile`** — Provides commands to build, start, run, etc. for Docker  
- **`ws_shared_with_docker/`** — Shared folder between the host (MacBook) and Ubuntu running in Docker  

---

## ⚙️ Using the Makefile

- `make help` — View available commands  
- `make build` — Build the Ubuntu Docker image  
- `make start` — Start the container and Ubuntu OS  

If successful, the terminal should switch to Ubuntu as:



if successful the terminal should switch to ubuntu as 'root@15681a0a4cd9:/#'
and ls should show the /work folder


## FAQ:
how is the folder 'ws_shared_with_docker' shared?
 -  While running docker we pass the command "-v ${SHARED_WS}:/work "; This command creates a folder named /work in ubuntu machine in the docker.
 - With this structure; we can edit files in the shared folder and it would reflect within the ubuntu machine
 - The way I use it is I 'cd ' into <some_path>/asm_practice and then I run 'code .' to start visual code
 - there I can see all the files and 'ws_shared_with_docker' within which I add the assembly/ cprograms I want to practice;
 - This way, Later when I want to install a new linux or another platform I still have the shared files that I can reuse

