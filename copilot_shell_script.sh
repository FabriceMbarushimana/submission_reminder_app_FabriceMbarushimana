#!/bin/bash

# Asking the user to enter his/her name

read -p "Enter the name: " name
if [ -z "$name" ]; then
	echo "Please enter your name."
	exit 1
fi
if ! [[ "$name" =~ ^[a-zA-Z\s]+$ ]]; then
    echo "The Assignment name must be alpherbetic."
    
    exit 1
fi
# Adding the variable to the directory and declaring variables

dir="submission_reminder_$name"
submissions_file="$dir/assets/submissions.txt"

# Checking if the directory exists
if [ ! -d "$dir" ]; then
	echo "Enter correct directory"
	 
	exit 1
fi

# Prompt for the assignment and the days remaining
read -p "Enter the name for the assignment: " Assignment
read -p "Enter the number of days remaining for submission: " Days

# Sanitazing the variables input
Assignment=$(echo "$Assignment" | sed "s/$(echo -e '\u00a0')/ /g" | tr -cd '[:alnum:] [:space:]' | xargs)

Days=$(echo "$Days" | xargs)

echo "DEBUG: [$Assignment]"

# Input validation

# Checking if the Assignment name ain't empty and that the Days are numbers
if [ -z "$Assignment" ] || ! [[ "$Days" =~ ^[0-9]+$ ]]; then
    echo "Add Assignment name."
fi

# Checking if the Assignment name ain't numerical
if ! echo "$Assignment" | grep -qE '^[A-Za-z ]+$'; then
    echo "The Assignment name must contain." 
    echo "only letters and spaces😑."
    echo "Aborting..."
    exit 1
fi

# Checking if the assignment exists in submissions.txt

matched_assignment=$(grep -i ", *$Assignment," "$submissions_file" | awk -F',' '{print $2}' | head -n1 | xargs)

if [ -z "$matched_assignment" ]; then
    echo "Assignment '$Assignment' isn't available in submissions.txt"
 
    exit 1
fi

# Update config.env

echo "Updating config.env in $dir/config/"
echo "ASSIGNMENT=\"$matched_assignment\"" > "$dir/config/config.env"
echo "DAYS_REMAINING=$Days" >> "$dir/config/config.env"

 cat "$dir/config/config.env"

# Ask if they want to start the app
read -p "Would you like to run the reminder app now? (y/n): " choice

if [[ "$choice" =~ ^[Yy]$ ]]; then
    echo "...Starting the app..."
    bash "$dir/startup.sh"
    echo "The app running"
 
else
    echo "Reminder app not started."
    
fi