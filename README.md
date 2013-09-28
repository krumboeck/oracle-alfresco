Oracle Server support for Alfresco Community
============================================

Note
----
Project is based on "Oracle for ALFRESCO Community" from Paul Web.

THIS SOFTWARE COMES WITHOUT ANY WARRANTY!


License
-------
GPLv2


Supported Alfresco Releases
---------------------------
* 4.0_b (branch)
* 4.2_b (branch)
* 4.2_d (master)


Upgrade Paths
-------------
    3.4_d ----> 3.4.d
    4.0_b ----> 3.4.d
    4.2_b ----> 3.4.d
> Other paths may work, but not known.
> Caution: Upgrades are not well tested and may cause problems. Always use a test environment to test the upgrade. A better idea is to use a second environment, to which you can switch over, when upgrade was successful.


Building the AMP
----------------
    cd src
    zip -r ../oracle-alfresco-4.2_d.amp *


Settings
----------------

To use Oracle please follow the steps below:


1.Create a new 'alfresco' user and schema in oracle
for example:
  CREATE TABLESPACE alfresco DATAFILE 'ALFRESCO-TS.DAT' SIZE 64M REUSE AUTOEXTEND ON NEXT 32M;
  CREATE USER alfresco DEFAULT TABLESPACE alfresco TEMPORARY TABLESPACE temp IDENTIFIED BY alfresco;
  GRANT ALL PRIVILEGES TO alfresco; 

2.Ensure that the alfresco user has the required privileges to create and modify tables. This can be removed once the server has started, but may be required during upgrades.

3.Override following properties in your alfresco-global.properties: 

db.driver=oracle.jdbc.OracleDriver
db.name=alfresco
db.url=jdbc:oracle:thin:@<machinename>:1521:<database sid>
db.username=alfresco
db.password=alfresco
db.pool.validate.query=SELECT 1 FROM DUAL

if you have error ORA set hibernate.show_sql=true

4.If you have multiple Alfresco instances installed on an Oracle server, you will need to force the database metadata queries to target the schema that each database user is using. Put the following in alfresco-global.properties: 

hibernate.default_schema=ALFRESCO 
or if you have error
hibernate.default_schema=alfresco

5.Copy the Oracle JDBC driver JAR into \tomcat\lib (on Tomcat 6) or \jboss\server\default\lib (JBoss). 
for example: oracle\product\10.2.0\db_1\jdbc\lib\ to \tomcat\lib

6.You can now startup the Tomcat or Jboss server 


    * Note: if you get JDBC errors ensure the location for the Oracle JDBC drivers are on the system path, or add them to the relevant lib directory of the app server - the Oracle JDBC drivers can be found in the <orainst>/ora<ver>/jdbc/lib directory (e.g. c:\oracle\ora92\jdbc\lib) 

    * Note: for performance reasons it is recommended that you use the 10g JDBC drivers, even if your Oracle server is 9i. 


Using with Alfresco Maven SDK 1.0
---------------------------------

To use this with the Alfresco Maven SDK 1.0 (https://artifacts.alfresco.com/nexus/content/repositories/alfresco-docs/alfresco-lifecycle-aggregator/latest/index.html) follow the below instructions:

1. Download the code from here
2. Copy the contents of `oracle-alfresco/src/config` to `(your parent Alfresco module)/alfresco/src/main/webapp/WEB-INF/classes/alfresco`

This will package the Oracle items into the appropriate area after running a Maven build (i.e. your WAR file will be packaged appropriately).
 
