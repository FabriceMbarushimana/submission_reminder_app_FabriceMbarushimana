## PROJECT: BASIC SUBMISSION REMINDER
Installation requirements


1. Git: This is required to be able to clone the repository to your local device

2. Bash shell or a shell that can run bash scripts: Preferrably Bash to avoid unforeseen errors, but the other major shells in UNIX like zsh or fish can run bash scripts too
Project setup

This project is a bash script that allows you to check for the missing submissions of different students. It doesn't require additional dependencies and it comes with five initial files, all found in the base_files folder.
1. create_environment.sh

This is the base script that create the user's folder and adds the necessary files
2. config.env

This file contains the app configuration. It contains the name of the course/lesson of which the user wants to check if they submitted or not and the number of days remaining for the submission deadline. Those two fields are both editable to meet the user's demands.
3. submissions.txt

This file contains the 1) names of students, 2) course names, and 3) submission status. It's the base file the program checks to know if someone submitted has submitted or not.
4. functions.sh

This file contains necessary functions that the program runs to check the course provided in the config.env file, and the students who submitted or not. You can customize this file if you want different results or it's format.
5. reminder.sh

This script file is the one that runs on the base level of a custom user's folder to get the return value from the functions.sh and display it to the user. This runs inside the custom user's folder, after the user has already run create_environment.sh.
Running the project
I. Initially (Right after cloning the repository)
1. Clone the repository on your local device
2. Using the command line, navigate inside the root directory of the project

This will be inside submission_reminder_app_cyuzuzo-aime, assuming that you didn't change the repository name
3. Run the base script

Inside the root directory, run ./create_environment.sh

Running this script will start the process by asking you your name
4. Write your name and press enter

This will run the initialization process, create necessary files and folders inside a new custom user's folder called submission_reminder_{user's name}, and display the missing submissions
II. After creating a user's folder (Running a user's custom project after initially running ./create_environment.sh
Navigate inside the user's newly created folder (formatted as submission_reminder_{user's name}).
Run ./startup.sh
Data modification

## To modify data for a new user without affecting the global information, NAVIGATE INSIDE THE NEWLY CREATED FOLDER submission_reminder_{user's name} **
Student's submissions and courses

While inside the newly created folder's root directory, go inside the assets folder, and edit submissions.txt. You can add more names, more courses, and their submission status
Results Configuration

NOTE that this only modifies the course name and the number of days to it's submission deadline. If you want to modify the formating of the returned data, check the next point Results Formatting Inside the config folder, edit the config.env file. You can change the name of the course that the user will be checking the status of, and the number of days to it's submission deadline
Results Formatting

If you want to change how the results being returned is formatted, go inside the functions folder, and edit functions.sh NOTE Proceed with caution, this file determines how to get data, if you incorrectly edit it, it may break the whole program's functionality
About
