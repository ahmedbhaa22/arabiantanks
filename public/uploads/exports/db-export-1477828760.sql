-- mysqldump-php https://github.com/ifsnop/mysqldump-php
--
-- Host: 127.0.0.1	Database: cms
-- ------------------------------------------------------
-- Server version 	5.5.52-0ubuntu0.14.04.1
-- Date: Sun, 30 Oct 2016 13:59:20 +0200

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `content`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content_title` varchar(255) NOT NULL,
  `content_body` varchar(255) CHARACTER SET latin1 NOT NULL,
  `content_description` varchar(255) CHARACTER SET latin1 NOT NULL,
  `content_created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `content_picture` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `content` VALUES (1,'','DSDSDS','DSDSSD','2016-10-26 12:41:49',NULL),(2,'','ddddd','ddddd','2016-10-27 10:25:18',NULL),(3,'','flash test flash flash test flashawy','flash test','2016-10-27 10:43:40',NULL),(4,'','achgain','again','2016-10-27 10:45:40',NULL),(5,'','begad','seriously','2016-10-27 11:01:52',NULL),(6,'','kdskskdsdsk','kdkskdsjdks','2016-10-27 11:02:56',NULL),(7,'test upload','sssss','tttt','2016-10-27 13:40:52',NULL),(8,'upload','uploading aho','test upoad','2016-10-27 13:46:57',NULL),(9,'upload','uploading aho','test upoad','2016-10-27 13:48:05',NULL),(10,'upload','uploading aho','test upoad','2016-10-27 13:49:02',NULL),(11,'upload','uploading aho','test upoad','2016-10-27 14:13:51',NULL),(12,'upload','uploading aho','test upoad','2016-10-27 14:18:49',NULL),(13,'upload','uploading aho','test upoad','2016-10-27 14:19:00',NULL),(14,'upload','uploading aho','test upoad','2016-10-27 14:23:03','three-dots.png'),(15,'title for test','body of content','another fancy descripton','2016-10-30 09:04:00',''),(16,'flash test','work ba2a yalla :@','flashing....hehe','2016-10-30 09:22:06',''),(17,'dslslsdjk','sdslslsalja','djsljdsl','2016-10-30 09:24:33','');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `email_confirmations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_confirmations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` int(10) unsigned NOT NULL,
  `code` char(32) NOT NULL,
  `createdAt` int(10) unsigned NOT NULL,
  `modifiedAt` int(10) unsigned DEFAULT NULL,
  `confirmed` char(1) DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_confirmations`
--

LOCK TABLES `email_confirmations` WRITE;
/*!40000 ALTER TABLE `email_confirmations` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `email_confirmations` VALUES (1,5,'sypaL8LxeMtY1tbGuusygj3QPyqB',1477311229,NULL,'N'),(2,6,'IeENOZ6PYb7gsgxxcjozbOhaD0lGtt5',1477311383,NULL,'N'),(3,7,'MPjOGjwUnFzozXrHi4Quj7swoGqTdkfe',1477311670,NULL,'N');
/*!40000 ALTER TABLE `email_confirmations` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `failed_logins`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_logins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` int(10) unsigned DEFAULT NULL,
  `ipAddress` char(15) NOT NULL,
  `attempted` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usersId` (`usersId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_logins`
--

LOCK TABLES `failed_logins` WRITE;
/*!40000 ALTER TABLE `failed_logins` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `failed_logins` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `menus`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `href` varchar(255) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `menus` VALUES (1,'المحتوى','icon-screen-tablet','all_content.html',1,NULL),(2,'محتوى الصور','icon-frame','images_content.html',2,NULL),(3,'محتوي الفيديو','icon-film','videos_content.html',3,NULL),(4,'الاشعارات','icon-bell','notification.html',4,NULL),(5,'إحصائيات','fa fa-bar-chart','statistics.html',5,NULL),(6,'إعلانات','icon-tag','ads.html',6,NULL);
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `password_changes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_changes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` int(10) unsigned NOT NULL,
  `ipAddress` char(15) NOT NULL,
  `userAgent` varchar(48) NOT NULL,
  `createdAt` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usersId` (`usersId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_changes`
--

LOCK TABLES `password_changes` WRITE;
/*!40000 ALTER TABLE `password_changes` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `password_changes` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `permissions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `profilesId` int(10) unsigned NOT NULL,
  `resource` varchar(16) NOT NULL,
  `action` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profilesId` (`profilesId`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `permissions` VALUES (1,3,'users','index'),(2,3,'users','search'),(3,3,'profiles','index'),(4,3,'profiles','search'),(5,1,'users','index'),(6,1,'users','search'),(7,1,'users','edit'),(8,1,'users','create'),(9,1,'users','delete'),(10,1,'users','changePassword'),(11,1,'profiles','index'),(12,1,'profiles','search'),(13,1,'profiles','edit'),(14,1,'profiles','create'),(15,1,'profiles','delete'),(16,1,'permissions','index'),(17,2,'users','index'),(18,2,'users','search'),(19,2,'users','edit'),(20,2,'users','create'),(21,2,'profiles','index'),(22,2,'profiles','search');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `profiles`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `active` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `profiles` VALUES (1,'Administrators','Y'),(2,'Users','Y'),(3,'Read-Only','Y');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `remember_tokens`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remember_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` int(10) unsigned NOT NULL,
  `token` char(32) NOT NULL,
  `userAgent` varchar(120) NOT NULL,
  `createdAt` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remember_tokens`
--

LOCK TABLES `remember_tokens` WRITE;
/*!40000 ALTER TABLE `remember_tokens` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `remember_tokens` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `reset_passwords`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reset_passwords` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` int(10) unsigned NOT NULL,
  `code` varchar(48) NOT NULL,
  `createdAt` int(10) unsigned NOT NULL,
  `modifiedAt` int(10) unsigned DEFAULT NULL,
  `reset` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usersId` (`usersId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reset_passwords`
--

LOCK TABLES `reset_passwords` WRITE;
/*!40000 ALTER TABLE `reset_passwords` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `reset_passwords` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `success_logins`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `success_logins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` int(10) unsigned NOT NULL,
  `ipAddress` char(15) NOT NULL,
  `userAgent` varchar(120) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usersId` (`usersId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `success_logins`
--

LOCK TABLES `success_logins` WRITE;
/*!40000 ALTER TABLE `success_logins` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `success_logins` VALUES (1,5,'::1','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36'),(2,5,'::1','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36'),(3,5,'::1','Mozilla/5.0 (Windows NT 6.3; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0'),(4,5,'::1','Mozilla/5.0 (Windows NT 6.3; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0'),(5,5,'::1','Mozilla/5.0 (Windows NT 6.3; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0'),(6,5,'::1','Mozilla/5.0 (Windows NT 6.3; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0'),(7,5,'::1','Mozilla/5.0 (Windows NT 6.3; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0'),(8,5,'127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:49.0) Gecko/20100101 Firefox/49.0'),(9,5,'127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:49.0) Gecko/20100101 Firefox/49.0');
/*!40000 ALTER TABLE `success_logins` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `users`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` char(60) NOT NULL,
  `mustChangePassword` char(1) DEFAULT NULL,
  `profilesId` int(10) unsigned NOT NULL,
  `banned` char(1) NOT NULL,
  `suspended` char(1) NOT NULL,
  `active` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `profilesId` (`profilesId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `users` VALUES (1,'Bob Burnquist','bob@phalconphp.com','$2a$08$Lx1577KNhPa9lzFYKssadetmbhaveRtCoVaOnoXXxUIhrqlCJYWCW','N',1,'N','N','Y'),(2,'Erik','erik@phalconphp.com','$2a$08$f4llgFQQnhPKzpGmY1sOuuu23nYfXYM/EVOpnjjvAmbxxDxG3pbX.','N',1,'Y','Y','Y'),(3,'Veronica','veronica@phalconphp.com','$2a$08$NQjrh9fKdMHSdpzhMj0xcOSwJQwMfpuDMzgtRyA89ADKUbsFZ94C2','N',1,'N','N','Y'),(4,'Yukimi Nagano','yukimi@phalconphp.com','$2a$08$cxxpy4Jvt6Q3xGKgMWIILuf75RQDSroenvoB7L..GlXoGkVEMoSr.','N',2,'N','N','Y'),(5,'admin','admin@pentavalue.com','$2y$08$M21LQ2FraXdKZHhMUGhYdeV2AYV0r1n9afNLG8IZgBXvWf365jsgy','N',2,'N','N','Y'),(6,'demo','demo@pentavalue.com','$2y$08$TWpvOVZtaEhXR2FZU3hZaekvS8f.AafBvL8ABt7RdCiVaSl31gYBC','N',2,'N','N','Y'),(7,'salma','salmaomar@pentavalue.com','$2y$08$MHhCTFFVUUNEdXY3OW44Tuv5JOsVPy0h.ejc82RfekEtZS0CHEvGC','N',2,'N','N','Y');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on: Sun, 30 Oct 2016 13:59:20 +0200
