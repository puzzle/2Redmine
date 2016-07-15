# 2Redmine

This README outlines the details of collaborating on this script. A short introduction of this script could easily go here.

## Prerequisites

You will need the following things properly installed on your computer.

Git

Bundle

## Installation

git clone <repository-url> this repository

change into the new directory

execute "bundle install"

## Running / Params

Example:

```
 ./2redmine --source ../../example_file --redmine_projectid 12121212 --apikey 3ithrfj4uihguh --url https://bugzilla.example.ch --source_tool bugzilla --status_id 2
```

| Params | Description           |
| ------------------------------- |:-------------:|
| --source     | Path to the File you wish to import |
| --redmine_projectid     | The redmine project id you wish your issues to import in      |
| --apikey | The API key to access to your redmine (MyAccount -> on the right side)      |
| --url | URL to the Redmine  |
| --source_tool | The source_tool where the file comes from      |
| --status_id | The status_id you want to set to this file export (by default is set 1)|


## Database credentials for OTRS

In the root directory is a file called: db_credentials.yml
Write your username, password,hostadress, and database name to this file.





