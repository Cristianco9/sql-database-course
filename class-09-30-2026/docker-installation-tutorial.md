# Docker Installation Guide

This guide explains how to install Docker on:

* Windows 11
* Ubuntu
* macOS

It also explains how to verify the installation, run your first container, 
and troubleshoot common problems.

---

# 1. What Are Docker, Images, and Containers?

Before installing anything, it is important to understand the role of each component.

## Docker

Docker is a platform for building, shipping, and running applications inside 
isolated environments called containers.

```text
Docker
 |
 +-- Builds images
 +-- Runs containers
 +-- Manages networks and volumes
 +-- Runs multi-container applications (Compose)
```

## Image

An image is a read-only template that contains an application and everything it 
needs to run: code, runtime, libraries, and configuration.

## Container

A container is a running instance of an image.

```text
Image (template)
   |
   +-- Container A (running instance)
   +-- Container B (running instance)
```

## Docker Engine, Docker CLI, and Docker Desktop

```text
Docker Engine   -> The background service (daemon) that runs containers
Docker CLI      -> The `docker` command you type in the terminal
Docker Compose  -> Tool to define multi-container apps (docker compose)
Docker Desktop  -> Application that bundles Engine + CLI + Compose + GUI
                   (used on Windows and macOS)
```

## Why Windows and macOS Need Extra Steps

Containers share the Linux kernel. Windows and macOS do not have a Linux kernel, 
so Docker Desktop runs a lightweight Linux virtual machine behind the scenes.

```text
Ubuntu (Linux)
 |
 +-- Docker Engine (native)
       |
       +-- Containers

Windows 11
 |
 +-- WSL 2 (lightweight Linux VM)
       |
       +-- Docker Desktop
             |
             +-- Containers

macOS
 |
 +-- Docker Desktop (Linux VM using Apple Virtualization)
       |
       +-- Containers
```

This is why Windows requires enabling several virtualization features before 
installing Docker.

---

# 2. System Requirements

## Windows 11

* Windows 11 64-bit (Home, Pro, Enterprise, or Education)
* CPU with virtualization support (Intel VT-x or AMD-V)
* Virtualization enabled in BIOS/UEFI
* At least 4 GB of RAM (8 GB or more recommended)
* Administrator privileges

## Ubuntu

* Ubuntu 22.04 LTS, 24.04 LTS, or a newer supported release (64-bit)
* A user with `sudo` privileges
* Internet access

## macOS

* A macOS version supported by the current Docker Desktop release (check the official documentation)
* Apple Silicon (M1/M2/M3/M4) or Intel processor
* At least 4 GB of RAM (8 GB or more recommended)
* Administrator privileges

You should also have:

* A terminal application
* A code editor such as Visual Studio Code

---

# PART A: WINDOWS 11

# 3. Steps to Follow (Windows 11)

Follow these steps **in order**. Each one is required.

```text
1. Enable Developer Mode
2. Enable Windows Features
   a. Windows Subsystem for Linux
   b. Virtual Machine Platform
   c. Windows Hypervisor Platform
3. Restart the computer
4. Verify virtualization is enabled
5. Install and update WSL 2
6. Install Docker Desktop
7. Configure Docker Desktop
8. Verify Docker
```

---

# 4. Step 1: Enable Developer Mode

Developer Mode allows Windows to run developer tools with fewer restrictions 
(for example, creating symbolic links without administrator rights).

1. Open **Settings** (`Win + I`).
2. Go to **System** > **For developers**.
   * On newer Windows 11 builds, this may be under **System** > **Advanced**.
3. Turn on **Developer Mode**.
4. Confirm the warning message by selecting **Yes**.

Alternative: open Settings directly from PowerShell:

```powershell
start ms-settings:developers
```

---

# 5. Step 2: Enable Windows Features

## 5.1 Open PowerShell as Administrator

Open the Windows Start menu and search for:

```text
PowerShell
```

Right-click **Windows PowerShell** (or **Terminal**) and select:

```text
Run as administrator
```

You should see an Administrator PowerShell window.

---

## 5.2 (Optional) Use the Graphical Method

You can also enable the features graphically:

1. Press `Win + R`, type `optionalfeatures`, and press Enter.
2. Check the following:
   * Virtual Machine Platform
   * Windows Hypervisor Platform
   * Windows Subsystem for Linux
3. Select **OK** and restart when prompted.

The command-line method below is faster and easier to reproduce for a whole class.

---

## 5.3 Enable the Features Using DISM

Run each command in the Administrator PowerShell window.

### a. Windows Subsystem for Linux

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

### b. Virtual Machine Platform

```powershell
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

### c. Windows Hypervisor Platform

```powershell
dism.exe /online /enable-feature /featurename:HypervisorPlatform /all /norestart
```

Each command should finish with:

```text
The operation completed successfully.
```

If a command reports that a restart is required, that is expected. 
Complete all three commands first, then restart.

### What Each Feature Does

| Feature                          | Purpose                                            |
| -------------------------------- | -------------------------------------------------- |
| Windows Subsystem for Linux      | Runs a real Linux environment inside Windows       |
| Virtual Machine Platform         | Provides the virtualization layer used by WSL 2    |
| Windows Hypervisor Platform      | Lets applications use the Windows hypervisor       |

---

## 5.4 Note About Hyper-V (Windows Pro, Enterprise, Education)

Docker Desktop uses WSL 2 by default, which works on **all** Windows 11 editions, 
including Home.

Hyper-V is **not required** for the WSL 2 backend. You only need it if you want 
to use the legacy Hyper-V backend or run other virtual machines. On Pro, Enterprise, 
or Education you can optionally enable it:

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V-All /all /norestart
```

---

# 6. Step 3: Restart the Computer

Restart Windows so the new features are activated:

```powershell
Restart-Computer
```

Do not skip this step. Most installation problems on Windows are caused by not 
restarting after enabling features.

---

# 7. Step 4: Verify Virtualization Is Enabled

Open **Task Manager** (`Ctrl + Shift + Esc`):

1. Go to the **Performance** tab.
2. Select **CPU**.
3. Look for:

```text
Virtualization: Enabled
```

You can also check from PowerShell:

```powershell
systeminfo
```

At the end of the output, look for:

```text
Hyper-V Requirements:
    ...
    Virtualization Enabled In Firmware: Yes
```

(If a hypervisor is already running, Windows may instead print: 
`A hypervisor has been detected.` This is also fine.)

## If Virtualization Is Disabled

1. Restart the computer and enter BIOS/UEFI (usually `F2`, `F10`, `F12`, `Del`, or `Esc` during startup).
2. Find the virtualization option. Common names:
   * Intel Virtualization Technology (VT-x)
   * SVM Mode (AMD)
   * Virtualization Technology
3. Enable it.
4. Save and exit.

---

# 8. Step 5: Install and Update WSL 2

Open PowerShell as Administrator.

## 8.1 Update WSL

```powershell
wsl --update
```

## 8.2 Set WSL 2 as the Default Version

```powershell
wsl --set-default-version 2
```

## 8.3 Install a Linux Distribution (Recommended)

```powershell
wsl --install -d Ubuntu
```

Wait until the installation finishes. Ubuntu will ask you to create a Linux 
username and password. Remember them.

## 8.4 Verify WSL

```powershell
wsl --status
```

```powershell
wsl -l -v
```

You should see something similar to:

```text
  NAME      STATE           VERSION
* Ubuntu    Running         2
```

The `VERSION` column must show `2`.

If it shows `1`, convert it:

```powershell
wsl --set-version Ubuntu 2
```

---

# 9. Step 6: Install Docker Desktop

There are three ways to install Docker Desktop on Windows. Choose **one**.

## Option A: Install with winget (Recommended)

```powershell
winget install -e --id Docker.DockerDesktop
```

## Option B: Install with Chocolatey

If you already use Chocolatey:

```powershell
choco install docker-desktop -y
```

## Option C: Install Manually

1. Visit:

   https://www.docker.com/products/docker-desktop/

2. Download **Docker Desktop for Windows**.
3. Run `Docker Desktop Installer.exe`.
4. Keep **Use WSL 2 instead of Hyper-V** selected.
5. Complete the installation.

After the installation finishes, **restart the computer** if the installer asks you to.

---

# 10. Step 7: Configure Docker Desktop

1. Open **Docker Desktop** from the Start menu.
2. Accept the Docker Subscription Service Agreement.
3. Wait until the Docker icon in the system tray shows that the engine is running.

## 10.1 Confirm the WSL 2 Backend

1. Open **Settings** (gear icon).
2. Go to **General**.
3. Make sure this option is enabled:

```text
Use the WSL 2 based engine
```

## 10.2 Enable WSL Integration with Ubuntu

1. Go to **Settings** > **Resources** > **WSL Integration**.
2. Enable **Enable integration with my default WSL distro**.
3. Turn on the switch for **Ubuntu**.
4. Select **Apply & Restart**.

## 10.3 Add Your User to the docker-users Group (If Needed)

If you use a standard (non-administrator) Windows account, or Docker reports a 
permission problem, run in Administrator PowerShell:

```powershell
net localgroup docker-users "YOUR_WINDOWS_USERNAME" /add
```

Then sign out of Windows and sign in again.

You can find your username with:

```powershell
whoami
```

## 10.4 Licensing Note

Docker Desktop is free for personal use, education, open-source projects, and 
small businesses. Larger organizations may require a paid subscription. Check 
the current terms on the Docker website.

---

# 11. Step 8: Verify Docker on Windows

Open a **new** PowerShell window (or Windows Terminal).

Check the version:

```powershell
docker --version
```

Expected output:

```text
Docker version 2x.x.x, build xxxxxxx
```

Check Docker Compose:

```powershell
docker compose version
```

Expected output:

```text
Docker Compose version v2.x.x
```

Run the test container:

```powershell
docker run hello-world
```

You should see:

```text
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

Find the Docker executable:

```powershell
where.exe docker
```

---

# 12. Windows Quick Reference

Run in **Administrator PowerShell**:

```powershell
# 1. Developer Mode (manual: Settings > System > For developers)
start ms-settings:developers

# 2. Enable Windows features
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:HypervisorPlatform /all /norestart

# 3. Restart
Restart-Computer
```

After restarting, in **Administrator PowerShell**:

```powershell
# 4. WSL 2
wsl --update
wsl --set-default-version 2
wsl --install -d Ubuntu

# 5. Docker Desktop
winget install -e --id Docker.DockerDesktop

# 6. Verify (new terminal, after starting Docker Desktop)
docker --version
docker compose version
docker run hello-world
```

---

# PART B: UBUNTU

On Ubuntu, Docker Engine runs natively. Docker Desktop is not required.

# 13. Steps to Follow (Ubuntu)

```text
1. Update the system
2. Remove conflicting packages
3. Add Docker's official APT repository
4. Install Docker Engine
5. Verify the Docker service
6. Run Docker without sudo
7. Verify Docker
```

---

# 14. Step 1: Update the System

Open a terminal and run:

```bash
sudo apt update
```

Optionally upgrade installed packages:

```bash
sudo apt upgrade -y
```

---

# 15. Step 2: Remove Conflicting Packages

Ubuntu may include unofficial Docker packages. Remove them to avoid conflicts:

```bash
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
  sudo apt-get remove -y $pkg
done
```

It is fine if `apt` reports that some packages are not installed.

Note: this does **not** remove your existing images, containers, volumes, or 
networks stored in `/var/lib/docker/`.

---

# 16. Step 3: Add Docker's Official APT Repository

## 16.1 Install Prerequisites

```bash
sudo apt install -y ca-certificates curl
```

## 16.2 Add Docker's GPG Key

```bash
sudo install -m 0755 -d /etc/apt/keyrings
```

```bash
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
```

```bash
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

The GPG key lets `apt` verify that the packages really come from Docker.

## 16.3 Add the Repository

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

## 16.4 Update the Package Index

```bash
sudo apt update
```

You should see `download.docker.com` in the output.

---

# 17. Step 4: Install Docker Engine

```bash
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

| Package                 | Purpose                                 |
| ----------------------- | --------------------------------------- |
| `docker-ce`             | Docker Engine (the daemon)              |
| `docker-ce-cli`         | The `docker` command                    |
| `containerd.io`         | Container runtime used by Docker        |
| `docker-buildx-plugin`  | Advanced image building                 |
| `docker-compose-plugin` | The `docker compose` command            |

---

# 18. Step 5: Verify the Docker Service

Check that the service is running:

```bash
sudo systemctl status docker
```

Look for:

```text
Active: active (running)
```

Press `q` to exit.

If it is not running:

```bash
sudo systemctl start docker
```

Make Docker start automatically on boot:

```bash
sudo systemctl enable docker
sudo systemctl enable containerd
```

---

# 19. Step 6: Run Docker Without sudo

By default, Docker requires `sudo`. To run Docker as your normal user, add 
yourself to the `docker` group.

Create the group (it usually already exists):

```bash
sudo groupadd docker
```

Add your user:

```bash
sudo usermod -aG docker $USER
```

Apply the new group membership. Either **log out and log in again**, or run:

```bash
newgrp docker
```

Verify that you belong to the group:

```bash
groups
```

You should see `docker` in the list.

Security note: members of the `docker` group effectively have root-level access 
to the machine. Only add trusted users.

---

# 20. Step 7: Verify Docker on Ubuntu

```bash
docker --version
```

```bash
docker compose version
```

Run the test container:

```bash
docker run hello-world
```

You should see:

```text
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

Find the Docker executable:

```bash
which docker
```

Expected:

```text
/usr/bin/docker
```

---

# 21. Ubuntu Quick Reference

```bash
sudo apt update
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $USER
newgrp docker

docker --version
docker compose version
docker run hello-world
```

---

# PART C: macOS

# 22. Steps to Follow (macOS)

```text
1. Identify your processor (Apple Silicon or Intel)
2. Install Homebrew (optional but recommended)
3. Install Docker Desktop
4. Start Docker Desktop
5. Verify Docker
```

---

# 23. Step 1: Identify Your Processor

Run:

```bash
uname -m
```

| Output   | Meaning                               |
| -------- | ------------------------------------- |
| `arm64`  | Apple Silicon (M1, M2, M3, M4)        |
| `x86_64` | Intel                                 |

Docker Desktop provides a separate installer for each architecture. 
Homebrew selects the correct one automatically.

## Apple Silicon Only: Install Rosetta 2 (Optional)

Some container images are built only for Intel (`amd64`). Rosetta lets them run on Apple Silicon:

```bash
softwareupdate --install-rosetta --agree-to-license
```

---

# 24. Step 2: Check Homebrew

```bash
brew --version
```

If Homebrew is not installed, visit:

https://brew.sh/

and follow the official installation instructions.

Update Homebrew:

```bash
brew update
```

---

# 25. Step 3: Install Docker Desktop

## Option A: Install with Homebrew (Recommended)

```bash
brew install --cask docker-desktop
```

Note: older Homebrew versions name this cask `docker`. If the command above is not found, run:

```bash
brew install --cask docker
```

## Option B: Install Manually

1. Visit:

   https://www.docker.com/products/docker-desktop/

2. Download **Docker Desktop for Mac** for your processor (Apple Silicon or Intel).
3. Open the downloaded `.dmg` file.
4. Drag **Docker** into the **Applications** folder.

---

# 26. Step 4: Start Docker Desktop

1. Open **Docker Desktop** from **Applications** (or Spotlight: `Cmd + Space`, type `Docker`).
2. Accept the Docker Subscription Service Agreement.
3. Grant the permissions that macOS requests (Docker may ask for your password to install networking components).
4. Wait until the whale icon in the menu bar indicates that Docker is running.

The first startup can take a few minutes.

## Optional Settings

Go to **Settings** > **Resources** to adjust CPU, memory, and disk limits for 
the Docker virtual machine. For most courses, the defaults are enough.

---

# 27. Step 5: Verify Docker on macOS

Open a **new** terminal window.

```bash
docker --version
```

```bash
docker compose version
```

Run the test container:

```bash
docker run hello-world
```

You should see:

```text
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

Find the Docker executable:

```bash
which docker
```

Expected (Apple Silicon with Homebrew, or Docker Desktop):

```text
/usr/local/bin/docker
```

The exact path can vary depending on the installation method.

---

# 28. macOS Quick Reference

```bash
brew update
brew install --cask docker-desktop
open -a Docker

docker --version
docker compose version
docker run hello-world
```

---

# 29. Common Installation Problems

## `docker: command not found` (Ubuntu / macOS)

Docker is not installed or not in `PATH`.

```bash
which docker
```

On macOS, make sure Docker Desktop has been opened at least once.

## `'docker' is not recognized` (Windows)

Close PowerShell and open a **new** terminal. If it persists:

```powershell
where.exe docker
```

Confirm Docker Desktop is installed and restart Windows.

## `Cannot connect to the Docker daemon`

Docker Engine is not running.

* Windows / macOS: open Docker Desktop and wait for it to finish starting.
* Ubuntu:

```bash
sudo systemctl start docker
```

## `permission denied while trying to connect to the Docker daemon socket` (Ubuntu)

Your user is not in the `docker` group.

```bash
sudo usermod -aG docker $USER
newgrp docker
```

## `WSL 2 installation is incomplete` (Windows)

Update WSL and restart:

```powershell
wsl --update
wsl --shutdown
```

Then reopen Docker Desktop.

## `Virtualization must be enabled` / `Hardware assisted virtualization and data execution protection must be enabled in the BIOS`

Virtualization is disabled in BIOS/UEFI. Follow Section 7 to enable it.

## Docker Desktop Stuck on "Starting..." (Windows)

Try:

```powershell
wsl --shutdown
```

Then restart Docker Desktop. Also confirm that the three Windows features from 
Section 5 are enabled and that you restarted after enabling them.

## Port Already in Use

Error:

```text
Bind for 0.0.0.0:5432 failed: port is already allocated
```

Another process (for example, a local PostgreSQL installation) is using the port. 
Either stop that process or map a different host port:

```bash
-p 5433:5432
```

## Not Enough Disk Space

Remove unused images, containers, and networks:

```bash
docker system prune
```

Add `-a` to also remove all unused images (more aggressive):

```bash
docker system prune -a
```

---

# 30. Uninstalling Docker

## Windows

```powershell
winget uninstall -e --id Docker.DockerDesktop
```

## macOS

```bash
brew uninstall --cask docker-desktop
```

## Ubuntu

```bash
sudo apt purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo apt autoremove -y
```

To also delete all images, containers, and volumes on Ubuntu:

```bash
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

Warning: this permanently deletes all Docker data.

---

# 31. Recommended Installation Checklist

Before starting the course project, every student should verify:

## Docker

```bash
docker --version
```

Expected:

```text
Docker version 2x.x.x
```

## Docker Compose

```bash
docker compose version
```

Expected:

```text
Docker Compose version v2.x.x
```

## Docker Engine

```bash
docker info
```

Expected: server information, no connection errors.

## Test Container

```bash
docker run hello-world
```

Expected:

```text
Hello from Docker!
```

## Windows Only

```powershell
wsl -l -v
```

Expected: your Ubuntu distribution with `VERSION 2`.

---

# 32. Complete Installation Flow

The overall environment can be represented as:

```text
Operating System
       |
       +-- Windows 11
       |     |
       |     +-- Developer Mode
       |     +-- WSL + Virtual Machine Platform + Hypervisor Platform
       |     +-- WSL 2 (Ubuntu)
       |     +-- Docker Desktop
       |
       +-- Ubuntu
       |     |
       |     +-- Docker APT repository
       |     +-- Docker Engine (native)
       |     +-- docker group
       |
       +-- macOS
             |
             +-- Homebrew
             +-- Docker Desktop
```

The basic workflow is:

```text
Prepare the system (Windows: features + restart)
          |
          v
Install Docker
          |
          v
Start Docker (Desktop or service)
          |
          v
Verify docker and docker compose
          |
          v
Run hello-world
          |
          v
Run your first real container (PostgreSQL)
```

---

# 33. Important Concepts to Remember

| Term                  | Meaning                                                |
| --------------------- | ------------------------------------------------------ |
| Docker Engine         | Background service that builds and runs containers     |
| Docker CLI            | The `docker` command                                   |
| Docker Desktop        | Docker app for Windows and macOS (includes a Linux VM) |
| Docker Compose        | Defines and runs multi-container applications          |
| Image                 | Read-only template for a container                     |
| Container             | Running instance of an image                           |
| Volume                | Persistent storage for container data                  |
| Docker Hub            | Public registry of Docker images                       |
| WSL 2                 | Lightweight Linux VM used by Docker Desktop on Windows |
| Virtual Machine Platform | Windows virtualization layer required by WSL 2      |
| Hypervisor Platform   | Lets apps use the Windows hypervisor                   |
| `docker-users` group  | Windows group allowed to use Docker Desktop            |
| `docker` group        | Linux group allowed to use Docker without `sudo`       |
| `docker-compose.yml`  | File that describes the services of an application     |

The most important relationship is:

```text
Image
  |
  +-- Container
        |
        +-- Volume (persistent data)
        +-- Network (communication)
        +-- Port mapping (access from your computer)
```