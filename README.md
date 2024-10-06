# Task-CLI: Task Tracking Command Line Interface


Task-CLI is a simple command-line interface (CLI) application built in PowerShell to help you track and manage tasks efficiently. You can add tasks, update them, mark them as "in progress" or "done," and list tasks by their status.

## Features

- **Add a task:** Create new tasks with descriptions.
- **Update a task:** Modify the description of an existing task.
- **Delete a task:** Remove a task from the list.
- **Mark tasks as in progress or done:** Update the status of a task.
- **List tasks:** View all tasks or filter tasks by their status (`todo`, `in-progress`, `done`).
- **Persist tasks:** Task data is stored in a `tasks.json` file for persistence.

## Requirements

- PowerShell (Windows)
- JSON file to store tasks

## Installation

1. Clone or download this repository to your local machine.
2. Ensure you have PowerShell installed on your system.
3. You can create a `tasks.json` file manually in the directory where you are running the script, or the script will automatically create it for you.

### Steps to Create a Custom Command in powershell:

1. **Open PowerShell**:
    - Search for "PowerShell" and open it.

2. **Check for PowerShell Profile**:
    - Run this to check if you have a profile:
        
        ```powershell

        Test-Path $profile
        
        ```
        
    - If it says `False`, create a profile:
        
        ```powershell
    
        New-Item -Path $profile -ItemType File -Force
        
        ```
        
3. **Edit the Profile**:
    - Open the profile in Notepad:
        
        ```powershell

        Notepad $profile
        
        ```
        
4. **Add Your Custom Command**:
    - In Notepad, copy a given repository code(task-cli.ps1) and paste in $profile. For example:
        
        ```powershell
        function task-cli {
            Write-Host "This is my custom task command!"
        }
        
        ```
        
5. **Save and Reload**:
    - Save the file, then reload the profile by running:
        
        ```powershell
        . $profile
        
        ```
        
6. **Run Your Command**:
    - Now, you can use `task-cli` as a command in PowerShell


## Usage

### Adding a Task

```powershell

task-cli add "Buy groceries"
# Output: Task added successfully (ID: 1)

```

### Updating a Task

```powershell
task-cli update 1 "Buy groceries and cook dinner"
# Output: Task updated successfully

```

### Deleting a Task

```powershell

task-cli delete 1
# Output: Task deleted successfully

```

### Marking a Task as "In Progress" or "Done"

```powershell

task-cli mark-in-progress 1
# Output: Task 1 marked as "in progress"

task-cli mark-done 1
# Output: Task 1 marked as "done"

```

### Listing All Tasks

```powershell

task-cli list
```

### Listing Tasks by Status

```powershell

task-cli list done   # Lists all done tasks
task-cli list todo   # Lists all to-do tasks
task-cli list in-progress  # Lists all in-progress tasks

```

### Example Task Structure

Each task stored in the `tasks.json` file will have the following properties:

```json
{
  "id": 1,
  "description": "Buy groceries",
  "status": "todo",
  "createdAt": "2024-10-04T12:00:00.000Z",
  "updatedAt": "2024-10-04T12:00:00.000Z"
}

```

## File Structure

```

root-directory/
│
├── task-cli.ps1         # PowerShell script for Task-CLI
├── tasks.json           # JSON file that stores tasks
└── README.md            # Documentation file

```
## project url
https://roadmap.sh/projects/task-tracker