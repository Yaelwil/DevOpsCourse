# Python Project

In the Python project, I needed to finish the Polybot bot code.  
I was provided the infrastructure for a Telegram bot and had to write the filter algorithm.  
The Telegram bot receives messages and photographs, and responds accordingly.   
It accepts color photographs and returns black and white photos.  
We used Ngrok to make the tunnel to the app.

![img.png](img.png)

In the project, I decided to implement the following filters:

- Blur 
- Contour 
- Rotate 
- Salt and Pepper 
- Segment 
- Random Colors   

For the project, I worked with a few files:  
- app.py:  
No need to update this file.  
It contains the URL's endpoints and calls the ImageProcessingBot method.  
- Bot.py:  
This file was partially altered.  
I coded the logic that calls the appropriate method based on the user's photo caption, as well as additional logic for processing text in the absence of photos.
- Img_proc.py:  
This file was mostly modified.  
I programmed the logic for the filters themselves.  
- requirements.txt:  
Contains project-specific requirements.  
- responses.json:  
Contains possible sentences to utilize when the user sends specific words.
- responses.py:  
Imports a JSON file into the project.

## Operating Systems
- Linux (Ubuntu)

## Programming Languages
- Bash Scripting  
- Python Scripting

## Version Control
- Git  
- GitHub

## Networking
- Ngrok
  
## Automation and Configuration Management:
- JSON