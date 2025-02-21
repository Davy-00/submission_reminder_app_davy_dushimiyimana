Submission Reminder Application

This is a simple shell application that helps students keep track of assignment deadlines. It checks upcoming deadlines and prepares reminders for students with pending assignments.


Directory Structure
Copysubmission_reminder_app/
├── config/             
│   └── config.env      
├── src/                
│   ├── reminder.sh     
│   └── functions.sh   
├── data/               
│   └── submissions.txt 
├── logs/               
│   └── reminder.log    
└── startup.sh          

How to Set Up the Application

Step 1: Download the Files
First, clone this repository or download the create_environment.sh script:
bashCopygit clone https://github.com/Davy-00/submission_reminder_app_davydushimiyimana.git
cd submission_reminder_app_davydushimiyimana

Step 2: Make the Setup Script Executable
bashCopychmod +x create_environment.sh

Step 3: Run the Setup Script
When you run the script, it will ask for your name and create all the necessary files and directories:
bashCopy./create_environment.sh

Step 4: Navigate to Your App Directory
The script will create a directory with your name. Navigate into it:
bashCopycd submission_reminder_yourname

How to Run the Application
Simply run the startup script from your app directory:
bashCopy./startup.sh

What Does Each File Do?
startup.sh
This is the main entry point. It checks if all needed files exist and then runs the application.

config.env
Contains settings for the application like file paths and email configuration.

reminder.sh
The main application script that controls the reminder workflow.

functions.sh
Contains helper functions used by the main script, such as:

init_log(): Sets up the log file
log_message(): Writes messages to the log
process_submissions(): Processes the submissions data
send_reminders(): Checks deadlines and prepares reminders

submissions.txt
Contains student records with the following format:
CopyStudentID|Name|Email|Subject|Deadline|Status

