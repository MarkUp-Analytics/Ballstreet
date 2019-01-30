# Ballstreet

## Setting up local DB
<ol>
<li>Check psql is installed by typing psql in terminal</li>
<li>If not installed, download and install psql from <a href="https://www.postgresql.org/download/">here</a> </li>
<li>If installed, create user ballstreetdev using the following command `CREATE ROLE ballstreetdev PASSWORD 'Amigosapp' SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;`</li>
<li>Check user is created by typing \du You should see list of all users available in your local db</li>
<li>cd into Ballstreet/scripts and enter the following commanf `psql -d ballstreetDev -f backup.sql`</li>
<li>Open PgAdmin using chrome.</li>
<li>Right click Servers and click create -> server</li>
<li>Enter name as 'ballstreetLocal'</li>
<li>
Goto connection tab and enter the following details
<ul>
<li>host name: localhost</li>
<li>port: 5432</li>
<li>username: ballstreetdev</li>
<li>password: Amigosapp</li>
</ul>
<br/>Now you can query db using pgAdmin
</li>
</ol>
