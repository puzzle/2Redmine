# 2Redmine

This README outlines the details of collaborating on this script. A short introduction of this script could easily go here.

2Redmine is a Script to Import Bugs/Tickets from an tool into Redmine.

## Prerequisites

You will need the following things properly installed on your computer.

Git

Bundle

## Installation

git clone <repository-url> this repository

change into the new directory

execute "bundle install"


## Bugzilla

Bugzilla importer imports the bugs from a xml file. Export the xml file manual from bugzilla. 

### Running / Params

Example:

```
 ./2redmine --source ../../example_file --redmine_projectid 12121212 --apikey 3ithrfj4uihguh --url https://redmine.example.ch --source_tool bugzilla --status_id 2
```

| Params | Description           |
| ------------------------------- |:-------------:|
| --redmine_source     | Path to the File you wish to import |
| --redmine_projectid     | The redmine project id you wish your issues to import in      |
| --redmine_apikey | The API key to access to your redmine (MyAccount -> on the right side)      |
| --redmine_url | URL to the Redmine  |
| --source_tool | which source tool you want to use (required) | Options: bugzilla, OTR |
| --status_id | The status_id you want to set to this file export (by default is set 1)|


##OTRS

Otrs importer imports ticket from the otrs database. You need a database user with at least read permisson.


Example:

```
 ./2redmine --source ../../example_file --redmine_projectid 12121212 --apikey 3ithrfj4uihguh --url https://redmine.example.ch --source_tool otrs --status_id 2 --otrs_query p25 --otrs_queue MyQueue
```

| Params | Description           |
| ------------------------------- |:-------------:|
| --redmine_source     | Path to the File you wish to import |
| --redmine_projectid     | The redmine project id you wish your issues to import in      |
| --redmine_apikey | The API key to access to your redmine (MyAccount -> on the right side)      |
| --redmine_url | URL to the Redmine  |
| --source_tool | which source tool you want to use (required) | Options: bugzilla, OTR |
| --status_id | The status_id you want to set to this file export (by default is set 1)|
| --otrs_query | otrs ticket title filter|
| --otrs_queue | otrs queue name to import tickets from, e.g. --otrs-queue-name MyQueue|



## Database credentials for OTRS

In the root directory is a file called: db_credentials.yml
Write your username, password,hostadress, and database name to this file.

