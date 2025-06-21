# WepicSync Backend on Laravel

## WebUI

This backend for [WepicSync WebUI](https://github.com/Kopchan/wepicsync/tree/main/wps-vue)

## Setup

Complete prerequirements:
* Install [Git](https://git-scm.com/download) to cloning this repo 
* Install [XAMPP](https://www.apachefriends.org/ru/download.html) to get Apache distribution easily 
* Install [Composer](https://getcomposer.org/download/) to get project dependencies

Open `XAMPP Control Panel` and click `Start` buttons next to `Apache` and `MySQL`

Open `shell` by clicking on the corresponding button and start enter following commands:

Go to folder with websites
```bash
cd htdocs
```

Create folder for project
```bash
mkdir wepicsync
```

Go to new folder
```bash
cd wepicsync
```

Clone this repo into current empty folder
```bash
git clone https://github.com/Kopchan/wepicsync .
```

Setup dependencies
```bash
composer i
```

Copy example config file into current folder at `.env` name
```bash
copy .env.example .env
```

Generate key
```bash
php artisan key:generate
```

Create database and fill basic info (press "y" if ask create DB)
```bash
php artisan migrate:fresh --seed
```

To access the website simply through the domain, you need to create a file called `.htaccess` in the root of the project and fill it with the following content:
```apacheconf
RewriteEngine on
RewriteRule (.*)? /public/$1
```
Or you can create symlink to `public/` folder, if you clone repo in different place

After you can open site at [http://localhost/wepicsync](http://localhost/wepicsync)

Or open API docs at [http://localhost/wepicsync/swagger/docs](http://localhost/wepicsync/swagger/docs)

## Add local folder

For add local folder for display in WebUI you can copy folder into `storage/app/images/` in project folder

Or you can create symlink to local folders:

Windows CMD with full paths: 
```bat
mklink /D "C:\xampp\htdocs\wepicsync\storage\app\images\ALBUM_NAME" "C:\Users\USERNAME\Pictures\GRAB_FOLDER_NAME"
```
Windows CMD if in the project folder:
```bat
cd storage\app\images\ 
mklink /D ALBUM_NAME "D:\Photos"
```
