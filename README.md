# README BKS-TOOL

This tool aims to provide a registration page to year 5 students, so that they
can sign up for Matura presentations presented by year 6 students. Built on
rails and passenger, it is designed to run on a debian server with apache.

Uses RUBY 2.5.1 and RAILS 5.2.0

# Wichtige Dateien:
## Mailtexte:

/var/www/bks-tool/app/views/student_mailer/  Nur .html.erb, nicht die .txt.erb

## Seeds datei:

/var/www/bks-tool/db/seeds.rb  ⇒ Bearbeitbar in vim

## SQLite DB:

/var/www/bks-tool/db/production.sqlite3 ⇒ SQLite DB Browser

## Beispiel CSV Dateien:

/var/www/bks-tool/CSVs/

## Error dateien:

/var/www/bks-tool/public/

## Installationsskripte für Einrichtung Debian 9 Server

/var/www/bks-tool/scripts

## Source code:

https://bitbucket.org/elancaster/bks-tool
