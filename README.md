Submission Reminder Application
This application is designed to help students keep track of assignment deadlines by sending automated reminders. It's built using shell scripts and demonstrates file organization, script automation, and basic application structure.
Directory Structure
Copysubmission_reminder_app/
├── config/
│   └── config.env          # Configuration settings
├── src/
│   ├── reminder.sh         # Main application script
│   └── functions.sh        # Helper functions
├── data/
│   └── submissions.txt     # Student submission data
├── logs/
│   └── reminder.log        # Application logs
└── startup.sh              # Application startup script
Setup Instructions

Clone this repository:
bashCopygit clone https://github.com/Davy-00/submission_reminder_app_davydushimiyimana.git
cd submission_reminder_app_davydushimiyimana

Make the setup script executable:
bashCopychmod +x create_environment.sh

Run the setup script:
bashCopy./create_environment.sh
You'll be prompted to enter your name, which will be used to create the main application directory.
Navigate to the created directory:
bashCopycd submission_reminder_davydushimiyimana


Running the Application
To start the application, run:
bashCopy./startup.sh
