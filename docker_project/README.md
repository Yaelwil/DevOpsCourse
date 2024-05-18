# Docker Project


In this project, I utilized containers to deploy the Python application alongside additional functionalities, storing the data received in a MongoDB database.

## MongoDB Initialization

Initially, I established a MongoDB replica set comprising three containers. This setup involved configuring the docker-compose.yaml file to define the three MongoDB containers and initializing the replica set via another container.

## Polybot Container

Next, I deployed the Polybot container responsible for managing the bot's logic. Within the filters section, I introduced a "predict" filter aimed at recognizing characters and returning the results.

Files Worked On:
- Dockerfile: Created to encapsulate the container's requirements.
- app.py: Required no modifications; contains URL endpoints and invokes the ImageProcessingBot method.
- bot.py: Partially edited to define the bot's behavior.
- detect_filters.py (added to project): Developed to handle the prediction function.
- filters.py: Developed to manage filter selection based on user photo captions.
- img_proc.py: Primarily edited to implement filter logic.
- requirements.txt: Specifies project dependencies.
- responses.json: Houses potential response sentences for user input.
- responses.py: Imports response data into the project.

# YOLOv5 Container

Finally, I deployed a YOLOv5 container to enable object detection. The prediction code was sourced from a GitHub repository

Files Worked On:

# --Need to finish--
# Need to add detect_filters.py file