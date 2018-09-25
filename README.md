# docker-infinitewp
A Docker container for running InfiniteWP

## Install

1. Download InfiniteWP from https://infinitewp.com/installing-download/<br>This will download a package **IWPAdminPanel_v\*.zip**.
2. Save package to root of this repository.
3. `docker-compose build --build-arg INSTALL=true`<br>
   The build arg leaves the install folder inplace to allow first run wizard to create the config.php file.
4. Create an empty config.php file.<br>
   `touch config.php`
5. Set permissions<br>
   `chmod 666 config.php`
6. `docker-compose up`<br>
   _Wait for database init process to complete_
7. Open browser `http://localhost:3000`
8. Complete InfiniteWP Installation

----

### InfiniteWP Installation

#### Licence Agreement

Click the Agree & Install button.

#### Server Requirements

Will automatically check and pass to DB Details.

#### DB Details

| Name                 | Name                 |
|----------------------|----------------------|
| DB Host              | database             |
| DB Port              | 3306                 |
| DB Name              | infinitewp           |
| DB Table Name Prefix | iwp_                 |
| DB Username          | infinitewp           |
| DB Password          | password             |

Click the Next, Create Login button.

#### Create Login

Enter email and password.

Click the Next, Install button.

#### Installation

Installed Successfully :)

----

9. \<Ctrl+C\> running Docker compose.
10. Reset permissions on config file.<br>
    `chmod 644 config.php`
11. Rebuild Docker image without install directory.<br>
    `docker-compose build`
