# Breitbandmessung.de Docker Container 

# ORIGINAL IMAGE
[![build_original_docker_image](https://github.com/JulKramer3G/breitbandmessung-docker/actions/workflows/build_original_image.yml/badge.svg)](https://github.com/JulKramer3G/breitbandmessung-docker/actions/workflows/build_original_image.yml)
Automatically builds the docker container for the GitHub container registry of repo https://github.com/fabianbees/breitbandmessung-docker

# CUSTOM IMAGE
[![build_custom_docker_image](https://github.com/JulKramer3G/breitbandmessung-docker/actions/workflows/build_custom_image.yml/badge.svg)](https://github.com/JulKramer3G/breitbandmessung-docker/actions/workflows/build_custom_image.yml)
Builds this repository for the GitHub container registry.

## Automated Speedtesting

### Preparation

1. Open your browser with the following url: http://ip-of-docker-host:5800

2. Go throgh setup process, until you reach the following page:
![Screenshot1](images/screenshot1.png)
**DO NOT KLICK THE BUTTON "Messung durchführen" if you want to use the Speedtest automation script!**
--> The automation script requires this exact screen to be shown for the automatic execution of a "Messkampagne".

### Start via GUI

3. To start the script, use the website on the exposed port and put the string 'RUN' in the clipboard. To stop the script, remove the string. You may need to do this twice (error unknown). After a maximum of 15 seconds you should see the screen in action. 
![Screenshot1](images/clipboard.png)

### Start via terminal
After you configured the utility, leave it in the "Messung starten" screen.
Use the console in the docker and execute the script `trigger_start.sh` in the root directory to start everything.

3. open a console (bash) to your docker container (```docker exec -it breitband-desktop bash```) and execute the following command inside this docker container:
```bash
touch /RUN
```
This creates a empty file called ```RUN``` in the root directory of the container, the automation script is looking for this file for knowing when the setup process has finished and speedtesting can start.

### During the process

4. Speedtesting get's started, the script tries to click through the buttons for running a speedtest every 5 minutes. If the countdown timer (waiting period) has not finished yet, the clicks will do nothing.

5. When all mesurements are done, the automation-script can be stopped by removing the ```/RUN``` file with the following command ```rm /RUN``` inside the docker container or change the content of the clipboard to something else than `RUN` via the GUI.




## Changes in custom image: 
- Brought back clipboard check for "RUN" string to activate script


## Deploy via docker run from GHCR.io

### Building the Container

Download container:

```bash
docker pull ghcr.io/julkramer3g/breitbandmessung-docker_original:latest
```

or

```bash
docker pull ghcr.io/julkramer3g/breitbandmessung-docker_custom:latest
```

## Deploy via docker-compose (from source)

Deploy container via docker-compose v3 schema:

```bash
git clone https://github.com/fabianbees/breitbandmessung-docker.git

cd breitbandmessung-docker

docker compose up
```

The container gets build automatically.


```yaml
version: "3.8"
services:
  breitband-desktop:
    image: breitband:latest
    build: .
    container_name: breitband-desktop
    environment:
      - TZ=Europe/Berlin
    volumes:
      - $PWD/breitbandmessung/data:/config/xdg/config/Breitbandmessung
    ports:
      - 5800:5800
    restart: unless-stopped
```


## Deploy as Portainer Stack

![Screenshot1](images/portainer-stack.png)


### Run the Container

Then the container can be run via docker:

```bash
docker run -d \
    --name breitband-desktop \
    -e TZ=Europe/Berlin \
    -v $PWD/breitbandmessung/data:/config/xdg/config/Breitbandmessung \
    -p 5800:5800 \
    ghcr.io/julkramer3g/breitbandmessung-docker_original:latest
```

or 


```bash
docker run -d \
    --name breitband-desktop \
    -e TZ=Europe/Berlin \
    -v $PWD/breitbandmessung/data:/config/xdg/config/Breitbandmessung \
    -p 5800:5800 \
    ghcr.io/julkramer3g/breitbandmessung-docker_custom:latest
```



Appdata for the Breitbandmessung Desktop App lives in the following directory (inside the container): ```/config/xdg/config/Breitbandmessung```. Therefore this directory can be mounted to a host directory.


## Additional Notes

- The automation-script is configured, to run speedtests only after 7:30 AM, becaus it is assumed, that the network load between 0 o'clock and 7:30 AM is lower than it is under normal use during the day.
(This behaviour could be alterd, by changing the values in the **if statement in line 18** of the file ```run-speedtest.sh``` before building the docker image).
- If you want to have more granular control for when speedtest should be run, the docker container could be stopped when no speedtest should be run, and restarted if testing should continue.
- A "Messkampagne" which is in progrss, can only be stopped, by purging the appdata of the container, or by altering your "Tarifangaben".
