
## To install docker (https://docs.docker.com/engine/install/ubuntu/)
 sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    
    
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

 sudo apt-get update
 sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo docker run hello-world

# hello-world should show docker is installed



# make folder for OSRM
sudo mkdir /home/osrm
cd /home/osrm



# to get and process OSRM and it's files (takes up to an hour to run and needs 8gb of RAM)
sudo docker pull osrm/osrm-backend
sudo curl -o great-britain-latest.osm.pbf http://download.geofabrik.de/europe/great-britain-latest.osm.pbf
sudo docker run -t -v "${PWD}:/data" osrm/osrm-backend osrm-extract -p /opt/car.lua  /data/great-britain-latest.osm.pbf
sudo docker run -t -v "${PWD}:/data" osrm/osrm-backend osrm-partition /data/great-britain-latest.osrm
sudo docker run -t -v "${PWD}:/data" osrm/osrm-backend osrm-customize /data/great-britain-latest.osrm


# to get OSRM running:
sudo docker run -t -i -p 5000:5000 -v "${PWD}:/data" osrm/osrm-backend osrm-routed --algorithm mld --max-table-size 1000 /data/great-britain-latest.osrm



# OSRM should now be queryable with up to 1000 routes

# test OSRM with (replace with your VM's IP address):
# http://0.0.0.0:5000/route/v1/driving/0.1278,51.5074;1.8904,52.4862?overview=false













