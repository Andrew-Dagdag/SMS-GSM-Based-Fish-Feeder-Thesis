# SMS-GSM-Based-Fish-Feeder-Thesis
Leveraging texting technology, use that to remotely feed fish, with a central server containing settings and statistics

Setup:
Please ensure you have the following installed:
>Git

>Nodejs

>npm

>XAMPP

Proceed to Server/
>npm install

Wait as it installs Nodejs dependencies
>npm install bower

>bower install jquery

>bower install bootstrap

>bower install MDBootstrap

Import autofishfeed.sql and smsserver.sql into phpMyAdmin

Install the following:
>Diafaan (note: This is a proprietary software. Free trial only lasts 30 days)

>mysql-connector-odbc

>SmartBro

Set up diafaan with the corresponding tables (refer to smsserver database)

Set up odbc with the following text:

>Driver={MySQL ODBC 5.1 Driver};Server=localhost;charset=UTF8MB4;Database=smsserver;User=root;Password=;Option=3;



Running the server:
Make sure you're in the Server/ folder

>node server.js

If you plan on using the testing tool, run this command in a separate terminal:

>node noTextTest.js

Help Area:

Texting formats can be found in Server/textingformats.txt
