#!/bin/bash

# Collect Name From User
echo "Welcome to the Submission Reminder"

read -p "Enter your name: " User_Name

# Validate if name is not empty

if [ -z "$User_Name" ]; then
	echo "Check directory created."
	exit 1
fi


echo "__________________________________________"

 
# commands that creating directory 

User_name_dir="submission_reminder_$User_Name"

# Check if the directory exists
if [ -d "$User_name_dir" ]; then
	echo "Directory name '$User_name_dir' already exists use different names."
	exit 1

else
    echo "Creating directory named '$User_name_dir'"
	mkdir -p "$User_name_dir"
	echo "The directory '$User_name_dir' created ."
fi
echo "__________________________________________"


# Creating directories and files inside the main directory
mkdir -p "$User_name_dir/app"
mkdir -p "$User_name_dir/modules"
mkdir -p "$User_name_dir/assets"
mkdir -p "$User_name_dir/config"


[ ! -f "$User_name_dir/app/reminder.sh" ] && touch "$User_name_dir/app/reminder.sh"
[ ! -f "$User_name_dir/modules/functions.sh" ] && touch "$User_name_dir/modules/functions.sh"
[ ! -f "$User_name_dir/assets/submissions.txt" ] && touch "$User_name_dir/assets/submissions.txt"
[ ! -f "$User_name_dir/config/config.env" ] && touch "$User_name_dir/config/config.env"
[ ! -f "$User_name_dir/startup.sh" ] && touch "$User_name_dir/startup.sh"
 
# Adding contents in reminder.sh and functions.sh
echo '
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
' >> $User_name_dir/config/config.env

echo '
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
' >> $User_name_dir/app/reminder.sh

echo '
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
' >> $User_name_dir/modules/functions.sh

echo '
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Kenny, Shell Navigation, not submitted
Aristides, Git, submitted
Kevin, Shell Basics, not submitted
Manzi, Shell Navigation, submitted
' >> $User_name_dir/assets/submissions.txt



# Add more students in submissions.txt

cat <<EOL >> "$User_name_dir/assets/submissions.txt"
Kennedy, Shell Navigation, not submitted
Mbarushimana, Shell Basics, submitted,
Amina, Git, not submitted

EOL

# Create startup.sh with logic to run the app

cat << 'EOL' > "$User_name_dir/startup.sh"
#!/bin/bash
# Script for uexecute the reminder app
cd "$(User_name_dir "$0")"
bash ./app/reminder.sh
EOL

#Add execute permissions to the scripts
chmod +x "$User_name_dir/assets/submissions.txt"
chmod +x "$User_name_dir/config/config.env"
chmod +x "$User_name_dir/startup.sh"
chmod +x "$User_name_dir/app/reminder.sh"
chmod +x "$User_name_dir/modules/functions.sh"


# __________________________________________

echo " The directory '$User_name_dir' has been set up successfully with all necessary files and directories."
 