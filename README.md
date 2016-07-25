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
 ./2redmine --source ../../example_file --redmine-projectid 12121212 --redmine-apikey 3ithrfj4uihguh --url https://redmine.example.ch --source-tool bugzilla --status-id 2
```

| Params | Description           |
| ------------------------------- |:-------------:|
| --redmine-source     | Path to the File you wish to import |
| --redmine-projectid     | The redmine project id you wish your issues to import in      |
| --redmine-apikey | The API key to access to your redmine (MyAccount -> on the right side)      |
| --redmine-url | URL to the Redmine  |
| --source-tool | which source tool you want to use (required) | Options: bugzilla, OTR |
| --status-id | The status-id you want to set to this file export (by default is set 1)|


##OTRS

Otrs importer imports ticket from the otrs database. You need a database user with at least read permisson.


Example:

```
 ./2redmine --source ../../example_file --redmine-projectid 12121212 --redmine-apikey 3ithrfj4uihguh --url https://redmine.example.ch --source-tool otrs --status-id 2 --otrs-query p25 --otrs-queue MyQueue
```

| Params | Description           |
| ------------------------------- |:-------------:|
| --redmine-source     | Path to the File you wish to import |
| --redmine-projectid     | The redmine project id you wish your issues to import in      |
| --redmine-apikey | The API key to access to your redmine (MyAccount -> on the right side)      |
| --redmine-url | URL to the Redmine  |
| --source-tool | which source tool you want to use (required) | Options: bugzilla, OTR |
| --status-id | The status-id you want to set to this file export (by default is set 1)|
| --otrs-query | otrs ticket title filter|
| --otrs-queue | otrs queue name to import tickets from, e.g. --otrs-queue-name MyQueue|



## Database credentials for OTRS

In the root directory is a file called: db_credentials.yml
Write your username, password,hostadress, and database name to this file.

