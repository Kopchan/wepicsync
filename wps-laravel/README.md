# WepicSync Backend on Laravel

## WebUI

This backend for [WepicSync WebUI](https://github.com/Kopchan/wepicsync/tree/main/wps-vue)

## Setup

Complete prerequirements:
* Install [Git](https://git-scm.com/download) to cloning this repo 
* Install [XAMPP](https://www.apachefriends.org/ru/download.html) to get Apache & MySQL & PHP distribution easily
* Install [Composer](https://getcomposer.org/download/) to get project dependencies
* Install [FFmpeg](https://ffmpeg.org/download.html) to generating previews of video
* *Install [Node.js & NPM](https://nodejs.org/en/download) to generating album link previews (optional)

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

Go to backend folder
```bash
cd wps-laravel
```

Setup dependencies
```bash
composer i
```

Setup chrome (optional, for album preview links in social media) 
```bash
npm i
npx puppeteer browsers install chrome-headless-shell@stable
```

Copy example config file into current folder at `.env` name
```bash
copy .env.example .env
```

If after install FFmpeg and commands `ffmpeg` & `ffprobe` doesn't work, you need
pass into system `$PATH` environment variable, or specify paths into `FFMPEG_BINARIES` & `FFPROBE_BINARIES`
variables in `.env` file.

Generate key
```bash
php artisan key:generate
```

Create database and fill basic info (press "y" if ask create DB)
```bash
php artisan migrate --seed
```

To access the website simply through the domain, you need to create a file called `.htaccess` in the root of the project and fill it with the following content:
```apacheconf
RewriteEngine on
RewriteRule (.*)? /wps-laravel/public/$1
```
Or you can create symlink to `wps-laravel/public/` folder, if you clone repo in different place

After you can open site at [http://localhost/wepicsync](http://localhost/wepicsync)

Or open API docs at [http://localhost/wepicsync/swagger/docs](http://localhost/wepicsync/swagger/docs)

## Add local folder

For add local folder of media (images/videos) you can copy folder into `storage/app/images/` in project folder

Or you can create symlink to local folders:

Windows CMD with full paths: 
```bat
mklink /D "C:\xampp\htdocs\wepicsync\wps-laravel\storage\app\images\ALBUM_NAME" "C:\Users\USERNAME\Pictures\GRAB_FOLDER_NAME"
```
Windows CMD if in the project folder:
```bat
cd storage\app\images\ 
mklink /D ALBUM_NAME "D:\Photos"
```

## Index local folders

To index root album for new images in local folder you can enter follow command:
```bash
php artisan app:index
```

You can pass param: `-s <ALBUM ID/HASH/ALIAS>` for point from which album need start.

You can pass param: `-d` for auto deletion not founded local albums and images.

## Administrator default credentials

Login: `admin`

Password `admin123`
