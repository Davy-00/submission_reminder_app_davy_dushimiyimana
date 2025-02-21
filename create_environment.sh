#!/bin/bash

# Ask for user's name
echo "Please enter your name:"
read username

# Create main directory with the provided name
main_dir="submission_reminder_$username"
echo "Creating directory structure for $main_dir..."
mkdir -p "$main_dir"

# Create subdirectories
mkdir -p "$main_dir/config"
mkdir -p "$main_dir/src"
mkdir -p "$main_dir/data"
mkdir -p "$main_dir/logs"

# Create and populate config.env
cat > "$main_dir/config/config.env" << 'EOF'
# Configuration settings for submission_reminder_app

# Log file path
LOG_FILE="../logs/reminder.log"

# Data file path
DATA_FILE="../data/submissions.txt"


# Reminder settings
DAYS_BEFORE_WARNING=3
EMAIL_SUBJECT="Assignment Submission Reminder"

# Application settings
APP_NAME="Submission Reminder System"
APP_VERSION="1.0.0"
ADMIN_EMAIL="admin@university.edu"
EOF

# Create and populate reminder.sh
cat > "$main_dir/src/reminder.sh" << 'EOF'
#!/bin/bash

# Import configuration and functions
source ../config/config.env
source ./functions.sh

# Initialize log file
init_log

# Log application start
log_message "INFO" "Application started: $APP_NAME v$APP_VERSION"

# Process submission data
process_submissions

# Send reminder emails
send_reminders

# Log application end
log_message "INFO" "Application completed execution"

exit 0
EOF

# Make reminder.sh executable
chmod +x "$main_dir/src/reminder.sh"

# Create and populate functions.sh
cat > "$main_dir/src/functions.sh" << 'EOF'
#!/bin/bash

# Initialize log file
init_log() {
    mkdir -p "$(dirname "$LOG_FILE")"
    touch "$LOG_FILE"
    log_message "INFO" "Log initialized"
}

# Log message function
log_message() {
    local level="$1"
    local message="$2"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
}

# Process submissions data
process_submissions() {
    if [ ! -f "$DATA_FILE" ]; then
        log_message "ERROR" "Submissions data file not found: $DATA_FILE"
        exit 1
    fi
    
    log_message "INFO" "Processing submission data from $DATA_FILE"
    
    # Count entries
    local entry_count=$(wc -l < "$DATA_FILE")
    log_message "INFO" "Found $entry_count submission records"
}

# Send reminder emails
send_reminders() {
    log_message "INFO" "Checking for upcoming deadlines"
    
    while IFS='|' read -r student_id name email subject deadline status; do
        # Skip header line
        if [ "$student_id" = "StudentID" ]; then
            continue
        fi
        
        # Process only open submissions
        if [ "$status" = "Pending" ]; then
            # Calculate days until deadline
            current_date=$(date +%s)
            deadline_date=$(date -d "$deadline" +%s)
            days_diff=$(( (deadline_date - current_date) / 86400 ))
            
            if [ "$days_diff" -le "$DAYS_BEFORE_WARNING" ] && [ "$days_diff" -ge 0 ]; then
                log_message "INFO" "Sending reminder to $name ($email) for $subject due in $days_diff days"
                
                # In a real implementation, this would send an actual email
                # For this assignment, we'll just log it
                log_message "INFO" "Email sent to $email with subject: $EMAIL_SUBJECT"
            fi
        fi
    done < "$DATA_FILE"
    
    log_message "INFO" "Reminder process completed"
}
EOF

# Create and populate submissions.txt with sample data
cat > "$main_dir/data/submissions.txt" << 'EOF'
StudentID|Name|Email|Subject|Deadline|Status
ST001|frank|m.frank@alueducation.com|git|2023-06-15|Pending
ST002|kenzo|s.kenzo.com|Resume|2023-06-10|Submitted
ST003|Kerry|b.kerry@alueducation.com|communication|2023-06-20|Pending
ST004|Davy|dav.y@alueducation.com|linux|2023-06-12|Pending
EOF

# Create and populate startup.sh
cat > "$main_dir/startup.sh" << 'EOF'
#!/bin/bash

# Startup script for Submission Reminder Application

echo "Starting Submission Reminder Application..."

# Change to the src directory
cd "$(dirname "$0")/src"

# Check if the reminder script exists and is executable
if [ ! -x "./reminder.sh" ]; then
    echo "Error: reminder.sh script not found or not executable."
    echo "Making it executable..."
    chmod +x ./reminder.sh 2>/dev/null || echo "Failed to make reminder.sh executable."
    exit 1
fi

# Check if the configuration file exists
if [ ! -f "../config/config.env" ]; then
    echo "Error: Configuration file not found."
    exit 1
fi

# Check if the data file exists
if [ ! -f "../data/submissions.txt" ]; then
    echo "Error: Submissions data file not found."
    exit 1
fi

# Run the reminder script
echo "Running reminder script..."
./reminder.sh

# Check the exit status
if [ $? -eq 0 ]; then
    echo "Submission Reminder Application ran successfully."
    echo "Check the logs directory for execution details."
else
    echo "Error: Submission Reminder Application encountered issues."
    echo "Please check the logs for more information."
fi

exit 0
EOF

# Make startup.sh executable
chmod +x "$main_dir/startup.sh"

# Create logs directory and initial log file
mkdir -p "$main_dir/logs"
touch "$main_dir/logs/reminder.log"

echo "Environment setup complete!"
echo "Directory structure created at: $main_dir"
echo "To run the application, navigate to $main_dir and execute ./startup.sh"

