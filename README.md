Submission Reminder Application

This is a simple shell application that helps students keep track of assignment deadlines. It checks upcoming deadlines and prepares reminders for students with pending assignments.

Directory Structure
submission_reminder_app/
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
git clone https://github.com/Davy-00/submission_reminder_app_davydushimiyimana.git
cd submission_reminder_app_davydushimiyimana

Step 2: Make the Setup Script Executable
chmod +x create_environment.sh

Step 3: Run the Setup Script
When you run the script, it will ask for your name and create all the necessary files and directories:
./create_environment.sh

Step 4: Navigate to Your App Directory
The script will create a directory with your name. Navigate into it:
cd submission_reminder_yourname

How to Run the Application
Simply run the startup script from your app directory:
./startup.sh

