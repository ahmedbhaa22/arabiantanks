-- MySQL dump 10.13  Distrib 5.6.38, for Linux (x86_64)
--
-- Host: localhost    Database: pentates_tanks
-- ------------------------------------------------------
-- Server version	5.6.38-log

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
-- Table structure for table `api`
--

DROP TABLE IF EXISTS `api`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `des` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `project_id` int(5) NOT NULL,
  `screen_id` int(5) NOT NULL,
  `success_response` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `fail_response` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `empty_response` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `type_method` enum('POST','GET','REQUEST') COLLATE utf8_unicode_ci NOT NULL,
  `api_link` text COLLATE utf8_unicode_ci NOT NULL,
  `group` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api`
--

LOCK TABLES `api` WRITE;
/*!40000 ALTER TABLE `api` DISABLE KEYS */;
/*!40000 ALTER TABLE `api` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_app_attachments`
--

DROP TABLE IF EXISTS `api_app_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_app_attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `file` varchar(100) DEFAULT NULL,
  `des` varchar(30) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_app_attachments`
--

LOCK TABLES `api_app_attachments` WRITE;
/*!40000 ALTER TABLE `api_app_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_app_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_app_screen_attachments`
--

DROP TABLE IF EXISTS `api_app_screen_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_app_screen_attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `screen_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `file` varchar(100) NOT NULL,
  `des` varchar(100) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_app_screen_attachments`
--

LOCK TABLES `api_app_screen_attachments` WRITE;
/*!40000 ALTER TABLE `api_app_screen_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_app_screen_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_app_screenshot_comments`
--

DROP TABLE IF EXISTS `api_app_screenshot_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_app_screenshot_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `screen_shot` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `comment` text NOT NULL,
  `created_date` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_app_screenshot_comments`
--

LOCK TABLES `api_app_screenshot_comments` WRITE;
/*!40000 ALTER TABLE `api_app_screenshot_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_app_screenshot_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_group`
--

DROP TABLE IF EXISTS `api_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_title` varchar(30) NOT NULL,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_group`
--

LOCK TABLES `api_group` WRITE;
/*!40000 ALTER TABLE `api_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_param`
--

DROP TABLE IF EXISTS `api_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` varchar(10) NOT NULL,
  `param_des` varchar(35) DEFAULT NULL,
  `param_link` varchar(35) DEFAULT NULL,
  `api_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_param`
--

LOCK TABLES `api_param` WRITE;
/*!40000 ALTER TABLE `api_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_cms_lang`
--

DROP TABLE IF EXISTS `application_cms_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_cms_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` int(11) NOT NULL,
  `lang_id` int(11) NOT NULL,
  `is_default` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_cms_lang`
--

LOCK TABLES `application_cms_lang` WRITE;
/*!40000 ALTER TABLE `application_cms_lang` DISABLE KEYS */;
INSERT INTO `application_cms_lang` VALUES (1,1,1,0),(2,1,2,1);
/*!40000 ALTER TABLE `application_cms_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_categories`
--

DROP TABLE IF EXISTS `client_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `application_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_categories`
--

LOCK TABLES `client_categories` WRITE;
/*!40000 ALTER TABLE `client_categories` DISABLE KEYS */;
INSERT INTO `client_categories` VALUES (1,'شركة',1),(2,'ضيف',1),(3,'عميل فردي',1),(4,'عميل مسجل',1);
/*!40000 ALTER TABLE `client_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies`
--

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` VALUES (1,'Arabia Tanks','Arabia tanks is a company specialized in selling high quality tanks in KSA',NULL);
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_branch_contacts`
--

DROP TABLE IF EXISTS `company_branch_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_branch_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL COMMENT 'holds value from contact_types table',
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_branch_contacts`
--

LOCK TABLES `company_branch_contacts` WRITE;
/*!40000 ALTER TABLE `company_branch_contacts` DISABLE KEYS */;
INSERT INTO `company_branch_contacts` VALUES (1,1,1,'info@gmail.com'),(2,1,1,'info@gmail.com'),(3,1,2,'0123456789 '),(4,1,2,'0123456789 '),(5,2,1,'info@gmail.com'),(6,2,1,'info@gmail.com'),(7,2,2,'0123456789 '),(8,2,2,'0123456789 ');
/*!40000 ALTER TABLE `company_branch_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_branch_covers`
--

DROP TABLE IF EXISTS `company_branch_covers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_branch_covers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_id` int(11) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_branch_covers`
--

LOCK TABLES `company_branch_covers` WRITE;
/*!40000 ALTER TABLE `company_branch_covers` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_branch_covers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_branch_users`
--

DROP TABLE IF EXISTS `company_branch_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_branch_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_branch_users`
--

LOCK TABLES `company_branch_users` WRITE;
/*!40000 ALTER TABLE `company_branch_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_branch_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_branches`
--

DROP TABLE IF EXISTS `company_branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_branches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `lat` decimal(9,6) NOT NULL,
  `long` decimal(9,6) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_branches`
--

LOCK TABLES `company_branches` WRITE;
/*!40000 ALTER TABLE `company_branches` DISABLE KEYS */;
INSERT INTO `company_branches` VALUES (1,1,'الفرع الرئيسي','عنوان الفرع الرئيسي - المملكة العربية السعودية',0.000000,0.000000,NULL,1),(2,1,'فرع الرياض','123 الرياض - المملكة العربية السعودية',0.000000,0.000000,NULL,2),(3,1,'فرع مصر الجديدة','Test',0.000000,0.000000,NULL,22),(5,1,'فرع الزيتون','Test',0.000000,0.000000,NULL,6),(6,1,'فرع السيدة','Test',0.000000,0.000000,NULL,7),(7,1,'فرع العجوزة','Test',0.000000,0.000000,NULL,8),(8,1,'فرع المعادي','Test',0.000000,0.000000,NULL,9);
/*!40000 ALTER TABLE `company_branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_departments`
--

DROP TABLE IF EXISTS `company_departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_departments`
--

LOCK TABLES `company_departments` WRITE;
/*!40000 ALTER TABLE `company_departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_payment_methods`
--

DROP TABLE IF EXISTS `company_payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_payment_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(55) NOT NULL,
  `account_name` varchar(255) NOT NULL,
  `account_number` varchar(255) NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_payment_methods`
--

LOCK TABLES `company_payment_methods` WRITE;
/*!40000 ALTER TABLE `company_payment_methods` DISABLE KEYS */;
INSERT INTO `company_payment_methods` VALUES (1,'SAB','SAB_TANKS','SABTANKS123456',1),(2,'HOLLAND','HOLLAND-TANKS','HOLLANDTANKS123456',1);
/*!40000 ALTER TABLE `company_payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_tags`
--

DROP TABLE IF EXISTS `company_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_tags`
--

LOCK TABLES `company_tags` WRITE;
/*!40000 ALTER TABLE `company_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_user`
--

DROP TABLE IF EXISTS `company_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_user`
--

LOCK TABLES `company_user` WRITE;
/*!40000 ALTER TABLE `company_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compared_items`
--

DROP TABLE IF EXISTS `compared_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compared_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compared_items`
--

LOCK TABLES `compared_items` WRITE;
/*!40000 ALTER TABLE `compared_items` DISABLE KEYS */;
INSERT INTO `compared_items` VALUES (1,42,11),(2,43,11),(3,44,11),(6,39,8),(9,41,12),(10,36,12),(11,28,12),(14,42,19),(15,41,19),(16,40,19),(17,3,13),(18,37,13),(20,42,22),(21,40,22),(22,39,22),(23,36,22),(24,37,22);
/*!40000 ALTER TABLE `compared_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_types`
--

DROP TABLE IF EXISTS `contact_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_types`
--

LOCK TABLES `contact_types` WRITE;
/*!40000 ALTER TABLE `contact_types` DISABLE KEYS */;
INSERT INTO `contact_types` VALUES (1,'email'),(2,'mobile');
/*!40000 ALTER TABLE `contact_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_keyvalue_setting`
--

DROP TABLE IF EXISTS `core_keyvalue_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_keyvalue_setting` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` varchar(200) NOT NULL,
  `img` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_keyvalue_setting`
--

LOCK TABLES `core_keyvalue_setting` WRITE;
/*!40000 ALTER TABLE `core_keyvalue_setting` DISABLE KEYS */;
INSERT INTO `core_keyvalue_setting` VALUES (1,'pdf','',''),(2,'image','',''),(3,'video','',''),(4,'sound','',''),(5,'html','',''),(6,'ppt','',''),(7,'word','',''),(8,'url','',''),(9,'map','',''),(10,'mail','',''),(11,'mobile','',''),(12,'website','',''),(13,'text','','');
/*!40000 ALTER TABLE `core_keyvalue_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_keyvalue_type`
--

DROP TABLE IF EXISTS `core_keyvalue_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_keyvalue_type` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` varchar(200) NOT NULL,
  `img` varchar(250) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_keyvalue_type`
--

LOCK TABLES `core_keyvalue_type` WRITE;
/*!40000 ALTER TABLE `core_keyvalue_type` DISABLE KEYS */;
INSERT INTO `core_keyvalue_type` VALUES (1,'قائمة إختيارات','','',NULL),(2,'نص','','',NULL),(3,'مربع تصحيح','','',NULL),(4,'رفع ملف ','','',NULL),(5,'براجراف','','',NULL),(6,'Time','','',NULL),(7,'Db','','',NULL),(8,'Entity','','',NULL);
/*!40000 ALTER TABLE `core_keyvalue_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cp_application_settings`
--

DROP TABLE IF EXISTS `cp_application_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cp_application_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` int(11) NOT NULL,
  `app_banner` varchar(100) NOT NULL DEFAULT 'app_default_banner.png',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cp_application_settings`
--

LOCK TABLES `cp_application_settings` WRITE;
/*!40000 ALTER TABLE `cp_application_settings` DISABLE KEYS */;
INSERT INTO `cp_application_settings` VALUES (1,1,'07120b44-a070-4962-a26d-d1fdeb5d88bf.png'),(2,597,'app_default_banner.png'),(3,602,'app_default_banner.png');
/*!40000 ALTER TABLE `cp_application_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cp_forms_replies`
--

DROP TABLE IF EXISTS `cp_forms_replies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cp_forms_replies` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Forms_Response` int(11) NOT NULL,
  `Date` datetime NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Replay` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cp_forms_replies`
--

LOCK TABLES `cp_forms_replies` WRITE;
/*!40000 ALTER TABLE `cp_forms_replies` DISABLE KEYS */;
/*!40000 ALTER TABLE `cp_forms_replies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cp_module_content_setting`
--

DROP TABLE IF EXISTS `cp_module_content_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cp_module_content_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL,
  `title` tinyint(4) NOT NULL DEFAULT '1',
  `des` tinyint(4) NOT NULL DEFAULT '1',
  `content` tinyint(4) NOT NULL DEFAULT '1',
  `order` tinyint(4) NOT NULL DEFAULT '1',
  `img` tinyint(4) NOT NULL DEFAULT '1',
  `visit_num` tinyint(4) NOT NULL DEFAULT '1',
  `datetime` tinyint(4) NOT NULL DEFAULT '1',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `depts` tinyint(4) NOT NULL DEFAULT '1',
  `mediaimg` tinyint(4) NOT NULL DEFAULT '1',
  `mediavideo` tinyint(4) NOT NULL DEFAULT '1',
  `kvinfo` tinyint(4) NOT NULL DEFAULT '1',
  `add` tinyint(4) NOT NULL DEFAULT '1',
  `delete` tinyint(4) NOT NULL DEFAULT '1',
  `import` tinyint(4) NOT NULL DEFAULT '0',
  `application_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cp_module_content_setting`
--

LOCK TABLES `cp_module_content_setting` WRITE;
/*!40000 ALTER TABLE `cp_module_content_setting` DISABLE KEYS */;
INSERT INTO `cp_module_content_setting` VALUES (1,1,1,0,1,0,1,1,1,1,1,0,0,1,1,1,0,1),(2,2,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1),(3,3,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1),(4,4,1,1,0,0,0,1,1,1,1,0,0,1,1,1,0,1),(5,5,1,1,0,0,0,1,1,1,1,0,0,1,1,1,0,1),(6,6,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1),(7,7,1,0,1,0,1,1,1,1,0,0,0,1,0,0,0,1),(8,8,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1),(9,9,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1),(10,11,1,1,1,0,1,1,1,1,1,1,0,1,1,1,0,1),(11,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1);
/*!40000 ALTER TABLE `cp_module_content_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cp_modules_settings`
--

DROP TABLE IF EXISTS `cp_modules_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cp_modules_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL,
  `toggle_grid` tinyint(4) NOT NULL DEFAULT '0',
  `has_media` tinyint(4) NOT NULL DEFAULT '0',
  `has_orders` tinyint(4) NOT NULL DEFAULT '0',
  `kv_price_param` int(11) NOT NULL DEFAULT '0',
  `img` varchar(100) NOT NULL DEFAULT 'default_module.jpg',
  `content_img` varchar(100) NOT NULL DEFAULT 'default_content.jpg',
  `content_stat_img` varchar(100) NOT NULL DEFAULT 'default_content_stat.jpg',
  `content_banner` varchar(100) NOT NULL DEFAULT 'default_content_banner.jpg',
  `module_banner` varchar(100) NOT NULL DEFAULT 'default_module_banner.jpg',
  `content_edit_banner` varchar(100) NOT NULL DEFAULT 'content_edit_banner.png',
  `export_fields_json` text,
  `import_export_enabled` tinyint(1) DEFAULT '1',
  `extra_fields` int(11) DEFAULT '0' COMMENT 'extra fields',
  `has_tags` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cp_modules_settings`
--

LOCK TABLES `cp_modules_settings` WRITE;
/*!40000 ALTER TABLE `cp_modules_settings` DISABLE KEYS */;
INSERT INTO `cp_modules_settings` VALUES (1,1,0,0,0,0,'1a00941d-5c5f-452e-824a-4cba788d224f.png','9af55751-3caf-4d9e-a517-6309ab2ea669.png','default_content_stat.png','ec77e670-102c-424d-9d6f-b69a0742f520.png','b04f752b-a631-494c-9ec7-6e0b22ed1e13.png','2950632d-5dd0-400b-b909-9767d2fd8d4b.png',NULL,1,0,0),(2,2,0,0,0,0,'87e16d5e-fd25-4f2d-bfa2-6db7eeb2e03e.png','0f1a1fe3-3fbe-4315-8e8b-13c94a968bce.png','2857144a-7116-4df9-ad21-4e27a6e1ccf1.png','96564db2-17f5-47c2-bd31-798b7e00f7eb.png','c5b7292e-0d17-4f5c-bf07-0640bbc5cfc4.png','0340246b-35c1-4c75-a008-409ddf19e572.png',NULL,1,0,0),(3,3,0,0,0,0,'0e4bd8d9-1754-4bcc-9f22-9aee0dc1f669.png','19caf26f-a55f-420c-931f-99ebb0eaf996.png','default_content_stat.png','3e8d5f33-e005-4b56-beae-59eb5e9bc488.png','79c697c9-ffff-4de1-b447-0c363c679ad0.png','bccc2a79-c0ea-47cf-bd23-bbfbe2a554ae.png',NULL,1,0,0),(4,4,0,0,0,0,'07d9d401-27d8-4bd2-bff9-4bbba21dc4fc.png','718640a1-4c54-4109-b024-fc78146e4d61.png','977c3199-4e56-455f-8401-9616bc593b60.png','225ed154-8042-48e9-a729-f90a0c53955c.png','661144f3-2739-4e80-9a57-7a1875e3e776.png','68366c7d-e1c2-4c1c-8b2c-d13a484554a0.png',NULL,1,0,0),(5,5,0,0,0,0,'43a329ba-8d20-4415-858a-86d059af8c94.png','dad1b9fd-951a-4f0b-b4b7-9b31d5670144.png','f3269f9a-48f4-4f86-ad38-9875807081de.png','9a1f1f6b-4760-4a2c-a253-83bda8665c76.png','21708d47-efb1-427f-9448-2c1459007810.png','8143aeb4-a6e5-483c-8300-a1502e2b340c.png',NULL,1,0,0),(6,6,0,0,0,0,'9ce128a3-8805-4d82-8c95-0d1f1db2ff1b.png','79a1aa30-ea05-4953-82c6-1002903c1784.png','afed02e9-90f8-4d77-8e76-d771c556dad3.png','65eb65fe-3129-4cf4-945a-ae3a6dc040c2.png','3990427d-6e00-4d7b-a8ef-db2f75a98c63.png','d04b3969-442e-4595-a0c1-c74aa4f70211.png',NULL,1,0,0),(7,7,0,0,0,0,'32f3964a-3946-48e6-af84-1e24218f6943.png','c62edf58-efcc-42e5-88d7-87ddac1c1b2b.png','cff641e9-7389-4e43-880e-5fb0b9d0c54d.png','9eaa9936-3e5d-41e2-8848-61fff68bed2d.png','3384d7ae-214f-4fd8-a231-37e057553091.png','d8452d61-89dd-4b8f-a512-1db51b246353.png',NULL,0,0,0),(8,8,0,0,1,82,'d6456630-60e9-4c9a-afc1-904c49f7ca81.png','d51b28d3-c8b3-45bd-96f3-5914177b7fbf.png','default_content_stat.png','d9246ab3-6aca-474b-9118-85db9e3a10ad.png','97ae80ac-0804-4e30-8958-5f1e54ff7ecc.png','abe51363-a739-4de5-92c5-69863a9cd111.png',NULL,1,8,1),(9,9,0,0,0,0,'7a617267-2b4a-4dae-b516-49f746e45500.png','12421be9-3e63-40d3-8e0c-d64e1088dce0.png','658b2556-d4ec-4709-8384-b513bd9c82a9.png','bd2edee1-7619-40c0-b1a4-e9edea05cf54.png','4e3341c9-04d5-4481-9d23-0c2b6d73066e.png','5a560590-e1b2-40a8-983f-4d73fed5b35f.png',NULL,1,0,0),(10,11,0,0,0,0,'ca1a7058-e92b-4e44-98a1-8de8e6495069.png','fa291ac1-43d8-4e1b-b589-86386e04de36.png','c466f470-bf4e-493c-bcd6-a84c3ecf06e1.png','9bd0b4a2-0a44-480c-bba3-6a40d75f4027.png','c9b218ca-e864-4cee-a081-113e5b51083d.png','5bc0f4b1-14c3-4dfb-bcd4-257ead50027a.png',NULL,1,0,0),(11,10,0,0,0,0,'c6eb5f33-7728-42a7-97c9-4f732e581078.png','a4f89808-b32f-45bd-97f3-d377a938a9a8.png','a593cb91-dbee-45f4-b460-dc32bc64120d.png','eadaaba9-501c-4bff-b83f-b3a6f369735c.png','98146685-a2ae-4897-a3c4-37467cfb00e4.png','ca281fb7-ab6a-43b3-bbec-797fbe3c0b43.png',NULL,1,0,0);
/*!40000 ALTER TABLE `cp_modules_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cp_modules_translation`
--

DROP TABLE IF EXISTS `cp_modules_translation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cp_modules_translation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL,
  `word_key` varchar(50) NOT NULL,
  `value` varchar(50) NOT NULL,
  `core_dept_id` int(11) NOT NULL DEFAULT '0',
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cp_modules_translation`
--

LOCK TABLES `cp_modules_translation` WRITE;
/*!40000 ALTER TABLE `cp_modules_translation` DISABLE KEYS */;
/*!40000 ALTER TABLE `cp_modules_translation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cp_system_translation`
--

DROP TABLE IF EXISTS `cp_system_translation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cp_system_translation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_key` varchar(50) CHARACTER SET utf8 NOT NULL,
  `value` varchar(50) CHARACTER SET utf8 NOT NULL,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cp_system_translation`
--

LOCK TABLES `cp_system_translation` WRITE;
/*!40000 ALTER TABLE `cp_system_translation` DISABLE KEYS */;
INSERT INTO `cp_system_translation` VALUES (3,'Main Departments','الأقسام الرئيسية',1),(4,'Control Panel','لوحة التحكم',1),(5,'Permissions','الصلاحيات',1),(6,'Control Panel Users','مستخدمين لوحة التحكم',1),(7,'Logs','التسجيلات',1),(8,'Hello','أهلا',1),(9,'Logout','تسجيل الخروج',1),(10,'Title','الاسم',1),(11,'Desc','الوصف',1),(12,'Active','مفعل',1),(13,'Edit/Delete','تعديل/مسح',1),(14,'Edit','تعديل',1),(15,'Delete','مسح',1),(16,'New','جديد',1),(17,'Content','محتوى',1),(18,'Departments','أقسام',1),(19,'First','الأول',1),(20,'Last','الأخير',1),(21,'Next','التالي',1),(22,'Back','السابق',1),(23,'Main Picture','الصورة الرئيسية',1),(24,'OrderBy','الترتيب',1),(25,'Visitors Count','عدد الزوار',1),(26,'Date','التاريخ',1),(27,'Language','اللغة',1),(28,'Checked Fuctions','اجراءات على المحدد',1),(29,'Delete Checked','مسح المحدد',1),(30,'Media','الميديا',1),(31,'Video','الفيديو',1),(32,'Other Options','اختيارات أخرى',1),(33,'Save','حفظ',1),(34,'ِAdd More','إضافة المزيد',1),(35,'New Content','محتوى جديد',1),(36,'Content Details','تفاصيل المحتوى',1),(37,'Picture','الصورة',1),(38,'Value','القيمة',1),(39,'Edit Content','تعديل محتوى',1),(40,'Content Statistics','إحصائيات المحتوى',1),(41,'Orders','الطلبات',1),(42,'Order','الطلب',1),(43,'Link','اللينك',1),(44,'Height','الارتفاع',1),(45,'Width','العرض',1),(46,'Add Ad','إضافة إعلان',1),(47,'Choose Module','إختيار موديول',1),(48,'Module','موديول',1),(49,'Modules','الموديولات',1),(50,'Statistics','الإحصائيات',1),(51,'Users Statistics','إحصائيات المستخدمين',1),(52,'Mobile','الموبايل',1),(53,'Mobile Type','نوع الموبايل',1),(54,'Length','المدة',1),(55,'IP','الآي بي',1),(56,'Country','البلد',1),(57,'City','المدينة',1),(58,'Browser','المتصفح',1),(59,'Coordinates','الإحداثيات',1),(60,'Online','أونلاين',1),(61,'Geo Location','الموقع الجغرافي',1),(62,'Content Contains','تفاصيل المحتوى يحتوي على',1),(63,'Mobile Users','مستخدمين الموبايل',1),(64,'Name','الإسم',1),(65,'User Name','اسم المستخدم',1),(66,'Gender','االنوع',1),(67,'E-Mail','الايميل',1),(68,'Registration Date','تاريخ التسجيل',1),(69,'Registration Time','وقت التسجيل',1),(70,'Time','الوقت',1),(71,'Product','المنتج',1),(72,'Price','السعر',1),(73,'Count','العدد',1),(74,'Options','خيارات',1),(75,'Order Details','تفاصيل الطلب',1),(76,'User','المستخدم',1),(77,'Item','موضوع التعديل',1),(78,'Edit Type','نوع التعديل',1),(79,'Action','الأكشن',1),(80,'Account Type','نوع العضوية',1),(81,'Add new account','إضافة عضوية جديدة',1),(82,'Colors','الألوان',1),(83,'Status','الحالة',1),(84,'Filter','فلتر',1),(85,'Apply Filter','تطبيق الفلتر',1),(86,'Order_ID','رقم الطلب',1),(87,'System Permissions','صلاحيات النظام',1),(88,'Choose','إختار',1),(89,'View Content','عرض المحتوى',1),(90,'Search Results For Content','نتائج البحث عن المحتوى',1),(91,'Advanced Search','بحدث متقدم',1),(92,'Date From','من تاريخ',1),(93,'Date To','إلى تاريخ',1),(94,'Title Contains','العنوان',1),(95,'Ads','اعلانات',1),(96,'Reset All','إعادة تعيين',1),(97,'Theme 1','ثيم 1',1),(98,'Theme 2','ثيم 2',1),(99,'Theme 3','ثيم 3',1),(100,'Theme 5','ثيم 5',1),(101,'Theme 6','ثيم 6',1),(102,'Theme 4','ثيم 4',1),(103,'Password','كلمة السر',1),(104,'Profile','البروفايل',1),(105,'Parent Department','القسم الأب',1),(106,'Main Department','القسم الرئيسي',1),(107,'Cancel','إلغاء',1),(108,'Yes','نعم',1),(109,'No','لا',1),(110,'Department Details','تفاصيل ',1),(111,'Quick Search','بحث سريع ',1),(112,'Records','بيانات',1),(113,'Got a total of','مجموع بيانات',1),(114,'to show','للعرض',1),(115,'to','إلى',1),(116,'Activate Checked','تفعيل المختار',1),(117,'Deactivate Checked','عدم تفعيل المختار',1),(118,'Data','البيانات',1),(119,'Type','النوع',1),(120,'Order Data','الترتيب',1),(121,'Operating Menu','قائمة التشغيل',1),(122,'Import Data','إستيراد البيانات',1),(123,'Source','المصدر',1),(124,'Sources','المصادر',1),(125,'Import','استيراد',1),(126,'Search','بحث',1),(127,'Active Gallery Content','تشغيل المحتوى بالصور؟',1),(128,'Orders Module','موديول طلبات ؟',1),(129,'Sort Order','الترتيب',1),(130,'New Department','قسم جديد',1),(131,'Add','إضافة',1),(132,'Details','تفاصيل',1),(133,'Not Active','غير مفعل',1),(134,'Content was created successfully','تم إضافة المحتوى بنجاح',1),(135,'Content was edited successfully','تم تعديل المحتوى بنجاح',1),(136,'Content Settings','خيارات المحتوى',1),(137,'Module settings has been updated','تم تعديل خيارات الموديول بنجاح',1),(138,'Edit Additional Information','تعديل المعلومات الاضافية',1),(139,'Add New Module','اضافة موديول جديد',1),(140,'Main Page','الصفحة الرئيسية',1),(141,'Languages','اللغات',1),(142,'KeyValue','الكي فاليو',1),(143,'Module Options','خيارات الموديول',1),(144,'Edit Module','تعديل الموديول',1),(145,'Add Group','إضافة مجموعة',1),(146,'End Date','تاريخ الانتهاء',1),(147,'Start Date','تاريخ البداية',1),(148,'Thumbnail','صورة مصغرة',1),(149,'Is Video?','الاعلان فيديو',1),(150,'Section','القسم',1),(151,'Inbox','الوارد',1),(152,'Sent','المرسل',1),(153,'Draft','الدرافت',1),(154,'Trash','المهمل',1),(155,'Compose','انشاء',1),(156,'Reply','اضف رد',1),(157,'From','من',1),(158,'To','الي',1),(159,'Messaging System','نظام الرسائل',1),(160,'Create New Notification','اضافة اشعار جديد',1),(161,'New Notification',' اشعار جديد',1),(162,'Settings',' اعدادات',1),(163,'Cancel',' الغاء',1),(164,'Update',' تحديث',1),(165,'Notifications',' الاشعارات',1),(166,'Choose Message','اختر الرسالة',1),(167,'Filter','فلتر',1),(168,'Send Time','موعد الارسال',1),(169,'Age','السن',1),(170,'Choose Notification Type','اختر نوع الاشعار',1),(171,'Choose Topic','اختر الموضوع',1),(172,'User Id','مسلسل المستخدم',1),(173,'File','الملف',1),(174,'Add Department','إضافة قسم',1),(175,'Create New Research','انشاء بحث جديد',1),(176,'Home','الرئيسية',1),(177,'Research Name','اسم البحث',1),(178,'Select Language','اختر اللغة',1),(179,'Researches','البحوث',1),(180,'Number of Replies','عدد الاجابات',1),(181,'Options','الخيارات',1),(182,'Delete Selected','حذف المحدد',1),(183,'Select Question Type','اختر نوع السؤال',1),(184,'Questions','الأسئلة',1),(185,'Previous','السابق',1),(186,'Next','التالي',1),(187,'Finish','انهاء',1),(188,'Add New Question','اضف سؤال آخر',1),(189,'Research Properties','خصائص الاستفتاء',1),(190,'Filter','فلتر',1),(191,'Fixed Questions','الاسئلة الثابتة',1),(192,'Question','السؤال',1),(193,'Question Content','نص السؤال',1),(194,'Minimum','حد أدنى للاجابات',1),(195,'Maximum','حد أقصى للاجابات',1),(196,'Question Content','صيغة السؤال',1),(197,'Charts','الرسم البياني',1),(198,'Chart Type','نوع الرسم البياني',1),(199,'Has Parent Department ?','ينتمي لقسم أب ؟',1),(200,'Age From','السن من',1),(201,'Age To','السن الي',1),(202,'Linear Scale','المقياس الخطي',1),(203,'Multiple Choice Grid','شبكة متعددة الاختيارات',1),(204,'Add new row','اضف صف جديد',1),(205,'Add new col','اضف عمود جديد',1),(206,'Edit Account','تعديل العضوية',1),(207,'Request New Password','ارسال كلمة مرور بديلة',1),(208,'Active Content','محتوى مفعل',1),(209,'Non Active Content','محتوى غير مفعل',1),(210,'Show All','شاهد الكل',1),(211,'Pending Notifications','تنبيهات جديدة',1),(212,'You Have','لديك',1),(213,'Action','إجراء',1),(214,'Choose Question Type','اختر نوع السؤال',1),(215,'Import Data EXCEL','استيراد بيانات اكسيل',1),(216,'Upload File','رفع ملف',1),(218,'Print','طباعة',1),(219,'Export','استخراج ملف',1),(220,'Export Data EXCEL','تصدير البيانات إكسيل',1),(221,'Users','المستخدمين',1),(222,'Export Answers','استخراج ملف الاجابات',1),(223,'Chart Name','عنوان الرسم البياني',1),(224,'Operation','العملية',1),(225,'','',0),(226,'Tanks','خزانات',1),(227,'Tanks','خزانات',1),(228,'My Profile','صفحتي الشخصية',1),(229,'Company Employees','موظفين الشركة',1),(230,'price','Price',2),(231,'price','السعر',1),(232,'old_price','Original Price',2),(233,'old_price','السعر الأصلي',1),(234,'cost','التكلفة',1),(235,'cost','Cost',2),(236,'free_shipping','Free Shipping',2),(237,'free_shipping','شحن مجاني',1),(238,'shipping_fee','تكلفة الشحن',1),(239,'shipping_fee','Shipping Fee',2),(240,'minimum_in_cart','Minimum In Cart',2),(241,'minimum_in_cart','الحد الأدنى في عربة التسوق',1),(242,'maximum_in_cart','الحد الأقصى في عربة التسوق',1),(243,'maximum_in_cart','Maximum In Cart',2),(244,'Product Tags','تاجات المنتجات',1),(245,'Clients Reviews','آراء العملاء',1),(246,'Manufacturers','المصنعين',1),(247,'Categories','التصنيفات',1),(248,'Sales','المبيعات',1),(249,'Products Statistics','إحصائيات المنتجات',1);
/*!40000 ALTER TABLE `cp_system_translation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cp_user_profile`
--

DROP TABLE IF EXISTS `cp_user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cp_user_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `profile_id` int(11) NOT NULL,
  `banned` char(1) NOT NULL DEFAULT 'N',
  `suspended` char(1) NOT NULL DEFAULT 'N',
  `active` char(1) DEFAULT 'Y',
  `mustChangePassword` char(1) DEFAULT NULL,
  `cp_lang` varchar(3) NOT NULL DEFAULT 'ar',
  `scheme_file` varchar(11) NOT NULL DEFAULT 'scheme_6',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cp_user_profile`
--

LOCK TABLES `cp_user_profile` WRITE;
/*!40000 ALTER TABLE `cp_user_profile` DISABLE KEYS */;
INSERT INTO `cp_user_profile` VALUES (1,1,1,'N','N','Y',NULL,'ar','scheme_2');
/*!40000 ALTER TABLE `cp_user_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cp_users`
--

DROP TABLE IF EXISTS `cp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cp_users` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cp_users`
--

LOCK TABLES `cp_users` WRITE;
/*!40000 ALTER TABLE `cp_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `cp_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms`
--

DROP TABLE IF EXISTS `data_cms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `des` varchar(255) DEFAULT NULL,
  `content` text,
  `order` int(10) DEFAULT '100',
  `user_id` int(10) NOT NULL DEFAULT '0',
  `img` varchar(100) DEFAULT NULL,
  `visit_num` int(10) DEFAULT NULL,
  `datetime` varchar(50) NOT NULL,
  `updated_at` varchar(100) DEFAULT NULL,
  `active` int(1) NOT NULL DEFAULT '1',
  `application_id` int(10) NOT NULL,
  `module_id` int(10) NOT NULL,
  `lang_id` int(4) NOT NULL DEFAULT '1',
  `key_1` varchar(250) NOT NULL,
  `key_2` varchar(250) NOT NULL,
  `key_3` varchar(250) NOT NULL,
  `key_4` varchar(250) NOT NULL,
  `key_5` varchar(250) NOT NULL,
  `secured` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms`
--

LOCK TABLES `data_cms` WRITE;
/*!40000 ALTER TABLE `data_cms` DISABLE KEYS */;
INSERT INTO `data_cms` VALUES (2,'من نحن','شركة تجارية تعمل في مجال تجارة مواد البناء مثل الحديد والاسمنت وخزانات المياه و العزل المائي والحراري. تنتج خيارات واسعة من الخزانات وبسعات تصل إلى 100,000 لتر ومن خلال نظام الوحدات المجزأة والتي يمكن تصميمها لتكون فوق الأرض أو مدفونة تحت الأرض  شركة تجار','&lt;p&gt;شركة تجارية تعمل في مجال تجارة مواد البناء مثل الحديد والاسمنت وخزانات المياه و العزل المائي والحراري. تنتج خيارات واسعة من الخزانات وبسعات تصل إلى 100,000 لتر ومن خلال نظام الوحدات المجزأة والتي يمكن تصميمها لتكون فوق الأرض أو مدفونة تحت الأرض&lt;/p&gt;\r\n&lt;p&gt;شركة تجارية تعمل في مجال تجارة مواد البناء مثل الحديد والاسمنت وخزانات المياه و العزل المائي والحراري. تنتج خيارات واسعة من الخزانات وبسعات تصل إلى 100,000 لتر ومن خلال نظام الوحدات المجزأة والتي يمكن تصميمها لتكون فوق الأرض أو مدفونة تحت الأرض&lt;/p&gt;',0,1,'7b9b30dd-0bef-438d-b4c6-4b4a62abc6c5.jpg',0,'1508407237',NULL,1,1,2,1,'1','1','1','1','1',0),(3,'Edit Tested Product','test producttest producttest product','&lt;p&gt;test product content&lt;/p&gt;',0,1,'5d1fcda0-bfaa-488a-ab30-b56add9469f8.jpg',0,'1516637377','1516637377',1,1,8,1,'1','1','1','1','1',0),(4,'Dubai Event','Dubai Event','&lt;p&gt;Event to be held in Dubai&lt;/p&gt;',0,1,'72b43492-5caf-44a2-a8b6-feb346d99d18.png',0,'1508246847',NULL,1,1,1,1,'1','1','1','1','1',0),(5,'KSA Event','KSA Event','&lt;p&gt;Event to be held in KSA&lt;/p&gt;',0,1,'d4b2d703-3f50-4c9d-889b-bfa83a7535cb.png',0,'1508246827',NULL,1,1,1,1,'0','0','0','0','0',0),(6,'Egypt Event','Egypt Event','&lt;p&gt;Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt, Event to be held in Egypt,&amp;nbsp;&lt;/p&gt;',0,1,'ac282713-08c6-4c5f-b169-c422b98c9231.jpg',0,'1508246959',NULL,1,1,1,1,'0','0','0','0','0',0),(7,'Test porchure 1','Test porchure 1','&lt;p&gt;Test porchure 1&amp;nbsp;Test porchure 1&amp;nbsp;Test porchure 1&amp;nbsp;Test porchure 1&lt;/p&gt;',0,1,'0538ec22-cd32-405d-aa03-d26af65bae26.png',0,'1508247247',NULL,1,1,5,1,'1','1','1','1','1',0),(8,'Test porchure 2','Test porchure 2',NULL,0,1,'82de7031-2ec0-4822-9ff3-826a9d94b5fa.jpg',0,'1509551201','1509551201',1,1,5,1,'1','1','1','1','1',0),(9,'اعتمادات المصنع','اعتمادات المصنع','&lt;h4&gt;اعتمادات المصنع اعتمادات المصنع اعتمادات المصنع&lt;/h4&gt;',0,1,'650938d3-7fe7-4aee-94d3-44c89d264695.jpg',0,'1508421357',NULL,1,1,4,1,'1','1','1','1','1',0),(10,'خزانات المياه','خزانات المياه','&lt;h4&gt;خزانات المياه خزانات المياه خزانات المياه&lt;/h4&gt;',0,1,'ed6361b9-e00f-4a18-9415-0b4397128cec.jpg',0,'1508403130',NULL,1,1,4,1,'1','1','1','1','1',0),(11,'اعتمادات خزانات المياه','اعتمادات خزانات المياه','&lt;h4&gt;اعتمادات خزانات المياه اعتمادات خزانات المياه اعتمادات خزانات المياه&lt;/h4&gt;',0,1,'ce25a430-a70d-4991-803d-e8912b639422.jpg',0,'1508403139',NULL,1,1,4,1,'1','1','1','1','1',0),(12,'خزانات الدفان','خزانات الدفان','&lt;h4&gt;خزانات الدفان خزانات الدفان خزانات الدفان&lt;/h4&gt;',0,1,'518227d0-9f80-4307-b435-ba6bc06e3daf.jpg',0,'1508403152',NULL,1,1,4,1,'1','1','1','1','1',0),(13,'اعتمادات خزانات الدفان','اعتمادات خزانات الدفان','&lt;h4&gt;اعتمادات خزانات الدفان اعتمادات خزانات الدفان اعتمادات خزانات الدفان&lt;/h4&gt;',0,1,'4a015e7e-7f85-4b61-9706-dbc747f1eccb.jpg',0,'1508413416',NULL,1,1,4,1,'1','1','1','1','1',0),(14,'Water Tanks Factory','Water Tanks Factory Water Tanks Factory','&lt;div class=\\&quot;\\\\&amp;quot;row\\\\&amp;quot;\\&quot;&gt;\r\n&lt;div class=\\&quot;\\\\&amp;quot;col-md-12\\\\&amp;quot;\\&quot;&gt;\r\n&lt;div class=\\&quot;\\\\&amp;quot;\\&quot;&gt;\r\n&lt;ul&gt;\r\n&lt;li&gt;Horizontal and vertical tanks up to 32000 vertical capacity&lt;/li&gt;\r\n&lt;li&gt;Chemical tanks up to 32000 vertical capacity&lt;/li&gt;\r\n&lt;li&gt;Under-ground modular tanks (5000 liters in multiple connection)&lt;/li&gt;\r\n&lt;li&gt;Special products - road barrier, road cone, water buoys, train tank&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;div class=\\&quot;\\\\&amp;quot;col-md-12\\\\&amp;quot;\\&quot;&gt;\r\n&lt;div class=\\&quot;\\\\&amp;quot;\\&quot;&gt;\r\n&lt;h5 class=\\&quot;\\\\&amp;quot;product-title\\&quot;&gt;&amp;nbsp;&lt;/h5&gt;\r\n&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;/div&gt;',0,1,'c8f5e3df-01f1-4fef-81b7-dd0b4abfde0c.jpg',0,'1508407765',NULL,1,1,3,1,'1','1','1','1','1',0),(19,'ِAuto Door Factory','Auto Door Factory','&lt;ul style=\\&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: #444444; font-family: \\\'Helvetica Neue W23 for SKY Reg\\\';\\&quot;&gt;\r\n&lt;li style=\\&quot;box-sizing: border-box;\\&quot;&gt;Roll up door assembly&lt;/li&gt;\r\n&lt;li style=\\&quot;box-sizing: border-box;\\&quot;&gt;Section door assembly&lt;/li&gt;\r\n&lt;/ul&gt;',0,1,'61242f81-ca8e-450d-bc1f-5b9b634c5b3f.jpg',0,'1508407846',NULL,1,1,3,1,'0','0','0','0','0',0),(20,'Manhole Cover Factory','Manhole Cover Factory','&lt;ul style=\\&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: #444444; font-family: \\\'Helvetica Neue W23 for SKY Reg\\\';\\&quot;&gt;\r\n&lt;li style=\\&quot;box-sizing: border-box;\\&quot;&gt;Class A type specification&lt;/li&gt;\r\n&lt;/ul&gt;',0,1,'02d59331-17ec-4c03-842a-b26eb7fe1603.jpg',0,'1508407890',NULL,1,1,3,1,'0','0','0','0','0',0),(21,'Injection Moulding Plant','Injection Moulding Plant','&lt;ul style=\\&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: #444444; font-family: \\\'Helvetica Neue W23 for SKY Reg\\\';\\&quot;&gt;\r\n&lt;li style=\\&quot;box-sizing: border-box;\\&quot;&gt;AC tray&lt;/li&gt;\r\n&lt;li style=\\&quot;box-sizing: border-box;\\&quot;&gt;Tank covers&lt;/li&gt;\r\n&lt;li style=\\&quot;box-sizing: border-box;\\&quot;&gt;Tank accessories (fitting of 1 ~ 3 inches in ABS)&lt;/li&gt;\r\n&lt;/ul&gt;',0,1,'b3d6a1a1-f833-4054-9343-06ff2c08af76.jpg',0,'1508407933',NULL,1,1,3,1,'0','0','0','0','0',0),(22,'PRODUCTION CAPACITY','PRODUCTION CAPACITY','&lt;div class=\\&quot;clearfix\\&quot; style=\\&quot;box-sizing: border-box; direction: rtl; color: #444444; font-family: \\\'Helvetica Neue W23 for SKY Reg\\\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial;\\&quot;&gt;&amp;nbsp;&lt;/div&gt;\r\n&lt;ul style=\\&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: #444444; font-family: \\\'Helvetica Neue W23 for SKY Reg\\\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial;\\&quot;&gt;\r\n&lt;li style=\\&quot;box-sizing: border-box;\\&quot;&gt;1.9 Million liters / Day (Maximum Plant Production Capacity)&lt;/li&gt;\r\n&lt;li style=\\&quot;box-sizing: border-box;\\&quot;&gt;437.866 Million liters annually (Planned for year 2014)&lt;/li&gt;\r\n&lt;/ul&gt;',0,1,'bf06c86c-04d3-48e9-8e49-55e0275c2d9a.jpg',0,'1508408222',NULL,1,1,3,1,'0','0','0','0','0',0),(24,'QUALITY STANDARDS &amp;amp;amp; REFERENCES','QUALITY STANDARDS &amp;amp;amp; REFERENCES','&lt;ul&gt;\r\n&lt;li&gt;ASTM Standards D 1998 - 06 (Standard Specification for PE Upright Storage Tanks)&lt;/li&gt;\r\n&lt;li&gt;IS 12701 : 1996 (Indian Standard Rotational Moulded PE Water Storage Tanks - Specification)&lt;/li&gt;\r\n&lt;li&gt;GCC (GS)) GSO 1831 / 2007 (Rotational molded PE Water Storage Tanks)&lt;/li&gt;\r\n&lt;li&gt;CPPA Standards 1996 (ASSHTO) (Corrugated PE pipe Association)&lt;/li&gt;\r\n&lt;li&gt;BS EN 124 : 1996 (Manhole cover Specifications)&lt;/li&gt;\r\n&lt;li&gt;ISO 9001 : 2008 Quality Management System&lt;/li&gt;\r\n&lt;li&gt;ISO 9001 : 2008 Safety Procedures - Clause 6.0&lt;/li&gt;\r\n&lt;/ul&gt;',0,1,'3c52a0b3-e478-429b-a023-1ea17cdeb63a.jpg',0,'1508408821',NULL,1,1,3,1,'1','1','1','1','1',0),(27,'المصنع','المصنعالمصنعالمصنعالمصنع',NULL,0,1,NULL,0,'1509535003','1509535003',1,1,4,1,'1','1','1','1','1',0),(28,'Vertical Tanks','Vertical Tanks Vertical Tanks Vertical Tanks','&lt;p&gt;&lt;span class=\\&quot;\\\\&amp;quot;\\\\\\\\&amp;quot;\\\\\\\\\\\\\\\\&amp;quot;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\&amp;quot;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\&amp;quot;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\&amp;quot;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\&amp;quot;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\&amp;quot;col-xs-12\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\&amp;quot;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\&amp;quot;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\&amp;quot;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\&amp;quot;\\\\\\\\\\\\\\\\&amp;quot;\\\\\\\\&amp;quot;\\\\&amp;quot;\\&quot;&gt;طريقة التصنيع&lt;/span&gt;&lt;/p&gt;\r\n&lt;p&gt;تستخدم خزانات مياه أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى&lt;/p&gt;',0,1,'5b336b17-51ec-41d8-8e90-6e943c02056b.png',0,'1509359855',NULL,1,1,8,1,'1','1','1','1','1',0),(30,'بروشور الزامل','PDF File',NULL,0,1,NULL,0,'1509551185','1509551185',1,1,5,1,'1','1','1','1','1',0),(31,'page to display data','description for the new page','&lt;p class=\\&quot;MsoNormal\\&quot; dir=\\&quot;rtl\\&quot; style=\\&quot;font-family: \\\'Times New Roman\\\'; font-size: medium; text-align: justify; direction: rtl; unicode-bidi: embed; text-indent: 25px; margin-left: 20px; margin-right: 20px;\\&quot;&gt;&lt;span style=\\&quot;color: #800080;\\&quot;&gt;&lt;span lang=\\&quot;AR-MA\\&quot;&gt;= إ&lt;u&gt;شكال النص&lt;/u&gt;&amp;nbsp;: ماهي الخصائص والشروط التي يجب أن تتوفر في العالم التجريبي ؟ وإلى أي حد يمكن الإحاطة بها كشرط لبلوغ العلمية ؟&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p class=\\&quot;MsoNormal\\&quot; dir=\\&quot;rtl\\&quot; style=\\&quot;font-family: \\\'Times New Roman\\\'; font-size: medium; text-align: justify; direction: rtl; unicode-bidi: embed; text-indent: 25px; margin-left: 20px; margin-right: 20px;\\&quot;&gt;&lt;span style=\\&quot;color: #800080;\\&quot;&gt;&lt;span lang=\\&quot;AR-MA\\&quot;&gt;=&amp;nbsp;&lt;u&gt;مفاهيم النص&lt;/u&gt;&amp;nbsp;:&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p class=\\&quot;MsoNormal\\&quot; dir=\\&quot;rtl\\&quot; style=\\&quot;font-family: \\\'Times New Roman\\\'; font-size: medium; text-align: justify; direction: rtl; unicode-bidi: embed; text-indent: 25px; margin-left: 20px; margin-right: 20px;\\&quot;&gt;&lt;span style=\\&quot;color: #800080;\\&quot;&gt;&lt;span lang=\\&quot;AR-MA\\&quot;&gt;المنهج التجريبي :&amp;nbsp; هو المنهج الذي يعتمد في دراسته للظواهر على الاستقراء والتحليل، والتركيب والتجريب، ويتميز بحرصه الشديد بالبحث عن العلاقات الثابتة بين الظواهر، ويعد فرانسيس بيكون وغاليلي ...أول من أحدث قطيعة إبستيمولوجية مع المنهج التأملي القديم الذي لا يستوفي شروط العلمية، وبين هذا المنهج الذي يتميز بالجدة والبحث في قوانين الطبيعة.&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p class=\\&quot;MsoNormal\\&quot; dir=\\&quot;rtl\\&quot; style=\\&quot;font-family: \\\'Times New Roman\\\'; font-size: medium; text-align: justify; direction: rtl; unicode-bidi: embed; text-indent: 25px; margin-left: 20px; margin-right: 20px;\\&quot;&gt;&lt;span style=\\&quot;color: #800080;\\&quot;&gt;&lt;span lang=\\&quot;AR-MA\\&quot;&gt;الحقيقة العلمية : &amp;nbsp;&amp;nbsp;&amp;nbsp; تتحدد في ضوء الاختلاف مع الرأي، وكون هذا الأخير ينبني على الحكم المشترك والمسبب وهو غير خاضع لبناء منهجي .&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p class=\\&quot;MsoNormal\\&quot; dir=\\&quot;rtl\\&quot; style=\\&quot;font-family: \\\'Times New Roman\\\'; font-size: medium; text-align: justify; direction: rtl; unicode-bidi: embed; text-indent: 25px; margin-left: 20px; margin-right: 20px;\\&quot;&gt;&lt;span style=\\&quot;color: #800080;\\&quot;&gt;&lt;span lang=\\&quot;AR-MA\\&quot;&gt;= ا&lt;u&gt;لأطروحة&lt;/u&gt;&amp;nbsp;: يبرز صاحب النص جملة من الشروط التي ينبغي توفرها في العالم التجريبي والتي يعتبرها ضرورية لبلوغ المعرفة العلمية، كما يميز بين الملاحظ والمجرب على المستويين النظري والعلمي، فعلى المستوى النظري نجد أن الملاحظ حسب \\&quot;برنار\\&quot; لا يستدل لكونه يفتقد للوقائع عكس المجرب.&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p class=\\&quot;MsoNormal\\&quot; dir=\\&quot;rtl\\&quot; style=\\&quot;font-family: \\\'Times New Roman\\\'; font-size: medium; text-align: justify; direction: rtl; unicode-bidi: embed; text-indent: 25px; margin-left: 20px; margin-right: 20px;\\&quot;&gt;&lt;span style=\\&quot;color: #800080;\\&quot;&gt;&lt;span lang=\\&quot;AR-MA\\&quot;&gt;أما على المستوى العلمي لا يمكن التفريق بينهما لأنه يشترط في الباحث أن يكون ملاحظا ومجربا في أن واحد .&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p class=\\&quot;MsoNormal\\&quot; dir=\\&quot;rtl\\&quot; style=\\&quot;font-family: \\\'Times New Roman\\\'; font-size: medium; text-align: justify; direction: rtl; unicode-bidi: embed; text-indent: 25px; margin-left: 20px; margin-right: 20px;\\&quot;&gt;&lt;span style=\\&quot;color: #800080;\\&quot;&gt;&lt;span lang=\\&quot;AR-MA\\&quot;&gt;= ا&lt;u&gt;لأفكار الأساسية&lt;/u&gt;&amp;nbsp;: يبرز صاحب في الفقرة الأولى أهم الشروط التي يجب توفرها في الباحث للتوصل إلى الحقيقة العلمية، وأهم هذه الشروط :&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p class=\\&quot;MsoNormal\\&quot; dir=\\&quot;rtl\\&quot; style=\\&quot;font-family: \\\'Times New Roman\\\'; font-size: medium; text-align: justify; text-indent: 25px; direction: rtl; unicode-bidi: embed; margin-left: 20px; margin-right: 20px;\\&quot;&gt;&lt;span style=\\&quot;color: #800080;\\&quot;&gt;-&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;span dir=\\&quot;RTL\\&quot; lang=\\&quot;AR-MA\\&quot;&gt;أن يخضع فكرته للفحص في ضوء الوقائع .&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p class=\\&quot;MsoNormal\\&quot; dir=\\&quot;rtl\\&quot; style=\\&quot;font-family: \\\'Times New Roman\\\'; font-size: medium; text-align: justify; text-indent: 25px; direction: rtl; unicode-bidi: embed; margin-left: 20px; margin-right: 20px;\\&quot;&gt;&lt;span style=\\&quot;color: #800080;\\&quot;&gt;-&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;span dir=\\&quot;RTL\\&quot; lang=\\&quot;AR-MA\\&quot;&gt;أن يكون ملاحظا ومجربا في آن واحد، ومدركا للظواهر المدروسة في شموليتها.&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p class=\\&quot;MsoNormal\\&quot; dir=\\&quot;rtl\\&quot; style=\\&quot;font-family: \\\'Times New Roman\\\'; font-size: medium; text-align: justify; direction: rtl; unicode-bidi: embed; text-indent: 25px; margin-left: 20px; margin-right: 20px;\\&quot;&gt;&lt;span style=\\&quot;color: #800080;\\&quot;&gt;&lt;span lang=\\&quot;AR-MA\\&quot;&gt;في الفقرة الثانية يؤكد على خاصية الجمع بين الفكر النظري والممارسة التجريبية .&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p class=\\&quot;MsoNormal\\&quot; dir=\\&quot;rtl\\&quot; style=\\&quot;font-family: \\\'Times New Roman\\\'; font-size: medium; text-align: justify; direction: rtl; unicode-bidi: embed; text-indent: 25px; margin-left: 20px; margin-right: 20px;\\&quot;&gt;&lt;span style=\\&quot;color: #800080;\\&quot;&gt;&lt;span lang=\\&quot;AR-MA\\&quot;&gt;+&amp;nbsp;&lt;u&gt;الحجاج&lt;/u&gt;&amp;nbsp;: يؤكد صاحب النص على أطروحة باعتماد حجاج التوكيد :&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p class=\\&quot;MsoNormal\\&quot; dir=\\&quot;rtl\\&quot; style=\\&quot;font-family: \\\'Times New Roman\\\'; font-size: medium; text-align: justify; text-indent: 25px; direction: rtl; unicode-bidi: embed; margin-left: 20px; margin-right: 20px;\\&quot;&gt;&lt;span style=\\&quot;color: #800080;\\&quot;&gt;-&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;span dir=\\&quot;RTL\\&quot; lang=\\&quot;AR-MA\\&quot;&gt;يجب على العالم أن يلاحظ بدون فكرة مسبقة .&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;',0,1,'8424f2a4-7ee1-4b29-b57b-ecaca179f54b.jpg',0,'1509459620',NULL,1,1,2,1,'0','0','0','0','0',0),(32,'Polyorthane','lining and joint sealant technology and can be used for a wide variaty of applications','&lt;p&gt;Polyurethane system and protection layer&lt;br /&gt;The advantage of using the Polyurethane system and the protection layer (water and thermal insulation system together) :&lt;/p&gt;\r\n&lt;ul&gt;\r\n&lt;li&gt;The ability to be executed on all the surface types ( metal &amp;ndash; wood &amp;ndash; concrete)&lt;/li&gt;\r\n&lt;li&gt;Light weight , the weight of the substance at density of 45kg/m2 and the thickness 4cm2 kg/ m2&lt;/li&gt;\r\n&lt;li&gt;The lease substances which link the heat 20 watt/ m2 kelvin m2&lt;/li&gt;\r\n&lt;li&gt;Complete resistant to the water , salty water and the alive creatures&lt;/li&gt;\r\n&lt;li&gt;Is not affected by the bugs , fungi , and does not cause smells and against corrosion&lt;/li&gt;\r\n&lt;li&gt;Very high resistance to changing weather , winds, rain and can get rid of the tiles and the reclamation above&lt;/li&gt;\r\n&lt;li&gt;No existence of any cords on the roof because it consists of interdependent and gathered layres with each other because of the cumulative spreading .&lt;/li&gt;\r\n&lt;li&gt;The fast execution to execute at two levels only which can be one of the fastest water and thermal insulation systems for the surfaces to execute and cost and the least to prevent other articles .&lt;/li&gt;\r\n&lt;/ul&gt;',0,1,'ddb21b06-d4e2-4e77-976c-9a141b66f5a3.jpeg',0,'1509629926','1509629926',1,1,11,1,'1','1','1','1','1',0),(33,'Polyparthane','lining and joint sealant technology and can be used for a wide variaty of applications','&lt;p&gt;Polyurethane system and protection layer&lt;br /&gt;The advantage of using the Polyurethane system and the protection layer (water and thermal insulation system together) :&lt;/p&gt;\r\n&lt;ul&gt;\r\n&lt;li&gt;The ability to be executed on all the surface types ( metal &amp;ndash; wood &amp;ndash; concrete)&lt;/li&gt;\r\n&lt;li&gt;Light weight , the weight of the substance at density of 45kg/m2 and the thickness 4cm2 kg/ m2&lt;/li&gt;\r\n&lt;li&gt;The lease substances which link the heat 20 watt/ m2 kelvin m2&lt;/li&gt;\r\n&lt;li&gt;Complete resistant to the water , salty water and the alive creatures&lt;/li&gt;\r\n&lt;li&gt;Is not affected by the bugs , fungi , and does not cause smells and against corrosion&lt;/li&gt;\r\n&lt;li&gt;Very high resistance to changing weather , winds, rain and can get rid of the tiles and the reclamation above&lt;/li&gt;\r\n&lt;li&gt;No existence of any cords on the roof because it consists of interdependent and gathered layres with each other because of the cumulative spreading .&lt;/li&gt;\r\n&lt;li&gt;The fast execution to execute at two levels only which can be one of the fastest water and thermal insulation systems for the surfaces to execute and cost and the least to prevent other articles .&lt;/li&gt;\r\n&lt;/ul&gt;',0,1,'ddb21b06-d4e2-4e77-976c-9a141b66f5a3.jpeg',0,'1509629861','1509629861',1,1,11,1,'1','1','1','1','1',0),(34,'Cementus','lining and joint sealant technology and can be used for a wide variaty of applications','&lt;p&gt;Polyurethane system and protection layer&lt;br /&gt;The advantage of using the Polyurethane system and the protection layer (water and thermal insulation system together) :&lt;/p&gt;\r\n&lt;ul&gt;\r\n&lt;li&gt;The ability to be executed on all the surface types ( metal &amp;ndash; wood &amp;ndash; concrete)&lt;/li&gt;\r\n&lt;li&gt;Light weight , the weight of the substance at density of 45kg/m2 and the thickness 4cm2 kg/ m2&lt;/li&gt;\r\n&lt;li&gt;The lease substances which link the heat 20 watt/ m2 kelvin m2&lt;/li&gt;\r\n&lt;li&gt;Complete resistant to the water , salty water and the alive creatures&lt;/li&gt;\r\n&lt;li&gt;Is not affected by the bugs , fungi , and does not cause smells and against corrosion&lt;/li&gt;\r\n&lt;li&gt;Very high resistance to changing weather , winds, rain and can get rid of the tiles and the reclamation above&lt;/li&gt;\r\n&lt;li&gt;No existence of any cords on the roof because it consists of interdependent and gathered layres with each other because of the cumulative spreading .&lt;/li&gt;\r\n&lt;li&gt;The fast execution to execute at two levels only which can be one of the fastest water and thermal insulation systems for the surfaces to execute and cost and the least to prevent other articles .&lt;/li&gt;\r\n&lt;/ul&gt;',0,1,'ddb21b06-d4e2-4e77-976c-9a141b66f5a3.jpeg',0,'1509629749','1509629749',1,1,11,1,'1','1','1','1','1',0),(35,'Aclyric','lining and joint sealant technology and can be used for a wide variaty of applications','&lt;p&gt;Polyurethane system and protection layer&lt;br /&gt;The advantage of using the Polyurethane system and the protection layer (water and thermal insulation system together) :&lt;/p&gt;\r\n&lt;ul&gt;\r\n&lt;li&gt;The ability to be executed on all the surface types ( metal &amp;ndash; wood &amp;ndash; concrete)&lt;/li&gt;\r\n&lt;li&gt;Light weight , the weight of the substance at density of 45kg/m2 and the thickness 4cm2 kg/ m2&lt;/li&gt;\r\n&lt;li&gt;The lease substances which link the heat 20 watt/ m2 kelvin m2&lt;/li&gt;\r\n&lt;li&gt;Complete resistant to the water , salty water and the alive creatures&lt;/li&gt;\r\n&lt;li&gt;Is not affected by the bugs , fungi , and does not cause smells and against corrosion&lt;/li&gt;\r\n&lt;li&gt;Very high resistance to changing weather , winds, rain and can get rid of the tiles and the reclamation above&lt;/li&gt;\r\n&lt;li&gt;No existence of any cords on the roof because it consists of interdependent and gathered layres with each other because of the cumulative spreading .&lt;/li&gt;\r\n&lt;li&gt;The fast execution to execute at two levels only which can be one of the fastest water and thermal insulation systems for the surfaces to execute and cost and the least to prevent other articles .&lt;/li&gt;\r\n&lt;/ul&gt;',0,1,'ddb21b06-d4e2-4e77-976c-9a141b66f5a3.jpeg',0,'1509629690','1509629690',1,1,11,1,'1','1','1','1','1',0),(36,'Tank with no pressure valve','Al Arabia water tanks factory uses the latest methods of global technology in this field, by Advanced Design in Roto-molding technique for producing water tanks in one piece without any joints for more strength and durability.','&lt;p style=\\&quot;box-sizing: border-box; margin: 0px 0px 10px; color: #444444; font-family: \\\'Helvetica Neue\\\', Helvetica, Arial, sans-serif;\\&quot;&gt;With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.&lt;/p&gt;\r\n&lt;p style=\\&quot;box-sizing: border-box; margin: 0px 0px 10px; text-align: right; direction: rtl; color: #444444; font-family: \\\'Helvetica Neue W23 for SKY Reg\\\';\\&quot;&gt;&lt;span class=\\&quot;col-xs-12 no-padding\\&quot; style=\\&quot;box-sizing: border-box; font-weight: bold; float: left; position: relative; min-height: 1px; padding-left: 0px; padding-right: 0px; width: 1110px; font-family: \\\'Helvetica Neue\\\', Helvetica, Arial, sans-serif; text-align: start;\\&quot;&gt;Manufacturing&lt;/span&gt;&lt;/p&gt;\r\n&lt;p style=\\&quot;box-sizing: border-box; margin: 0px 0px 10px; color: #444444; font-family: \\\'Helvetica Neue\\\', Helvetica, Arial, sans-serif;\\&quot;&gt;Al Arabia water tanks factory uses the latest methods of global technology in this field, by Advanced Design in Roto-molding technique for producing water tanks in one piece without any joints for more strength and durability.&lt;/p&gt;',0,1,'77c7b85c-9dc8-4072-bd79-67abddd2c80c.jpg',0,'1509531987',NULL,1,1,8,1,'0','0','0','0','0',0),(37,'arabia water tanks','With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specification','&lt;div id=\\&quot;overview\\&quot; class=\\&quot;tab-pane fade in active col-xs-12\\&quot; style=\\&quot;box-sizing: border-box; float: left; position: relative; min-height: 1px; padding-left: 15px; padding-right: 15px; width: 1140px; opacity: 1; transition: opacity 0.15s linear; color: #444444; font-family: \\\'Helvetica Neue\\\', Helvetica, Arial, sans-serif;\\&quot;&gt;\r\n&lt;p style=\\&quot;box-sizing: border-box; margin: 0px 0px 10px;\\&quot;&gt;With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.&lt;/p&gt;\r\n&lt;span class=\\&quot;col-xs-12 no-padding\\&quot; style=\\&quot;box-sizing: border-box; font-weight: bold; float: left; position: relative; min-height: 1px; padding-left: 0px; padding-right: 0px; width: 1110px;\\&quot;&gt;Manufacturing&lt;/span&gt;\r\n&lt;p style=\\&quot;box-sizing: border-box; margin: 0px 0px 10px;\\&quot;&gt;Al Arabia water tanks factory uses the latest methods of global technology in this field, by Advanced Design in Roto-molding technique for producing water tanks in one piece without any joints for more strength and durability.&lt;/p&gt;\r\n&lt;div id=\\&quot;overview\\&quot; class=\\&quot;tab-pane fade in active col-xs-12\\&quot; style=\\&quot;box-sizing: border-box; float: left; position: relative; min-height: 1px; padding-left: 15px; padding-right: 15px; width: 1140px; opacity: 1; transition: opacity 0.15s linear;\\&quot;&gt;\r\n&lt;p style=\\&quot;box-sizing: border-box; margin: 0px 0px 10px;\\&quot;&gt;With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.&lt;/p&gt;\r\n&lt;span class=\\&quot;col-xs-12 no-padding\\&quot; style=\\&quot;box-sizing: border-box; font-weight: bold; float: left; position: relative; min-height: 1px; padding-left: 0px; padding-right: 0px; width: 1110px;\\&quot;&gt;Manufacturing&lt;/span&gt;\r\n&lt;p style=\\&quot;box-sizing: border-box; margin: 0px 0px 10px;\\&quot;&gt;Al Arabia water tanks factory uses the latest methods of global technology in this field, by Advanced Design in Roto-molding technique for producing water tanks in one piece without any joints for more strength and durability.&lt;/p&gt;\r\n&lt;p&gt;&amp;nbsp;&lt;/p&gt;\r\n&lt;/div&gt;\r\n&lt;/div&gt;',0,1,'a60b6549-76ff-4283-8765-40857dfea366.png',0,'1509532499',NULL,1,1,8,1,'0','0','0','0','0',0),(38,'Polyethylene','erial from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.','&lt;p&gt;&lt;span class=\\&quot;\\\\&amp;quot;col-xs-12\\&quot;&gt;Polyethylene&lt;/span&gt;&lt;/p&gt;\r\n&lt;p&gt;With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.&lt;/p&gt;\r\n&lt;p&gt;&lt;span class=\\&quot;\\\\&amp;quot;col-xs-12\\&quot;&gt;Manufacturing&lt;/span&gt;&lt;/p&gt;\r\n&lt;p&gt;Al Arabia water tanks factory uses the latest methods of global technology in this field, by Advanced Design in Roto-molding technique for producing water tanks in one piece without any joints for more strength and durability.&lt;/p&gt;',0,1,'13a56b79-f7cd-4145-8171-9207afd7eed8.jpg',0,'1509538961','1509538961',1,1,8,1,'1','1','1','1','1',0),(39,'chemicals and range of salt addiditives.  Manufacturing','Al Arabia water tanks factory uses the latest methods of global technology in this field, by Advanced Design in Roto-molding','&lt;p&gt;&lt;span class=\\&quot;\\\\&amp;quot;col-xs-12\\&quot;&gt;Polyethylene&lt;/span&gt;&lt;/p&gt;\r\n&lt;p&gt;With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.&lt;/p&gt;\r\n&lt;p&gt;&lt;span class=\\&quot;\\\\&amp;quot;col-xs-12\\&quot;&gt;Ma&lt;/span&gt;&lt;span class=\\&quot;\\\\&amp;quot;col-xs-12\\&quot;&gt;nufacturingAl Arabia water tanks factory uses the latest methods of global technology in this field, by Advanced Design in Roto-molding technique for producing water tanks in one piece without any joints for more strength and durability.&lt;/span&gt;&lt;/p&gt;',0,1,'579f75b8-bad8-4ba2-8c87-e4fb03e8110a.jpg',0,'1509538952','1509538952',1,1,8,1,'1','1','1','1','1',0),(40,'ed by the highest international quality specificati','ed by the highest international quality specificati','&lt;p&gt;&lt;span class=\\&quot;\\\\&amp;quot;col-xs-12\\&quot;&gt;&lt;span class=\\&quot;\\\\&amp;quot;col-xs-12\\&quot;&gt;Polyethylene&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p&gt;With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.&lt;/p&gt;\r\n&lt;p&gt;&lt;span class=\\&quot;\\\\&amp;quot;col-xs-12\\&quot;&gt;&lt;span class=\\&quot;\\\\&amp;quot;col-xs-12\\&quot;&gt;Manufacturing&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p&gt;Al Arabia water tanks factory uses the latest methods of global technology in this field, by Advanced Design in Roto-molding technique for producing water tanks in one piece without any joints for more strength and durability.&lt;/p&gt;',0,1,'066f044f-e2ce-4061-bd82-890459097dcb.jpg',0,'1509538941','1509538941',1,1,8,1,'1','1','1','1','1',0),(41,'latest methods of global','tory uses the latest methods of global technology in this fie','&lt;p&gt;&lt;span class=\\\\\\&quot;col-xs-12 no-padding\\\\\\&quot; style=\\\\\\&quot;box-sizing: border-box; font-weight: bold; float: right; text-align: right; direction: rtl; position: relative; min-height: 1px; padding-right: 0px; padding-left: 0px; width: 1110px; color: #444444; font-family: \\\\\\\'Helvetica Neue W23 for SKY Reg\\\\\\\';\\\\\\&quot;&gt;&lt;span class=\\\\\\&quot;col-xs-12 no-padding\\\\\\&quot; style=\\\\\\&quot;box-sizing: border-box; float: left; position: relative; min-height: 1px; padding-left: 0px; padding-right: 0px; width: 1110px; font-family: \\\\\\\'Helvetica Neue\\\\\\\', Helvetica, Arial, sans-serif; text-align: start;\\\\\\&quot;&gt;Polyethylene&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p style=\\\\\\&quot;box-sizing: border-box; margin: 0px 0px 10px; color: #444444; font-family: \\\\\\\'Helvetica Neue\\\\\\\', Helvetica, Arial, sans-serif;\\\\\\&quot;&gt;With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.&lt;/p&gt;\r\n&lt;p&gt;&lt;span class=\\\\\\&quot;col-xs-12 no-padding\\\\\\&quot; style=\\\\\\&quot;box-sizing: border-box; font-weight: bold; float: right; text-align: right; direction: rtl; position: relative; min-height: 1px; padding-right: 0px; padding-left: 0px; width: 1110px; color: #444444; font-family: \\\\\\\'Helvetica Neue W23 for SKY Reg\\\\\\\';\\\\\\&quot;&gt;&lt;span class=\\\\\\&quot;col-xs-12 no-padding\\\\\\&quot; style=\\\\\\&quot;box-sizing: border-box; float: left; position: relative; min-height: 1px; padding-left: 0px; padding-right: 0px; width: 1110px; font-family: \\\\\\\'Helvetica Neue\\\\\\\', Helvetica, Arial, sans-serif; text-align: start;\\\\\\&quot;&gt;Manufacturing&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p style=\\\\\\&quot;box-sizing: border-box; margin: 0px 0px 10px; color: #444444; font-family: \\\\\\\'Helvetica Neue\\\\\\\', Helvetica, Arial, sans-serif;\\\\\\&quot;&gt;Al Arabia water tanks factory uses the latest methods of global technology in this field, by Advanced Design in Roto-molding technique for producing water tanks in one piece without any joints for more strength and durability.&lt;/p&gt;',0,1,'474eb005-406c-4353-9f9d-9c3ce54a4711.jpg',0,'1509538932','1509538932',1,1,8,1,'1','1','1','1','1',0),(42,'Al Arabia water tanks factory uses the latest methods of global technology in this field, by','Al Arabia water tanks factory uses the latest methods of global technology in this field, by','&lt;p&gt;&lt;span class=\\&quot;\\\\&amp;quot;\\\\\\\\&amp;quot;col-xs-12\\\\&amp;quot;\\&quot;&gt;Polyethylene&lt;/span&gt;&lt;/p&gt;\r\n&lt;p&gt;With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.&lt;/p&gt;\r\n&lt;p&gt;&lt;span class=\\&quot;\\\\&amp;quot;\\\\\\\\&amp;quot;col-xs-12\\\\&amp;quot;\\&quot;&gt;Manufacturing&lt;/span&gt;&lt;/p&gt;\r\n&lt;p&gt;Al Arabia water tanks factory uses the latest methods of global technology in this field, by Advanced Design in Roto-molding technique for producing water tanks in one piece without any joints for more strength and durability.&lt;/p&gt;',0,1,'b3664358-fea3-4616-9be3-8b6fa2a38dc6.png',0,'1509539000','1509539000',1,1,8,1,'1','1','1','1','1',0),(43,'بروفايل','بروفايل',NULL,0,1,NULL,0,'1509635700','1509635700',1,1,4,1,'1','1','1','1','1',0),(44,'Arabia Water Tanks is a building material trading company specialized mainly in steel, cement,water tanks and water &amp;amp; heat insulation, We produce water tanks with capacities exceeding 100,000 liters utilizing unique modular design with above and u',NULL,'&lt;p&gt;Arabia Water Tanks is a building material trading company specialized mainly in steel, cement,water tanks and water &amp;amp; heat insulation, We produce water tanks with capacities exceeding 100,000 liters utilizing unique modular design with above and underground models&lt;/p&gt;',0,1,'9610ffd9-3dc8-42f2-8f9d-e9118a9df4ef.png',0,'1509631986','1509631986',1,1,7,1,'1','1','1','1','1',0),(49,'التست','تستينج',NULL,6,1,NULL,0,'1509635839',NULL,1,1,4,1,'0','0','0','0','0',0),(50,'your test','that is your test','',0,1,'fe443033-0379-4ee5-9633-fbb6132cbb9a.png',0,'1509636137',NULL,1,1,6,1,'0','0','0','0','0',0),(51,'testing','a page for testing','&lt;p&gt;test for testing&lt;/p&gt;',0,1,'afbb95a4-9c50-42bf-9a25-c1de2239d38d.jpg',0,'1512295438',NULL,1,1,2,1,'0','0','0','0','0',0),(52,'تست حدث',NULL,'&lt;p&gt;a good test for testing&lt;/p&gt;',0,1,'2e63c1c1-fb90-47db-8933-14e47d816224.jpg',0,'1512305739',NULL,1,1,1,1,'0','0','0','0','0',0),(53,'Tank Test 01','Tank Test 01','&lt;p&gt;Tank Test 01&lt;/p&gt;',0,1,'40467a10-f4bd-4268-9a23-e41c6cdb4db9.jpg',0,'1516025976',NULL,1,1,8,1,'0','0','0','0','0',0),(55,'New Product For Test','New Product For Test  New Product For Test New Product For Test New Product For Test New Product For Test','&lt;p&gt;منتج جديد للتيست&amp;nbsp;منتج جديد للتيست&amp;nbsp;منتج جديد للتيست&amp;nbsp;منتج جديد للتيست&amp;nbsp;منتج جديد للتيست&amp;nbsp;منتج جديد للتيست&amp;nbsp;&lt;/p&gt;',2,1,'482ca304-e082-47a7-9329-6232e0df3471.jpg',0,'1516619921','1516620333',1,1,8,1,'0','0','0','0','0',0),(56,'Tank Oover View','Tank Oover ViewTank Oover ViewTank Oover ViewTank Oover View','&lt;p&gt;Tank Oover ViewTank Oover ViewTank Oover ViewTank Oover ViewTank Oover View&lt;/p&gt;',0,1,'7622f933-a800-467d-a016-08b1d595cde4.jpg',0,'1516621453',NULL,1,1,8,1,'0','0','0','0','0',0),(57,'Walkway Tank','Walkway Tank','&lt;p&gt;Walkway Tank&lt;/p&gt;',0,1,'abbcd85b-717f-4331-b469-06041f530d51.jpg',0,'1517216151',NULL,1,1,8,1,'0','0','0','0','0',0),(58,'Nice Automatic Door','Nice Automatic Door','&lt;p&gt;Nice Automatic Door&lt;/p&gt;',0,1,'fa1e5dd1-8305-4ef3-8c4b-7809539ec359.jpg',0,'1517216450',NULL,1,1,8,1,'0','0','0','0','0',0),(59,'Simple Pump 01','Simple Pump 01','&lt;p&gt;Simple Pump 01&lt;/p&gt;',0,1,'3902dc8b-4db8-4fb4-af3e-1fe3523dc896.jpg',0,'1517216723',NULL,1,1,8,1,'0','0','0','0','0',0),(60,'Ground Cover 01','Ground Cover 01','&lt;p&gt;Ground Cover 01&lt;/p&gt;',0,1,'51492c64-5df0-4d53-8d28-ce3d86180f11.jpg',0,'1517217102',NULL,1,1,8,1,'0','0','0','0','0',0),(61,'test product','test desc','&lt;p&gt;test desc&lt;/p&gt;',0,1,'f5b2c38f-1723-475f-8046-6577389a8b38.png',0,'1517823992',NULL,1,1,8,1,'0','0','0','0','0',0),(62,'Test product','Test product desc','&lt;p&gt;Test product desc&lt;/p&gt;',0,1,'f622c99b-1ae2-4be1-8af8-9ecc13dab20e.png',0,'1517838279',NULL,1,1,8,1,'0','0','0','0','0',0);
/*!40000 ALTER TABLE `data_cms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_depts`
--

DROP TABLE IF EXISTS `data_cms_depts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_depts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `des` varchar(750) NOT NULL,
  `img` varchar(100) NOT NULL,
  `application_id` int(10) NOT NULL,
  `module_id` int(10) NOT NULL,
  `target_layout_id` int(5) NOT NULL DEFAULT '0',
  `target_action_id` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_depts`
--

LOCK TABLES `data_cms_depts` WRITE;
/*!40000 ALTER TABLE `data_cms_depts` DISABLE KEYS */;
INSERT INTO `data_cms_depts` VALUES (1,'ALZAMIL FACTORY','ALZAMIL FACTORY','6472c638-4077-41cb-9a9b-15e7b673558a.png',1,3,0,0),(2,'بروفايل الزامل','بروفايل الزامل','94a45dab-0e2e-4507-ab7a-cf14ef85ffc3.jpg',1,4,0,0),(3,'Brochures','Alzamil Brochures','a1446bac-7514-464a-ac00-4596aa314da9.png',1,5,0,0),(4,'Categories','Categories','d499c8ba-1c1c-4ce8-9b87-12567b28d1d7.png',1,8,0,0),(5,'Manufacturers','Manufacturers','0d69a6c9-d6ab-4cf9-8075-cbc66339e843.png',1,8,0,0),(6,'Water and heat insulation','Water and heat insulation','e2971c24-d354-4d4f-b30b-fafd13d08186.png',1,11,0,0);
/*!40000 ALTER TABLE `data_cms_depts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_depts_lang`
--

DROP TABLE IF EXISTS `data_cms_depts_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_depts_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `core_dept_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `des` text,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_depts_lang`
--

LOCK TABLES `data_cms_depts_lang` WRITE;
/*!40000 ALTER TABLE `data_cms_depts_lang` DISABLE KEYS */;
INSERT INTO `data_cms_depts_lang` VALUES (1,1,'مصنع الزامل','مصنع الزامل',1),(2,2,'بروفايل الزامل','بروفايل الزامل',1),(3,3,'بروشورات','بروشورات الزامل',1),(4,4,'التصنيفات','التصنيفات',1),(5,5,'المصنعين','المصنعين',1),(6,6,'عزل مائي وحراري','عزل مائي وحراري',1);
/*!40000 ALTER TABLE `data_cms_depts_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_depts_rel`
--

DROP TABLE IF EXISTS `data_cms_depts_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_depts_rel` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `parent_depts_id` int(10) NOT NULL DEFAULT '0',
  `des` varchar(750) NOT NULL,
  `img` varchar(100) NOT NULL,
  `active` int(3) NOT NULL DEFAULT '1',
  `orders` int(10) NOT NULL,
  `core_depts_id` int(10) NOT NULL DEFAULT '0',
  `application_id` int(10) NOT NULL,
  `module_id` int(10) NOT NULL,
  `lang_id` int(4) NOT NULL DEFAULT '1',
  `is_public` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` varchar(30) NOT NULL DEFAULT '',
  `created_by` int(11) NOT NULL DEFAULT '113',
  `subject_to_maintenance` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'show at maintenance module',
  `show_in_homepage` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_depts_rel`
--

LOCK TABLES `data_cms_depts_rel` WRITE;
/*!40000 ALTER TABLE `data_cms_depts_rel` DISABLE KEYS */;
INSERT INTO `data_cms_depts_rel` VALUES (1,'الشركة العربية',0,'الشركة العربية الشركة العربية الشركة العربية','0',1,3,5,1,8,1,0,'2017-10-16 12:16:20',113,0,NULL),(2,'شركة العربي',0,'شركة العربيشركة العربيشركة العربيشركة العربيشركة العربيشركة العربي','9428e8fe-413b-4a8e-920a-c829feb82e7d.png',1,2,5,1,8,1,0,'2017-10-16 12:19:22',113,0,NULL),(3,'شركة المصري',1,'شركة المصري شركة المصري شركة المصري شركة المصري','6ab85a61-10cd-4770-9157-146049042be5.png',1,1,5,1,8,1,0,'2017-10-16 12:20:25',113,0,NULL),(4,'Fanta',0,'Fanta Company','72882a3b-34b0-4098-bc96-1a51ee7d5a12.jpg',1,4,5,1,8,1,0,'2017-10-16 12:43:46',113,0,NULL),(5,'BMW',0,'BMW  BMW  BMW','bbd20576-4428-467f-ae69-d8020e7580b1.jpg',1,5,5,1,8,1,0,'2017-10-16 12:44:47',113,0,NULL),(6,'CocaCola',0,'CocaCola  CocaCola  CocaCola','091e5e86-3eb3-48bb-8f33-c45048f542ad.jpg',1,6,5,1,8,1,0,'2017-10-16 12:49:12',113,0,NULL),(7,'Water tanks',0,'Water tanks','0',1,0,4,1,8,1,0,'2017-10-16 13:17:51',113,0,0),(8,'Water/heat insulators',0,'Water/heat insulators','d4ffb61c-4171-4405-808c-7d3b6e301a49.jpg',1,0,4,1,8,1,0,'2017-10-16 13:30:30',113,0,NULL),(9,'Automatic Doors',0,'With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.','82faecb8-1a84-4833-870c-3fbe421fb326.jpg',1,0,4,1,8,1,0,'2017-10-16 13:30:54',113,1,NULL),(10,'Pumps',0,'With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.','b4000205-37ce-44e2-a81b-5f91c93ec9ae.jpg',1,0,4,1,8,1,0,'2017-10-16 13:31:13',113,1,NULL),(11,'Traffic Cones',0,'With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.','269d79da-81c4-4818-a2c5-36cb66ea388d.jpg',1,0,4,1,8,1,0,'2017-10-16 13:32:34',113,0,NULL),(12,'RAAD Barriers',0,'With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.','b7283e63-7c70-40c3-9f96-6becfbe7a840.jpg',1,0,4,1,8,1,0,'2017-10-16 13:32:58',113,0,NULL),(13,'Electrical Flooter',0,'With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.','04d6ae2e-20d1-4102-a109-bbb77a83c74f.jpg',1,0,4,1,8,1,0,'2017-10-16 13:33:17',113,0,NULL),(14,'GLS Tank',1,'With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our','2f77b97c-58c6-442e-8714-676f13105934.jpg',1,0,4,1,8,1,0,'2017-10-16 13:35:58',113,0,NULL),(16,'Vertical Tanks',7,'With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.','3d807f7d-b5b8-49b3-9a2f-2e77b8c1ee39.jpg',1,0,4,1,8,1,0,'2017-10-16 13:36:40',113,1,NULL),(17,'Walkway Tanks',7,'With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.','c97dcd97-ae5e-420c-8604-a9b6a43326ed.jpg',1,0,4,1,8,1,0,'2017-10-16 13:36:56',113,1,NULL),(18,'Staircase tanks',7,'With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.','c8334da2-6db6-40ff-b1fd-7f95cb639e12.jpg',1,0,4,1,8,1,0,'2017-10-16 13:37:21',113,1,NULL),(19,'Underground Tanks',7,'With confidence, we guarantee the polyethylene material from SABIC, which is the only element of the industry of our tanks, because it is characterized by the highest international quality specifications. Polyethylene has high resistivity characters to chemicals and range of salt addiditives.','d6ff4527-b77c-42ae-857f-502255101dbe.jpg',1,0,4,1,8,1,0,'2017-10-16 13:37:46',113,1,NULL),(23,'MANUFACTURING',0,'MANUFACTURING MANUFACTURING MANUFACTURING','738fd230-6b5e-4273-be70-b2c6cdb01ec7.jpg',1,0,1,1,3,1,0,'2017-10-17 10:39:22',113,0,NULL),(24,'PRODUCTION CAPACITY',0,'PRODUCTION CAPACITY PRODUCTION CAPACITY','74c1ba6a-3cb2-4d23-bdb2-a0dd229a4932.png',1,0,1,1,3,1,0,'2017-10-17 10:39:56',113,0,NULL),(25,'TOTAL STAFF - 259 HEAD COUNT',0,'TOTAL STAFF - 259 HEAD COUNT TOTAL STAFF - 259 HEAD COUNT TOTAL STAFF - 259 HEAD COUNT','305f1e56-06c3-42f4-8e27-e89b6ee19f2e.jpeg',1,0,1,1,3,1,0,'2017-10-17 10:40:32',113,0,NULL),(26,'QUALITY STANDARDS &amp; REFERENCES',0,'QUALITY STANDARDS &amp; REFERENCES QUALITY STANDARDS &amp; REFERENCES QUALITY STANDARDS &amp; REFERENCES','650e853a-d7b3-4c4f-be20-919576ba3d40.jpg',1,0,1,1,3,1,0,'2017-10-17 10:41:13',113,0,NULL),(27,'Arabian Company Profile',0,'Arabian Company Profile Arabian Company Profile Arabian Company Profile','5c051e08-d220-4455-b37a-114ba20000c9.pdf',1,0,2,1,4,1,0,'2017-10-17 11:08:42',113,0,NULL),(28,'Al-Zamil Porchure',0,'Al-Zamil Porchure Al-Zamil Porchure Al-Zamil Porchure','4f407a07-8e3f-4979-baec-a6c6490ded5f.png',1,0,3,1,5,1,0,'2017-10-17 11:10:38',113,0,NULL),(29,'Instant Heaters',0,'Instant Heaters','a77136e3-218e-4da8-a92c-5942d4719fe8.jpg',1,0,4,1,8,1,0,'2017-10-26 14:38:57',113,0,NULL),(30,'Disposal remain food place',0,'Disposal remain food place','a60324c4-6e8a-4ce0-b5b9-b43b3c2c3db2.jpg',1,0,4,1,8,1,0,'2017-10-26 14:43:10',113,0,NULL),(31,'Floor Coverings',0,'Floor Coverings','6d737bb6-2de7-4b0a-b9c0-6b9fedab33de.jpeg',1,0,4,1,8,1,0,'2017-10-26 14:45:25',113,1,NULL),(32,'Roll Doors / American Doors',0,'Roll Doors / American Doors','01490272-8895-4e98-9e56-21cd02b21fcf.jpg',0,0,4,1,8,1,0,'2017-10-26 14:52:06',113,0,NULL),(33,'العزل المائي والحراري',0,'هي تقنية تبطين و مانع للتسرب يمكن استخدامها في مجالات عديدة.','27139018-c968-4283-9b88-ac1803cc0795.jpeg',1,0,6,1,11,1,0,'1509461352',113,0,NULL),(34,'باستخدام بولي يوريا',33,'هي تقنية تبطين و مانع للتسرب يمكن استخدامها في مجالات عديدة.','3e9860aa-7877-429a-b4ce-b6a3d13b68c1.jpeg',1,0,6,1,11,1,0,'1509461381',113,0,NULL),(35,'باستخدام البولييورثان',33,'هي تقنية تبطين و مانع للتسرب يمكن استخدامها في مجالات عديدة.','f60217b4-d936-4905-a16e-6fc52d6ec66d.png',1,0,6,1,11,1,0,'1509461407',113,0,NULL),(36,'باستخدام المواد الاسمنتية',33,'هي تقنية تبطين و مانع للتسرب يمكن استخدامها في مجالات عديدة.','947b6536-5997-43bb-b6d4-27fd79fd0438.png',1,0,6,1,11,1,0,'1509461446',113,0,NULL),(37,'باستخدام دهانات',33,'هي تقنية تبطين و مانع للتسرب يمكن استخدامها في مجالات عديدة.','106aa324-eb56-4194-8328-f4bf5029773d.png',1,0,6,1,11,1,0,'1509461467',113,0,NULL),(39,'خزان أفقي',7,'خزان أفقي','bbedeeb8-127f-418d-8026-d1578f587e7b.jpg',1,0,4,1,8,1,0,'1513519152',113,1,NULL),(40,'التست',0,'انه التيست','fd80ffe1-e8c0-4d3a-92f0-88f5e36a6bfa.png',0,0,4,1,8,1,0,'1515413811',113,0,NULL),(41,'الجودة',0,'الجودة','',1,0,0,1,9,1,0,'2017-10-16 12:16:20',1,0,NULL),(43,'بتنافاليو',0,'وصف الشركة بنتافاليو  وصف الشركة بنتافاليو  وصف الشركة بنتافاليو  وصف الشركة بنتافاليو  وصف الشركة بنتافاليو','0',1,15,5,1,8,1,0,'',113,0,NULL);
/*!40000 ALTER TABLE `data_cms_depts_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_depts_rel_items`
--

DROP TABLE IF EXISTS `data_cms_depts_rel_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_depts_rel_items` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `item_id` int(10) DEFAULT NULL,
  `depts_id` int(10) NOT NULL,
  `application_id` int(10) NOT NULL,
  `module_id` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8 COMMENT='content_depts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_depts_rel_items`
--

LOCK TABLES `data_cms_depts_rel_items` WRITE;
/*!40000 ALTER TABLE `data_cms_depts_rel_items` DISABLE KEYS */;
INSERT INTO `data_cms_depts_rel_items` VALUES (5,7,28,1,5),(7,10,27,1,4),(8,11,27,1,4),(9,12,27,1,4),(18,14,23,1,3),(19,19,23,1,3),(20,20,23,1,3),(21,21,23,1,3),(22,22,24,1,3),(24,24,26,1,3),(26,13,27,1,4),(27,9,27,1,4),(70,28,16,1,8),(101,36,7,1,8),(102,37,10,1,8),(111,27,27,1,4),(113,41,3,1,8),(114,40,18,1,8),(115,39,16,1,8),(116,38,10,1,8),(117,29,10,1,8),(118,42,8,1,8),(120,30,28,1,5),(121,8,28,1,5),(123,35,37,1,11),(124,34,36,1,11),(125,33,34,1,11),(126,32,35,1,11),(131,43,27,1,4),(132,53,7,1,8),(133,53,39,1,8),(134,55,7,1,8),(135,55,16,1,8),(136,55,17,1,8),(137,55,18,1,8),(138,55,19,1,8),(139,55,39,1,8),(140,55,8,1,8),(141,55,9,1,8),(142,55,10,1,8),(143,55,11,1,8),(144,55,12,1,8),(145,55,13,1,8),(146,55,29,1,8),(147,55,30,1,8),(148,55,31,1,8),(149,55,32,1,8),(150,55,40,1,8),(151,55,1,1,8),(152,55,3,1,8),(153,55,14,1,8),(154,55,2,1,8),(155,55,4,1,8),(156,55,5,1,8),(157,55,6,1,8),(158,56,7,1,8),(159,56,17,1,8),(160,56,39,1,8),(161,56,5,1,8),(162,56,6,1,8),(163,3,7,1,8),(164,3,16,1,8),(165,3,17,1,8),(166,3,1,1,8),(167,3,3,1,8),(168,3,14,1,8),(169,3,2,1,8),(170,3,4,1,8),(171,3,6,1,8),(172,57,7,1,8),(173,57,17,1,8),(174,58,9,1,8),(175,59,10,1,8),(176,60,31,1,8),(177,61,9,1,8);
/*!40000 ALTER TABLE `data_cms_depts_rel_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_depts_rel_lang`
--

DROP TABLE IF EXISTS `data_cms_depts_rel_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_depts_rel_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `des` text,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_depts_rel_lang`
--

LOCK TABLES `data_cms_depts_rel_lang` WRITE;
/*!40000 ALTER TABLE `data_cms_depts_rel_lang` DISABLE KEYS */;
INSERT INTO `data_cms_depts_rel_lang` VALUES (1,19,'خزانات دفان','البولي ايثلين\r\n\r\nنضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك).\r\n\r\nطريقة التصنيع\r\n\r\nتستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى\r\n\r\n\r\nالطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل.\r\nالطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان.\r\nالطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى',1),(2,1,'الشركة العربية','الشركة العربية',1),(3,2,'شركة العربي','شركة العربي',1),(4,3,'شركة المصري','شركة المصري',1),(5,4,'فانتا','فانتا',1),(6,5,'بي ام دبليو','بي ام دبليو',1),(7,6,'كوكاكولا','كوكاكولا',1),(8,18,'خزانات سلم','نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك).\r\n\r\nتستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى\r\n\r\n\r\nالطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل.\r\nالطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان.\r\nالطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى درجات النقاء.',1),(9,17,'خزانات طريق','لبولي ايثلين نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك). طريقة التصنيع تستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى الطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل. الطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان. الطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى',1),(10,16,'خزانات رأسية','نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك).\r\n\r\nتستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى\r\n\r\n\r\nالطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل.\r\nالطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان.\r\nالطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى درجات النقاء.',1),(11,15,'خزانات أفقية','خزانات أفقية',1),(12,14,'خزانات جي ال اس','لبولي ايثلين نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك). طريقة التصنيع تستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى الطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل. الطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان. الطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى',1),(13,7,'خزانات المياه','لبولي ايثلين نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك). طريقة التصنيع تستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى الطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل. الطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان. الطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى',1),(14,10,'مضخات','لبولي ايثلين نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك). طريقة التصنيع تستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى الطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل. الطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان. الطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى',1),(15,11,'أقماع مرور','لبولي ايثلين نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك). طريقة التصنيع تستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى الطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل. الطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان. الطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى',1),(16,12,'حواجز طريق','لبولي ايثلين نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك). طريقة التصنيع تستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى الطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل. الطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان. الطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى',1),(17,13,'فلوتر كهربائي','لبولي ايثلين نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك). طريقة التصنيع تستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى الطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل. الطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان. الطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى',1),(18,28,'بروشورات الزامل','بروشورات الزامل',1),(19,27,'بروفايل الشركة العربية','بروفايل الشركة العربية الزامل',1),(20,9,'ابواب اتوماتيكية','لبولي ايثلين نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك). طريقة التصنيع تستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى الطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل. الطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان. الطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى',1),(21,32,'أبواب رول / أبواب امريكية','لبولي ايثلين نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك). طريقة التصنيع تستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى الطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل. الطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان. الطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى',1),(22,31,'أغطية الفتحات الأرضية','لبولي ايثلين نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك). طريقة التصنيع تستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى الطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل. الطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان. الطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى',1),(23,30,'مكان التخلص من بقايا الطعام','لبولي ايثلين نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك). طريقة التصنيع تستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى الطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل. الطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان. الطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى',1),(24,29,'سخانات فورية','لبولي ايثلين نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك). طريقة التصنيع تستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى الطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل. الطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان. الطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى',1),(25,8,'عوازل ماء وحرارة','لبولي ايثلين نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك). طريقة التصنيع تستخدم خزانات مياه الزامل أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى الطبقة الأولى (الخارجية): تقوم بمهمة منع امتصاص الغبار ومقاومة مرور الأشعة وتأتي بألوان متعددة حسب رغبة العميل. الطبقة الثانية (السوداء): تقوم بمهمة حجب جميع أنواع الإشعاعات بما فيها الأشعة فوق البنفسجية وتجعل الخزان غير شفاف، بالتالي تمنع تكون أي نوع من الطحالب ضمن جسم الخزان. الطبقة الرابعة (الملساء): وهي طبقة ناعمة ناصعة البياض تمنع تراكم أية شوائب قد تسبب في تولد البكتريا على الجدار الداخلي للخزان، كما أنها تقاوم التآكل الذي يمكن أن يحدث، بما يضمن حفظ المياه بشكل صحي وبأعلى',1),(26,42,'تست','تست تست تست تست تست تست تست تست تست تست تست تست تست تست تست تست تست تست تست تست',1),(27,42,'test','test test test test test test test test test test test test test test test test test test test test test test test test test test',2),(28,7,'Water tanks','Water tanks',2);
/*!40000 ALTER TABLE `data_cms_depts_rel_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_filter_search`
--

DROP TABLE IF EXISTS `data_cms_filter_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_filter_search` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(50) DEFAULT NULL,
  `title` varchar(30) DEFAULT NULL,
  `depts` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `date_from` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `date_to` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `lang_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_filter_search`
--

LOCK TABLES `data_cms_filter_search` WRITE;
/*!40000 ALTER TABLE `data_cms_filter_search` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_cms_filter_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_follow_types`
--

DROP TABLE IF EXISTS `data_cms_follow_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_follow_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_follow_types`
--

LOCK TABLES `data_cms_follow_types` WRITE;
/*!40000 ALTER TABLE `data_cms_follow_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_cms_follow_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_img_thumb`
--

DROP TABLE IF EXISTS `data_cms_img_thumb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_img_thumb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_cms_id` int(11) NOT NULL,
  `thumb_name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_img_thumb`
--

LOCK TABLES `data_cms_img_thumb` WRITE;
/*!40000 ALTER TABLE `data_cms_img_thumb` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_cms_img_thumb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_import`
--

DROP TABLE IF EXISTS `data_cms_import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_import` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `operating_menu` varchar(255) DEFAULT NULL,
  `content` text,
  `depts_id` int(11) NOT NULL,
  `application_id` int(11) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_import`
--

LOCK TABLES `data_cms_import` WRITE;
/*!40000 ALTER TABLE `data_cms_import` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_cms_import` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_import_order_option`
--

DROP TABLE IF EXISTS `data_cms_import_order_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_import_order_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_title` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_import_order_option`
--

LOCK TABLES `data_cms_import_order_option` WRITE;
/*!40000 ALTER TABLE `data_cms_import_order_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_cms_import_order_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_import_sources`
--

DROP TABLE IF EXISTS `data_cms_import_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_import_sources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `img` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_import_sources`
--

LOCK TABLES `data_cms_import_sources` WRITE;
/*!40000 ALTER TABLE `data_cms_import_sources` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_cms_import_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_import_type`
--

DROP TABLE IF EXISTS `data_cms_import_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_import_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(55) NOT NULL,
  `dept_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_import_type`
--

LOCK TABLES `data_cms_import_type` WRITE;
/*!40000 ALTER TABLE `data_cms_import_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_cms_import_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_lang`
--

DROP TABLE IF EXISTS `data_cms_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_cms_id` int(11) NOT NULL,
  `lang_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `des` text NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_lang`
--

LOCK TABLES `data_cms_lang` WRITE;
/*!40000 ALTER TABLE `data_cms_lang` DISABLE KEYS */;
INSERT INTO `data_cms_lang` VALUES (1,3,1,'الخزنات الافقية','خزنات المياة / الخزنات الافقية','&lt;div id=\\&quot;overview\\&quot; class=\\&quot;tab-pane fade col-xs-12 active in\\&quot; style=\\&quot;box-sizing: border-box; direction: rtl; float: right; position: relative; min-height: 1px; padding-right: 15px; padding-left: 15px; width: 1140px; opacity: 1; transition: opacity 0.15s linear; color: #444444; font-family: \\\'Helvetica Neue W23 for SKY Reg\\\';\\&quot;&gt;&lt;span class=\\&quot;col-xs-12 no-padding\\&quot; style=\\&quot;box-sizing: border-box; font-weight: bold; float: right; text-align: right; direction: rtl; position: relative; min-height: 1px; padding-right: 0px; padding-left: 0px; width: 1110px;\\&quot;&gt;لبولي ايثلين&lt;/span&gt;\r\n&lt;p style=\\&quot;box-sizing: border-box; margin: 0px 0px 10px; text-align: right; direction: rtl;\\&quot;&gt;نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك).&lt;/p&gt;\r\n&lt;span class=\\&quot;col-xs-12 no-padding\\&quot; style=\\&quot;box-sizing: border-box; font-weight: bold; float: right; text-align: right; direction: rtl; position: relative; min-height: 1px; padding-right: 0px; padding-left: 0px; width: 1110px;\\&quot;&gt;طريقة التصنيع&lt;/span&gt;\r\n&lt;p style=\\&quot;box-sizing: border-box; margin: 0px 0px 10px; text-align: right; direction: rtl;\\&quot;&gt;تستخدم خزانات مياه أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى.&lt;/p&gt;\r\n&lt;p&gt;&amp;nbsp;&lt;/p&gt;\r\n&lt;/div&gt;'),(2,28,1,'الخزانات الرأسية','الخزانات الرأسية \\\\ الخزانات الرأسية',''),(3,29,1,'خزان للاختبار','خزان للاختبار','خزان للاختبار'),(4,31,1,'صفحة عرض بيانات الشركة','وصف مختصر للصفحة',''),(5,32,1,'البوليوريثان','هي تقنية تبطين و مانع للتسرب يمكن استخدامها في مجالات عديدة','مميزات إستخدام نظام البوليوريثين و طبقة الحماية\r\n(نظام العزل المائي و الحراري معاً):\r\nإمكانية تنفيذه علي جميع أنواع الأسطح ( معدنية ــ خشبية ــ خرسانية ).\r\nخفة الوزن حيث يبلغ وزن المادة عند كثافة 45 كجم/م2 .\r\nأقل المواد توصيلاً للحرارة 20 واط/ م2 كلفن م2 .\r\nمقاومة كاملة للماء و للمياه المالحة و الكائنات الحية .\r\nلا يتأثر بالحشرات و الفطريات و لا ينتج عنه أي روائح و عدم قابليته للتآكل .\r\nمقاومة عالية جداً للطقس المتقلب و الرياح و الأمطار و يمكن اللإستغناء عن البلاط و الدفان أعلاه .\r\nعدم وجود أي وصلات في السقف لأنه يتكون من طبقات متماسكة و متلاصقة مع بعضها بفعل عملية الرش المتراكمة .\r\nسرعة التنفيذ حيث أنه يتم تنفيذه علي مرحلتين فقط. و يعتبر من أسرع أنظمة العزل المائي و الحراري للأسطح تنفيذاً و تكلفة ، و أقلهنم تعطيلا للبنود الأخري .'),(6,33,1,'البوليبارثان','هي تقنية تبطين و مانع للتسرب يمكن استخدامها في مجالات عديدة','مميزات إستخدام نظام البوليوريثين و طبقة الحماية\r\n(نظام العزل المائي و الحراري معاً):\r\nإمكانية تنفيذه علي جميع أنواع الأسطح ( معدنية ــ خشبية ــ خرسانية ).\r\nخفة الوزن حيث يبلغ وزن المادة عند كثافة 45 كجم/م2 .\r\nأقل المواد توصيلاً للحرارة 20 واط/ م2 كلفن م2 .\r\nمقاومة كاملة للماء و للمياه المالحة و الكائنات الحية .\r\nلا يتأثر بالحشرات و الفطريات و لا ينتج عنه أي روائح و عدم قابليته للتآكل .\r\nمقاومة عالية جداً للطقس المتقلب و الرياح و الأمطار و يمكن اللإستغناء عن البلاط و الدفان أعلاه .\r\nعدم وجود أي وصلات في السقف لأنه يتكون من طبقات متماسكة و متلاصقة مع بعضها بفعل عملية الرش المتراكمة .\r\nسرعة التنفيذ حيث أنه يتم تنفيذه علي مرحلتين فقط. و يعتبر من أسرع أنظمة العزل المائي و الحراري للأسطح تنفيذاً و تكلفة ، و أقلهنم تعطيلا للبنود الأخري .'),(7,34,1,'الأسمنت','هي تقنية تبطين و مانع للتسرب يمكن استخدامها في مجالات عديدة','&lt;p&gt;مميزات إستخدام نظام البوليوريثين و طبقة الحماية (نظام العزل المائي و الحراري معاً): إمكانية تنفيذه علي جميع أنواع الأسطح ( معدنية ــ خشبية ــ خرسانية ). خفة الوزن حيث يبلغ وزن المادة عند كثافة 45 كجم/م2 . أقل المواد توصيلاً للحرارة 20 واط/ م2 كلفن م2 . مقاومة كاملة للماء و للمياه المالحة و الكائنات الحية . لا يتأثر بالحشرات و الفطريات و لا ينتج عنه أي روائح و عدم قابليته للتآكل . مقاومة عالية جداً للطقس المتقلب و الرياح و الأمطار و يمكن اللإستغناء عن البلاط و الدفان أعلاه . عدم وجود أي وصلات في السقف لأنه يتكون من طبقات متماسكة و متلاصقة مع بعضها بفعل عملية الرش المتراكمة . سرعة التنفيذ حيث أنه يتم تنفيذه علي مرحلتين فقط. و يعتبر من أسرع أنظمة العزل المائي و الحراري للأسطح تنفيذاً و تكلفة ، و أقلهنم تعطيلا للبنود الأخري .&lt;/p&gt;'),(8,35,1,'أكليرك','هي تقنية تبطين و مانع للتسرب يمكن استخدامها في مجالات عديدة','&lt;p&gt;مميزات إستخدام نظام البوليوريثين و طبقة الحماية (نظام العزل المائي و الحراري معاً): إمكانية تنفيذه علي جميع أنواع الأسطح ( معدنية ــ خشبية ــ خرسانية ). خفة الوزن حيث يبلغ وزن المادة عند كثافة 45 كجم/م2 . أقل المواد توصيلاً للحرارة 20 واط/ م2 كلفن م2 . مقاومة كاملة للماء و للمياه المالحة و الكائنات الحية . لا يتأثر بالحشرات و الفطريات و لا ينتج عنه أي روائح و عدم قابليته للتآكل . مقاومة عالية جداً للطقس المتقلب و الرياح و الأمطار و يمكن اللإستغناء عن البلاط و الدفان أعلاه . عدم وجود أي وصلات في السقف لأنه يتكون من طبقات متماسكة و متلاصقة مع بعضها بفعل عملية الرش المتراكمة . سرعة التنفيذ حيث أنه يتم تنفيذه علي مرحلتين فقط. و يعتبر من أسرع أنظمة العزل المائي و الحراري للأسطح تنفيذاً و تكلفة ، و أقلهنم تعطيلا للبنود الأخري .&lt;/p&gt;'),(9,36,1,'خزان ضغط عالي','الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك).','نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك).\r\n\r\nطريقة التصنيع\r\n\r\nتستخدم خزانات مياه أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى.'),(10,37,1,'المصنع : العربية لخزنات المياة','ية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب','نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك).\r\n\r\nطريقة التصنيع\r\nتستخدم خزانات مياه أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى'),(11,38,1,'تستخدم خزانات ميا','تستخدم خزانات مياه أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتق','&lt;p&gt;&lt;span class=\\&quot;col-xs-12 no-padding\\&quot; style=\\&quot;box-sizing: border-box; font-weight: bold; float: right; text-align: right; direction: rtl; position: relative; min-height: 1px; padding-right: 0px; padding-left: 0px; width: 1110px; color: #444444; font-family: \\\'Helvetica Neue W23 for SKY Reg\\\';\\&quot;&gt;البولي ايثلين&lt;/span&gt;&lt;/p&gt;\r\n&lt;p style=\\&quot;box-sizing: border-box; margin: 0px 0px 10px; text-align: right; direction: rtl; color: #444444; font-family: \\\'Helvetica Neue W23 for SKY Reg\\\';\\&quot;&gt;نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك).&lt;/p&gt;\r\n&lt;p&gt;&lt;span class=\\&quot;col-xs-12 no-padding\\&quot; style=\\&quot;box-sizing: border-box; font-weight: bold; float: right; text-align: right; direction: rtl; position: relative; min-height: 1px; padding-right: 0px; padding-left: 0px; width: 1110px; color: #444444; font-family: \\\'Helvetica Neue W23 for SKY Reg\\\';\\&quot;&gt;طريقة التصنيع&lt;/span&gt;&lt;/p&gt;\r\n&lt;p style=\\&quot;box-sizing: border-box; margin: 0px 0px 10px; text-align: right; direction: rtl; color: #444444; font-family: \\\'Helvetica Neue W23 for SKY Reg\\\';\\&quot;&gt;تستخدم خزانات مياه أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى.&lt;/p&gt;'),(12,39,1,'مة الغذاء والدواء الأمريكية FD','كل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ،','نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك).\r\n\r\nطريقة التصنيع\r\nتستخدم خزانات مياه أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى'),(13,40,1,'البولي ايثلين','البولي ايثلين  نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب','البولي ايثلين\r\n\r\nنضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك).\r\n\r\nطريقة التصنيع\r\n\r\nتستخدم خزانات مياه أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى.'),(14,41,1,'البولي ايثلين نضمن بكل ثقة صحي','البولي ايثلين نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة','البولي ايثلين نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة'),(15,42,1,'نضمن بكل ثقة صحية','نضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها','لبولي ايثلين\r\nنضمن بكل ثقة صحية مادة البولي ايثلين العنصر الوحيد لصناعة خزاناتنا لتمتعها بأعلى مواصفات الجودة العالمية من سابك ، حيث أنها المادة الوحيدة المعتمدة لتخزين المياه من قبل منظمة الغذاء والدواء الأمريكية FDA ، وحسب توجيهات الاتحاد الأوروبي. وتتميز مادة البولي ايثلين لمقاومتها الشديدة للكثير من المواد الكيميائية بالإضافة إلى مقاومتها للأملاح بشكلها الصلب أو المحلول في الماء. ( حسب الجدول المرفق المقدم من شركة سابك).\r\n\r\nطريقة التصنيع\r\nتستخدم خزانات مياه أحدث أساليب التقنية العالمية في هذا المجال عن طريق تقنية القولبة المتقدمة في التصميم لإنتاج خزانات مياه من قطعة واحدة بدون فواصل ، مما يعطي الخزان قوة ومتانة ومدة أداء أطول. بالإضافة إلى أحدث طرق الاختبار والتي تتم على القوالب والخزانات قبل الإنتاج وبعده: تصنع خزانات مياه الزامل من أربع طبقات ولكل طبقة منها دور هام مما يعطي الخزان أداء أطول ومواصفات أعلى.'),(16,44,1,'شركة تجارية تعمل في مجال تجارة','','&lt;p&gt;العربية للخزانات&lt;/p&gt;'),(20,50,1,'','',''),(21,51,1,'تيست','صفحة للتيست','التيست من اجل التيست'),(22,53,1,'خزان تست 01','خزان تست 01','خزان تست 01'),(23,54,1,'منتج جديد','منتج جديدمنتج جديدمنتج جديدمنتج جديدمنتج جديدمنتج جديد',''),(24,55,1,'منتج جديد للتيست','منتج جديد للتيست منتج جديد للتيست منتج جديد للتيست منتج جديد للتيست منتج جديد للتيست منتج جديد للتيست','منتج جديد للتيست منتج جديد للتيست منتج جديد للتيست منتج جديد للتيست منتج جديد للتيست منتج جديد للتيست منتج جديد للتيست منتج جديد للتيست منتج جديد للتيست منتج جديد للتيست منتج جديد للتيست منتج جديد للتيست'),(25,56,1,'تانك اوفر فيو','تانك اوفر فيوتانك اوفر فيوتانك اوفر فيوتانك اوفر فيوتانك اوفر فيو','Tank Oover ViewTank Oover ViewTank Oover ViewTank Oover ViewTank Oover View'),(26,57,1,'خزان طريق','خزان طريق','خزان طريق'),(27,58,1,'باب اوتوماتيكي بسيط','باب اوتوماتيكي بسيط','باب اوتوماتيكي بسيط'),(28,59,1,'مضخه بسيطه 01','مضخه بسيطه 01','مضخه بسيطه 01'),(29,60,1,'','',''),(30,61,1,'test product','test desc',''),(31,62,1,'Test product','Test product desc','');
/*!40000 ALTER TABLE `data_cms_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_list_settings`
--

DROP TABLE IF EXISTS `data_cms_list_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_list_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL,
  `title` tinyint(4) NOT NULL DEFAULT '1',
  `des` tinyint(4) NOT NULL DEFAULT '1',
  `content` tinyint(4) NOT NULL DEFAULT '1',
  `order` tinyint(4) NOT NULL DEFAULT '1',
  `img` tinyint(4) NOT NULL DEFAULT '1',
  `visit_num` tinyint(4) NOT NULL DEFAULT '1',
  `datetime` tinyint(4) NOT NULL DEFAULT '1',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `depts` tinyint(4) NOT NULL DEFAULT '1',
  `add` int(11) NOT NULL DEFAULT '1',
  `delete` int(11) NOT NULL DEFAULT '1',
  `application_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_list_settings`
--

LOCK TABLES `data_cms_list_settings` WRITE;
/*!40000 ALTER TABLE `data_cms_list_settings` DISABLE KEYS */;
INSERT INTO `data_cms_list_settings` VALUES (1,3,1,1,0,1,1,1,1,1,0,1,1,1),(2,8,1,1,0,1,1,1,1,1,0,1,1,1),(3,4,1,1,0,0,0,0,1,1,0,1,1,1),(4,1,1,1,0,1,1,1,1,1,0,1,1,1),(5,2,1,1,0,1,1,1,1,1,0,1,1,1),(6,5,1,1,0,0,0,0,1,1,0,1,1,1),(7,6,0,0,0,0,0,0,0,0,0,1,1,1),(8,7,1,1,0,0,0,0,1,0,0,1,1,1),(9,9,1,1,0,1,1,1,1,1,0,1,1,1),(10,11,1,1,0,0,1,0,1,0,0,1,1,1),(11,10,1,1,0,1,1,1,1,1,0,1,1,1);
/*!40000 ALTER TABLE `data_cms_list_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_media`
--

DROP TABLE IF EXISTS `data_cms_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_media` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `link` varchar(255) DEFAULT NULL,
  `item_id` int(10) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `img_title` varchar(255) DEFAULT NULL,
  `img_alt` varchar(255) DEFAULT NULL,
  `img` varchar(100) DEFAULT NULL,
  `application_id` int(10) NOT NULL,
  `module_id` int(10) NOT NULL,
  `type` enum('Video','Img','Menu') NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_media`
--

LOCK TABLES `data_cms_media` WRITE;
/*!40000 ALTER TABLE `data_cms_media` DISABLE KEYS */;
INSERT INTO `data_cms_media` VALUES (5,' ',2,NULL,'','','ec5019f9-dcb8-4115-864b-d4956cf6fd49.jpg',1,2,'Img','2017-10-19 10:00:04'),(6,' ',2,NULL,'','','93adc3b0-eeec-4ad1-889c-c4aaabfb3da5.jpg',1,2,'Img','2017-10-19 10:00:04'),(7,' ',2,NULL,'','','d85781ed-c7a4-4d28-9d3c-6d2319d6725a.png',1,2,'Img','2017-10-19 10:00:04'),(8,'https://www.youtube.com/watch?v=EJz5KSQTntM',2,NULL,'','',' ',1,2,'Video','2017-10-19 10:00:04'),(9,'https://www.youtube.com/watch?v=zzFI6sEICEE',2,NULL,'','',' ',1,2,'Video','2017-10-19 10:00:19'),(10,'https://www.youtube.com/watch?v=qjsMb34Tg6o',2,NULL,'','',' ',1,2,'Video','2017-10-19 10:00:37'),(11,' ',3,NULL,'','','050745e5-d336-491b-909a-66e3d5540396.jpg',1,8,'Img','2017-10-26 14:32:34'),(12,' ',3,NULL,'','','db2e1e2e-fac1-4346-aad3-f0b326a2a48d.jpg',1,8,'Img','2017-10-26 14:32:34'),(13,' ',3,NULL,'','','12b2a2b0-ab0f-4fce-bd32-9f0ea5df3e87.jpg',1,8,'Img','2017-10-26 14:32:34'),(14,' ',3,NULL,'','','a26826db-6ddc-4f77-8c1c-2116023fec69.jpg',1,8,'Img','2017-10-26 14:32:34'),(15,' ',28,NULL,'','','e3029f2e-af24-4f8b-8471-91af0ef0c4a7.jpg',1,8,'Img','2017-10-26 14:39:14'),(16,' ',28,NULL,'','','8b8986c2-1265-4fa8-a288-458e25f8e54d.png',1,8,'Img','2017-10-26 14:39:14'),(17,' ',28,NULL,'','','34e69807-4b26-4f4c-98a3-00c46e1ecd57.png',1,8,'Img','2017-10-26 14:39:14'),(18,' ',28,NULL,'','','c79d5dc3-12df-4851-924e-2b5de98208c9.png',1,8,'Img','2017-10-26 14:39:14'),(19,' ',28,NULL,'','','af3b7023-b6d5-43a5-a094-1b77a41524e7.jpg',1,8,'Img','2017-10-26 14:39:14'),(20,' ',31,NULL,'','','0cdf0bdd-a6fe-46da-8b6e-50be6bfb0688.jpeg',1,2,'Img','2017-10-31 14:20:20'),(21,' ',31,NULL,'','','dad7b5b0-c71d-44e7-a1de-b6c28d76dad2.jpeg',1,2,'Img','2017-10-31 14:20:20'),(22,' ',31,NULL,'','','956db9aa-2811-4618-a7bd-c8761d4d9da2.png',1,2,'Img','2017-10-31 14:20:20'),(23,' ',31,NULL,'','','1e081783-f945-4ec8-8e2f-6f5b3b802b36.jpg',1,2,'Img','2017-10-31 14:20:20'),(24,' ',32,NULL,'','','b3e1d03d-0cad-4374-abc8-9a5902eaaec1.jpeg',1,11,'Img','2017-10-31 14:55:52'),(25,' ',32,NULL,'','','40bd3a4d-58f8-488e-8713-ac984a35b34d.png',1,11,'Img','2017-10-31 14:55:52'),(26,' ',32,NULL,'','','7631fced-fea0-4568-9f99-a63afc246db8.png',1,11,'Img','2017-10-31 14:55:52'),(27,' ',32,NULL,'','','d7df2e51-7ea9-4267-9817-766832c85935.png',1,11,'Img','2017-10-31 14:55:52'),(28,' ',36,NULL,'','','c1db89c4-275d-4757-b9f5-37eff6893de0.png',1,8,'Img','2017-11-01 10:26:27'),(29,' ',36,NULL,'','','48835c83-1fb0-4199-8ccf-9323ff288fb4.jpg',1,8,'Img','2017-11-01 10:26:27'),(30,' ',37,NULL,'','','0265c876-5c63-4155-a0ab-a4a763d2e89b.jpeg',1,8,'Img','2017-11-01 10:34:59'),(31,' ',37,NULL,'','','1a7c0c34-22b6-4a62-9866-3285e7b65c0f.png',1,8,'Img','2017-11-01 10:34:59'),(32,' ',37,NULL,'','','54f39034-1b9b-4561-ac30-44686b470eaa.png',1,8,'Img','2017-11-01 10:34:59'),(33,' ',37,NULL,'','','2493aeef-6fea-4607-8241-4786f2efdf2f.jpg',1,8,'Img','2017-11-01 10:34:59'),(34,' ',37,NULL,'','','f5c625a7-f2cf-47d4-9d89-eb996de34936.png',1,8,'Img','2017-11-01 10:34:59'),(35,' ',38,NULL,'','','e7eeb4de-82a4-438e-ace4-b341367b1087.jpeg',1,8,'Img','2017-11-01 10:40:46'),(36,' ',38,NULL,'','','dc4f0416-f0be-470f-aaa9-18b1c1ddf19f.jpg',1,8,'Img','2017-11-01 10:40:46'),(37,' ',38,NULL,'','','77afb832-4d43-4ffb-88fc-3f5d7642e31e.jpg',1,8,'Img','2017-11-01 10:40:46'),(38,' ',38,NULL,'','','b1bc9a3f-2b60-4616-b7a8-82e45c1b0c6b.jpg',1,8,'Img','2017-11-01 10:40:46'),(39,' ',39,NULL,'','','30eaf58f-b4cc-4cd3-a2d2-681075fa9cd0.png',1,8,'Img','2017-11-01 10:44:17'),(40,' ',39,NULL,'','','e3441146-8170-47df-96ed-6122057a1e2c.jpg',1,8,'Img','2017-11-01 10:44:17'),(41,' ',39,NULL,'','','a8b1706d-ac8b-43df-8d27-9208f4880aa8.jpg',1,8,'Img','2017-11-01 10:44:17'),(42,' ',40,NULL,'','','dfe77242-7db9-4c2e-adfd-afda4d94f050.jpg',1,8,'Img','2017-11-01 10:53:18'),(43,' ',40,NULL,'','','5d15eea2-46bf-4517-a179-c58cf596bf49.jpg',1,8,'Img','2017-11-01 10:53:18'),(44,' ',40,NULL,'','','909dabd3-c40b-4732-8487-faecee72b101.jpg',1,8,'Img','2017-11-01 10:53:18'),(45,' ',40,NULL,'','','6ca37022-4e89-4443-8395-25772106cdb0.jpg',1,8,'Img','2017-11-01 10:53:18'),(46,' ',40,NULL,'','','275e820f-6988-414d-8fce-628bb330e655.jpg',1,8,'Img','2017-11-01 10:53:18'),(47,' ',41,NULL,'','','e60ce4f2-1fbf-4f43-822b-39854a75d4b2.jpg',1,8,'Img','2017-11-01 10:58:05'),(48,' ',41,NULL,'','','6737e8e3-9ad7-401a-bde1-acdb0ec1effe.jpg',1,8,'Img','2017-11-01 10:58:05'),(49,' ',41,NULL,'','','ff479796-1c80-4cb0-9255-cbe9e55a8d8d.jpg',1,8,'Img','2017-11-01 10:58:05'),(50,' ',35,NULL,'','','4b3275d1-55bc-491b-81c0-0eb3e89bf882.jpeg',1,11,'Img','2017-11-01 22:58:27'),(51,' ',35,NULL,'','','8225ae59-3064-4efc-b324-27619a8c3e97.jpeg',1,11,'Img','2017-11-01 22:58:27'),(52,' ',35,NULL,'','','f6bb7f9e-202c-430a-8a0a-dafd94e4818d.jpeg',1,11,'Img','2017-11-01 22:58:27'),(53,' ',35,NULL,'','','d5f1619f-79c8-4c2b-b4e4-b892ff71515c.jpeg',1,11,'Img','2017-11-02 13:34:50'),(54,' ',35,NULL,'','','811ad5ee-e33f-4978-bdaa-fcfb397aa712.jpeg',1,11,'Img','2017-11-02 13:34:50'),(55,' ',34,NULL,'','','99d961b7-878d-4d55-a842-0f20510baca8.jpeg',1,11,'Img','2017-11-02 13:35:49'),(56,' ',34,NULL,'','','2f2aa01e-f1a4-490c-85f4-ffb76ccf8765.jpeg',1,11,'Img','2017-11-02 13:35:49'),(57,' ',34,NULL,'','','e73f4b21-68bf-4552-937a-bc7fcbf8f942.jpeg',1,11,'Img','2017-11-02 13:35:49'),(58,' ',34,NULL,'','','f552debf-15b3-40ce-8231-5c1e46a69cba.jpg',1,11,'Img','2017-11-02 13:35:49'),(59,' ',34,NULL,'','','82fa121b-2059-4ce5-b789-4700171fb5dc.jpeg',1,11,'Img','2017-11-02 13:35:49'),(60,' ',34,NULL,'','','7eab4a41-fc20-4b73-8fc6-cd278b08792f.gif',1,11,'Img','2017-11-02 13:35:49'),(61,' ',34,NULL,'','','7aee5e92-aa06-474f-9105-c6244c19105d.jpeg',1,11,'Img','2017-11-02 13:35:49'),(62,' ',33,NULL,'','','0ce37b1a-9335-43d0-8fce-db029775db84.jpeg',1,11,'Img','2017-11-02 13:37:41'),(63,' ',33,NULL,'','','2b54fb0f-8ed1-401d-845f-30f33fbae11b.jpg',1,11,'Img','2017-11-02 13:37:41'),(64,' ',46,NULL,'','','02af9ce2-b579-42ad-b882-c4ccc0dfb993.jpg',1,8,'Img','2017-11-02 14:55:52'),(65,' ',47,NULL,'','','397e8fa4-a659-4882-9572-316c9dbbef69.jpg',1,3,'Img','2017-11-02 15:05:20'),(66,' ',48,NULL,'','','c5eff232-f6db-40b6-ae1d-bd2f626b3bcd.jpg',1,2,'Img','2017-11-02 15:11:24'),(67,' ',50,NULL,'','','4e9e5e63-dfb5-47d8-8450-4ad007bd1c8b.jpg',1,6,'Img','2017-11-02 15:22:17'),(68,' ',55,NULL,'','','01666977-0ba2-49cd-a143-ba5016f7f4d4.jpg',1,8,'Img','2018-01-22 11:18:41'),(69,' ',55,NULL,'','','068ccb4c-59dc-40ea-b84b-813626e3d06e.png',1,8,'Img','2018-01-22 11:18:41'),(70,' ',55,NULL,'','','e825c207-b36f-49b1-aa60-b55acc0be081.png',1,8,'Img','2018-01-22 11:18:41'),(71,' ',55,NULL,'','','4e590503-0a84-4763-8594-e751a45add25.jpg',1,8,'Img','2018-01-22 11:18:41'),(72,' ',56,NULL,'','','8925ae01-176e-4d2b-aa00-09e6d197a34c.png',1,8,'Img','2018-01-22 11:44:13'),(73,' ',56,NULL,'','','12fe7d4e-0dcf-4200-992a-fa262d4a6e80.png',1,8,'Img','2018-01-22 11:44:13'),(74,' ',56,NULL,'','','845a6948-10d2-4cfb-9497-1ef00c83daf7.jpg',1,8,'Img','2018-01-22 11:44:13'),(75,' ',56,NULL,'','','e71b2cff-90fe-4b03-9e36-9d636a9f0cd3.jpg',1,8,'Img','2018-01-22 11:44:13'),(76,' ',56,NULL,'','','0594cd20-8a22-4811-9f8f-45e3a2c74c62.png',1,8,'Img','2018-01-22 11:44:13'),(77,' ',56,NULL,'','','ea996700-ca53-4163-bf89-d230e00e6d39.png',1,8,'Img','2018-01-22 11:44:13'),(78,' ',56,NULL,'','','5bdaa849-e4bd-4d4c-96d6-64a4ef8a9dd9.png',1,8,'Img','2018-01-22 11:44:13'),(79,NULL,NULL,42,'test img 1','test alt 1','uploads/users/151708337108zjMLvf2Qy9zgAn.png',1,8,'Img','2018-01-27 18:02:51'),(80,NULL,NULL,42,'test img 2','test alt 2','uploads/users/151708337198WMv6CEKWqfTyyn.jpg',1,8,'Img','2018-01-27 18:02:51'),(81,NULL,NULL,1,'test img1','test','uploads/users/1517083610HxPLZCvfjD3pPmSA.png',1,8,'Img','2018-01-27 18:06:50'),(82,'',57,NULL,NULL,NULL,' ',1,8,'Video','2018-01-29 08:55:51'),(83,'',58,NULL,NULL,NULL,' ',1,8,'Video','2018-01-29 09:00:50'),(84,'',59,NULL,NULL,NULL,' ',1,8,'Video','2018-01-29 09:05:23'),(85,'',60,NULL,NULL,NULL,' ',1,8,'Video','2018-01-29 09:11:42'),(86,NULL,NULL,43,'صورة','صور','uploads/users/1517259104rCHXgvMDkps2jw8t.png',1,8,'Img','2018-01-29 18:51:44'),(87,'',61,NULL,NULL,NULL,' ',1,8,'Video','2018-02-05 09:46:32'),(88,'',62,NULL,NULL,NULL,' ',1,8,'Video','2018-02-05 13:44:39'),(89,NULL,NULL,7,'test img 1','test alt 1','uploads/users/1517918362pAA0CrTNpsTSEpEs.png',1,8,'Img','2018-02-06 09:59:22'),(90,'youtube1.com',NULL,7,NULL,NULL,'0',1,8,'Video','2018-02-06 09:59:22'),(91,'youtub21.com',NULL,7,NULL,NULL,'0',1,8,'Video','2018-02-06 09:59:22');
/*!40000 ALTER TABLE `data_cms_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_media_thumb`
--

DROP TABLE IF EXISTS `data_cms_media_thumb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_media_thumb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `media_id` int(11) NOT NULL,
  `thumb_name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_media_thumb`
--

LOCK TABLES `data_cms_media_thumb` WRITE;
/*!40000 ALTER TABLE `data_cms_media_thumb` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_cms_media_thumb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_menus`
--

DROP TABLE IF EXISTS `data_cms_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(30) NOT NULL,
  `application_id` int(11) NOT NULL,
  `is_main` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_menus`
--

LOCK TABLES `data_cms_menus` WRITE;
/*!40000 ALTER TABLE `data_cms_menus` DISABLE KEYS */;
INSERT INTO `data_cms_menus` VALUES (1,'MainMenu',0,1),(2,'MainMenu',1,1),(3,'MainMenu',597,1),(4,'MainMenu',573,1),(5,'MainMenu',602,1);
/*!40000 ALTER TABLE `data_cms_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_order_item_types`
--

DROP TABLE IF EXISTS `data_cms_order_item_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_order_item_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_order_item_types`
--

LOCK TABLES `data_cms_order_item_types` WRITE;
/*!40000 ALTER TABLE `data_cms_order_item_types` DISABLE KEYS */;
INSERT INTO `data_cms_order_item_types` VALUES (1,'data_cms'),(2,'offer');
/*!40000 ALTER TABLE `data_cms_order_item_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_order_status`
--

DROP TABLE IF EXISTS `data_cms_order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_order_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_name` varchar(25) NOT NULL,
  `display_name` varchar(25) NOT NULL,
  `display_name_ar` varchar(30) DEFAULT NULL,
  `parent_status_id` int(11) DEFAULT '0',
  `application_id` int(11) NOT NULL DEFAULT '0',
  `module_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_order_status`
--

LOCK TABLES `data_cms_order_status` WRITE;
/*!40000 ALTER TABLE `data_cms_order_status` DISABLE KEYS */;
INSERT INTO `data_cms_order_status` VALUES (1,'wishlist','Wish List','قائمة الأمنيات',0,0,0),(2,'cart','Cart','عربة التسوق',0,0,0),(3,'new_order','New Order','طلب جديد',0,0,0),(4,'payment_confirmed','Payment Confirmed','تأكيد الدفع',0,0,0),(5,'payment_rejected','Payment Rejected','رفض الدفع',0,0,0),(6,'pending','Pending','تحت الانتظار',0,0,0),(7,'shipping','Shipping','في الشحن',0,0,0),(8,'delivered','Delivered','تم التسليم',0,0,0),(9,'canceled','Canceled','لاغي',0,0,0),(10,'returned','Returned','مرتجع',0,0,0),(11,'in_progress','In Progress','جاري العمل',10,0,0),(12,'returned_with_permission','Returned With Permission','مرتجع مع عذر',10,0,0),(13,'fix_product','Fix Product','اصلاح المنتج',10,0,0),(14,'return_product','Return Product','مرتجع المنتج',10,0,0),(15,'reject_product','Reject Product','رفض المنتج',10,0,0),(16,'cancel','Cancel','إلغاء',10,0,0);
/*!40000 ALTER TABLE `data_cms_order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_order_status_lang`
--

DROP TABLE IF EXISTS `data_cms_order_status_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_order_status_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_title` varchar(30) CHARACTER SET utf8 NOT NULL,
  `status_id` int(11) NOT NULL,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_order_status_lang`
--

LOCK TABLES `data_cms_order_status_lang` WRITE;
/*!40000 ALTER TABLE `data_cms_order_status_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_cms_order_status_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_orders`
--

DROP TABLE IF EXISTS `data_cms_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_orders` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL DEFAULT '0',
  `address_id` int(11) NOT NULL DEFAULT '0',
  `date` varchar(255) NOT NULL,
  `updated_at` varchar(255) NOT NULL DEFAULT '1',
  `application_id` int(10) NOT NULL,
  `module_id` int(10) NOT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `payment_receipt` varchar(255) DEFAULT NULL,
  `user_comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_orders`
--

LOCK TABLES `data_cms_orders` WRITE;
/*!40000 ALTER TABLE `data_cms_orders` DISABLE KEYS */;
INSERT INTO `data_cms_orders` VALUES (1,1,1,'1508592044','1508592044',1,8,NULL,2,NULL,NULL),(2,1,1,'1508592044','1508592044',1,8,NULL,1,NULL,NULL),(3,8,9,'1509528027','1509539151',1,1,300.00,3,'uploads/tanks/payment_receipts/1ir1or315v.png',NULL),(4,11,10,'1509538843','1509552184',1,1,100.00,3,'uploads/tanks/payment_receipts/0jmc111lb1.jpeg',NULL),(5,8,9,'1509539151','1509539586',1,1,300.00,3,'uploads/tanks/payment_receipts/ke571gkyr1.png',NULL),(6,8,9,'1509539586','1509539799',1,1,400.00,3,'uploads/tanks/payment_receipts/2y7o8090c6.png',NULL),(7,8,9,'1509539799','1509539969',1,1,10.00,3,'uploads/tanks/payment_receipts/0mi7n8098p.png',NULL),(8,8,9,'1509539969','1509540435',1,1,100.00,3,'uploads/tanks/payment_receipts/lng4sfl81.png',NULL),(9,8,9,'1509540435','1509542375',1,1,0.00,3,'uploads/tanks/payment_receipts/0g9dc0ro19.png',NULL),(10,8,9,'1509542375','1509542528',1,1,0.00,3,'uploads/tanks/payment_receipts/tr41b111g1.png',NULL),(11,8,9,'1509542528','1509542667',1,1,0.00,3,'uploads/tanks/payment_receipts/501m99nb72.png',NULL),(12,8,9,'1509542667','1509542844',1,1,0.00,3,'uploads/tanks/payment_receipts/mve9i23si2.png',NULL),(13,8,9,'1509542844','1509543001',1,1,0.00,3,'uploads/tanks/payment_receipts/6rbnwh8411.png',NULL),(14,8,9,'1509543001','1509543205',1,1,0.00,3,'uploads/tanks/payment_receipts/k951010vm1.png',NULL),(15,8,9,'1509543205','1509543593',1,1,0.00,3,'uploads/tanks/payment_receipts/8j1y3410lv.png',NULL),(16,8,9,'1509543593','1509543926',1,1,501.00,4,'uploads/tanks/payment_receipts/111c10905n.png',NULL),(17,8,8,'1509543926','1509746283',1,1,100.00,3,'uploads/tanks/payment_receipts/1qg119cti1.png',NULL),(18,11,0,'1509551680','1509551680',1,1,NULL,1,NULL,NULL),(19,11,11,'1509552184','1509637185',1,1,701.00,3,'uploads/tanks/payment_receipts/vt17w051o8.jpg',NULL),(20,11,0,'1509637185','1509637185',1,1,NULL,2,NULL,NULL),(21,8,0,'1509662130','1509662130',1,1,NULL,1,NULL,NULL),(22,8,0,'1509746283','1509746283',1,1,NULL,2,NULL,NULL),(23,12,0,'1509796304','1509796304',1,1,NULL,1,NULL,NULL),(24,13,0,'1509799045','1509799045',1,1,NULL,1,NULL,NULL),(25,0,0,'1509912573','1509912573',1,1,NULL,2,NULL,NULL),(26,13,0,'1509954807','1509954807',1,1,NULL,2,NULL,NULL),(27,19,0,'1511098922','1511098922',1,1,NULL,2,NULL,NULL),(28,20,17,'1511169278','1511173311',1,1,15300.00,3,'uploads/tanks/payment_receipts/803l1t1z1a.jpeg',NULL),(29,20,0,'1511173311','1511173311',1,1,NULL,2,NULL,NULL),(30,22,0,'1512310421','1512310421',1,1,NULL,1,NULL,NULL),(31,22,0,'1512311009','1512311009',1,1,NULL,2,NULL,NULL),(32,32,0,'1515512464','1515512464',1,1,NULL,2,NULL,NULL),(33,32,0,'1515512464','1515512464',1,1,NULL,1,NULL,NULL),(34,26,0,'1515679178','1515679178',1,1,NULL,2,NULL,NULL),(35,34,0,'1515928333','1515928333',1,1,NULL,2,NULL,NULL),(36,34,0,'1515928333','1515928333',1,1,NULL,1,NULL,NULL),(37,36,0,'1515934534','1515934534',1,1,NULL,2,NULL,NULL),(38,36,0,'1515934534','1515934534',1,1,NULL,1,NULL,NULL),(39,35,0,'1515934552','1515934552',1,1,NULL,2,NULL,NULL),(40,35,0,'1515934552','1515934552',1,1,NULL,1,NULL,NULL),(41,37,0,'1515944609','1515944609',1,1,NULL,2,NULL,NULL),(42,37,0,'1515944609','1515944609',1,1,NULL,1,NULL,NULL),(43,38,0,'1516021848','1516021848',1,1,NULL,2,NULL,NULL),(44,38,0,'1516021848','1516021848',1,1,NULL,1,NULL,NULL),(45,39,0,'1516283172','1516283172',1,1,NULL,2,NULL,NULL),(46,39,0,'1516283172','1516283172',1,1,NULL,1,NULL,NULL),(47,43,0,'1517007302','1517007302',1,1,NULL,2,NULL,NULL),(48,47,0,'1517827372','1517827372',1,1,NULL,2,NULL,NULL);
/*!40000 ALTER TABLE `data_cms_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_orders_keyvalue`
--

DROP TABLE IF EXISTS `data_cms_orders_keyvalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_orders_keyvalue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(200) NOT NULL,
  `time` varchar(50) NOT NULL,
  `dkv_id` int(11) NOT NULL COMMENT 'دا الكولم الفعلي بتاع الكي والفاليو',
  `purchase_id` int(5) NOT NULL,
  `application_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `lang_id` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_orders_keyvalue`
--

LOCK TABLES `data_cms_orders_keyvalue` WRITE;
/*!40000 ALTER TABLE `data_cms_orders_keyvalue` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_cms_orders_keyvalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_orders_purchase`
--

DROP TABLE IF EXISTS `data_cms_orders_purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_orders_purchase` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) NOT NULL DEFAULT '0',
  `item_type_id` int(11) DEFAULT NULL,
  `item_id` int(10) NOT NULL DEFAULT '0',
  `date` varchar(255) NOT NULL,
  `application_id` int(10) NOT NULL,
  `module_id` int(10) NOT NULL,
  `cost` varchar(50) NOT NULL,
  `count` int(4) NOT NULL,
  `updated_at` varchar(20) DEFAULT NULL,
  `color` int(11) DEFAULT NULL COMMENT 'relation to the setup colors',
  `delivery_place` int(11) DEFAULT NULL COMMENT 'relation to the company branches',
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_orders_purchase`
--

LOCK TABLES `data_cms_orders_purchase` WRITE;
/*!40000 ALTER TABLE `data_cms_orders_purchase` DISABLE KEYS */;
INSERT INTO `data_cms_orders_purchase` VALUES (2,1,2,29,'1508940435',1,8,'0',1,'1508940435',NULL,NULL),(5,2,2,28,'1508930377',1,8,'0',0,'1508930377',NULL,NULL),(35,28,1,37,'1511169286',1,1,'0',2,'1511169286',NULL,2),(36,28,1,29,'1511169294',1,1,'0',2,'1511169294',NULL,2),(38,34,1,42,'1516117480',1,1,'0',1,'1516117480',NULL,2),(39,34,1,53,'1516117478',1,1,'0',1,'1516117478',NULL,2),(40,34,1,41,'1516117481',1,1,'0',1,'1516117481',NULL,2),(41,46,1,40,'1517260246',1,1,'0',0,'1517260246',NULL,NULL),(42,45,1,38,'1516283878',1,1,'0',1,'1516283878',NULL,1),(44,47,1,59,'1517744302',1,1,'0',1,'1517744302',NULL,2),(45,48,1,60,'1517827375',1,1,'0',1,'1517827375',NULL,2),(46,47,1,58,'1517744307',1,1,'0',4,'1517744307',NULL,2),(47,48,1,61,'1517827372',1,1,'0',1,'1517827372',NULL,2);
/*!40000 ALTER TABLE `data_cms_orders_purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_rates_types`
--

DROP TABLE IF EXISTS `data_cms_rates_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_rates_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_rates_types`
--

LOCK TABLES `data_cms_rates_types` WRITE;
/*!40000 ALTER TABLE `data_cms_rates_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_cms_rates_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_saved_filter`
--

DROP TABLE IF EXISTS `data_cms_saved_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_saved_filter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filter` text NOT NULL,
  `action` varchar(30) NOT NULL DEFAULT 'content_search',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `application_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_saved_filter`
--

LOCK TABLES `data_cms_saved_filter` WRITE;
/*!40000 ALTER TABLE `data_cms_saved_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_cms_saved_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_users`
--

DROP TABLE IF EXISTS `data_cms_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `data_cms_id` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_users`
--

LOCK TABLES `data_cms_users` WRITE;
/*!40000 ALTER TABLE `data_cms_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_cms_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_users_follow`
--

DROP TABLE IF EXISTS `data_cms_users_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_users_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `data_cms_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `type` int(11) NOT NULL COMMENT 'follow 1,favourite 2, going 3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_users_follow`
--

LOCK TABLES `data_cms_users_follow` WRITE;
/*!40000 ALTER TABLE `data_cms_users_follow` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_cms_users_follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cms_users_rates`
--

DROP TABLE IF EXISTS `data_cms_users_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cms_users_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `data_cms_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `type` int(11) NOT NULL COMMENT 'Clean,Expensive,Service .. etc',
  `rate` int(11) NOT NULL DEFAULT '0' COMMENT '1 to 5',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cms_users_rates`
--

LOCK TABLES `data_cms_users_rates` WRITE;
/*!40000 ALTER TABLE `data_cms_users_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_cms_users_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_form_charts`
--

DROP TABLE IF EXISTS `data_form_charts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_form_charts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `name_ar` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_form_charts`
--

LOCK TABLES `data_form_charts` WRITE;
/*!40000 ALTER TABLE `data_form_charts` DISABLE KEYS */;
INSERT INTO `data_form_charts` VALUES (2,'Donut Chart','Donut Chart'),(3,'Bar Chart','مخطط شريطي رأسي'),(4,'Horizontal Bar Chart',' مخطط شريطي أفقي'),(5,'Stack Chart','Stack Chart');
/*!40000 ALTER TABLE `data_form_charts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_form_field_charts`
--

DROP TABLE IF EXISTS `data_form_field_charts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_form_field_charts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `data_form_field_id` int(11) NOT NULL,
  `data_form_chart_id` int(11) NOT NULL,
  `data_form_fixed_question_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=571 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_form_field_charts`
--

LOCK TABLES `data_form_field_charts` WRITE;
/*!40000 ALTER TABLE `data_form_field_charts` DISABLE KEYS */;
INSERT INTO `data_form_field_charts` VALUES (30,'whatever',3,5,NULL),(32,'رسم بياني 2',24,4,NULL),(34,'جديد رسم بياني',26,2,NULL),(35,'تصحيح ',26,3,NULL),(36,'donut',8,2,NULL),(37,'test',8,5,NULL),(40,'team',33,3,0),(41,'team2',33,5,0),(225,'chart',369,3,NULL),(226,'جديد',370,3,0),(228,'',372,3,0),(229,'New Chart Donut',373,2,0),(231,'Bar Chart',373,3,0),(233,'new',412,4,0),(234,'chart',397,4,NULL),(235,'donut',398,5,0),(237,'go',400,2,NULL),(291,'',666,2,0),(292,'',667,3,0),(293,'',668,5,0),(294,'',669,4,0),(296,'',671,2,0),(297,'',672,4,0),(298,'',673,4,0),(299,'',674,2,0),(300,'',675,5,0),(301,'',676,5,0),(302,'',679,5,0),(316,'club',687,2,0),(317,'my player',688,3,0),(389,'ما هى ماركات الخزانات التى لديك بالمحل / المؤسسة',823,2,0),(390,'ما هى ماركات الخزانات التى لديك بالمحل / المؤسسة',823,3,0),(391,'ما هى نوعية خزانات المياه التى تتعامل فى بيعها ',827,4,0),(392,'ما هى نوعية خزانات المياه التى تتعامل فى بيعها ',827,4,0),(401,'ما هى ماركات الخزانات التى لديك بالمحل / المؤسسة',833,2,0),(402,'ما هى ماركات الخزانات التى لديك بالمحل / المؤسسة',833,3,0),(404,' ما هى نوعية خزانات المياه التى تتعامل فى بيعها',837,2,0),(405,' ما هى نوعية خزانات المياه التى تتعامل فى بيعها',837,3,0),(406,'ا مدى رضائك عن المصنع / المصنعين الذين تتعامل معهم مباشرة',838,4,0),(453,'ما هى ماركات الخزانات التى لديك بالمحل / المؤسسة',844,2,0),(454,'ما هى ماركات الخزانات التى لديك بالمحل / المؤسسة',844,3,0),(455,'ما هى ماركات الخزانات التى لديك بالمحل / المؤسسة',844,5,37),(457,'ما هى نوعية خزانات المياه التى تتعامل فى بيعها',848,4,0),(458,' اذكر افضل مصنع خزانات مياه من بين جميع المصانع ',849,3,0),(461,'hor bar',867,4,NULL),(463,'tytuyi',737,4,0),(482,'aaaaaaaaa',732,5,NULL),(484,'اذا تكلمنا عن خزانات المياه ، ما هى ماركات الخزانات التى لديك بالمحل / المؤسسة',718,3,0),(486,'aaaaaaaaaaaaaa',718,5,0),(487,'',719,5,36),(489,'',721,4,0),(491,'',721,4,0),(510,'اذا تكلمنا عن خزانات المياه ، ما هى ماركات الخزانات التى لديك بالمحل / المؤسسة',934,2,0),(511,'اذا تكلمنا عن خزانات المياه ، ما هى ماركات الخزانات التى لديك بالمحل / المؤسسة',934,4,0),(512,'من هم مصنعى خزانات المياه الذين تتعامل معهم مباشرة عن طريق مندوب الشركة',935,2,0),(513,'من هم مصنعى خزانات المياه الذين تتعامل معهم مباشرة عن طريق مندوب الشركة',935,5,0),(514,'ما هى نوعية خزانات المياه التى تتعامل فى بيعها ',938,3,0),(515,'ما هى نوعية خزانات المياه التى تتعامل فى بيعها ',938,2,0),(518,'ما هى الحوافز البيعية التى يعطيها لك مصنع',939,4,0),(519,'ما هى الحوافز البيعية التى يعطيها لك مصنع',939,3,0),(521,'ما هى الحوافز البيعية التى يعطيها لك مصنع',940,2,0),(522,'ما هى الحوافز البيعية التى يعطيها لك مصنع',940,4,0),(524,'ما مدى رضائك عن المصنع / المصنعين الذين تتعامل معهم مباشرة',941,2,0),(525,'ما مدى رضائك عن المصنع / المصنعين الذين تتعامل معهم مباشرة',941,3,0),(562,'اذا تكلمنا عن خزانات المياه ',952,4,0),(563,'اذا تكلمنا عن خزانات المياه ',952,2,0),(564,'اذا تكلمنا عن خزانات المياه ',952,3,0),(565,'من هم مصنعى خزانات المياه الذين تتعامل معهم مباشرة عن طريق مندوب الشركة',956,4,0),(566,'من هم مصنعى خزانات المياه الذين تتعامل معهم مباشرة عن طريق مندوب الشركة',956,2,0),(567,'من هم مصنعى خزانات المياه الذين تتعامل معهم مباشرة عن طريق مندوب الشركة',956,5,0),(568,'ما مدى رضائك عن المصنع',957,2,0),(569,'ما مدى رضائك عن المصنع',957,2,0),(570,'ما مدى رضائك عن المصنع',957,3,0);
/*!40000 ALTER TABLE `data_form_field_charts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_form_field_options`
--

DROP TABLE IF EXISTS `data_form_field_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_form_field_options` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `selected` tinyint(1) DEFAULT NULL,
  `application_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `data_form_field_id` int(11) NOT NULL,
  `data_form_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_form_field_options`
--

LOCK TABLES `data_form_field_options` WRITE;
/*!40000 ALTER TABLE `data_form_field_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_form_field_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_form_fields`
--

DROP TABLE IF EXISTS `data_form_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_form_fields` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `field_type_id` int(11) NOT NULL,
  `sub_type` varchar(255) DEFAULT NULL,
  `placeholder` varchar(45) DEFAULT NULL,
  `class_name` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `setup_field_validation_id` int(11) NOT NULL,
  `min` varchar(255) DEFAULT NULL,
  `max` varchar(255) DEFAULT NULL,
  `is_filter` tinyint(1) DEFAULT NULL,
  `is_required` varchar(255) DEFAULT NULL,
  `data_form_id` int(10) NOT NULL,
  `order` int(3) NOT NULL,
  `question_type` int(11) DEFAULT '1',
  `parent_id` int(11) DEFAULT NULL,
  `scale_label_1` varchar(255) DEFAULT NULL,
  `scale_label_2` varchar(255) DEFAULT NULL,
  `helptext` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_form_fields`
--

LOCK TABLES `data_form_fields` WRITE;
/*!40000 ALTER TABLE `data_form_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_form_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_form_fixed_question_responses`
--

DROP TABLE IF EXISTS `data_form_fixed_question_responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_form_fixed_question_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_form_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `fixed_question_id` int(11) DEFAULT NULL,
  `response_field` varchar(255) DEFAULT NULL,
  `response_value` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `unique_id` varchar(255) DEFAULT NULL,
  `created_at` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_form_fixed_question_responses`
--

LOCK TABLES `data_form_fixed_question_responses` WRITE;
/*!40000 ALTER TABLE `data_form_fixed_question_responses` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_form_fixed_question_responses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_form_fixed_question_types`
--

DROP TABLE IF EXISTS `data_form_fixed_question_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_form_fixed_question_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_name` varchar(35) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `entity_field_name` varchar(35) DEFAULT NULL,
  `field_type_id` int(11) DEFAULT NULL,
  `display_name` varchar(35) DEFAULT NULL,
  `display_name_ar` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_form_fixed_question_types`
--

LOCK TABLES `data_form_fixed_question_types` WRITE;
/*!40000 ALTER TABLE `data_form_fixed_question_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_form_fixed_question_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_form_fixed_questions`
--

DROP TABLE IF EXISTS `data_form_fixed_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_form_fixed_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `field_type_id` int(11) DEFAULT NULL,
  `response_enity_id` int(11) DEFAULT NULL,
  `response_field` varchar(255) DEFAULT NULL,
  `fixed_question_type_id` int(11) DEFAULT NULL,
  `is_shown` tinyint(1) NOT NULL DEFAULT '1',
  `display_name_ar` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_form_fixed_questions`
--

LOCK TABLES `data_form_fixed_questions` WRITE;
/*!40000 ALTER TABLE `data_form_fixed_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_form_fixed_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_form_grid_columns`
--

DROP TABLE IF EXISTS `data_form_grid_columns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_form_grid_columns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_form_field_id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf16 COLLATE utf16_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_form_grid_columns`
--

LOCK TABLES `data_form_grid_columns` WRITE;
/*!40000 ALTER TABLE `data_form_grid_columns` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_form_grid_columns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_form_grid_rows`
--

DROP TABLE IF EXISTS `data_form_grid_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_form_grid_rows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_form_field_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_form_grid_rows`
--

LOCK TABLES `data_form_grid_rows` WRITE;
/*!40000 ALTER TABLE `data_form_grid_rows` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_form_grid_rows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_form_groups`
--

DROP TABLE IF EXISTS `data_form_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_form_groups` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `data_form_id` int(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_form_groups`
--

LOCK TABLES `data_form_groups` WRITE;
/*!40000 ALTER TABLE `data_form_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_form_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_form_option_fields`
--

DROP TABLE IF EXISTS `data_form_option_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_form_option_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_forms_option_id` int(11) NOT NULL,
  `data_forms_field_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_form_option_fields`
--

LOCK TABLES `data_form_option_fields` WRITE;
/*!40000 ALTER TABLE `data_form_option_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_form_option_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_form_question_types`
--

DROP TABLE IF EXISTS `data_form_question_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_form_question_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_ar` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `is_shown` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_form_question_types`
--

LOCK TABLES `data_form_question_types` WRITE;
/*!40000 ALTER TABLE `data_form_question_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_form_question_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_form_response_details`
--

DROP TABLE IF EXISTS `data_form_response_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_form_response_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_form_response_id` int(11) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_form_response_details`
--

LOCK TABLES `data_form_response_details` WRITE;
/*!40000 ALTER TABLE `data_form_response_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_form_response_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_form_responses`
--

DROP TABLE IF EXISTS `data_form_responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_form_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_form_id` int(11) NOT NULL,
  `data_form_field_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `response_json` varchar(255) DEFAULT NULL,
  `ip` varchar(50) NOT NULL,
  `user_id` int(10) NOT NULL,
  `unique_id` varchar(255) DEFAULT NULL,
  `created_at` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_form_responses`
--

LOCK TABLES `data_form_responses` WRITE;
/*!40000 ALTER TABLE `data_form_responses` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_form_responses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_forms`
--

DROP TABLE IF EXISTS `data_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_forms` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `application_id` int(11) NOT NULL,
  `type` enum('DB','Survey') NOT NULL DEFAULT 'Survey',
  `module_id` int(11) NOT NULL,
  `target_module_id` int(5) NOT NULL DEFAULT '0',
  `target_action_id` int(5) NOT NULL DEFAULT '0',
  `target_layout_id` int(5) NOT NULL DEFAULT '0',
  `login` int(5) NOT NULL DEFAULT '0',
  `api` varchar(245) NOT NULL,
  `notifications` int(4) NOT NULL,
  `see_responses` int(4) NOT NULL,
  `questions_type` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_forms`
--

LOCK TABLES `data_forms` WRITE;
/*!40000 ALTER TABLE `data_forms` DISABLE KEYS */;
INSERT INTO `data_forms` VALUES (1,'contact us',1,'Survey',8,0,0,0,0,'',0,0,1),(2,'Request Visit',1,'Survey',8,0,0,0,0,'',0,0,1);
/*!40000 ALTER TABLE `data_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_forms_lang`
--

DROP TABLE IF EXISTS `data_forms_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_forms_lang` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `form_id` int(5) NOT NULL DEFAULT '0',
  `lang_id` int(5) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_forms_lang`
--

LOCK TABLES `data_forms_lang` WRITE;
/*!40000 ALTER TABLE `data_forms_lang` DISABLE KEYS */;
INSERT INTO `data_forms_lang` VALUES (1,'اتصل بنا',1,1),(2,'Contact us',1,2);
/*!40000 ALTER TABLE `data_forms_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_forms_response`
--

DROP TABLE IF EXISTS `data_forms_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_forms_response` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(2) NOT NULL,
  `response` text NOT NULL,
  `ip` varchar(50) NOT NULL,
  `user_id` int(10) NOT NULL,
  `date` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_forms_response`
--

LOCK TABLES `data_forms_response` WRITE;
/*!40000 ALTER TABLE `data_forms_response` DISABLE KEYS */;
INSERT INTO `data_forms_response` VALUES (2,1,'{\"Login\":\"0\",\"msg\":\"La valse de mille temps\",\"send\":\"0\",\"mail\":\"islam.hamdy@pentavalue.com\",\"Name\":\"islam test\",\"Title\":\"Customer Service Enquiry\"}','192.168.1.1',0,'1509541724'),(3,1,'{\"Login\":\"0\",\"msg\":\"Stranger in the night\",\"send\":\"0\",\"mail\":\"islam87@live.com\",\"Name\":\"Islam\",\"Title\":\"Customer Service Enquiry\"}','192.168.1',0,'1509619947'),(4,1,'{\"Login\":\"0\",\"msg\":\"Stranger in the night\",\"send\":\"0\",\"mail\":\"islam87@live.com\",\"Name\":\"Islam\",\"Title\":\"Customer Service Enquiry\"}','192.168.1',0,'1509620006'),(5,1,'{\"Login\":\"0\",\"msg\":\"Stranger in the night sa7 \",\"send\":\"0\",\"mail\":\"salma@yahoo.com\",\"Name\":\"Salma Omar\",\"Title\":\"Customer Service Enquiry\"}','192.168.1.3333',0,'1509621059'),(6,1,'{\"Login\":\"0\",\"msg\":null,\"send\":\"0\",\"mail\":null,\"Name\":null,\"Title\":\"Customer Service Enquiry\"}','156.203.48.234',0,'1509623958'),(7,1,'{\"Login\":\"0\",\"msg\":null,\"send\":\"0\",\"mail\":null,\"Name\":null,\"Title\":\"Customer Service Enquiry\"}','156.203.48.234',0,'1509624023'),(8,1,'{\"Login\":\"0\",\"msg\":\"say the truth\",\"send\":\"0\",\"mail\":\"wael.fci@gmail.com\",\"Name\":\"wael salah\",\"Title\":\"Customer Service Enquiry\"}','156.203.48.234',0,'1509624114'),(9,1,'{\"Login\":\"0\",\"msg\":null,\"send\":\"0\",\"mail\":null,\"Name\":null,\"Title\":\"Customer Service Enquiry\"}','41.35.138.185',0,'1509633905'),(10,2,'{\"date\":\"1509633538\",\"name\":\"A user\",\"mobile\":\"01125445566\",\"location\":\"Riad KSA\",\"user_id\":11}','0',11,'1509634155'),(11,2,'{\"date\":\"1288-04-05\",\"name\":\"wael salah\",\"mobile\":\"02345673334\",\"location\":\"almaza\",\"user_id\":\"8\",\"lang_id\":1}','0',8,'1509716018'),(12,2,'{\"date\":\"2017-02-03\",\"name\":\"wael salah\",\"mobile\":\"3244563221\",\"location\":\"almaza\",\"user_id\":\"8\",\"lang_id\":1}','0',8,'1509716329'),(13,2,'{\"date\":\"2017-11-11\",\"name\":\"test user\",\"mobile\":\"01123252211\",\"location\":\"ksa\",\"user_id\":\"13\",\"lang_id\":1}','0',13,'1510418273'),(14,1,'{\"Login\":\"0\",\"msg\":\"hi tester\",\"send\":\"0\",\"mail\":\"amralaaismail30@gmail.com\",\"Name\":\"amr\",\"Title\":\"Customer Service Enquiry\"}','45.247.102.163',0,'1512314906'),(15,1,'{\"Login\":\"0\",\"msg\":\"hi\",\"send\":\"0\",\"mail\":\"amralaaismail30@gmail.com\",\"Name\":\"amr\",\"Title\":\"Customer Service Enquiry\"}','41.35.242.251',0,'1513088805');
/*!40000 ALTER TABLE `data_forms_response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_keyvalue`
--

DROP TABLE IF EXISTS `data_keyvalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_keyvalue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paramter` varchar(244) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `ckv_id` int(5) NOT NULL,
  `depts_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `group_id` int(4) NOT NULL DEFAULT '1' COMMENT 'هو موجود في مجموعه كام ',
  `show` tinyint(4) NOT NULL DEFAULT '0',
  `show_kv` tinyint(4) NOT NULL DEFAULT '1',
  `ckvt_id` int(4) NOT NULL DEFAULT '0',
  `has_langs` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `Depts_ID` (`depts_id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_keyvalue`
--

LOCK TABLES `data_keyvalue` WRITE;
/*!40000 ALTER TABLE `data_keyvalue` DISABLE KEYS */;
INSERT INTO `data_keyvalue` VALUES (2,'creation_date',NULL,2,0,1,1,1,0,1,0,0),(4,'pdf_file',NULL,4,0,1,4,3,0,1,0,0),(6,'supervisor_comment',NULL,2,0,1,8,5,0,1,0,0),(7,'maintainable',NULL,1,0,1,8,5,0,1,0,0),(8,'in_warranty',NULL,1,0,1,8,5,0,1,0,0),(9,'warranty_period',NULL,1,0,1,8,5,1,1,0,0),(10,'other_warranty_period',NULL,2,0,1,8,5,1,1,0,0),(11,'delivery_date',NULL,1,0,1,8,5,0,1,0,0),(12,'important_notes',NULL,2,0,1,8,5,1,1,0,0),(13,'is_published',NULL,1,0,1,8,5,1,1,0,0),(14,'pumping_fluid',NULL,2,4,1,8,6,0,1,0,0),(15,'liquid_temperature',NULL,2,4,1,8,6,0,1,0,0),(16,'denisty',NULL,2,4,1,8,6,0,1,0,0),(17,'sealant',NULL,2,4,1,8,6,0,1,0,0),(18,'pump_certificates',NULL,2,4,1,8,6,1,1,0,0),(19,'pump_curve',NULL,2,4,1,8,6,1,1,0,0),(20,'pump_body',NULL,2,4,1,8,6,1,1,0,0),(21,'propeller',NULL,2,4,1,8,6,0,1,0,0),(22,'temperature',NULL,2,4,1,8,6,0,1,0,0),(23,'endurance_compression',NULL,2,4,1,8,6,0,1,0,0),(24,'electric_power',NULL,2,4,1,8,6,0,1,0,0),(25,'frequency',NULL,2,4,1,8,6,1,1,0,0),(26,'voltages',NULL,2,4,1,8,6,1,1,0,0),(27,'electric_current',NULL,2,4,1,8,6,1,1,0,0),(28,'engine_protection_degree',NULL,2,4,1,8,6,1,1,0,0),(29,'engine_insulation',NULL,2,4,1,8,6,1,1,0,0),(30,'plug',NULL,2,4,1,8,6,1,1,0,0),(31,'model',NULL,2,4,1,8,6,1,1,0,0),(32,'tall',NULL,2,4,1,8,6,1,1,0,0),(33,'width',NULL,2,4,1,8,6,1,1,0,0),(34,'height_1',NULL,2,4,1,8,6,1,1,0,0),(35,'height_2',NULL,2,4,1,8,6,1,1,0,0),(36,'height_3',NULL,2,4,1,8,6,1,1,0,0),(37,'hot_water_evaporation',NULL,2,4,1,8,6,1,1,0,0),(38,'hole_depth',NULL,2,4,1,8,6,1,1,0,0),(39,'tank_volume',NULL,2,4,1,8,6,1,1,0,0),(40,'adjustable_tank_temperature',NULL,2,4,1,8,6,1,1,0,0),(41,'desired_feeding_pressure',NULL,2,4,1,8,6,1,1,0,0),(42,'warranty',NULL,2,4,1,8,6,1,1,0,0),(43,'feeding_type',NULL,2,4,1,8,6,1,1,0,0),(44,'on_off',NULL,2,4,1,8,6,1,1,0,0),(45,'power_supply',NULL,2,4,1,8,6,1,1,0,0),(46,'time_estimation',NULL,2,4,1,8,6,1,1,0,0),(47,'lubrication',NULL,2,4,1,8,6,1,1,0,0),(48,'milling_technology',NULL,2,4,1,8,6,1,1,0,0),(49,'sound_technology',NULL,2,4,1,8,6,1,1,0,0),(50,'volts_hz',NULL,2,4,1,8,6,1,1,0,0),(51,'grinding_room_capacity',NULL,2,4,1,8,6,1,1,0,0),(52,'water_consumption_rate',NULL,2,4,1,8,6,1,1,0,0),(53,'electricity_consumption_rate',NULL,2,4,1,8,6,1,1,0,0),(54,'sewerage_network',NULL,2,4,1,8,6,1,1,0,0),(55,'connected_to_dishwasher',NULL,2,4,1,8,6,1,1,0,0),(56,'sound_reduction_technology',NULL,2,4,1,8,6,1,1,0,0),(57,'grinding_stages_count',NULL,2,4,1,8,6,1,1,0,0),(58,'engine',NULL,2,4,1,8,6,1,1,0,0),(59,'embedded_antenna_key',NULL,2,4,1,8,6,1,1,0,0),(60,'energy_efficiency_circuit',NULL,2,4,1,8,6,1,1,0,0),(61,'filter_plug_and_bristles',NULL,2,4,1,8,6,1,1,0,0),(62,'control_extension_through_cover',NULL,2,4,1,8,6,1,1,0,0),(63,'stainless_steel_grinding_items',NULL,2,4,1,8,6,1,1,0,0),(64,'net_slot_cover',NULL,2,4,1,8,6,1,1,0,0),(65,'size',NULL,2,4,1,8,6,1,1,0,0),(66,'ton',NULL,2,4,1,8,6,1,1,0,0),(67,'max_gate_weight',NULL,2,4,1,8,6,1,1,0,0),(68,'engine_power_supplies',NULL,2,4,1,8,6,1,1,0,0),(69,'energy_consumption',NULL,2,4,1,8,6,1,1,0,0),(70,'speed',NULL,2,4,1,8,6,1,1,0,0),(71,'gate_sliding_distance',NULL,2,4,1,8,6,1,1,0,0),(72,'cycles_number',NULL,2,4,1,8,6,1,1,0,0),(73,'max_engine_running_time',NULL,2,4,1,8,6,1,1,0,0),(74,'max_running_times_per_day',NULL,2,4,1,8,6,1,1,0,0),(75,'temperature_when_running',NULL,2,4,1,8,6,1,1,0,0),(76,'gate_warranty',NULL,2,4,1,8,6,1,1,0,0),(77,'engine_warranty',NULL,2,4,1,8,6,1,1,0,0),(78,'lighting_area',NULL,2,4,1,8,6,1,1,0,0),(80,'avaliable_colors_entity',NULL,8,0,1,8,5,0,1,0,0),(81,'pdf_file',NULL,4,0,1,5,7,0,1,0,0),(83,'email',NULL,2,0,1,7,9,0,1,0,0),(84,'mobile1',NULL,2,0,1,7,9,0,1,0,0),(85,'mobile2',NULL,2,0,1,7,9,0,1,0,0),(86,'address',NULL,2,0,1,7,9,0,1,0,0),(87,'fax',NULL,2,0,1,7,9,0,1,0,0),(88,'horizontal_tank_capacity',NULL,1,4,1,8,6,1,1,0,0),(89,'vertical_tank_capacity',NULL,1,4,1,8,6,1,1,0,0),(90,'capacity_daffan_tanks',NULL,1,4,1,8,6,1,1,0,0),(91,'capacity_pathways_tanks',NULL,1,4,1,8,6,1,1,0,0),(92,'capacity_stairs_tanks',NULL,1,4,1,8,6,1,1,0,0),(93,'ground_covers_type',NULL,1,4,1,8,6,1,1,0,0),(94,'size_ground_covers',NULL,1,4,1,8,6,1,1,0,0),(95,'type_automatic_doors',NULL,1,4,1,8,6,1,1,0,0),(96,'size_automatic_doors',NULL,1,4,1,8,6,1,1,0,0),(97,'type_pumps',NULL,1,4,1,8,6,0,1,0,0),(98,'size_pumps',NULL,1,4,1,8,6,1,1,0,0);
/*!40000 ALTER TABLE `data_keyvalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_keyvalue_db`
--

DROP TABLE IF EXISTS `data_keyvalue_db`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_keyvalue_db` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dkv_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `core_dept_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_keyvalue_db`
--

LOCK TABLES `data_keyvalue_db` WRITE;
/*!40000 ALTER TABLE `data_keyvalue_db` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_keyvalue_db` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_keyvalue_dept_cms`
--

DROP TABLE IF EXISTS `data_keyvalue_dept_cms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_keyvalue_dept_cms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dkv_id` int(11) NOT NULL,
  `dept_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `subject_to_maintenance` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=404 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_keyvalue_dept_cms`
--

LOCK TABLES `data_keyvalue_dept_cms` WRITE;
/*!40000 ALTER TABLE `data_keyvalue_dept_cms` DISABLE KEYS */;
INSERT INTO `data_keyvalue_dept_cms` VALUES (104,31,15,1,0),(105,32,15,1,0),(106,33,15,1,0),(107,34,15,1,0),(108,35,15,1,0),(109,36,15,1,0),(273,31,32,1,0),(274,33,32,1,0),(275,34,32,1,0),(276,76,32,1,0),(277,77,32,1,0),(285,42,30,1,0),(286,43,30,1,0),(287,44,30,1,0),(288,45,30,1,0),(289,46,30,1,0),(290,47,30,1,0),(291,48,30,1,0),(292,49,30,1,0),(293,50,30,1,0),(294,51,30,1,0),(295,52,30,1,0),(296,53,30,1,0),(297,54,30,1,0),(298,55,30,1,0),(299,56,30,1,0),(300,57,30,1,0),(301,58,30,1,0),(302,59,30,1,0),(303,60,30,1,0),(304,61,30,1,0),(305,62,30,1,0),(306,63,30,1,0),(307,30,29,1,0),(308,37,29,1,0),(309,38,29,1,0),(310,39,29,1,0),(311,40,29,1,0),(312,41,29,1,0),(313,42,29,1,0),(343,89,40,1,1),(345,91,42,1,1),(352,31,31,1,0),(353,34,31,1,0),(354,35,31,1,0),(355,42,31,1,0),(356,64,31,1,0),(357,65,31,1,0),(358,66,31,1,0),(359,93,31,1,1),(360,94,31,1,1),(361,67,9,1,0),(362,68,9,1,0),(363,69,9,1,0),(364,70,9,1,0),(365,71,9,1,0),(366,72,9,1,0),(367,73,9,1,0),(368,74,9,1,0),(369,75,9,1,0),(370,78,9,1,0),(371,95,9,1,1),(372,96,9,1,1),(373,14,10,1,0),(374,15,10,1,0),(375,16,10,1,0),(376,17,10,1,0),(377,18,10,1,0),(378,19,10,1,0),(379,20,10,1,0),(380,21,10,1,0),(381,22,10,1,0),(382,23,10,1,0),(383,24,10,1,0),(384,25,10,1,0),(385,26,10,1,0),(386,27,10,1,0),(387,28,10,1,0),(388,29,10,1,0),(389,30,10,1,0),(390,97,10,1,1),(391,98,10,1,1),(392,88,39,1,1),(393,32,19,1,0),(394,33,19,1,0),(395,90,19,1,1),(396,92,18,1,1),(397,91,17,1,1),(398,31,16,1,0),(399,32,16,1,0),(400,33,16,1,0),(401,34,16,1,0),(402,35,16,1,0),(403,36,16,1,0);
/*!40000 ALTER TABLE `data_keyvalue_dept_cms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_keyvalue_entity`
--

DROP TABLE IF EXISTS `data_keyvalue_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_keyvalue_entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` int(11) NOT NULL,
  `dkv_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_keyvalue_entity`
--

LOCK TABLES `data_keyvalue_entity` WRITE;
/*!40000 ALTER TABLE `data_keyvalue_entity` DISABLE KEYS */;
INSERT INTO `data_keyvalue_entity` VALUES (1,22,80);
/*!40000 ALTER TABLE `data_keyvalue_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_keyvalue_group`
--

DROP TABLE IF EXISTS `data_keyvalue_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_keyvalue_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paramter` varchar(244) NOT NULL,
  `img` varchar(255) NOT NULL,
  `key_value_layout_id` int(2) NOT NULL DEFAULT '1',
  `cell_press` int(4) NOT NULL DEFAULT '0',
  `depts_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `core` enum('yes','no') NOT NULL DEFAULT 'no',
  `is_dept` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Depts_ID` (`depts_id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_keyvalue_group`
--

LOCK TABLES `data_keyvalue_group` WRITE;
/*!40000 ALTER TABLE `data_keyvalue_group` DISABLE KEYS */;
INSERT INTO `data_keyvalue_group` VALUES (1,'creation_date',' ',1,0,0,1,1,'no',0),(3,'file',' ',1,0,0,1,4,'no',0),(5,'fields',' ',1,0,0,1,8,'no',0),(6,'category_fields',' ',1,0,4,1,8,'no',2),(7,'file',' ',1,0,0,1,5,'no',0),(9,'contact_us',' ',1,0,0,1,7,'no',0);
/*!40000 ALTER TABLE `data_keyvalue_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_keyvalue_group_lang`
--

DROP TABLE IF EXISTS `data_keyvalue_group_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_keyvalue_group_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `lang_id` int(5) NOT NULL DEFAULT '1',
  `group_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Depts_ID` (`group_id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_keyvalue_group_lang`
--

LOCK TABLES `data_keyvalue_group_lang` WRITE;
/*!40000 ALTER TABLE `data_keyvalue_group_lang` DISABLE KEYS */;
INSERT INTO `data_keyvalue_group_lang` VALUES (1,'Date',1,1,1,1),(3,'File',1,3,1,4),(4,'Settings',1,4,1,8),(5,'Fields',1,5,1,8),(6,'Category Fields',1,6,1,8),(7,'PDF File',1,7,1,5),(9,'Contact Us',1,9,1,7);
/*!40000 ALTER TABLE `data_keyvalue_group_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_keyvalue_lang`
--

DROP TABLE IF EXISTS `data_keyvalue_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_keyvalue_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dkv_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8 COMMENT='Language system for Key,Value';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_keyvalue_lang`
--

LOCK TABLES `data_keyvalue_lang` WRITE;
/*!40000 ALTER TABLE `data_keyvalue_lang` DISABLE KEYS */;
INSERT INTO `data_keyvalue_lang` VALUES (2,2,'Creation Date',2),(4,4,'PDF File',2),(6,5,'is published',2),(8,6,'تعليق المشرف',1),(9,7,'قابل للصيانة',1),(10,7,'قابل للصيانة',1),(11,8,'في الضمان',1),(12,8,'في الضمان',1),(13,9,'Warranty Period',2),(14,9,'مدة الضمان',1),(15,10,'Other warranty period',2),(16,10,'مدة الضمان الأخرى',1),(17,11,'تاريخ التسليم',1),(19,12,'Important notes for clients',2),(20,12,'ملاحظات هامة للعملاء',1),(21,13,'Published',2),(22,13,'إظهار في المتجر',1),(23,14,'سائل الضخ',1),(24,14,'سائل الضخ',1),(25,15,'مدى درجة حرارة السائل',1),(26,15,'مدى درجة حرارة السائل',1),(27,16,'Denisty',2),(28,16,'الكثافة',1),(29,17,'Sealant',2),(30,17,'مانع التسرب',1),(31,18,'Pump Credits/Certificates',2),(32,18,'اعتمادات/ شهادات المضخة',1),(33,19,'Pump curve',2),(34,19,'منحنى المضخة',1),(35,20,'Pump body',2),(36,20,'جسم المضخة',1),(37,21,'Propeller',2),(38,21,'المروحة',1),(39,22,'Temperature',2),(40,22,'درجة الحرارة',1),(41,23,'Endurance compression',2),(42,23,'ضغط التحمل',1),(43,24,'Electric power',2),(44,24,'القدرة الكهربائية',1),(45,25,'Frequency',2),(46,25,'التردد',1),(47,26,'Voltages',2),(48,26,'الفولتية',1),(49,27,'Electric current',2),(50,27,'التيار الكهربائي',1),(51,28,'Engine protection degree',2),(52,28,'درجة حماية المحرك',1),(53,29,'Engine insulation',2),(54,29,'عزل المحرك',1),(55,30,'Plug',2),(56,30,'القابس',1),(57,31,'Model',2),(58,31,'الموديل',1),(59,32,'Tall',2),(60,32,'الطول',1),(61,33,'Width',2),(62,33,'عرض',1),(63,34,'Height 1',2),(64,34,'الارتفاع 1',1),(65,35,'Height 2',2),(66,35,'الارتفاع 2',1),(67,36,'Height 3',2),(68,36,'الارتفاع 3',1),(69,37,'Hot water evaporation',2),(70,37,'تبخر الماء الساخن',1),(71,38,'Hole depth',2),(72,38,'عمق الثقب',1),(73,39,'Tank volume',2),(74,39,'حجم الخزان',1),(75,40,'Adjustable tank temperature',2),(76,40,'درجة الحرارة الخزان القابة للتعديل',1),(77,41,'Desired feeding pressure',2),(78,41,'ضغط التغذية المطلوب',1),(79,42,'Warranty',2),(80,42,'الضمان',1),(81,43,'Feeding type',2),(82,43,'نوع التغذية',1),(83,44,'On/Off',2),(84,44,'التشغيل / الايقاف',1),(85,45,'Power supply',2),(86,45,'مزود الطاقة',1),(87,46,'Time estimation',2),(88,46,'تقيم الوقت',1),(89,47,'Lubrication',2),(90,47,'التشحيم',1),(91,48,'Milling technology',2),(92,48,'تكنولوجيا الطحن',1),(93,49,'Sound technology',2),(94,49,'تقنية الصوت',1),(95,50,'Volts/Hz 220-240V, 50 Hz',2),(96,50,'Volts/Hz 220-240V, 50 Hz',1),(97,51,'Grinding room capacity',2),(98,51,'سعة غرفة طحن',1),(99,52,'Water consumption rate',2),(100,52,'معدل استهلاك الماء',1),(101,53,'Electricity consumption rate',2),(102,53,'معدل استهلاك الكهرباء',1),(103,54,'Sewerage network',2),(104,54,'شبكة الصرف الصحي',1),(105,55,'Connected to dish-washer',2),(106,55,'متصل بغسالة الصحون',1),(107,56,'Sound reduction technology',2),(108,56,'تقنية خفض الصوت',1),(109,57,'Grinding stages count',2),(110,57,'عد مراحل الطحن',1),(111,58,'Engine',2),(112,58,'المحرك',1),(113,59,'Embedded antena',2),(114,59,'مفتاح هوائي مضمن',1),(115,60,'Energy efficiency circuit',2),(116,60,'دائرة تعزيز كفاءة الطاقة',1),(117,61,'Filter plug and bristles',2),(118,61,'قابس المصفاة وحشيتها',1),(119,62,'Control extension through cover',2),(120,62,'ملحق التحكم من خلا ل الغطاء',1),(121,63,'Stainless steel grinding items',2),(122,63,'عناصر طحن مصنوعة من صلب لا يصدا',1),(123,64,'Net slot cover',2),(124,64,'صافي فتحة الغطاء',1),(125,65,'Size',2),(126,65,'مقاس',1),(127,66,'Ton',2),(128,66,'طن',1),(129,67,'Maximum gate weight',2),(130,67,'الحدّ الأقصى لوزن البوابة',1),(131,68,'Engine power supplies',2),(132,68,'مدادات المحرّك بالطاقة',1),(133,69,'Energy consumption',2),(134,69,'استهلاك الطاقة',1),(135,70,'Speed',2),(136,70,'السرعة',1),(137,71,'Gate sliding distance',2),(138,71,'مسافة تباطؤ البوابة',1),(139,72,'Cycles number',2),(140,72,'عدد الدورات',1),(141,73,'Maximum engine running time',2),(142,73,'مدّة تشغيل المحرّك – المدّة القصوى',1),(143,74,'Maximum running times per day',2),(144,74,'العدد الأقصى لعمليّات التشغيل في اليوم',1),(145,75,'Temperature when running',2),(146,75,'الحرارة عند التشغيل',1),(147,76,'Gate warranty',2),(148,76,'ضمان باب',1),(149,77,'Engine warranty',2),(150,77,'ضمان المحرك',1),(151,6,'Supervisor Comment',2),(152,11,'Maintainable',2),(153,7,'Maintainable',2),(154,8,'In warranty',2),(155,14,'Pumping Fluid',2),(156,15,'Liquid Temperature',2),(157,78,'Lighting area',2),(158,78,'اضاءة المنطقة',1),(160,79,'الألوان المتاحة',1),(161,80,'Available Colors',2),(162,80,'الألوان المتاحة',1),(163,80,'Available Colors',2),(164,81,'PDF File',1),(165,81,'ملف البروشور',1),(167,82,'السعر',1),(168,82,'Price',2),(169,81,'pdf_file',2),(170,83,'email',1),(171,83,'ايميل',1),(172,84,'mobile 1',1),(173,84,'تليفون 1',1),(174,84,'mobile 1',2),(175,85,'mobile2',1),(176,85,'mobile2',1),(177,85,'mobile2',2),(178,83,'email',2),(179,86,'address',1),(180,86,'address',1),(181,86,'address',2),(182,87,'fax',1),(183,87,'fax',1),(184,87,'fax',2),(185,88,'Capacity - Horizontal Tank',2),(186,88,'السعة - الخزان الأفقي',1),(187,89,'Capacity - Vertical Tanks',2),(188,89,'السعة - الخزانات الرأسية',1),(189,90,'Capacity - Daffan Tanks',2),(190,90,'السعة - سخانات الدفان',1),(191,91,'Capacity - Pathway Tanks',2),(192,91,'السعة - خزانات ممرات',1),(193,92,'Capacity - Stairs Tanks',2),(194,92,'السعة - خزانات بيت الدرج',1),(195,93,'Type: Ground Cover',2),(196,93,'النوع : أغطية أرضية',1),(197,94,'Size: Ground Covers',2),(198,94,'المقاس: أغطية أرضية',1),(199,95,'Type: Automatic Doors',2),(200,95,'النوع: الأبواب الأوتوماتيكية',1),(201,96,'Size: Automatic Doors',2),(202,96,'المقاس: الأبواب الأوتوماتيكية',1),(203,97,'المضخات',1),(204,97,'النوع: المضخات',1),(205,98,'Size: Pumps',2),(206,98,'المقاس: المضخات',1),(207,97,'Pumps',2);
/*!40000 ALTER TABLE `data_keyvalue_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_keyvalue_option`
--

DROP TABLE IF EXISTS `data_keyvalue_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_keyvalue_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dkv_id` varchar(255) NOT NULL,
  `application_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_keyvalue_option`
--

LOCK TABLES `data_keyvalue_option` WRITE;
/*!40000 ALTER TABLE `data_keyvalue_option` DISABLE KEYS */;
INSERT INTO `data_keyvalue_option` VALUES (3,'7',1,8),(4,'7',1,8),(5,'8',1,8),(6,'8',1,8),(7,'9',1,8),(8,'9',1,8),(9,'9',1,8),(10,'9',1,8),(11,'11',1,8),(12,'11',1,8),(13,'11',1,8),(14,'11',1,8),(15,'11',1,8),(16,'11',1,8),(17,'13',1,8),(18,'13',1,8),(19,'88',1,8),(20,'88',1,8),(21,'88',1,8),(22,'88',1,8),(23,'88',1,8),(24,'88',1,8),(25,'89',1,8),(26,'89',1,8),(27,'89',1,8),(28,'89',1,8),(29,'89',1,8),(30,'89',1,8),(31,'90',1,8),(32,'90',1,8),(33,'90',1,8),(34,'90',1,8),(35,'90',1,8),(36,'90',1,8),(37,'91',1,8),(38,'91',1,8),(39,'91',1,8),(40,'91',1,8),(41,'91',1,8),(42,'92',1,8),(43,'92',1,8),(44,'92',1,8),(45,'93',1,8),(46,'93',1,8),(47,'93',1,8),(48,'94',1,8),(49,'94',1,8),(50,'94',1,8),(51,'95',1,8),(52,'95',1,8),(53,'95',1,8),(54,'96',1,8),(55,'96',1,8),(56,'96',1,8),(57,'96',1,8),(58,'97',1,8),(59,'97',1,8),(60,'97',1,8),(61,'98',1,8),(62,'98',1,8),(63,'98',1,8);
/*!40000 ALTER TABLE `data_keyvalue_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_keyvalue_option_lang`
--

DROP TABLE IF EXISTS `data_keyvalue_option_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_keyvalue_option_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `option_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COMMENT='Language system for Key,Value';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_keyvalue_option_lang`
--

LOCK TABLES `data_keyvalue_option_lang` WRITE;
/*!40000 ALTER TABLE `data_keyvalue_option_lang` DISABLE KEYS */;
INSERT INTO `data_keyvalue_option_lang` VALUES (5,3,'نعم',1),(6,4,'لا',1),(7,5,'نعم',1),(8,6,'لا',1),(9,7,'6 أشهر',1),(10,8,'سنة',1),(11,9,'سنتين',1),(12,10,'أخرى',1),(13,11,'لا شيء',1),(14,12,'خلال أسبوع',1),(15,13,'خلال 1 -2 أيام',1),(16,14,'خلال 3 - 5 أيام',1),(17,15,'خلال 7 - 10 أيام',1),(18,16,'خلال 10 - 15 أيام',1),(19,17,'نعم',1),(20,18,'لا',1),(21,11,' ',2),(22,12,' ',2),(23,13,' ',2),(24,14,' ',2),(25,15,' ',2),(26,16,' ',2),(27,19,'300',1),(28,20,'400',1),(29,21,'500',1),(30,22,'600',1),(31,23,'700',1),(32,24,'800',1),(33,25,'100',1),(34,26,'125',1),(35,27,'200',1),(36,28,'350',1),(37,29,'542',1),(38,30,'1200',1),(39,31,'20',1),(40,32,'40',1),(41,33,'50',1),(42,34,'60',1),(43,35,'70',1),(44,36,'80',1),(45,37,'300',1),(46,38,'400',1),(47,39,'500',1),(48,40,'600',1),(49,41,'800',1),(50,42,'300',1),(51,43,'400',1),(52,44,'600',1),(53,45,'type 1',1),(54,46,'type 2',1),(55,47,'type 3',1),(56,48,'20',1),(57,49,'30',1),(58,50,'410',1),(59,51,'Type1',1),(60,52,'Type2',1),(61,53,'Type3',1),(62,54,'20',1),(63,55,'40',1),(64,56,'60',1),(65,57,'80',1),(66,58,'نوع المضخة ',1),(67,59,'قوة المضخة ',1),(68,60,'type 3',1),(69,61,'type 1',1),(70,62,'type 2',1),(71,63,'type 3',1),(72,58,' ',2),(73,59,' ',2),(74,60,' ',2);
/*!40000 ALTER TABLE `data_keyvalue_option_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_keyvalue_show_settings`
--

DROP TABLE IF EXISTS `data_keyvalue_show_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_keyvalue_show_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dkv_id` int(11) NOT NULL,
  `title` tinyint(4) NOT NULL,
  `des` tinyint(4) NOT NULL,
  `img` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_keyvalue_show_settings`
--

LOCK TABLES `data_keyvalue_show_settings` WRITE;
/*!40000 ALTER TABLE `data_keyvalue_show_settings` DISABLE KEYS */;
INSERT INTO `data_keyvalue_show_settings` VALUES (2,2,0,0,0),(3,4,0,0,0),(5,11,0,0,0),(6,6,0,0,0),(7,7,0,0,0),(8,8,0,0,0),(9,9,0,0,0),(10,10,0,0,0),(11,12,0,0,0),(12,13,0,0,0),(13,14,0,0,0),(14,15,0,0,0),(15,16,0,0,0),(16,17,0,0,0),(17,21,0,0,0),(18,22,0,0,0),(19,23,0,0,0),(20,24,0,0,0),(21,18,0,0,0),(22,19,0,0,0),(23,20,0,0,0),(24,25,0,0,0),(25,26,0,0,0),(26,27,0,0,0),(27,28,0,0,0),(28,29,0,0,0),(29,30,0,0,0),(30,31,0,0,0),(31,32,0,0,0),(32,33,0,0,0),(33,34,0,0,0),(34,35,0,0,0),(35,36,0,0,0),(36,37,0,0,0),(37,38,0,0,0),(38,39,0,0,0),(39,40,0,0,0),(40,41,0,0,0),(41,42,0,0,0),(42,43,0,0,0),(43,44,0,0,0),(44,45,0,0,0),(45,46,0,0,0),(46,47,0,0,0),(47,48,0,0,0),(48,49,0,0,0),(49,50,0,0,0),(50,51,0,0,0),(51,52,0,0,0),(52,53,0,0,0),(53,54,0,0,0),(54,55,0,0,0),(55,56,0,0,0),(56,57,0,0,0),(57,58,0,0,0),(58,59,0,0,0),(59,60,0,0,0),(60,61,0,0,0),(61,62,0,0,0),(62,63,0,0,0),(63,64,0,0,0),(64,65,0,0,0),(65,66,0,0,0),(66,67,0,0,0),(67,68,0,0,0),(68,69,0,0,0),(69,70,0,0,0),(70,71,0,0,0),(71,72,0,0,0),(72,73,0,0,0),(73,74,0,0,0),(74,75,0,0,0),(75,76,0,0,0),(76,77,0,0,0),(77,78,0,0,0),(79,80,0,0,0),(80,81,0,0,0),(82,84,0,0,0),(83,85,0,0,0),(84,83,0,0,0),(85,86,0,0,0),(86,87,0,0,0),(87,88,0,0,0),(88,89,0,0,0),(89,90,0,0,0),(90,91,0,0,0),(91,92,0,0,0),(92,93,0,0,0),(93,94,0,0,0),(94,96,1,1,1),(95,95,0,0,0),(96,97,0,0,0),(97,98,0,0,0);
/*!40000 ALTER TABLE `data_keyvalue_show_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_keyvalue_types`
--

DROP TABLE IF EXISTS `data_keyvalue_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_keyvalue_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_keyvalue_types`
--

LOCK TABLES `data_keyvalue_types` WRITE;
/*!40000 ALTER TABLE `data_keyvalue_types` DISABLE KEYS */;
INSERT INTO `data_keyvalue_types` VALUES (1,'Number'),(2,'Mobile'),(3,'Time'),(4,'DateTime'),(5,'Link'),(6,'Date'),(7,'Location');
/*!40000 ALTER TABLE `data_keyvalue_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_keyvalue_userdata`
--

DROP TABLE IF EXISTS `data_keyvalue_userdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_keyvalue_userdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `des` varchar(255) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `value` varchar(200) DEFAULT NULL,
  `time` varchar(50) NOT NULL,
  `dkv_id` int(11) NOT NULL COMMENT 'دا الكولم الفعلي بتاع الكي والفاليو',
  `item_id` int(5) NOT NULL,
  `application_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `lang_id` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_keyvalue_userdata`
--

LOCK TABLES `data_keyvalue_userdata` WRITE;
/*!40000 ALTER TABLE `data_keyvalue_userdata` DISABLE KEYS */;
INSERT INTO `data_keyvalue_userdata` VALUES (1,'','',NULL,'17/10/2017','1508246827',2,5,1,1,0),(2,'','',NULL,'16/10/2017','1508246847',2,4,1,1,0),(3,'','',NULL,'18/10/2017','1508246959',2,6,1,1,0),(5,'','',NULL,'1c718ce3-b1ac-4cab-8cdb-3948038cf308.pdf','1508413416',4,13,1,4,0),(6,NULL,NULL,NULL,'79666273-303a-4601-ba5d-9e769a475897.pdf','1508421357',4,9,1,4,0),(7,'','',NULL,'b4dea915-298d-403c-a438-fb8cecc5436a.pdf','1508680243',4,27,1,4,0),(8,'','',NULL,'لوريم ايبسوم دولار سيت أميت ,ك','1508838388',6,3,1,8,0),(9,'','',NULL,'4','1508838388',7,3,1,8,0),(10,'','',NULL,'6','1508838388',8,3,1,8,0),(11,'','',NULL,'10','1508838388',9,3,1,8,0),(12,'','',NULL,'13','1508838388',11,3,1,8,0),(13,'','',NULL,'فينايم,كيواس نوستريد أكسير سيت','1508838388',12,3,1,8,0),(14,'','',NULL,'17','1508838388',13,3,1,8,0),(15,'','',NULL,'15','1509027526',10,3,1,8,0),(16,'','',NULL,'سابك ، حيث أنها المادة الوحيد','1509028754',6,28,1,8,0),(17,'','',NULL,'3','1509028754',7,28,1,8,0),(18,'','',NULL,'5','1509028754',8,28,1,8,0),(19,'','',NULL,'7','1509028754',9,28,1,8,0),(20,'','',NULL,'11','1509028754',11,28,1,8,0),(21,'','',NULL,'17','1509028754',13,28,1,8,0),(46,'','',NULL,'1,2','1509353628',80,28,1,8,0),(47,'','',NULL,'2','1509358027',80,3,1,8,0),(48,'','',NULL,'211f8913-786b-4f4c-a955-a7af7244cdf8.pdf','1509455416',81,30,1,5,0),(49,'','',NULL,'3','1509531987',7,36,1,8,0),(50,'','',NULL,'5','1509531987',8,36,1,8,0),(51,'','',NULL,'7','1509531987',9,36,1,8,0),(52,'','',NULL,'11','1509531987',11,36,1,8,0),(53,'','',NULL,'17','1509531987',13,36,1,8,0),(54,'','',NULL,'comment','1509532499',6,37,1,8,0),(55,'','',NULL,'3','1509532499',7,37,1,8,0),(56,'','',NULL,'5','1509532499',8,37,1,8,0),(57,'','',NULL,'7','1509532499',9,37,1,8,0),(58,'','',NULL,'11','1509532499',11,37,1,8,0),(59,'','',NULL,'17','1509532499',13,37,1,8,0),(60,'','',NULL,'50000','1509532499',14,37,1,8,0),(61,'','',NULL,'250','1509532499',15,37,1,8,0),(62,'','',NULL,'152000','1509532499',16,37,1,8,0),(63,'','',NULL,'444','1509532499',18,37,1,8,0),(64,'','',NULL,'4444','1509532499',19,37,1,8,0),(65,'','',NULL,'4444','1509532499',20,37,1,8,0),(66,'','',NULL,'25','1509532499',22,37,1,8,0),(67,'','',NULL,'154','1509532499',23,37,1,8,0),(68,'','',NULL,'5400','1509532499',24,37,1,8,0),(69,'','',NULL,'1100','1509532499',26,37,1,8,0),(70,'','',NULL,'42424','1509532499',27,37,1,8,0),(71,'','',NULL,'43434','1509532499',28,37,1,8,0),(72,'','',NULL,'4343','1509532499',29,37,1,8,0),(73,'','',NULL,'4343','1509532499',30,37,1,8,0),(74,'','',NULL,'1,2','1509532499',80,37,1,8,0),(76,'','',NULL,'no comment','1509532846',6,38,1,8,0),(77,'','',NULL,'3','1509532846',7,38,1,8,0),(78,'','',NULL,'5','1509532846',8,38,1,8,0),(79,'','',NULL,'7','1509532846',9,38,1,8,0),(80,'','',NULL,'15200','1509532846',10,38,1,8,0),(81,'','',NULL,'11','1509532846',11,38,1,8,0),(82,'','',NULL,'17','1509532846',13,38,1,8,0),(83,'','',NULL,'1500','1509532846',14,38,1,8,0),(84,'','',NULL,'100','1509532846',15,38,1,8,0),(85,'','',NULL,'1500','1509532846',16,38,1,8,0),(86,'','',NULL,'1500','1509532846',17,38,1,8,0),(87,'','',NULL,'1500','1509532846',18,38,1,8,0),(88,'','',NULL,'1500','1509532846',19,38,1,8,0),(89,'','',NULL,'1500','1509532846',20,38,1,8,0),(90,'','',NULL,'1500','1509532846',21,38,1,8,0),(91,'','',NULL,'1500','1509532846',22,38,1,8,0),(92,'','',NULL,'1500','1509532846',23,38,1,8,0),(93,'','',NULL,'1500','1509532846',24,38,1,8,0),(94,'','',NULL,'1500','1509532846',26,38,1,8,0),(95,'','',NULL,'1500','1509532846',27,38,1,8,0),(96,'','',NULL,'1500','1509532846',28,38,1,8,0),(97,'','',NULL,'1500','1509532846',29,38,1,8,0),(98,'','',NULL,'1500','1509532846',30,38,1,8,0),(99,'','',NULL,'1,2,3,4,5,6,7','1509532846',80,38,1,8,0),(101,'','',NULL,'10','1509533057',6,39,1,8,0),(102,'','',NULL,'3','1509533057',7,39,1,8,0),(103,'','',NULL,'5','1509533057',8,39,1,8,0),(104,'','',NULL,'7','1509533057',9,39,1,8,0),(105,'','',NULL,'10','1509533057',10,39,1,8,0),(106,'','',NULL,'11','1509533057',11,39,1,8,0),(107,'','',NULL,'10','1509533057',12,39,1,8,0),(108,'','',NULL,'17','1509533057',13,39,1,8,0),(109,'','',NULL,'10','1509533057',31,39,1,8,0),(110,'','',NULL,'10','1509533057',32,39,1,8,0),(111,'','',NULL,'10','1509533057',33,39,1,8,0),(112,'','',NULL,'10','1509533057',34,39,1,8,0),(113,'','',NULL,'10','1509533057',35,39,1,8,0),(114,'','',NULL,'10','1509533057',36,39,1,8,0),(116,'','',NULL,'100','1509533598',6,40,1,8,0),(117,'','',NULL,'3','1509533598',7,40,1,8,0),(118,'','',NULL,'5','1509533598',8,40,1,8,0),(119,'','',NULL,'7','1509533598',9,40,1,8,0),(120,'','',NULL,'11','1509533598',11,40,1,8,0),(121,'','',NULL,'100','1509533598',12,40,1,8,0),(122,'','',NULL,'17','1509533598',13,40,1,8,0),(123,'','',NULL,'1,2,4,6,7','1509533598',80,40,1,8,0),(125,'','',NULL,'100','1509533885',6,41,1,8,0),(126,'','',NULL,'3','1509533885',7,41,1,8,0),(127,'','',NULL,'5','1509533885',8,41,1,8,0),(128,'','',NULL,'7','1509533885',9,41,1,8,0),(129,'','',NULL,'100','1509533885',10,41,1,8,0),(130,'','',NULL,'11','1509533885',11,41,1,8,0),(131,'','',NULL,'100','1509533885',12,41,1,8,0),(132,'','',NULL,'17','1509533885',13,41,1,8,0),(133,'','',NULL,'1,2,3,4,5,6,7','1509533885',80,41,1,8,0),(135,'','',NULL,'yyyyyyyy','1509534069',6,42,1,8,0),(136,'','',NULL,'3','1509534069',7,42,1,8,0),(137,'','',NULL,'5','1509534069',8,42,1,8,0),(138,'','',NULL,'7','1509534069',9,42,1,8,0),(139,'','',NULL,'1000','1509534069',10,42,1,8,0),(140,'','',NULL,'11','1509534069',11,42,1,8,0),(141,'','',NULL,'1000','1509534069',12,42,1,8,0),(142,'','',NULL,'17','1509534069',13,42,1,8,0),(143,'','',NULL,'1,2,3,4,5,6,7','1509534069',80,42,1,8,0),(145,'','',NULL,'2eab99a8-8512-40d3-81c0-54e2b0af5653.','1509534660',4,43,1,4,0),(146,'','',NULL,'info@arabia.com','1509536846',83,44,1,7,0),(147,'','',NULL,' 0123456789','1509536846',84,44,1,7,0),(148,'','',NULL,'0122547852','1509536846',85,44,1,7,0),(149,'','',NULL,'29 مدينة نصر, القاهرة','1509536846',86,44,1,7,0),(150,'','',NULL,'013521531515613','1509536846',87,44,1,7,0),(151,'','',NULL,'1,2,3,4,5,6,7','1509538952',80,39,1,8,0),(152,'','',NULL,'34c869f3-0e36-480b-a99a-1db8b7e357fa.pdf','1509551201',81,8,1,5,0),(161,'','',NULL,'6c6fe96f-7abd-43eb-be98-75d09271dcf3.png','1509635839',4,49,1,4,0),(162,'','',NULL,'2017/12/03 14:57','1512305739',2,52,1,1,0),(163,'','',NULL,'comment','1516025976',6,53,1,8,0),(164,'','',NULL,'3','1516025976',7,53,1,8,0),(165,'','',NULL,'5','1516025976',8,53,1,8,0),(166,'','',NULL,'7','1516025976',9,53,1,8,0),(167,'','',NULL,'مدى الحياه','1516025976',10,53,1,8,0),(168,'','',NULL,'11','1516025976',11,53,1,8,0),(169,'','',NULL,'ملاحظات هامة للعملاء','1516025976',12,53,1,8,0),(170,'','',NULL,'17','1516025976',13,53,1,8,0),(171,'','',NULL,'1,2,3,4,5,6,7','1516025976',80,53,1,8,0),(173,'','',NULL,'22','1516025976',88,53,1,8,0),(179,'','',NULL,'تعليق مشرف','1516619921',6,55,1,8,0),(180,'','',NULL,'3','1516619921',7,55,1,8,0),(181,'','',NULL,'5','1516619921',8,55,1,8,0),(182,'','',NULL,'7','1516619921',9,55,1,8,0),(183,'','',NULL,'10','1516619921',10,55,1,8,0),(184,'','',NULL,'11','1516619921',11,55,1,8,0),(185,'','',NULL,'ملاحظات عميل','1516619921',12,55,1,8,0),(186,'','',NULL,'17','1516619921',13,55,1,8,0),(187,'','',NULL,'1,2,3,4,5,6,7','1516619921',80,55,1,8,0),(189,'','',NULL,'no comment','1516621453',6,56,1,8,0),(190,'','',NULL,'3','1516621453',7,56,1,8,0),(191,'','',NULL,'5','1516621453',8,56,1,8,0),(192,'','',NULL,'7','1516621453',9,56,1,8,0),(193,'','',NULL,'15','1516621453',10,56,1,8,0),(194,'','',NULL,'11','1516621453',11,56,1,8,0),(195,'','',NULL,'no','1516621453',12,56,1,8,0),(196,'','',NULL,'17','1516621453',13,56,1,8,0),(197,'','',NULL,'1,2,4','1516621453',80,56,1,8,0),(199,'','',NULL,'تعليق المشرف','1517216151',6,57,1,8,0),(200,'','',NULL,'3','1517216151',7,57,1,8,0),(201,'','',NULL,'5','1517216151',8,57,1,8,0),(202,'','',NULL,'7','1517216151',9,57,1,8,0),(203,'','',NULL,'5','1517216151',10,57,1,8,0),(204,'','',NULL,'11','1517216151',11,57,1,8,0),(205,'','',NULL,'ملاحظات هامة للعملاء','1517216151',12,57,1,8,0),(206,'','',NULL,'17','1517216151',13,57,1,8,0),(207,'','',NULL,'2,3,4,5,6,7','1517216151',80,57,1,8,0),(209,'','',NULL,'38','1517216151',91,57,1,8,0),(210,'','',NULL,'تعليق المشرف','1517216450',6,58,1,8,0),(211,'','',NULL,'3','1517216450',7,58,1,8,0),(212,'','',NULL,'5','1517216450',8,58,1,8,0),(213,'','',NULL,'7','1517216450',9,58,1,8,0),(214,'','',NULL,'4','1517216450',10,58,1,8,0),(215,'','',NULL,'11','1517216450',11,58,1,8,0),(216,'','',NULL,'ملاحظات كثيره','1517216450',12,58,1,8,0),(217,'','',NULL,'17','1517216450',13,58,1,8,0),(218,'','',NULL,'200','1517216450',67,58,1,8,0),(219,'','',NULL,'1200','1517216450',68,58,1,8,0),(220,'','',NULL,'a','1517216450',69,58,1,8,0),(221,'','',NULL,'500','1517216450',70,58,1,8,0),(222,'','',NULL,'1','1517216450',71,58,1,8,0),(223,'','',NULL,'2','1517216450',72,58,1,8,0),(224,'','',NULL,'200','1517216450',73,58,1,8,0),(225,'','',NULL,'20000','1517216450',74,58,1,8,0),(226,'','',NULL,'30','1517216450',75,58,1,8,0),(227,'','',NULL,'20','1517216450',78,58,1,8,0),(229,'','',NULL,'52','1517216450',95,58,1,8,0),(230,'','',NULL,'55','1517216450',96,58,1,8,0),(231,'','',NULL,'تعليق المشرف','1517216723',6,59,1,8,0),(232,'','',NULL,'3','1517216723',7,59,1,8,0),(233,'','',NULL,'5','1517216723',8,59,1,8,0),(234,'','',NULL,'7','1517216723',9,59,1,8,0),(235,'','',NULL,'2','1517216723',10,59,1,8,0),(236,'','',NULL,'11','1517216723',11,59,1,8,0),(237,'','',NULL,'ملاحظات هامة للعملاء','1517216723',12,59,1,8,0),(238,'','',NULL,'17','1517216723',13,59,1,8,0),(239,'','',NULL,'1000','1517216723',14,59,1,8,0),(240,'','',NULL,'30','1517216723',15,59,1,8,0),(241,'','',NULL,'25','1517216723',16,59,1,8,0),(242,'','',NULL,'25','1517216723',17,59,1,8,0),(243,'','',NULL,'25','1517216723',18,59,1,8,0),(244,'','',NULL,'25','1517216723',19,59,1,8,0),(245,'','',NULL,'25','1517216723',20,59,1,8,0),(246,'','',NULL,'25','1517216723',21,59,1,8,0),(247,'','',NULL,'30','1517216723',22,59,1,8,0),(248,'','',NULL,'25','1517216723',23,59,1,8,0),(249,'','',NULL,'25','1517216723',24,59,1,8,0),(250,'','',NULL,'25','1517216723',25,59,1,8,0),(251,'','',NULL,'25','1517216723',26,59,1,8,0),(252,'','',NULL,'25','1517216723',27,59,1,8,0),(253,'','',NULL,'25','1517216723',28,59,1,8,0),(254,'','',NULL,'25','1517216723',29,59,1,8,0),(255,'','',NULL,'25','1517216723',30,59,1,8,0),(257,'','',NULL,'58','1517216723',97,59,1,8,0),(258,'','',NULL,'63','1517216723',98,59,1,8,0),(259,'','',NULL,'تعليق المشرف','1517217102',6,60,1,8,0),(260,'','',NULL,'3','1517217102',7,60,1,8,0),(261,'','',NULL,'5','1517217102',8,60,1,8,0),(262,'','',NULL,'7','1517217102',9,60,1,8,0),(263,'','',NULL,' 5','1517217102',10,60,1,8,0),(264,'','',NULL,'11','1517217102',11,60,1,8,0),(265,'','',NULL,'17','1517217102',13,60,1,8,0),(266,'','',NULL,' 5','1517217102',31,60,1,8,0),(267,'','',NULL,' 5','1517217102',34,60,1,8,0),(268,'','',NULL,' 5','1517217102',35,60,1,8,0),(269,'','',NULL,' 5','1517217102',42,60,1,8,0),(270,'','',NULL,' 5','1517217102',64,60,1,8,0),(271,'','',NULL,' 5','1517217102',65,60,1,8,0),(272,'','',NULL,' 5','1517217102',66,60,1,8,0),(273,'','',NULL,'1,2,5','1517217102',80,60,1,8,0),(275,'','',NULL,'45','1517217102',93,60,1,8,0),(276,'','',NULL,'49','1517217102',94,60,1,8,0),(277,'','',NULL,'3','1517823992',7,61,1,8,0),(278,'','',NULL,'5','1517823992',8,61,1,8,0),(279,'','',NULL,'7','1517823992',9,61,1,8,0),(280,'','',NULL,'11','1517823992',11,61,1,8,0),(281,'','',NULL,'17','1517823992',13,61,1,8,0),(282,'','',NULL,'51','1517823992',95,61,1,8,0),(283,'','',NULL,'54','1517823992',96,61,1,8,0),(284,'','',NULL,'3','1517838279',7,62,1,8,0),(285,'','',NULL,'5','1517838279',8,62,1,8,0),(286,'','',NULL,'7','1517838279',9,62,1,8,0),(287,'','',NULL,'11','1517838279',11,62,1,8,0),(288,'','',NULL,'17','1517838279',13,62,1,8,0);
/*!40000 ALTER TABLE `data_keyvalue_userdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_keyvalue_userdata_lang`
--

DROP TABLE IF EXISTS `data_keyvalue_userdata_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_keyvalue_userdata_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kv_userdata_id` int(11) NOT NULL COMMENT 'data keyvalue user data id',
  `dkv_id` int(11) NOT NULL,
  `value` text,
  `title` varchar(30) DEFAULT NULL,
  `des` varchar(30) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `module_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `lang_id` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_keyvalue_userdata_lang`
--

LOCK TABLES `data_keyvalue_userdata_lang` WRITE;
/*!40000 ALTER TABLE `data_keyvalue_userdata_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_keyvalue_userdata_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_keyvalue_validation_settings`
--

DROP TABLE IF EXISTS `data_keyvalue_validation_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_keyvalue_validation_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dkv_id` int(11) NOT NULL,
  `kv_type` int(11) NOT NULL,
  `req` tinyint(4) NOT NULL,
  `application_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_keyvalue_validation_settings`
--

LOCK TABLES `data_keyvalue_validation_settings` WRITE;
/*!40000 ALTER TABLE `data_keyvalue_validation_settings` DISABLE KEYS */;
INSERT INTO `data_keyvalue_validation_settings` VALUES (1,1,6,0,1,1),(2,2,4,0,1,1),(3,3,0,0,1,4),(4,4,0,1,1,4),(5,5,0,0,1,8),(6,6,0,0,1,8),(7,7,0,0,1,8),(8,8,0,0,1,8),(9,9,0,0,1,8),(10,10,0,0,1,8),(11,11,0,0,1,8),(12,12,0,0,1,8),(13,13,0,0,1,8),(14,14,0,0,1,8),(15,15,0,0,1,8),(16,16,0,0,1,8),(17,17,0,0,1,8),(18,18,0,0,1,8),(19,19,0,0,1,8),(20,20,0,0,1,8),(21,21,0,0,1,8),(22,22,0,0,1,8),(23,23,0,0,1,8),(24,24,0,0,1,8),(25,25,0,0,1,8),(26,26,0,0,1,8),(27,27,0,0,1,8),(28,28,0,0,1,8),(29,29,0,0,1,8),(30,30,0,0,1,8),(31,31,0,0,1,8),(32,32,0,0,1,8),(33,33,0,0,1,8),(34,34,0,0,1,8),(35,35,0,0,1,8),(36,36,0,0,1,8),(37,37,0,0,1,8),(38,38,0,0,1,8),(39,39,0,0,1,8),(40,40,0,0,1,8),(41,41,0,0,1,8),(42,42,0,0,1,8),(43,43,0,0,1,8),(44,44,0,0,1,8),(45,45,0,0,1,8),(46,46,0,0,1,8),(47,47,0,0,1,8),(48,48,0,0,1,8),(49,49,0,0,1,8),(50,50,0,0,1,8),(51,51,0,0,1,8),(52,52,0,0,1,8),(53,53,0,0,1,8),(54,54,0,0,1,8),(55,55,0,0,1,8),(56,56,0,0,1,8),(57,57,0,0,1,8),(58,58,0,0,1,8),(59,59,0,0,1,8),(60,60,0,0,1,8),(61,61,0,0,1,8),(62,62,0,0,1,8),(63,63,0,0,1,8),(64,64,0,0,1,8),(65,65,0,0,1,8),(66,66,0,0,1,8),(67,67,0,0,1,8),(68,68,0,0,1,8),(69,69,0,0,1,8),(70,70,0,0,1,8),(71,71,0,0,1,8),(72,72,0,0,1,8),(73,73,0,0,1,8),(74,74,0,0,1,8),(75,75,0,0,1,8),(76,76,0,0,1,8),(77,77,0,0,1,8),(78,78,0,0,1,8),(79,79,0,0,1,8),(80,80,0,0,1,8),(81,81,0,0,1,5),(82,82,1,1,1,8),(83,83,0,0,1,7),(84,84,2,0,1,7),(85,85,2,0,1,7),(86,86,0,0,1,7),(87,87,1,0,1,7),(88,88,0,0,1,8),(89,89,0,0,1,8),(90,90,0,0,1,8),(91,91,0,0,1,8),(92,92,0,0,1,8),(93,93,0,0,1,8),(94,94,0,0,1,8),(95,95,0,0,1,8),(96,96,0,0,1,8),(97,97,0,0,1,8),(98,98,0,0,1,8);
/*!40000 ALTER TABLE `data_keyvalue_validation_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_message_relations`
--

DROP TABLE IF EXISTS `data_message_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_message_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_message_id` int(11) NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `is_draft` tinyint(1) DEFAULT NULL,
  `from_user_id` int(11) NOT NULL,
  `to_user_id` int(11) DEFAULT NULL,
  `parent_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `data_cms_id` int(11) DEFAULT NULL,
  `data_cms_depts_rel_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `messageid` (`data_message_id`),
  KEY `From_User_ID` (`from_user_id`,`to_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_message_relations`
--

LOCK TABLES `data_message_relations` WRITE;
/*!40000 ALTER TABLE `data_message_relations` DISABLE KEYS */;
INSERT INTO `data_message_relations` VALUES (1,1,0,0,NULL,1,6,1,1,20195,NULL,NULL),(2,2,0,0,NULL,1,6,1,1,20195,NULL,NULL);
/*!40000 ALTER TABLE `data_message_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_message_settings`
--

DROP TABLE IF EXISTS `data_message_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_message_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `db_type` int(11) DEFAULT NULL,
  `chat_type` int(11) DEFAULT NULL,
  `banner_image` varchar(255) DEFAULT NULL,
  `fb_api_key` varchar(255) DEFAULT NULL,
  `fb_auth_domain` varchar(255) DEFAULT NULL,
  `fb_db_url` varchar(255) DEFAULT NULL,
  `fb_storage` varchar(255) DEFAULT NULL,
  `fb_messaging_id` varchar(255) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_message_settings`
--

LOCK TABLES `data_message_settings` WRITE;
/*!40000 ALTER TABLE `data_message_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_message_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_messages`
--

DROP TABLE IF EXISTS `data_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_messages` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` text,
  `content` mediumtext NOT NULL,
  `number` int(10) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `application_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_messages`
--

LOCK TABLES `data_messages` WRITE;
/*!40000 ALTER TABLE `data_messages` DISABLE KEYS */;
INSERT INTO `data_messages` VALUES (1,NULL,'stuff',0,'0000-00-00 00:00:00',1,20195),(2,NULL,'stuff',0,'0000-00-00 00:00:00',1,20195);
/*!40000 ALTER TABLE `data_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_messages_drafts`
--

DROP TABLE IF EXISTS `data_messages_drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_messages_drafts` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Content` text NOT NULL,
  `To_User_ID` int(11) DEFAULT NULL,
  `subject` text,
  `Application_ID` int(11) NOT NULL,
  `Module_ID` int(11) NOT NULL,
  `From_User_ID` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_messages_drafts`
--

LOCK TABLES `data_messages_drafts` WRITE;
/*!40000 ALTER TABLE `data_messages_drafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_messages_drafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_messages_relation`
--

DROP TABLE IF EXISTS `data_messages_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_messages_relation` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Message_ID` int(10) NOT NULL,
  `Main` int(10) NOT NULL,
  `Read` int(1) NOT NULL DEFAULT '0',
  `Deleted` int(1) NOT NULL DEFAULT '0',
  `From_User_ID` int(10) NOT NULL,
  `To_User_ID` int(10) NOT NULL,
  `Parent_ID` int(11) NOT NULL,
  `Application_ID` int(11) NOT NULL,
  `Module_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `messageid` (`Message_ID`),
  KEY `main` (`Main`),
  KEY `From_User_ID` (`From_User_ID`,`To_User_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_messages_relation`
--

LOCK TABLES `data_messages_relation` WRITE;
/*!40000 ALTER TABLE `data_messages_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_messages_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_messages_settings`
--

DROP TABLE IF EXISTS `data_messages_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_messages_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `db_type` int(11) DEFAULT NULL,
  `chat_type` int(11) DEFAULT NULL,
  `banner_image` varchar(255) DEFAULT NULL,
  `fb_api_key` varchar(255) DEFAULT NULL,
  `fb_auth_domain` varchar(255) DEFAULT NULL,
  `fb_db_url` varchar(255) DEFAULT NULL,
  `fb_storage` varchar(255) DEFAULT NULL,
  `fb_messaging_id` varchar(255) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_messages_settings`
--

LOCK TABLES `data_messages_settings` WRITE;
/*!40000 ALTER TABLE `data_messages_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_messages_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_module_relations`
--

DROP TABLE IF EXISTS `data_module_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_module_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_one` int(11) NOT NULL,
  `model_two` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `rel_type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_module_relations`
--

LOCK TABLES `data_module_relations` WRITE;
/*!40000 ALTER TABLE `data_module_relations` DISABLE KEYS */;
INSERT INTO `data_module_relations` VALUES (18,2,0,1,NULL),(26,1,0,1,NULL),(31,8,0,1,NULL),(40,9,0,1,NULL),(45,10,0,1,NULL),(46,11,0,1,NULL),(47,3,0,1,NULL),(50,4,0,1,NULL),(51,5,0,1,NULL),(52,6,0,1,NULL),(54,7,0,1,NULL);
/*!40000 ALTER TABLE `data_module_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_module_relations_cms`
--

DROP TABLE IF EXISTS `data_module_relations_cms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_module_relations_cms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rel_id` int(11) NOT NULL,
  `item_cms_one` int(11) NOT NULL,
  `parent_cms_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_module_relations_cms`
--

LOCK TABLES `data_module_relations_cms` WRITE;
/*!40000 ALTER TABLE `data_module_relations_cms` DISABLE KEYS */;
INSERT INTO `data_module_relations_cms` VALUES (1,4,1,0),(2,4,2,0),(3,4,3,0),(4,4,4,0),(5,4,5,0),(6,4,6,0),(7,4,7,0),(8,4,8,0),(9,4,9,0),(10,4,10,0),(11,4,11,0),(12,4,12,0),(13,4,13,0),(14,4,14,0),(15,4,15,0),(16,4,16,0),(17,4,17,0),(18,4,18,0),(19,4,19,0),(20,4,20,0),(21,4,21,0),(22,4,22,0),(23,4,23,0),(24,4,24,0),(25,4,25,0),(26,4,26,0),(27,4,27,0),(28,4,28,0),(29,4,29,0),(30,4,30,0),(31,4,31,0),(32,4,32,0),(33,4,36,0),(34,4,37,0),(35,4,38,0),(36,4,39,0),(37,4,40,0),(38,4,41,0),(39,4,42,0),(40,4,43,0),(41,4,44,0),(42,4,45,0),(43,4,46,0),(44,4,47,0),(45,4,48,0),(46,4,49,0),(47,4,50,0),(48,4,51,0),(49,4,52,0),(50,4,53,0),(51,4,54,0),(52,4,55,0),(53,4,56,0),(54,4,57,0),(55,4,58,0),(56,4,59,0),(57,4,60,0),(58,4,61,0),(59,4,62,0);
/*!40000 ALTER TABLE `data_module_relations_cms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount_rel_items`
--

DROP TABLE IF EXISTS `discount_rel_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discount_rel_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discount_id` int(11) NOT NULL,
  `data_cms_id` int(11) NOT NULL,
  `created_at` varchar(30) NOT NULL,
  `updated_at` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount_rel_items`
--

LOCK TABLES `discount_rel_items` WRITE;
/*!40000 ALTER TABLE `discount_rel_items` DISABLE KEYS */;
INSERT INTO `discount_rel_items` VALUES (1,2,56,'1516630510','1516630510'),(2,3,56,'1516630540','1516630540');
/*!40000 ALTER TABLE `discount_rel_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `percentage` int(11) NOT NULL,
  `coupon` varchar(40) DEFAULT NULL,
  `start_date` varchar(30) NOT NULL,
  `end_date` varchar(30) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` varchar(30) NOT NULL,
  `updated_at` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
INSERT INTO `discounts` VALUES (1,'خصم جديد',50,'215262301256','1515456000','1516665600',1,'1515508884','1515508884'),(2,'خصم بنسبة 50%',50,NULL,'1514764800','1517356800',1,'1516630510','1516630510'),(3,'discount on product',10,NULL,'1514764800','1515974400',1,'1516630540','1516630540');
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_confirmations`
--

DROP TABLE IF EXISTS `email_confirmations`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_confirmations`
--

LOCK TABLES `email_confirmations` WRITE;
/*!40000 ALTER TABLE `email_confirmations` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_confirmations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_tags`
--

DROP TABLE IF EXISTS `entity_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_tags`
--

LOCK TABLES `entity_tags` WRITE;
/*!40000 ALTER TABLE `entity_tags` DISABLE KEYS */;
INSERT INTO `entity_tags` VALUES (9,5,37,1,8),(19,5,29,1,8),(8,5,36,1,8),(18,6,29,1,8),(10,7,37,1,8),(11,8,37,1,8),(17,5,38,1,8),(16,9,38,1,8),(20,6,29,1,8),(21,10,62,1,8),(22,11,62,1,8),(23,12,62,1,8),(24,13,62,1,8);
/*!40000 ALTER TABLE `entity_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_notifications_types`
--

DROP TABLE IF EXISTS `external_notifications_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_notifications_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `external_type` varchar(255) DEFAULT NULL COMMENT 'contains name of the external notification type related to an application and module , for example application 597 (matgr_minaa) can have request_price_list notification type and price_list_response notifications type, this is made to make it easy for getting the notifications on a scope',
  `app_id` int(11) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_notifications_types`
--

LOCK TABLES `external_notifications_types` WRITE;
/*!40000 ALTER TABLE `external_notifications_types` DISABLE KEYS */;
INSERT INTO `external_notifications_types` VALUES (1,'pricelist_request',597,20002),(2,'pricelist_response',597,20002),(3,'confirm_user',597,20002);
/*!40000 ALTER TABLE `external_notifications_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_logins`
--

DROP TABLE IF EXISTS `failed_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_logins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` int(10) unsigned DEFAULT NULL,
  `ipAddress` char(15) NOT NULL,
  `attempted` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usersId` (`usersId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_logins`
--

LOCK TABLES `failed_logins` WRITE;
/*!40000 ALTER TABLE `failed_logins` DISABLE KEYS */;
INSERT INTO `failed_logins` VALUES (1,0,'127.0.0.1',1508240595),(2,0,'127.0.0.1',1508842303),(3,1,'127.0.0.1',1508922201),(4,1,'127.0.0.1',1510418494),(5,0,'127.0.0.1',1512302493),(6,1,'127.0.0.1',1513245758),(7,1,'127.0.0.1',1513582691),(8,1,'127.0.0.1',1514886062),(9,1,'197.246.35.131',1515425041),(10,1,'197.246.73.238',1516281274),(11,0,'197.246.75.189',1517144220),(12,1,'197.246.42.48',1517741725),(13,1,'197.48.81.39',1517928413);
/*!40000 ALTER TABLE `failed_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fileupload_content`
--

DROP TABLE IF EXISTS `fileupload_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fileupload_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_path` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `uploader_name` varchar(255) DEFAULT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fileupload_content`
--

LOCK TABLES `fileupload_content` WRITE;
/*!40000 ALTER TABLE `fileupload_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `fileupload_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `general_notifications`
--

DROP TABLE IF EXISTS `general_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `general_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `external_type_id` int(11) DEFAULT NULL,
  `show_type_id` int(11) DEFAULT NULL COMMENT 'now or scheduled',
  `content` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `general_notifications`
--

LOCK TABLES `general_notifications` WRITE;
/*!40000 ALTER TABLE `general_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `general_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_cities`
--

DROP TABLE IF EXISTS `geo_cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_cities`
--

LOCK TABLES `geo_cities` WRITE;
/*!40000 ALTER TABLE `geo_cities` DISABLE KEYS */;
INSERT INTO `geo_cities` VALUES (1,'منطقة الرياض',NULL,3,1),(2,'منطقة مكة المكرمة',NULL,3,1),(3,'منطقة المدينة المنورة',NULL,3,1),(4,'منطقة القصيم',NULL,3,1),(5,'المنطقة الشرقية',NULL,3,1),(6,'منطقة عسير',NULL,3,1),(7,'منطقة تبوك',NULL,3,1),(8,'منطقة حائل',NULL,3,1),(9,'منطقة الحدود الشمالية',NULL,3,1),(10,'منطقة جازان',NULL,3,1),(11,'منطقة نجران',NULL,3,1),(12,'منطقة الباحة',NULL,3,1),(13,'منطقة الجوف',NULL,3,1);
/*!40000 ALTER TABLE `geo_cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_cities_lang`
--

DROP TABLE IF EXISTS `geo_cities_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_cities_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_cities_lang`
--

LOCK TABLES `geo_cities_lang` WRITE;
/*!40000 ALTER TABLE `geo_cities_lang` DISABLE KEYS */;
INSERT INTO `geo_cities_lang` VALUES (1,1,'منطقة الرياض',1),(2,2,'منطقة مكة المكرمة',1),(3,3,'منطقة المدينة المنورة',1),(4,4,'منطقة القصيم',1),(5,5,'المنطقة الشرقية',1),(6,6,'منطقة عسير',1),(7,7,'منطقة تبوك',1),(8,8,'منطقة حائل',1),(9,9,'منطقة الحدود الشمالية',1),(10,10,'منطقة جازان',1),(11,11,'منطقة نجران',1),(12,12,'منطقة الباحة',1),(13,13,'منطقة الجوف',1);
/*!40000 ALTER TABLE `geo_cities_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_continents`
--

DROP TABLE IF EXISTS `geo_continents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_continents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `lang_id` int(11) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_continents`
--

LOCK TABLES `geo_continents` WRITE;
/*!40000 ALTER TABLE `geo_continents` DISABLE KEYS */;
INSERT INTO `geo_continents` VALUES (1,'أفريقيا',NULL,1),(2,'أوروبا',NULL,1),(3,'أسيا',NULL,1),(4,'أمريكا',NULL,1);
/*!40000 ALTER TABLE `geo_continents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_continents_lang`
--

DROP TABLE IF EXISTS `geo_continents_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_continents_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `continent_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_continents_lang`
--

LOCK TABLES `geo_continents_lang` WRITE;
/*!40000 ALTER TABLE `geo_continents_lang` DISABLE KEYS */;
INSERT INTO `geo_continents_lang` VALUES (1,1,'أفريقيا',1),(2,1,'Africa',2),(3,2,'أوروبا',1),(4,2,'Europe',2),(5,3,'أسيا',1),(6,3,'Asia',2),(7,4,'أمريكا',1),(8,4,'America',2);
/*!40000 ALTER TABLE `geo_continents_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_countries`
--

DROP TABLE IF EXISTS `geo_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `continent_id` int(11) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_countries`
--

LOCK TABLES `geo_countries` WRITE;
/*!40000 ALTER TABLE `geo_countries` DISABLE KEYS */;
INSERT INTO `geo_countries` VALUES (7,'السعودية',NULL,3,1);
/*!40000 ALTER TABLE `geo_countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_countries_lang`
--

DROP TABLE IF EXISTS `geo_countries_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_countries_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_countries_lang`
--

LOCK TABLES `geo_countries_lang` WRITE;
/*!40000 ALTER TABLE `geo_countries_lang` DISABLE KEYS */;
INSERT INTO `geo_countries_lang` VALUES (1,7,'المملكة العربية السعودية',1),(2,7,'KSA',2);
/*!40000 ALTER TABLE `geo_countries_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_districts`
--

DROP TABLE IF EXISTS `geo_districts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_districts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_districts`
--

LOCK TABLES `geo_districts` WRITE;
/*!40000 ALTER TABLE `geo_districts` DISABLE KEYS */;
/*!40000 ALTER TABLE `geo_districts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_langs`
--

DROP TABLE IF EXISTS `geo_langs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_langs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `setting_id` int(11) NOT NULL,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_langs`
--

LOCK TABLES `geo_langs` WRITE;
/*!40000 ALTER TABLE `geo_langs` DISABLE KEYS */;
INSERT INTO `geo_langs` VALUES (5,1,1),(6,1,2);
/*!40000 ALTER TABLE `geo_langs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_regions`
--

DROP TABLE IF EXISTS `geo_regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_regions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_regions`
--

LOCK TABLES `geo_regions` WRITE;
/*!40000 ALTER TABLE `geo_regions` DISABLE KEYS */;
INSERT INTO `geo_regions` VALUES (1,'محافظة الرياض',NULL,1,1),(2,'الدرعية',NULL,1,1),(3,'الخرج',NULL,1,1),(4,'الدوادمي',NULL,1,1),(5,'المجمعة',NULL,1,1),(6,'القويعية',NULL,1,1),(7,'الأفلاج',NULL,1,1),(8,'وادي الدواسر',NULL,1,1),(9,'الزلفي',NULL,1,1),(10,'شقراء',NULL,1,1),(11,'حوطة بني تميم',NULL,1,1),(12,'عفيف',NULL,1,1),(13,'الغاط',NULL,1,1),(14,'السليل',NULL,1,1),(15,'ضرما',NULL,1,1),(16,'المزاحمية',NULL,1,1),(17,'رماح',NULL,1,1),(18,'ثادق',NULL,1,1),(19,'حريملاء',NULL,1,1),(20,'الحريق',NULL,1,1),(21,'مرات',NULL,1,1),(22,'الرين',NULL,1,1),(23,'مكة المكرمة',NULL,2,1),(24,'جدة',NULL,2,1),(25,'الطائف',NULL,2,1),(26,'القنفذة',NULL,2,1),(27,'الليث',NULL,2,1),(28,'رابغ',NULL,2,1),(29,'خليص',NULL,2,1),(30,'الخرمة',NULL,2,1),(31,'رنية',NULL,2,1),(32,'تربة',NULL,2,1),(33,'الجموم',NULL,2,1),(34,'الكامل',NULL,2,1),(35,'المويه',NULL,2,1),(36,'ميسان',NULL,2,1),(37,'أضم',NULL,2,1),(38,'المدينة المنورة',NULL,3,1),(39,'ينبع',NULL,3,1),(40,'العلا',NULL,3,1),(41,'مهد الذهب',NULL,3,1),(42,'الحناكية',NULL,3,1),(43,'بدر',NULL,3,1),(44,'خيبر',NULL,3,1),(45,'العيص',NULL,3,1),(46,'وادي الفرع',NULL,3,1),(47,'بريدة','',4,1),(48,'عنيزة','',4,1),(49,'الرس','',4,1),(50,'المذنب','',4,1),(51,'البكيرية','',4,1),(52,'البدائع','',4,1),(53,'الأسياح','',4,1),(54,'النبهانية','',4,1),(55,'الشماسية','',4,1),(56,'عيون الجواء','',4,1),(57,'رياض الخبراء','',4,1),(58,'عقلة الصقور','',4,1),(59,'ضرية',NULL,4,1),(60,'الدمام','',5,1),(61,'الأحساء','',5,1),(62,'حفر الباطن','',5,1),(63,'الجبيل','',5,1),(64,'القطيف','',5,1),(65,'الخبر','',5,1),(66,'الخفجي','',5,1),(67,'رأس تنورة','',5,1),(68,'بقيق','',5,1),(69,'النعيرية','',5,1),(70,'قرية العليا','',5,1),(71,'العديد',NULL,5,1),(72,'أبها','',6,1),(73,'خميس مشيط','',6,1),(74,'بيشة','',6,1),(75,'النماص','',6,1),(76,'محايل عسير','',6,1),(77,'ظهران الجنوب','',6,1),(78,'تثليث','',6,1),(79,'سراة عبيدة','',6,1),(80,'رجال ألمع','',6,1),(81,'بلقرن','',6,1),(82,'أحد رفيدة','',6,1),(83,'المجاردة','',6,1),(84,'البرك','',6,1),(85,'بارق','',6,1),(86,'تنومة','',6,1),(87,'طريب',NULL,6,1),(88,'تبوك','',7,1),(89,'الوجه','',7,1),(90,'ضبا','',7,1),(91,'تيماء','',7,1),(92,'أملج','',7,1),(93,'حقل','',7,1),(94,'البدع',NULL,7,1),(95,'حائل','',8,1),(96,'بقعاء','',8,1),(97,'الغزالة','',8,1),(98,'الشنان','',8,1),(99,'الحائط','',8,1),(100,'السليمي','',8,1),(101,'الشملي','',8,1),(102,'موقق','',8,1),(103,'سميراء',NULL,8,1),(104,'عرعر','',9,1),(105,'رفحاء','',9,1),(106,'طريف','',9,1),(107,'العويقيلة',NULL,9,1),(108,'جازان','',10,1),(109,'صبيا','',10,1),(110,'أبو عريش','',10,1),(111,'صامطة','',10,1),(112,'بيش','',10,1),(113,'الدرب','',10,1),(114,'الحرث','',10,1),(115,'ضمد','',10,1),(116,'الريث','',10,1),(117,'جزر فرسان','',10,1),(118,'الدائر','',10,1),(119,'العارضة','',10,1),(120,'أحد المسارحة','',10,1),(121,'العيدابي','',10,1),(122,'فيفاء','',10,1),(123,'الطوال','',10,1),(124,'هروب','',10,1),(125,'نجران','',11,1),(126,'شرورة','',11,1),(127,'حبونا','',11,1),(128,'بدر الجنوب','',11,1),(129,'يدمه','',11,1),(130,'ثار','',11,1),(131,'خباش','',11,1),(132,'الخرخير',NULL,11,1),(133,'الباحة','',12,1),(134,'بلجرشي','',12,1),(135,'المندق','',12,1),(136,'المخواة','',12,1),(137,'قلوة','',12,1),(138,'العقيق','',12,1),(139,'القرى','',12,1),(140,'غامد الزناد','',12,1),(141,'الحجرة','',12,1),(142,'بني حسن',NULL,12,1),(143,'سكاكا',NULL,13,1),(144,'القريات','',13,1),(145,'دومة الجندل','',13,1),(146,'طبرجل',NULL,13,1);
/*!40000 ALTER TABLE `geo_regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_regions_lang`
--

DROP TABLE IF EXISTS `geo_regions_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_regions_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `region_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_regions_lang`
--

LOCK TABLES `geo_regions_lang` WRITE;
/*!40000 ALTER TABLE `geo_regions_lang` DISABLE KEYS */;
INSERT INTO `geo_regions_lang` VALUES (1,1,'محافظة الرياض',1),(2,2,'الدرعية',1),(3,3,'الخرج',1),(4,4,'الدوادمي',1),(5,5,'المجمعة',1),(6,6,'القويعية',1),(7,7,'الأفلاج',1),(8,8,'وادي الدواسر',1),(9,9,'الزلفي',1),(10,10,'شقراء',1),(11,11,'حوطة بني تميم',1),(12,12,'عفيف',1),(13,13,'الغاط',1),(14,14,'السليل',1),(15,15,'ضرما',1),(16,16,'المزاحمية',1),(17,17,'رماح',1),(18,18,'ثادق',1),(19,19,'حريملاء',1),(20,20,'الحريق',1),(21,21,'مرات',1),(22,22,'الرين',1),(23,23,'مكة المكرمة',1),(24,24,'جدة',1),(25,25,'الطائف',1),(26,26,'القنفذة',1),(27,27,'الليث',1),(28,28,'رابغ',1),(29,29,'خليص',1),(30,30,'الخرمة',1),(31,31,'رنية',1),(32,32,'تربة',1),(33,33,'الجموم',1),(34,34,'الكامل',1),(35,35,'المويه',1),(36,36,'ميسان',1),(37,37,'أضم',1),(38,38,'المدينة المنورة',1),(39,39,'ينبع',1),(40,40,'العلا',1),(41,41,'مهد الذهب',1),(42,42,'الحناكية',1),(43,43,'بدر',1),(44,44,'خيبر',1),(45,45,'العيص',1),(46,46,'وادي الفرع',1),(47,47,'بريدة',1),(48,48,'عنيزة',1),(49,49,'الرس',1),(50,50,'المذنب',1),(51,51,'البكيرية',1),(52,52,'البدائع',1),(53,53,'الأسياح',1),(54,54,'النبهانية',1),(55,55,'الشماسية',1),(56,56,'عيون الجواء',1),(57,57,'رياض الخبراء',1),(58,58,'عقلة الصقور',1),(59,59,'ضرية',1),(60,60,'الدمام',1),(61,61,'الأحساء',1),(62,62,'حفر الباطن',1),(63,63,'الجبيل',1),(64,64,'القطيف',1),(65,65,'الخبر',1),(66,66,'الخفجي',1),(67,67,'رأس تنورة',1),(68,68,'بقيق',1),(69,69,'النعيرية',1),(70,70,'قرية العليا',1),(71,71,'العديد',1),(72,72,'أبها',1),(73,73,'خميس مشيط',1),(74,74,'بيشة',1),(75,75,'النماص',1),(76,76,'محايل عسير',1),(77,77,'ظهران الجنوب',1),(78,78,'تثليث',1),(79,79,'سراة عبيدة',1),(80,80,'رجال ألمع',1),(81,81,'بلقرن',1),(82,82,'أحد رفيدة',1),(83,83,'المجاردة',1),(84,84,'البرك',1),(85,85,'بارق',1),(86,86,'تنومة',1),(87,87,'طريب',1),(88,88,'تبوك',1),(89,89,'الوجه',1),(90,90,'ضبا',1),(91,91,'تيماء',1),(92,92,'أملج',1),(93,93,'حقل',1),(94,94,'البدع',1),(95,95,'حائل',1),(96,96,'بقعاء',1),(97,97,'الغزالة',1),(98,98,'الشنان',1),(99,99,'الحائط',1),(100,100,'السليمي',1),(101,101,'الشملي',1),(102,102,'موقق',1),(103,103,'سميراء',1),(104,104,'عرعر',1),(105,105,'رفحاء',1),(106,106,'طريف',1),(107,107,'العويقيلة',1),(108,108,'جازان',1),(109,109,'صبيا',1),(110,110,'أبو عريش',1),(111,111,'صامطة',1),(112,112,'بيش',1),(113,113,'الدرب',1),(114,114,'الحرث',1),(115,115,'ضمد',1),(116,116,'الريث',1),(117,117,'جزر فرسان',1),(118,118,'الدائر',1),(119,119,'العارضة',1),(120,120,'أحد المسارحة',1),(121,121,'العيدابي',1),(122,122,'فيفاء',1),(123,123,'الطوال',1),(124,124,'هروب',1),(125,125,'نجران',1),(126,126,'شرورة',1),(127,127,'حبونا',1),(128,128,'بدر الجنوب',1),(129,129,'يدمه',1),(130,130,'ثار',1),(131,131,'خباش',1),(132,132,'الخرخير',1),(133,133,'الباحة',1),(134,134,'بلجرشي',1),(135,135,'المندق',1),(136,136,'المخواة',1),(137,137,'قلوة',1),(138,138,'العقيق',1),(139,139,'القرى',1),(140,140,'غامد الزناد',1),(141,141,'الحجرة',1),(142,142,'بني حسن',1),(143,143,'سكاكا',1),(144,144,'القريات',1),(145,145,'دومة الجندل',1),(146,146,'طبرجل',1);
/*!40000 ALTER TABLE `geo_regions_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_settings`
--

DROP TABLE IF EXISTS `geo_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enable_continents` tinyint(4) NOT NULL DEFAULT '0',
  `enable_countries` tinyint(4) NOT NULL DEFAULT '0',
  `enable_states` tinyint(4) NOT NULL DEFAULT '0',
  `enable_city` tinyint(4) NOT NULL DEFAULT '0',
  `enable_regions` tinyint(4) NOT NULL DEFAULT '0',
  `enable_streets` tinyint(4) NOT NULL DEFAULT '0',
  `banner_image` varchar(255) DEFAULT NULL,
  `modal_image` varchar(255) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_settings`
--

LOCK TABLES `geo_settings` WRITE;
/*!40000 ALTER TABLE `geo_settings` DISABLE KEYS */;
INSERT INTO `geo_settings` VALUES (1,0,0,0,0,1,0,NULL,NULL,1);
/*!40000 ALTER TABLE `geo_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_states`
--

DROP TABLE IF EXISTS `geo_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `lang_id` int(11) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_states`
--

LOCK TABLES `geo_states` WRITE;
/*!40000 ALTER TABLE `geo_states` DISABLE KEYS */;
INSERT INTO `geo_states` VALUES (3,'المملكة العربية السعودية',7,NULL,1);
/*!40000 ALTER TABLE `geo_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_states_lang`
--

DROP TABLE IF EXISTS `geo_states_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_states_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_states_lang`
--

LOCK TABLES `geo_states_lang` WRITE;
/*!40000 ALTER TABLE `geo_states_lang` DISABLE KEYS */;
INSERT INTO `geo_states_lang` VALUES (3,3,'المملكة العربية السعودية',1),(4,3,'KSA',2);
/*!40000 ALTER TABLE `geo_states_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_streets`
--

DROP TABLE IF EXISTS `geo_streets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_streets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_streets`
--

LOCK TABLES `geo_streets` WRITE;
/*!40000 ALTER TABLE `geo_streets` DISABLE KEYS */;
/*!40000 ALTER TABLE `geo_streets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_streets_lang`
--

DROP TABLE IF EXISTS `geo_streets_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_streets_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `street_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_streets_lang`
--

LOCK TABLES `geo_streets_lang` WRITE;
/*!40000 ALTER TABLE `geo_streets_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `geo_streets_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goapp_data_cms_zones`
--

DROP TABLE IF EXISTS `goapp_data_cms_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goapp_data_cms_zones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_cms_id` int(11) NOT NULL,
  `zone_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goapp_data_cms_zones`
--

LOCK TABLES `goapp_data_cms_zones` WRITE;
/*!40000 ALTER TABLE `goapp_data_cms_zones` DISABLE KEYS */;
INSERT INTO `goapp_data_cms_zones` VALUES (1,246,26,20195,593),(2,247,26,20196,593),(3,248,26,20197,593),(4,249,26,20196,593),(5,250,26,20198,593),(6,251,26,20198,593),(7,252,26,20195,593),(8,253,26,20195,593),(9,254,26,20195,593),(10,255,26,20195,593),(11,256,26,20195,593),(12,257,26,20195,593),(13,258,26,20195,593),(14,259,26,20195,593),(15,260,26,20195,593),(16,261,26,20196,593),(17,262,26,20196,593),(18,263,26,20197,593),(19,264,26,20195,593),(20,265,26,20195,593),(21,266,26,20197,593),(22,267,26,20196,593),(23,268,26,20195,593),(24,269,26,20195,593),(25,270,26,20196,593),(26,271,26,20196,593),(27,272,26,20195,593),(28,273,26,20196,593),(29,274,26,20196,593),(30,275,26,20195,593),(31,276,26,20195,593),(32,277,26,20195,593),(33,278,26,20196,593),(34,279,26,20195,593),(35,280,26,20195,593),(36,281,26,20195,593),(37,282,26,20195,593),(38,283,26,20195,593),(39,284,26,20195,593),(40,285,26,20195,593),(41,286,26,20195,593),(42,287,26,20195,593),(43,288,26,20195,593),(44,289,26,20195,593),(45,290,26,20195,593),(46,291,26,20195,593),(47,292,26,20195,593),(48,293,26,20195,593),(49,294,27,20195,593),(50,295,26,20195,593),(51,296,26,20195,593),(52,297,26,20195,593),(53,298,26,20195,593),(54,299,26,20195,593),(55,300,26,20195,593),(56,301,26,20195,593),(57,302,26,20195,593),(58,303,26,20195,593),(59,304,26,20195,593),(60,305,26,20197,593),(61,306,26,20197,593),(62,307,26,20195,593),(63,308,26,20195,593),(64,309,26,20195,593),(65,310,26,20197,593),(66,311,26,20195,593),(67,312,26,20196,593),(68,313,26,20195,593),(69,314,26,20195,593),(70,315,26,20195,593),(71,316,26,20195,593),(72,317,26,20195,593),(73,318,26,20195,593),(74,319,26,20195,593),(75,320,26,20195,593),(76,321,26,20195,593),(77,322,26,20195,593),(78,323,26,20195,593),(79,324,26,20195,593),(80,325,26,20195,593),(81,326,26,20195,593),(82,327,26,20195,593),(83,328,26,20195,593),(84,329,26,20195,593),(85,330,26,20195,593),(86,331,26,20195,593),(87,332,26,20195,593),(88,333,26,20195,593),(89,334,26,20195,593),(90,335,26,20195,593),(91,336,26,20195,593),(92,337,26,20195,593),(93,338,26,20195,593),(94,339,26,20195,593),(95,340,26,20195,593),(96,341,26,20195,593),(97,342,26,20195,593),(98,343,26,20195,593),(99,344,26,20195,593),(100,345,26,20195,593),(101,346,26,20195,593),(102,347,26,20195,593),(103,348,26,20195,593),(104,349,26,20195,593),(105,350,26,20195,593),(106,351,26,20195,593),(107,352,26,20195,593),(108,353,26,20195,593),(109,354,26,20197,593),(110,355,26,20196,593),(111,356,26,20196,593),(112,357,26,20198,593);
/*!40000 ALTER TABLE `goapp_data_cms_zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL,
  `title` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'ar','العربية'),(2,'en','English'),(3,'fr','Française');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `date` datetime NOT NULL,
  `Model` varchar(60) NOT NULL,
  `link` varchar(15) NOT NULL DEFAULT 'log/index/',
  `application_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=737 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES (1,1,3,1,'create','2017-10-15 15:55:35','DataCmsDepts','log/index/',1),(2,1,4,2,'create','2017-10-15 15:58:13','DataCmsDepts','log/index/',1),(3,1,5,3,'create','2017-10-15 15:59:06','DataCmsDepts','log/index/',1),(4,1,8,4,'create','2017-10-15 16:01:44','DataCmsDepts','log/index/',1),(5,1,8,5,'create','2017-10-15 16:02:50','DataCmsDepts','log/index/',1),(6,1,8,1,'create','2017-10-16 10:16:20','DataCmsDeptsRel','log/index/',1),(7,1,8,2,'create','2017-10-16 10:19:22','DataCmsDeptsRel','log/index/',1),(8,1,8,3,'create','2017-10-16 10:20:25','DataCmsDeptsRel','log/index/',1),(9,1,8,3,'update','2017-10-16 10:35:53','DataCmsDeptsRel','log/index/',1),(10,1,8,2,'update','2017-10-16 10:38:10','DataCmsDeptsRel','log/index/',1),(11,1,8,1,'update','2017-10-16 10:39:13','DataCmsDeptsRel','log/index/',1),(12,1,8,5,'update','2017-10-16 10:41:38','DataCmsDepts','log/index/',1),(13,1,8,4,'update','2017-10-16 10:42:24','DataCmsDepts','log/index/',1),(14,1,8,4,'update','2017-10-16 10:42:42','DataCmsDepts','log/index/',1),(15,1,8,4,'create','2017-10-16 10:43:46','DataCmsDeptsRel','log/index/',1),(16,1,8,5,'create','2017-10-16 10:44:47','DataCmsDeptsRel','log/index/',1),(17,1,8,6,'create','2017-10-16 10:49:12','DataCmsDeptsRel','log/index/',1),(18,1,8,7,'create','2017-10-16 11:17:51','DataCmsDeptsRel','log/index/',1),(19,1,8,8,'create','2017-10-16 11:30:30','DataCmsDeptsRel','log/index/',1),(20,1,8,9,'create','2017-10-16 11:30:54','DataCmsDeptsRel','log/index/',1),(21,1,8,10,'create','2017-10-16 11:31:13','DataCmsDeptsRel','log/index/',1),(22,1,8,11,'create','2017-10-16 11:32:34','DataCmsDeptsRel','log/index/',1),(23,1,8,12,'create','2017-10-16 11:32:58','DataCmsDeptsRel','log/index/',1),(24,1,8,13,'create','2017-10-16 11:33:17','DataCmsDeptsRel','log/index/',1),(25,1,8,14,'create','2017-10-16 11:35:58','DataCmsDeptsRel','log/index/',1),(26,1,8,15,'create','2017-10-16 11:36:25','DataCmsDeptsRel','log/index/',1),(27,1,8,16,'create','2017-10-16 11:36:40','DataCmsDeptsRel','log/index/',1),(28,1,8,17,'create','2017-10-16 11:36:56','DataCmsDeptsRel','log/index/',1),(29,1,8,18,'create','2017-10-16 11:37:21','DataCmsDeptsRel','log/index/',1),(30,1,8,19,'create','2017-10-16 11:37:46','DataCmsDeptsRel','log/index/',1),(31,1,8,20,'create','2017-10-16 11:39:42','DataCmsDeptsRel','log/index/',1),(32,1,8,21,'create','2017-10-16 11:40:01','DataCmsDeptsRel','log/index/',1),(33,1,8,22,'create','2017-10-16 11:40:24','DataCmsDeptsRel','log/index/',1),(34,1,8,22,'delete','2017-10-16 11:52:32','DataCmsDeptsRel','log/index/',1),(35,1,8,21,'delete','2017-10-16 11:52:32','DataCmsDeptsRel','log/index/',1),(36,1,8,20,'delete','2017-10-16 11:52:32','DataCmsDeptsRel','log/index/',1),(37,1,1,1,'create','2017-10-16 13:44:42','Content Details','content/edit/',1),(38,1,2,2,'create','2017-10-16 14:26:01','Content Details','content/edit/',1),(39,1,8,3,'create','2017-10-16 14:58:43','Content Details','content/edit/',1),(40,1,8,1,'create','2017-10-16 14:58:43','Content Departments','log/index/',1),(41,1,8,3,'update','2017-10-16 15:00:34','Content Details','content/edit/',1),(42,1,8,1,'delete','2017-10-16 15:00:34','Content Departments','log/index/',1),(43,1,8,2,'create','2017-10-16 15:00:34','Content Departments','log/index/',1),(44,1,8,3,'create','2017-10-16 15:00:34','Content Departments','log/index/',1),(45,1,3,23,'create','2017-10-17 08:39:22','DataCmsDeptsRel','log/index/',1),(46,1,3,24,'create','2017-10-17 08:39:56','DataCmsDeptsRel','log/index/',1),(47,1,3,25,'create','2017-10-17 08:40:32','DataCmsDeptsRel','log/index/',1),(48,1,3,26,'create','2017-10-17 08:41:13','DataCmsDeptsRel','log/index/',1),(49,1,4,27,'create','2017-10-17 09:08:42','DataCmsDeptsRel','log/index/',1),(50,1,5,28,'create','2017-10-17 09:10:38','DataCmsDeptsRel','log/index/',1),(51,1,1,1,'delete','2017-10-17 10:32:42','Content Details','content/edit/',1),(52,1,1,4,'create','2017-10-17 13:23:38','Content Details','content/edit/',1),(53,1,1,5,'create','2017-10-17 13:27:07','Content Details','content/edit/',1),(54,1,1,4,'update','2017-10-17 13:27:27','Content Details','content/edit/',1),(55,1,1,6,'create','2017-10-17 13:29:19','Content Details','content/edit/',1),(56,1,5,7,'create','2017-10-17 13:32:32','Content Details','content/edit/',1),(57,1,5,8,'create','2017-10-17 13:33:00','Content Details','content/edit/',1),(58,1,5,8,'update','2017-10-17 13:33:48','Content Details','content/edit/',1),(59,1,5,4,'create','2017-10-17 13:33:48','Content Departments','log/index/',1),(60,1,5,7,'update','2017-10-17 13:34:07','Content Details','content/edit/',1),(61,1,5,5,'create','2017-10-17 13:34:07','Content Departments','log/index/',1),(62,1,2,2,'update','2017-10-19 08:07:44','Content Details','content/edit/',1),(63,1,2,1,'create','2017-10-19 08:07:44','Content Media','log/index/',1),(64,1,2,2,'create','2017-10-19 08:07:44','Content Media','log/index/',1),(65,1,2,3,'create','2017-10-19 08:07:44','Content Media','log/index/',1),(66,1,4,9,'create','2017-10-19 08:50:30','Content Details','content/edit/',1),(67,1,4,6,'create','2017-10-19 08:50:30','Content Departments','log/index/',1),(68,1,4,10,'create','2017-10-19 08:50:52','Content Details','content/edit/',1),(69,1,4,11,'create','2017-10-19 08:51:09','Content Details','content/edit/',1),(70,1,4,12,'create','2017-10-19 08:51:24','Content Details','content/edit/',1),(71,1,4,13,'create','2017-10-19 08:51:40','Content Details','content/edit/',1),(72,1,4,10,'update','2017-10-19 08:52:10','Content Details','content/edit/',1),(73,1,4,7,'create','2017-10-19 08:52:10','Content Departments','log/index/',1),(74,1,4,11,'update','2017-10-19 08:52:19','Content Details','content/edit/',1),(75,1,4,8,'create','2017-10-19 08:52:19','Content Departments','log/index/',1),(76,1,4,12,'update','2017-10-19 08:52:32','Content Details','content/edit/',1),(77,1,4,9,'create','2017-10-19 08:52:32','Content Departments','log/index/',1),(78,1,4,13,'update','2017-10-19 08:52:53','Content Details','content/edit/',1),(79,1,4,10,'create','2017-10-19 08:52:53','Content Departments','log/index/',1),(80,1,3,14,'create','2017-10-19 09:01:09','Content Details','content/edit/',1),(81,1,3,11,'create','2017-10-19 09:01:09','Content Departments','log/index/',1),(82,1,3,15,'create','2017-10-19 09:01:44','Content Details','content/edit/',1),(83,1,3,12,'create','2017-10-19 09:01:44','Content Departments','log/index/',1),(84,1,3,16,'create','2017-10-19 09:02:14','Content Details','content/edit/',1),(85,1,3,17,'create','2017-10-19 09:02:46','Content Details','content/edit/',1),(86,1,3,13,'create','2017-10-19 09:02:46','Content Departments','log/index/',1),(87,1,3,16,'update','2017-10-19 09:03:07','Content Details','content/edit/',1),(88,1,3,14,'create','2017-10-19 09:03:07','Content Departments','log/index/',1),(89,1,4,27,'update','2017-10-19 09:06:36','DataCmsDeptsRel','log/index/',1),(90,1,4,9,'update','2017-10-19 09:25:15','Content Details','content/edit/',1),(91,1,4,6,'delete','2017-10-19 09:25:15','Content Departments','log/index/',1),(92,1,4,15,'create','2017-10-19 09:25:15','Content Departments','log/index/',1),(93,1,4,9,'update','2017-10-19 09:32:57','Content Details','content/edit/',1),(94,1,4,15,'delete','2017-10-19 09:32:57','Content Departments','log/index/',1),(95,1,4,16,'create','2017-10-19 09:32:57','Content Departments','log/index/',1),(96,1,4,18,'create','2017-10-19 09:51:55','Content Details','content/edit/',1),(97,1,4,17,'create','2017-10-19 09:51:55','Content Departments','log/index/',1),(98,1,4,18,'delete','2017-10-19 09:52:32','Content Details','content/edit/',1),(99,1,4,17,'delete','2017-10-19 09:52:32','Content Departments','log/index/',1),(100,1,2,2,'update','2017-10-19 10:00:04','Content Details','content/edit/',1),(101,1,2,4,'create','2017-10-19 10:00:04','Content Media','log/index/',1),(102,1,2,5,'create','2017-10-19 10:00:04','Content Media','log/index/',1),(103,1,2,6,'create','2017-10-19 10:00:04','Content Media','log/index/',1),(104,1,2,7,'create','2017-10-19 10:00:04','Content Media','log/index/',1),(105,1,2,4,'delete','2017-10-19 10:00:04','Content Media','log/index/',1),(106,1,2,8,'create','2017-10-19 10:00:04','Content Media','log/index/',1),(107,1,2,2,'update','2017-10-19 10:00:19','Content Details','content/edit/',1),(108,1,2,9,'create','2017-10-19 10:00:19','Content Media','log/index/',1),(109,1,2,2,'update','2017-10-19 10:00:31','Content Details','content/edit/',1),(110,1,2,2,'update','2017-10-19 10:00:37','Content Details','content/edit/',1),(111,1,2,10,'create','2017-10-19 10:00:37','Content Media','log/index/',1),(112,1,3,14,'update','2017-10-19 10:09:25','Content Details','content/edit/',1),(113,1,3,11,'delete','2017-10-19 10:09:25','Content Departments','log/index/',1),(114,1,3,18,'create','2017-10-19 10:09:25','Content Departments','log/index/',1),(115,1,3,19,'create','2017-10-19 10:10:46','Content Details','content/edit/',1),(116,1,3,19,'create','2017-10-19 10:10:46','Content Departments','log/index/',1),(117,1,3,17,'delete','2017-10-19 10:11:07','Content Details','content/edit/',1),(118,1,3,13,'delete','2017-10-19 10:11:07','Content Departments','log/index/',1),(119,1,3,16,'delete','2017-10-19 10:11:07','Content Details','content/edit/',1),(120,1,3,14,'delete','2017-10-19 10:11:07','Content Departments','log/index/',1),(121,1,3,15,'delete','2017-10-19 10:11:07','Content Details','content/edit/',1),(122,1,3,12,'delete','2017-10-19 10:11:07','Content Departments','log/index/',1),(123,1,3,20,'create','2017-10-19 10:11:30','Content Details','content/edit/',1),(124,1,3,20,'create','2017-10-19 10:11:30','Content Departments','log/index/',1),(125,1,3,21,'create','2017-10-19 10:12:13','Content Details','content/edit/',1),(126,1,3,21,'create','2017-10-19 10:12:13','Content Departments','log/index/',1),(127,1,3,22,'create','2017-10-19 10:17:02','Content Details','content/edit/',1),(128,1,3,22,'create','2017-10-19 10:17:02','Content Departments','log/index/',1),(129,1,3,23,'create','2017-10-19 10:17:34','Content Details','content/edit/',1),(130,1,3,23,'create','2017-10-19 10:17:34','Content Departments','log/index/',1),(131,1,3,23,'delete','2017-10-19 10:18:29','Content Details','content/edit/',1),(132,1,3,23,'delete','2017-10-19 10:18:29','Content Departments','log/index/',1),(133,1,3,24,'create','2017-10-19 10:21:22','Content Details','content/edit/',1),(134,1,3,24,'update','2017-10-19 10:26:51','Content Details','content/edit/',1),(135,1,3,24,'update','2017-10-19 10:27:01','Content Details','content/edit/',1),(136,1,3,24,'create','2017-10-19 10:27:01','Content Departments','log/index/',1),(137,1,1,25,'create','2017-10-19 10:32:30','Content Details','content/edit/',1),(138,1,1,26,'create','2017-10-19 10:33:39','Content Details','content/edit/',1),(139,1,4,13,'update','2017-10-19 11:40:56','Content Details','content/edit/',1),(140,1,4,10,'delete','2017-10-19 11:40:56','Content Departments','log/index/',1),(141,1,4,25,'create','2017-10-19 11:40:56','Content Departments','log/index/',1),(142,1,4,13,'update','2017-10-19 11:43:36','Content Details','content/edit/',1),(143,1,4,25,'delete','2017-10-19 11:43:36','Content Departments','log/index/',1),(144,1,4,26,'create','2017-10-19 11:43:36','Content Departments','log/index/',1),(145,1,4,9,'update','2017-10-19 13:55:57','Content Details','content/edit/',1),(146,1,4,16,'delete','2017-10-19 13:55:57','Content Departments','log/index/',1),(147,1,4,27,'create','2017-10-19 13:55:57','Content Departments','log/index/',1),(148,1,4,27,'create','2017-10-22 13:50:43','Content Details','content/edit/',1),(149,1,4,28,'create','2017-10-22 13:50:43','Content Departments','log/index/',1),(150,1,8,3,'update','2017-10-24 09:46:28','Content Details','content/edit/',1),(151,1,8,2,'delete','2017-10-24 09:46:28','Content Departments','log/index/',1),(152,1,8,3,'delete','2017-10-24 09:46:28','Content Departments','log/index/',1),(153,1,8,29,'create','2017-10-24 09:46:28','Content Departments','log/index/',1),(154,1,8,30,'create','2017-10-24 09:46:28','Content Departments','log/index/',1),(155,1,8,10,'update','2017-10-26 12:13:54','DataCmsDeptsRel','log/index/',1),(156,1,8,15,'update','2017-10-26 12:18:21','DataCmsDeptsRel','log/index/',1),(157,1,8,15,'update','2017-10-26 12:20:57','DataCmsDeptsRel','log/index/',1),(158,1,8,16,'update','2017-10-26 12:25:45','DataCmsDeptsRel','log/index/',1),(159,1,8,16,'update','2017-10-26 12:26:13','DataCmsDeptsRel','log/index/',1),(160,1,8,16,'update','2017-10-26 12:26:47','DataCmsDeptsRel','log/index/',1),(161,1,8,19,'update','2017-10-26 12:28:23','DataCmsDeptsRel','log/index/',1),(162,1,8,29,'create','2017-10-26 12:38:57','DataCmsDeptsRel','log/index/',1),(163,1,8,30,'create','2017-10-26 12:43:10','DataCmsDeptsRel','log/index/',1),(164,1,8,31,'create','2017-10-26 12:45:25','DataCmsDeptsRel','log/index/',1),(165,1,8,9,'update','2017-10-26 12:50:09','DataCmsDeptsRel','log/index/',1),(166,1,8,32,'create','2017-10-26 12:52:06','DataCmsDeptsRel','log/index/',1),(167,1,8,3,'update','2017-10-26 14:18:46','Content Details','content/edit/',1),(168,1,8,29,'delete','2017-10-26 14:18:46','Content Departments','log/index/',1),(169,1,8,30,'delete','2017-10-26 14:18:46','Content Departments','log/index/',1),(170,1,8,31,'create','2017-10-26 14:18:46','Content Departments','log/index/',1),(171,1,8,3,'update','2017-10-26 14:20:54','Content Details','content/edit/',1),(172,1,8,31,'delete','2017-10-26 14:20:54','Content Departments','log/index/',1),(173,1,8,32,'create','2017-10-26 14:20:54','Content Departments','log/index/',1),(174,1,8,3,'update','2017-10-26 14:32:34','Content Details','content/edit/',1),(175,1,8,32,'delete','2017-10-26 14:32:34','Content Departments','log/index/',1),(176,1,8,33,'create','2017-10-26 14:32:34','Content Departments','log/index/',1),(177,1,8,11,'create','2017-10-26 14:32:34','Content Media','log/index/',1),(178,1,8,12,'create','2017-10-26 14:32:34','Content Media','log/index/',1),(179,1,8,13,'create','2017-10-26 14:32:34','Content Media','log/index/',1),(180,1,8,14,'create','2017-10-26 14:32:34','Content Media','log/index/',1),(181,1,8,28,'create','2017-10-26 14:39:14','Content Details','content/edit/',1),(182,1,8,34,'create','2017-10-26 14:39:14','Content Departments','log/index/',1),(183,1,8,15,'create','2017-10-26 14:39:14','Content Media','log/index/',1),(184,1,8,16,'create','2017-10-26 14:39:14','Content Media','log/index/',1),(185,1,8,17,'create','2017-10-26 14:39:14','Content Media','log/index/',1),(186,1,8,18,'create','2017-10-26 14:39:14','Content Media','log/index/',1),(187,1,8,19,'create','2017-10-26 14:39:14','Content Media','log/index/',1),(188,1,5,33,'create','2017-10-29 07:45:32','DataCmsDeptsRel','log/index/',1),(189,1,5,34,'create','2017-10-29 07:52:38','DataCmsDeptsRel','log/index/',1),(190,1,5,34,'delete','2017-10-29 08:26:43','DataCmsDeptsRel','log/index/',1),(191,1,5,33,'delete','2017-10-29 08:26:43','DataCmsDeptsRel','log/index/',1),(192,1,8,3,'update','2017-10-29 09:13:18','Content Details','content/edit/',1),(193,1,8,33,'delete','2017-10-29 09:13:18','Content Departments','log/index/',1),(194,1,8,35,'create','2017-10-29 09:13:18','Content Departments','log/index/',1),(195,1,8,3,'update','2017-10-29 09:14:29','Content Details','content/edit/',1),(196,1,8,35,'delete','2017-10-29 09:14:29','Content Departments','log/index/',1),(197,1,8,36,'create','2017-10-29 09:14:29','Content Departments','log/index/',1),(198,1,8,3,'update','2017-10-29 12:35:17','Content Details','content/edit/',1),(199,1,8,36,'delete','2017-10-29 12:35:17','Content Departments','log/index/',1),(200,1,8,37,'create','2017-10-29 12:35:17','Content Departments','log/index/',1),(201,1,8,3,'update','2017-10-29 12:37:52','Content Details','content/edit/',1),(202,1,8,37,'delete','2017-10-29 12:37:52','Content Departments','log/index/',1),(203,1,8,38,'create','2017-10-29 12:37:52','Content Departments','log/index/',1),(204,1,8,3,'update','2017-10-29 12:38:14','Content Details','content/edit/',1),(205,1,8,38,'delete','2017-10-29 12:38:14','Content Departments','log/index/',1),(206,1,8,39,'create','2017-10-29 12:38:14','Content Departments','log/index/',1),(207,1,8,29,'create','2017-10-29 13:36:47','Content Details','content/edit/',1),(208,1,8,40,'create','2017-10-29 13:36:47','Content Departments','log/index/',1),(209,1,8,29,'update','2017-10-29 13:39:52','Content Details','content/edit/',1),(210,1,8,40,'delete','2017-10-29 13:39:52','Content Departments','log/index/',1),(211,1,8,41,'create','2017-10-29 13:39:52','Content Departments','log/index/',1),(212,1,8,29,'update','2017-10-29 13:41:07','Content Details','content/edit/',1),(213,1,8,41,'delete','2017-10-29 13:41:07','Content Departments','log/index/',1),(214,1,8,42,'create','2017-10-29 13:41:07','Content Departments','log/index/',1),(215,1,8,29,'update','2017-10-29 13:42:05','Content Details','content/edit/',1),(216,1,8,42,'delete','2017-10-29 13:42:05','Content Departments','log/index/',1),(217,1,8,43,'create','2017-10-29 13:42:05','Content Departments','log/index/',1),(218,1,8,29,'update','2017-10-29 18:29:15','Content Details','content/edit/',1),(219,1,8,43,'delete','2017-10-29 18:29:15','Content Departments','log/index/',1),(220,1,8,44,'create','2017-10-29 18:29:15','Content Departments','log/index/',1),(221,1,8,29,'update','2017-10-29 18:49:04','Content Details','content/edit/',1),(222,1,8,44,'delete','2017-10-29 18:49:04','Content Departments','log/index/',1),(223,1,8,45,'create','2017-10-29 18:49:04','Content Departments','log/index/',1),(224,1,8,29,'update','2017-10-29 18:50:34','Content Details','content/edit/',1),(225,1,8,45,'delete','2017-10-29 18:50:34','Content Departments','log/index/',1),(226,1,8,46,'create','2017-10-29 18:50:34','Content Departments','log/index/',1),(227,1,8,29,'update','2017-10-30 05:17:57','Content Details','content/edit/',1),(228,1,8,46,'delete','2017-10-30 05:17:57','Content Departments','log/index/',1),(229,1,8,47,'create','2017-10-30 05:17:57','Content Departments','log/index/',1),(230,1,8,29,'update','2017-10-30 05:22:07','Content Details','content/edit/',1),(231,1,8,47,'delete','2017-10-30 05:22:07','Content Departments','log/index/',1),(232,1,8,48,'create','2017-10-30 05:22:07','Content Departments','log/index/',1),(233,1,8,29,'update','2017-10-30 05:22:46','Content Details','content/edit/',1),(234,1,8,48,'delete','2017-10-30 05:22:46','Content Departments','log/index/',1),(235,1,8,49,'create','2017-10-30 05:22:46','Content Departments','log/index/',1),(236,1,8,29,'update','2017-10-30 05:25:10','Content Details','content/edit/',1),(237,1,8,49,'delete','2017-10-30 05:25:10','Content Departments','log/index/',1),(238,1,8,50,'create','2017-10-30 05:25:10','Content Departments','log/index/',1),(239,1,8,29,'update','2017-10-30 05:27:57','Content Details','content/edit/',1),(240,1,8,50,'delete','2017-10-30 05:27:57','Content Departments','log/index/',1),(241,1,8,51,'create','2017-10-30 05:27:57','Content Departments','log/index/',1),(242,1,8,29,'update','2017-10-30 05:30:02','Content Details','content/edit/',1),(243,1,8,51,'delete','2017-10-30 05:30:02','Content Departments','log/index/',1),(244,1,8,52,'create','2017-10-30 05:30:02','Content Departments','log/index/',1),(245,1,8,3,'update','2017-10-30 08:33:18','Content Details','content/edit/',1),(246,1,8,39,'delete','2017-10-30 08:33:18','Content Departments','log/index/',1),(247,1,8,53,'create','2017-10-30 08:33:18','Content Departments','log/index/',1),(248,1,8,3,'update','2017-10-30 08:33:53','Content Details','content/edit/',1),(249,1,8,53,'delete','2017-10-30 08:33:53','Content Departments','log/index/',1),(250,1,8,54,'create','2017-10-30 08:33:53','Content Departments','log/index/',1),(251,1,8,3,'update','2017-10-30 08:34:36','Content Details','content/edit/',1),(252,1,8,54,'delete','2017-10-30 08:34:36','Content Departments','log/index/',1),(253,1,8,55,'create','2017-10-30 08:34:36','Content Departments','log/index/',1),(254,1,8,28,'update','2017-10-30 08:37:39','Content Details','content/edit/',1),(255,1,8,34,'delete','2017-10-30 08:37:39','Content Departments','log/index/',1),(256,1,8,56,'create','2017-10-30 08:37:39','Content Departments','log/index/',1),(257,1,8,28,'update','2017-10-30 08:39:20','Content Details','content/edit/',1),(258,1,8,56,'delete','2017-10-30 08:39:20','Content Departments','log/index/',1),(259,1,8,57,'create','2017-10-30 08:39:20','Content Departments','log/index/',1),(260,1,8,28,'update','2017-10-30 08:39:27','Content Details','content/edit/',1),(261,1,8,57,'delete','2017-10-30 08:39:27','Content Departments','log/index/',1),(262,1,8,58,'create','2017-10-30 08:39:27','Content Departments','log/index/',1),(263,1,8,28,'update','2017-10-30 08:42:30','Content Details','content/edit/',1),(264,1,8,58,'delete','2017-10-30 08:42:30','Content Departments','log/index/',1),(265,1,8,59,'create','2017-10-30 08:42:30','Content Departments','log/index/',1),(266,1,8,28,'update','2017-10-30 08:53:48','Content Details','content/edit/',1),(267,1,8,59,'delete','2017-10-30 08:53:48','Content Departments','log/index/',1),(268,1,8,60,'create','2017-10-30 08:53:48','Content Departments','log/index/',1),(269,1,8,28,'update','2017-10-30 09:07:59','Content Details','content/edit/',1),(270,1,8,60,'delete','2017-10-30 09:07:59','Content Departments','log/index/',1),(271,1,8,61,'create','2017-10-30 09:07:59','Content Departments','log/index/',1),(272,1,8,29,'update','2017-10-30 09:39:48','Content Details','content/edit/',1),(273,1,8,52,'delete','2017-10-30 09:39:48','Content Departments','log/index/',1),(274,1,8,62,'create','2017-10-30 09:39:48','Content Departments','log/index/',1),(275,1,8,29,'update','2017-10-30 09:43:33','Content Details','content/edit/',1),(276,1,8,62,'delete','2017-10-30 09:43:33','Content Departments','log/index/',1),(277,1,8,63,'create','2017-10-30 09:43:33','Content Departments','log/index/',1),(278,1,8,29,'update','2017-10-30 09:57:54','Content Details','content/edit/',1),(279,1,8,63,'delete','2017-10-30 09:57:54','Content Departments','log/index/',1),(280,1,8,64,'create','2017-10-30 09:57:54','Content Departments','log/index/',1),(281,1,8,29,'update','2017-10-30 10:03:22','Content Details','content/edit/',1),(282,1,8,64,'delete','2017-10-30 10:03:22','Content Departments','log/index/',1),(283,1,8,65,'create','2017-10-30 10:03:22','Content Departments','log/index/',1),(284,1,8,29,'update','2017-10-30 10:03:32','Content Details','content/edit/',1),(285,1,8,65,'delete','2017-10-30 10:03:32','Content Departments','log/index/',1),(286,1,8,66,'create','2017-10-30 10:03:32','Content Departments','log/index/',1),(287,1,8,29,'update','2017-10-30 10:03:45','Content Details','content/edit/',1),(288,1,8,66,'delete','2017-10-30 10:03:45','Content Departments','log/index/',1),(289,1,8,67,'create','2017-10-30 10:03:45','Content Departments','log/index/',1),(290,1,8,3,'update','2017-10-30 10:07:07','Content Details','content/edit/',1),(291,1,8,55,'delete','2017-10-30 10:07:07','Content Departments','log/index/',1),(292,1,8,68,'create','2017-10-30 10:07:07','Content Departments','log/index/',1),(293,1,8,28,'update','2017-10-30 10:10:23','Content Details','content/edit/',1),(294,1,8,61,'delete','2017-10-30 10:10:23','Content Departments','log/index/',1),(295,1,8,69,'create','2017-10-30 10:10:23','Content Departments','log/index/',1),(296,1,8,19,'update','2017-10-30 10:20:56','DataCmsDeptsRel','log/index/',1),(297,1,8,28,'update','2017-10-30 10:37:35','Content Details','content/edit/',1),(298,1,8,69,'delete','2017-10-30 10:37:35','Content Departments','log/index/',1),(299,1,8,70,'create','2017-10-30 10:37:35','Content Departments','log/index/',1),(300,1,8,29,'update','2017-10-30 11:31:44','Content Details','content/edit/',1),(301,1,8,67,'delete','2017-10-30 11:31:44','Content Departments','log/index/',1),(302,1,8,71,'create','2017-10-30 11:31:44','Content Departments','log/index/',1),(303,1,8,29,'update','2017-10-30 11:32:39','Content Details','content/edit/',1),(304,1,8,71,'delete','2017-10-30 11:32:39','Content Departments','log/index/',1),(305,1,8,72,'create','2017-10-30 11:32:39','Content Departments','log/index/',1),(306,1,8,29,'update','2017-10-30 11:33:58','Content Details','content/edit/',1),(307,1,8,72,'delete','2017-10-30 11:33:58','Content Departments','log/index/',1),(308,1,8,73,'create','2017-10-30 11:33:58','Content Departments','log/index/',1),(309,1,8,29,'update','2017-10-30 11:35:40','Content Details','content/edit/',1),(310,1,8,73,'delete','2017-10-30 11:35:40','Content Departments','log/index/',1),(311,1,8,74,'create','2017-10-30 11:35:40','Content Departments','log/index/',1),(312,1,8,29,'update','2017-10-30 14:26:18','Content Details','content/edit/',1),(313,1,8,74,'delete','2017-10-30 14:26:18','Content Departments','log/index/',1),(314,1,8,75,'create','2017-10-30 14:26:18','Content Departments','log/index/',1),(315,1,8,29,'update','2017-10-30 14:27:53','Content Details','content/edit/',1),(316,1,8,75,'delete','2017-10-30 14:27:53','Content Departments','log/index/',1),(317,1,8,76,'create','2017-10-30 14:27:53','Content Departments','log/index/',1),(318,1,8,29,'update','2017-10-30 14:30:22','Content Details','content/edit/',1),(319,1,8,76,'delete','2017-10-30 14:30:22','Content Departments','log/index/',1),(320,1,8,77,'create','2017-10-30 14:30:22','Content Departments','log/index/',1),(321,1,8,29,'update','2017-10-30 14:31:26','Content Details','content/edit/',1),(322,1,8,77,'delete','2017-10-30 14:31:26','Content Departments','log/index/',1),(323,1,8,78,'create','2017-10-30 14:31:26','Content Departments','log/index/',1),(324,1,8,29,'update','2017-10-30 14:32:56','Content Details','content/edit/',1),(325,1,8,78,'delete','2017-10-30 14:32:56','Content Departments','log/index/',1),(326,1,8,79,'create','2017-10-30 14:32:56','Content Departments','log/index/',1),(327,1,8,29,'update','2017-10-30 14:36:29','Content Details','content/edit/',1),(328,1,8,79,'delete','2017-10-30 14:36:29','Content Departments','log/index/',1),(329,1,8,80,'create','2017-10-30 14:36:29','Content Departments','log/index/',1),(330,1,8,29,'update','2017-10-30 14:36:57','Content Details','content/edit/',1),(331,1,8,80,'delete','2017-10-30 14:36:57','Content Departments','log/index/',1),(332,1,8,81,'create','2017-10-30 14:36:57','Content Departments','log/index/',1),(333,1,8,29,'update','2017-10-30 14:45:18','Content Details','content/edit/',1),(334,1,8,81,'delete','2017-10-30 14:45:18','Content Departments','log/index/',1),(335,1,8,82,'create','2017-10-30 14:45:18','Content Departments','log/index/',1),(336,1,8,29,'update','2017-10-30 14:49:56','Content Details','content/edit/',1),(337,1,8,82,'delete','2017-10-30 14:49:56','Content Departments','log/index/',1),(338,1,8,83,'create','2017-10-30 14:49:56','Content Departments','log/index/',1),(339,1,8,18,'update','2017-10-31 11:41:31','DataCmsDeptsRel','log/index/',1),(340,1,8,17,'update','2017-10-31 11:41:49','DataCmsDeptsRel','log/index/',1),(341,1,8,16,'update','2017-10-31 11:42:08','DataCmsDeptsRel','log/index/',1),(342,1,8,15,'update','2017-10-31 11:42:34','DataCmsDeptsRel','log/index/',1),(343,1,8,14,'update','2017-10-31 11:42:52','DataCmsDeptsRel','log/index/',1),(344,1,8,7,'update','2017-10-31 11:43:16','DataCmsDeptsRel','log/index/',1),(345,1,8,8,'update','2017-10-31 11:43:42','DataCmsDeptsRel','log/index/',1),(346,1,8,10,'update','2017-10-31 11:44:53','DataCmsDeptsRel','log/index/',1),(347,1,8,11,'update','2017-10-31 11:45:18','DataCmsDeptsRel','log/index/',1),(348,1,8,12,'update','2017-10-31 11:45:40','DataCmsDeptsRel','log/index/',1),(349,1,8,13,'update','2017-10-31 11:46:04','DataCmsDeptsRel','log/index/',1),(350,1,5,3,'update','2017-10-31 12:13:47','DataCmsDepts','log/index/',1),(351,1,5,3,'update','2017-10-31 12:14:08','DataCmsDepts','log/index/',1),(352,1,5,28,'update','2017-10-31 12:19:15','DataCmsDeptsRel','log/index/',1),(353,1,4,2,'update','2017-10-31 12:22:03','DataCmsDepts','log/index/',1),(354,1,4,27,'update','2017-10-31 12:22:55','DataCmsDeptsRel','log/index/',1),(355,1,8,4,'update','2017-10-31 12:23:54','DataCmsDepts','log/index/',1),(356,1,8,9,'update','2017-10-31 12:25:01','DataCmsDeptsRel','log/index/',1),(357,1,5,30,'create','2017-10-31 12:44:01','Content Details','content/edit/',1),(358,1,5,84,'create','2017-10-31 12:44:01','Content Departments','log/index/',1),(359,1,5,30,'update','2017-10-31 12:45:26','Content Details','content/edit/',1),(360,1,5,84,'delete','2017-10-31 12:45:26','Content Departments','log/index/',1),(361,1,5,85,'create','2017-10-31 12:45:26','Content Departments','log/index/',1),(362,1,5,30,'update','2017-10-31 12:47:08','Content Details','content/edit/',1),(363,1,5,85,'delete','2017-10-31 12:47:08','Content Departments','log/index/',1),(364,1,5,86,'create','2017-10-31 12:47:08','Content Departments','log/index/',1),(365,1,5,30,'update','2017-10-31 12:48:34','Content Details','content/edit/',1),(366,1,5,86,'delete','2017-10-31 12:48:34','Content Departments','log/index/',1),(367,1,5,87,'create','2017-10-31 12:48:34','Content Departments','log/index/',1),(368,1,5,30,'update','2017-10-31 12:49:56','Content Details','content/edit/',1),(369,1,5,87,'delete','2017-10-31 12:49:56','Content Departments','log/index/',1),(370,1,5,88,'create','2017-10-31 12:49:56','Content Departments','log/index/',1),(371,1,5,30,'update','2017-10-31 12:52:40','Content Details','content/edit/',1),(372,1,5,88,'delete','2017-10-31 12:52:40','Content Departments','log/index/',1),(373,1,5,89,'create','2017-10-31 12:52:40','Content Departments','log/index/',1),(374,1,5,30,'update','2017-10-31 12:54:20','Content Details','content/edit/',1),(375,1,5,89,'delete','2017-10-31 12:54:20','Content Departments','log/index/',1),(376,1,5,90,'create','2017-10-31 12:54:20','Content Departments','log/index/',1),(377,1,5,30,'update','2017-10-31 12:57:47','Content Details','content/edit/',1),(378,1,5,90,'delete','2017-10-31 12:57:47','Content Departments','log/index/',1),(379,1,5,91,'create','2017-10-31 12:57:47','Content Departments','log/index/',1),(380,1,5,30,'update','2017-10-31 13:00:24','Content Details','content/edit/',1),(381,1,5,91,'delete','2017-10-31 13:00:24','Content Departments','log/index/',1),(382,1,5,92,'create','2017-10-31 13:00:24','Content Departments','log/index/',1),(383,1,5,30,'update','2017-10-31 13:05:53','Content Details','content/edit/',1),(384,1,5,92,'delete','2017-10-31 13:05:53','Content Departments','log/index/',1),(385,1,5,93,'create','2017-10-31 13:05:53','Content Departments','log/index/',1),(386,1,5,30,'update','2017-10-31 13:09:26','Content Details','content/edit/',1),(387,1,5,93,'delete','2017-10-31 13:09:26','Content Departments','log/index/',1),(388,1,5,94,'create','2017-10-31 13:09:26','Content Departments','log/index/',1),(389,1,5,30,'update','2017-10-31 13:10:16','Content Details','content/edit/',1),(390,1,5,94,'delete','2017-10-31 13:10:16','Content Departments','log/index/',1),(391,1,5,95,'create','2017-10-31 13:10:16','Content Departments','log/index/',1),(392,1,2,31,'create','2017-10-31 14:20:20','Content Details','content/edit/',1),(393,1,2,20,'create','2017-10-31 14:20:20','Content Media','log/index/',1),(394,1,2,21,'create','2017-10-31 14:20:20','Content Media','log/index/',1),(395,1,2,22,'create','2017-10-31 14:20:20','Content Media','log/index/',1),(396,1,2,23,'create','2017-10-31 14:20:20','Content Media','log/index/',1),(397,1,8,7,'update','2017-10-31 14:27:07','DataCmsDeptsRel','log/index/',1),(398,1,8,19,'update','2017-10-31 14:29:34','DataCmsDeptsRel','log/index/',1),(399,1,8,19,'update','2017-10-31 14:30:11','DataCmsDeptsRel','log/index/',1),(400,1,8,18,'update','2017-10-31 14:41:09','DataCmsDeptsRel','log/index/',1),(401,1,8,15,'delete','2017-10-31 14:42:13','DataCmsDeptsRel','log/index/',1),(402,1,8,16,'update','2017-10-31 14:42:37','DataCmsDeptsRel','log/index/',1),(403,1,11,6,'create','2017-10-31 14:46:26','DataCmsDepts','log/index/',1),(404,1,11,6,'update','2017-10-31 14:47:14','DataCmsDepts','log/index/',1),(405,1,11,33,'create','2017-10-31 14:49:12','DataCmsDeptsRel','log/index/',1),(406,1,11,34,'create','2017-10-31 14:49:41','DataCmsDeptsRel','log/index/',1),(407,1,11,35,'create','2017-10-31 14:50:07','DataCmsDeptsRel','log/index/',1),(408,1,11,36,'create','2017-10-31 14:50:46','DataCmsDeptsRel','log/index/',1),(409,1,11,37,'create','2017-10-31 14:51:07','DataCmsDeptsRel','log/index/',1),(410,1,11,32,'create','2017-10-31 14:55:52','Content Details','content/edit/',1),(411,1,11,96,'create','2017-10-31 14:55:52','Content Departments','log/index/',1),(412,1,11,24,'create','2017-10-31 14:55:52','Content Media','log/index/',1),(413,1,11,25,'create','2017-10-31 14:55:52','Content Media','log/index/',1),(414,1,11,26,'create','2017-10-31 14:55:52','Content Media','log/index/',1),(415,1,11,27,'create','2017-10-31 14:55:52','Content Media','log/index/',1),(416,1,11,33,'update','2017-10-31 15:01:01','Content Details','content/edit/',1),(417,1,11,97,'create','2017-10-31 15:01:01','Content Departments','log/index/',1),(418,1,11,32,'update','2017-10-31 15:01:17','Content Details','content/edit/',1),(419,1,11,96,'delete','2017-10-31 15:01:17','Content Departments','log/index/',1),(420,1,11,98,'create','2017-10-31 15:01:17','Content Departments','log/index/',1),(421,1,11,34,'update','2017-10-31 15:03:33','Content Details','content/edit/',1),(422,1,11,99,'create','2017-10-31 15:03:33','Content Departments','log/index/',1),(423,1,11,35,'update','2017-10-31 15:03:46','Content Details','content/edit/',1),(424,1,11,100,'create','2017-10-31 15:03:46','Content Departments','log/index/',1),(425,1,8,32,'update','2017-10-31 15:31:51','DataCmsDeptsRel','log/index/',1),(426,1,8,32,'update','2017-10-31 15:32:34','DataCmsDeptsRel','log/index/',1),(427,1,8,36,'create','2017-11-01 10:26:27','Content Details','content/edit/',1),(428,1,8,101,'create','2017-11-01 10:26:27','Content Departments','log/index/',1),(429,1,8,28,'create','2017-11-01 10:26:27','Content Media','log/index/',1),(430,1,8,29,'create','2017-11-01 10:26:27','Content Media','log/index/',1),(431,1,8,37,'create','2017-11-01 10:34:59','Content Details','content/edit/',1),(432,1,8,102,'create','2017-11-01 10:34:59','Content Departments','log/index/',1),(433,1,8,30,'create','2017-11-01 10:34:59','Content Media','log/index/',1),(434,1,8,31,'create','2017-11-01 10:34:59','Content Media','log/index/',1),(435,1,8,32,'create','2017-11-01 10:34:59','Content Media','log/index/',1),(436,1,8,33,'create','2017-11-01 10:34:59','Content Media','log/index/',1),(437,1,8,34,'create','2017-11-01 10:34:59','Content Media','log/index/',1),(438,1,8,38,'create','2017-11-01 10:40:46','Content Details','content/edit/',1),(439,1,8,103,'create','2017-11-01 10:40:46','Content Departments','log/index/',1),(440,1,8,35,'create','2017-11-01 10:40:46','Content Media','log/index/',1),(441,1,8,36,'create','2017-11-01 10:40:46','Content Media','log/index/',1),(442,1,8,37,'create','2017-11-01 10:40:46','Content Media','log/index/',1),(443,1,8,38,'create','2017-11-01 10:40:46','Content Media','log/index/',1),(444,1,8,39,'create','2017-11-01 10:44:17','Content Details','content/edit/',1),(445,1,8,104,'create','2017-11-01 10:44:17','Content Departments','log/index/',1),(446,1,8,39,'create','2017-11-01 10:44:17','Content Media','log/index/',1),(447,1,8,40,'create','2017-11-01 10:44:17','Content Media','log/index/',1),(448,1,8,41,'create','2017-11-01 10:44:17','Content Media','log/index/',1),(449,1,8,38,'update','2017-11-01 10:51:05','Content Details','content/edit/',1),(450,1,8,103,'delete','2017-11-01 10:51:05','Content Departments','log/index/',1),(451,1,8,105,'create','2017-11-01 10:51:05','Content Departments','log/index/',1),(452,1,8,40,'create','2017-11-01 10:53:18','Content Details','content/edit/',1),(453,1,8,106,'create','2017-11-01 10:53:18','Content Departments','log/index/',1),(454,1,8,42,'create','2017-11-01 10:53:18','Content Media','log/index/',1),(455,1,8,43,'create','2017-11-01 10:53:18','Content Media','log/index/',1),(456,1,8,44,'create','2017-11-01 10:53:18','Content Media','log/index/',1),(457,1,8,45,'create','2017-11-01 10:53:18','Content Media','log/index/',1),(458,1,8,46,'create','2017-11-01 10:53:18','Content Media','log/index/',1),(459,1,8,41,'create','2017-11-01 10:58:05','Content Details','content/edit/',1),(460,1,8,107,'create','2017-11-01 10:58:05','Content Departments','log/index/',1),(461,1,8,47,'create','2017-11-01 10:58:05','Content Media','log/index/',1),(462,1,8,48,'create','2017-11-01 10:58:05','Content Media','log/index/',1),(463,1,8,49,'create','2017-11-01 10:58:05','Content Media','log/index/',1),(464,1,8,42,'create','2017-11-01 11:01:09','Content Details','content/edit/',1),(465,1,8,108,'create','2017-11-01 11:01:09','Content Departments','log/index/',1),(466,1,4,43,'create','2017-11-01 11:11:00','Content Details','content/edit/',1),(467,1,4,109,'create','2017-11-01 11:11:00','Content Departments','log/index/',1),(468,1,4,43,'update','2017-11-01 11:14:51','Content Details','content/edit/',1),(469,1,4,109,'delete','2017-11-01 11:14:51','Content Departments','log/index/',1),(470,1,4,110,'create','2017-11-01 11:14:51','Content Departments','log/index/',1),(471,1,4,27,'update','2017-11-01 11:16:43','Content Details','content/edit/',1),(472,1,4,28,'delete','2017-11-01 11:16:43','Content Departments','log/index/',1),(473,1,4,111,'create','2017-11-01 11:16:43','Content Departments','log/index/',1),(474,1,7,44,'create','2017-11-01 11:47:26','Content Details','content/edit/',1),(475,1,8,42,'update','2017-11-01 12:21:53','Content Details','content/edit/',1),(476,1,8,108,'delete','2017-11-01 12:21:53','Content Departments','log/index/',1),(477,1,8,112,'create','2017-11-01 12:21:53','Content Departments','log/index/',1),(478,1,8,41,'update','2017-11-01 12:22:12','Content Details','content/edit/',1),(479,1,8,107,'delete','2017-11-01 12:22:12','Content Departments','log/index/',1),(480,1,8,113,'create','2017-11-01 12:22:12','Content Departments','log/index/',1),(481,1,8,40,'update','2017-11-01 12:22:21','Content Details','content/edit/',1),(482,1,8,106,'delete','2017-11-01 12:22:21','Content Departments','log/index/',1),(483,1,8,114,'create','2017-11-01 12:22:21','Content Departments','log/index/',1),(484,1,8,39,'update','2017-11-01 12:22:32','Content Details','content/edit/',1),(485,1,8,104,'delete','2017-11-01 12:22:32','Content Departments','log/index/',1),(486,1,8,115,'create','2017-11-01 12:22:32','Content Departments','log/index/',1),(487,1,8,38,'update','2017-11-01 12:22:41','Content Details','content/edit/',1),(488,1,8,105,'delete','2017-11-01 12:22:41','Content Departments','log/index/',1),(489,1,8,116,'create','2017-11-01 12:22:41','Content Departments','log/index/',1),(490,1,8,29,'update','2017-11-01 12:22:50','Content Details','content/edit/',1),(491,1,8,83,'delete','2017-11-01 12:22:50','Content Departments','log/index/',1),(492,1,8,117,'create','2017-11-01 12:22:50','Content Departments','log/index/',1),(493,1,8,42,'update','2017-11-01 12:23:20','Content Details','content/edit/',1),(494,1,8,112,'delete','2017-11-01 12:23:20','Content Departments','log/index/',1),(495,1,8,118,'create','2017-11-01 12:23:20','Content Departments','log/index/',1),(496,1,5,30,'update','2017-11-01 15:46:07','Content Details','content/edit/',1),(497,1,5,95,'delete','2017-11-01 15:46:07','Content Departments','log/index/',1),(498,1,5,119,'create','2017-11-01 15:46:07','Content Departments','log/index/',1),(499,1,5,30,'update','2017-11-01 15:46:25','Content Details','content/edit/',1),(500,1,5,119,'delete','2017-11-01 15:46:25','Content Departments','log/index/',1),(501,1,5,120,'create','2017-11-01 15:46:25','Content Departments','log/index/',1),(502,1,5,8,'update','2017-11-01 15:46:41','Content Details','content/edit/',1),(503,1,5,4,'delete','2017-11-01 15:46:41','Content Departments','log/index/',1),(504,1,5,121,'create','2017-11-01 15:46:41','Content Departments','log/index/',1),(505,1,11,35,'update','2017-11-01 22:58:27','Content Details','content/edit/',1),(506,1,11,100,'delete','2017-11-01 22:58:27','Content Departments','log/index/',1),(507,1,11,122,'create','2017-11-01 22:58:27','Content Departments','log/index/',1),(508,1,11,50,'create','2017-11-01 22:58:27','Content Media','log/index/',1),(509,1,11,51,'create','2017-11-01 22:58:27','Content Media','log/index/',1),(510,1,11,52,'create','2017-11-01 22:58:27','Content Media','log/index/',1),(511,1,8,31,'update','2017-11-02 08:50:36','DataCmsDeptsRel','log/index/',1),(512,1,8,31,'update','2017-11-02 08:50:50','DataCmsDeptsRel','log/index/',1),(513,1,8,30,'update','2017-11-02 08:51:20','DataCmsDeptsRel','log/index/',1),(514,1,8,30,'update','2017-11-02 08:52:42','DataCmsDeptsRel','log/index/',1),(515,1,8,30,'update','2017-11-02 08:53:10','DataCmsDeptsRel','log/index/',1),(516,1,8,30,'update','2017-11-02 08:53:43','DataCmsDeptsRel','log/index/',1),(517,1,8,29,'update','2017-11-02 08:54:11','DataCmsDeptsRel','log/index/',1),(518,1,8,29,'update','2017-11-02 08:54:23','DataCmsDeptsRel','log/index/',1),(519,1,8,8,'update','2017-11-02 08:55:08','DataCmsDeptsRel','log/index/',1),(520,1,8,8,'update','2017-11-02 08:55:40','DataCmsDeptsRel','log/index/',1),(521,1,8,7,'update','2017-11-02 08:56:16','DataCmsDeptsRel','log/index/',1),(522,1,8,7,'update','2017-11-02 08:56:28','DataCmsDeptsRel','log/index/',1),(523,1,7,44,'update','2017-11-02 10:01:14','Content Details','content/edit/',1),(524,1,7,44,'update','2017-11-02 10:30:33','Content Details','content/edit/',1),(525,1,7,44,'update','2017-11-02 11:17:56','Content Details','content/edit/',1),(526,1,7,44,'update','2017-11-02 11:18:43','Content Details','content/edit/',1),(527,1,11,34,'update','2017-11-02 12:44:07','DataCmsDeptsRel','log/index/',1),(528,1,8,32,'update','2017-11-02 13:07:39','DataCmsDeptsRel','log/index/',1),(529,1,8,31,'update','2017-11-02 13:09:46','DataCmsDeptsRel','log/index/',1),(530,1,8,30,'update','2017-11-02 13:15:10','DataCmsDeptsRel','log/index/',1),(531,1,8,29,'update','2017-11-02 13:15:19','DataCmsDeptsRel','log/index/',1),(532,1,8,17,'update','2017-11-02 13:15:31','DataCmsDeptsRel','log/index/',1),(533,1,8,14,'update','2017-11-02 13:15:44','DataCmsDeptsRel','log/index/',1),(534,1,8,13,'update','2017-11-02 13:15:51','DataCmsDeptsRel','log/index/',1),(535,1,8,13,'update','2017-11-02 13:30:37','DataCmsDeptsRel','log/index/',1),(536,1,8,12,'update','2017-11-02 13:30:45','DataCmsDeptsRel','log/index/',1),(537,1,8,11,'update','2017-11-02 13:30:53','DataCmsDeptsRel','log/index/',1),(538,1,8,10,'update','2017-11-02 13:31:01','DataCmsDeptsRel','log/index/',1),(539,1,8,9,'update','2017-11-02 13:31:08','DataCmsDeptsRel','log/index/',1),(540,1,8,8,'update','2017-11-02 13:31:15','DataCmsDeptsRel','log/index/',1),(541,1,8,7,'update','2017-11-02 13:31:21','DataCmsDeptsRel','log/index/',1),(542,1,11,35,'update','2017-11-02 13:34:50','Content Details','content/edit/',1),(543,1,11,122,'delete','2017-11-02 13:34:50','Content Departments','log/index/',1),(544,1,11,123,'create','2017-11-02 13:34:50','Content Departments','log/index/',1),(545,1,11,53,'create','2017-11-02 13:34:50','Content Media','log/index/',1),(546,1,11,54,'create','2017-11-02 13:34:50','Content Media','log/index/',1),(547,1,11,34,'update','2017-11-02 13:35:49','Content Details','content/edit/',1),(548,1,11,99,'delete','2017-11-02 13:35:49','Content Departments','log/index/',1),(549,1,11,124,'create','2017-11-02 13:35:49','Content Departments','log/index/',1),(550,1,11,55,'create','2017-11-02 13:35:49','Content Media','log/index/',1),(551,1,11,56,'create','2017-11-02 13:35:49','Content Media','log/index/',1),(552,1,11,57,'create','2017-11-02 13:35:49','Content Media','log/index/',1),(553,1,11,58,'create','2017-11-02 13:35:49','Content Media','log/index/',1),(554,1,11,59,'create','2017-11-02 13:35:49','Content Media','log/index/',1),(555,1,11,60,'create','2017-11-02 13:35:49','Content Media','log/index/',1),(556,1,11,61,'create','2017-11-02 13:35:49','Content Media','log/index/',1),(557,1,11,33,'update','2017-11-02 13:37:41','Content Details','content/edit/',1),(558,1,11,97,'delete','2017-11-02 13:37:41','Content Departments','log/index/',1),(559,1,11,125,'create','2017-11-02 13:37:41','Content Departments','log/index/',1),(560,1,11,62,'create','2017-11-02 13:37:41','Content Media','log/index/',1),(561,1,11,63,'create','2017-11-02 13:37:41','Content Media','log/index/',1),(562,1,11,32,'update','2017-11-02 13:38:46','Content Details','content/edit/',1),(563,1,11,98,'delete','2017-11-02 13:38:46','Content Departments','log/index/',1),(564,1,11,126,'create','2017-11-02 13:38:46','Content Departments','log/index/',1),(565,1,7,44,'update','2017-11-02 14:13:06','Content Details','content/edit/',1),(566,1,1,45,'create','2017-11-02 14:48:19','Content Details','content/edit/',1),(567,1,1,45,'update','2017-11-02 14:49:13','Content Details','content/edit/',1),(568,1,1,45,'update','2017-11-02 14:49:51','Content Details','content/edit/',1),(569,1,1,45,'update','2017-11-02 14:50:23','Content Details','content/edit/',1),(570,1,1,45,'update','2017-11-02 14:51:46','Content Details','content/edit/',1),(571,1,8,46,'create','2017-11-02 14:55:52','Content Details','content/edit/',1),(572,1,8,127,'create','2017-11-02 14:55:52','Content Departments','log/index/',1),(573,1,8,64,'create','2017-11-02 14:55:52','Content Media','log/index/',1),(574,1,8,46,'update','2017-11-02 14:57:04','Content Details','content/edit/',1),(575,1,8,127,'delete','2017-11-02 14:57:04','Content Departments','log/index/',1),(576,1,8,128,'create','2017-11-02 14:57:04','Content Departments','log/index/',1),(577,1,8,46,'update','2017-11-02 14:57:31','Content Details','content/edit/',1),(578,1,8,128,'delete','2017-11-02 14:57:31','Content Departments','log/index/',1),(579,1,8,129,'create','2017-11-02 14:57:31','Content Departments','log/index/',1),(580,1,8,46,'delete','2017-11-02 14:57:47','Content Details','content/edit/',1),(581,1,8,129,'delete','2017-11-02 14:57:47','Content Departments','log/index/',1),(582,1,3,47,'create','2017-11-02 15:05:20','Content Details','content/edit/',1),(583,1,3,130,'create','2017-11-02 15:05:20','Content Departments','log/index/',1),(584,1,3,65,'create','2017-11-02 15:05:20','Content Media','log/index/',1),(585,1,3,47,'delete','2017-11-02 15:06:33','Content Details','content/edit/',1),(586,1,3,130,'delete','2017-11-02 15:06:33','Content Departments','log/index/',1),(587,1,1,45,'update','2017-11-02 15:07:26','Content Details','content/edit/',1),(588,1,1,45,'delete','2017-11-02 15:07:57','Content Details','content/edit/',1),(589,1,2,48,'create','2017-11-02 15:11:24','Content Details','content/edit/',1),(590,1,2,66,'create','2017-11-02 15:11:24','Content Media','log/index/',1),(591,1,2,48,'update','2017-11-02 15:13:40','Content Details','content/edit/',1),(592,1,2,48,'update','2017-11-02 15:13:53','Content Details','content/edit/',1),(593,1,2,48,'delete','2017-11-02 15:14:13','Content Details','content/edit/',1),(594,1,4,43,'update','2017-11-02 15:15:00','Content Details','content/edit/',1),(595,1,4,110,'delete','2017-11-02 15:15:00','Content Departments','log/index/',1),(596,1,4,131,'create','2017-11-02 15:15:00','Content Departments','log/index/',1),(597,1,4,49,'create','2017-11-02 15:17:19','Content Details','content/edit/',1),(598,1,6,50,'create','2017-11-02 15:22:17','Content Details','content/edit/',1),(599,1,6,67,'create','2017-11-02 15:22:17','Content Media','log/index/',1),(600,1,2,51,'create','2017-12-03 10:03:58','Content Details','content/edit/',1),(601,1,1,25,'delete','2017-12-03 12:52:46','Content Details','content/edit/',1),(602,1,1,26,'delete','2017-12-03 12:52:54','Content Details','content/edit/',1),(603,1,1,52,'create','2017-12-03 12:55:39','Content Details','content/edit/',1),(604,1,8,38,'create','2017-12-17 13:56:40','DataCmsDeptsRel','log/index/',1),(605,1,8,39,'create','2017-12-17 13:59:12','DataCmsDeptsRel','log/index/',1),(606,1,8,40,'create','2017-12-17 14:04:02','DataCmsDeptsRel','log/index/',1),(607,1,8,41,'create','2017-12-17 14:04:31','DataCmsDeptsRel','log/index/',1),(608,1,8,42,'create','2017-12-17 14:04:57','DataCmsDeptsRel','log/index/',1),(609,1,8,43,'create','2017-12-17 14:05:21','DataCmsDeptsRel','log/index/',1),(610,1,8,43,'update','2017-12-17 14:06:19','DataCmsDeptsRel','log/index/',1),(611,1,8,39,'update','2017-12-17 14:23:29','DataCmsDeptsRel','log/index/',1),(612,1,8,39,'update','2017-12-17 14:24:17','DataCmsDeptsRel','log/index/',1),(613,1,8,40,'update','2017-12-17 14:35:03','DataCmsDeptsRel','log/index/',1),(614,1,8,39,'update','2017-12-17 14:36:57','DataCmsDeptsRel','log/index/',1),(615,1,8,42,'update','2017-12-17 14:38:30','DataCmsDeptsRel','log/index/',1),(616,1,8,38,'delete','2017-12-17 14:38:43','DataCmsDeptsRel','log/index/',1),(617,1,8,43,'delete','2017-12-17 14:39:31','DataCmsDeptsRel','log/index/',1),(618,1,8,41,'delete','2017-12-17 14:39:31','DataCmsDeptsRel','log/index/',1),(619,1,8,40,'delete','2017-12-17 14:39:31','DataCmsDeptsRel','log/index/',1),(620,1,8,42,'update','2017-12-17 14:50:54','DataCmsDeptsRel','log/index/',1),(621,1,8,19,'update','2017-12-17 14:54:47','DataCmsDeptsRel','log/index/',1),(622,1,8,42,'delete','2017-12-17 15:01:23','DataCmsDeptsRel','log/index/',1),(623,1,8,17,'update','2017-12-17 15:01:43','DataCmsDeptsRel','log/index/',1),(624,1,8,17,'update','2017-12-17 15:02:13','DataCmsDeptsRel','log/index/',1),(625,1,8,18,'update','2017-12-17 15:03:54','DataCmsDeptsRel','log/index/',1),(626,1,8,31,'update','2017-12-17 15:14:28','DataCmsDeptsRel','log/index/',1),(627,1,8,9,'update','2017-12-17 15:20:31','DataCmsDeptsRel','log/index/',1),(628,1,8,10,'update','2017-12-17 15:20:39','DataCmsDeptsRel','log/index/',1),(629,1,8,39,'update','2017-12-17 15:59:26','DataCmsDeptsRel','log/index/',1),(630,1,8,19,'update','2017-12-17 15:59:29','DataCmsDeptsRel','log/index/',1),(631,1,8,18,'update','2017-12-17 15:59:33','DataCmsDeptsRel','log/index/',1),(632,1,8,17,'update','2017-12-17 15:59:36','DataCmsDeptsRel','log/index/',1),(633,1,8,16,'update','2017-12-17 15:59:39','DataCmsDeptsRel','log/index/',1),(634,1,8,40,'create','2018-01-08 12:16:51','DataCmsDeptsRel','log/index/',1),(635,1,8,53,'create','2018-01-15 14:19:36','Content Details','content/edit/',1),(636,1,8,132,'create','2018-01-15 14:19:36','Content Departments','log/index/',1),(637,1,8,133,'create','2018-01-15 14:19:36','Content Departments','log/index/',1),(638,1,8,54,'create','2018-01-22 09:38:32','Content Details','content/edit/',1),(639,1,8,54,'delete','2018-01-22 10:39:02','Content Details','content/edit/',1),(640,1,8,55,'create','2018-01-22 11:18:41','Content Details','content/edit/',1),(641,1,8,134,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(642,1,8,135,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(643,1,8,136,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(644,1,8,137,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(645,1,8,138,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(646,1,8,139,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(647,1,8,140,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(648,1,8,141,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(649,1,8,142,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(650,1,8,143,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(651,1,8,144,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(652,1,8,145,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(653,1,8,146,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(654,1,8,147,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(655,1,8,148,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(656,1,8,149,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(657,1,8,150,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(658,1,8,151,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(659,1,8,152,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(660,1,8,153,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(661,1,8,154,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(662,1,8,155,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(663,1,8,156,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(664,1,8,157,'create','2018-01-22 11:18:41','Content Departments','log/index/',1),(665,1,8,68,'create','2018-01-22 11:18:41','Content Media','log/index/',1),(666,1,8,69,'create','2018-01-22 11:18:41','Content Media','log/index/',1),(667,1,8,70,'create','2018-01-22 11:18:41','Content Media','log/index/',1),(668,1,8,71,'create','2018-01-22 11:18:41','Content Media','log/index/',1),(669,1,8,55,'update','2018-01-22 11:25:33','Content Details','content/edit/',1),(670,1,8,56,'create','2018-01-22 11:44:13','Content Details','content/edit/',1),(671,1,8,158,'create','2018-01-22 11:44:13','Content Departments','log/index/',1),(672,1,8,159,'create','2018-01-22 11:44:13','Content Departments','log/index/',1),(673,1,8,160,'create','2018-01-22 11:44:13','Content Departments','log/index/',1),(674,1,8,161,'create','2018-01-22 11:44:13','Content Departments','log/index/',1),(675,1,8,162,'create','2018-01-22 11:44:13','Content Departments','log/index/',1),(676,1,8,72,'create','2018-01-22 11:44:13','Content Media','log/index/',1),(677,1,8,73,'create','2018-01-22 11:44:13','Content Media','log/index/',1),(678,1,8,74,'create','2018-01-22 11:44:13','Content Media','log/index/',1),(679,1,8,75,'create','2018-01-22 11:44:13','Content Media','log/index/',1),(680,1,8,76,'create','2018-01-22 11:44:13','Content Media','log/index/',1),(681,1,8,77,'create','2018-01-22 11:44:13','Content Media','log/index/',1),(682,1,8,78,'create','2018-01-22 11:44:13','Content Media','log/index/',1),(683,1,8,29,'delete','2018-01-22 16:09:09','Content Details','content/edit/',1),(684,1,8,3,'update','2018-01-22 16:09:37','Content Details','content/edit/',1),(685,1,8,68,'delete','2018-01-22 16:09:37','Content Departments','log/index/',1),(686,1,8,163,'create','2018-01-22 16:09:37','Content Departments','log/index/',1),(687,1,8,164,'create','2018-01-22 16:09:37','Content Departments','log/index/',1),(688,1,8,165,'create','2018-01-22 16:09:37','Content Departments','log/index/',1),(689,1,8,166,'create','2018-01-22 16:09:37','Content Departments','log/index/',1),(690,1,8,167,'create','2018-01-22 16:09:37','Content Departments','log/index/',1),(691,1,8,168,'create','2018-01-22 16:09:37','Content Departments','log/index/',1),(692,1,8,169,'create','2018-01-22 16:09:37','Content Departments','log/index/',1),(693,1,8,170,'create','2018-01-22 16:09:37','Content Departments','log/index/',1),(694,1,8,171,'create','2018-01-22 16:09:37','Content Departments','log/index/',1),(695,1,8,32,'update','2018-01-27 19:49:16','DataCmsDeptsRel','log/index/',1),(696,1,8,7,'update','2018-01-27 19:50:50','DataCmsDeptsRel','log/index/',1),(697,1,8,7,'update','2018-01-27 19:51:14','DataCmsDeptsRel','log/index/',1),(698,1,8,42,'create','2018-01-27 20:02:51','DataCmsDeptsRel','log/index/',1),(699,1,8,79,'create','2018-01-27 20:02:51','Content Media','log/index/',1),(700,1,8,80,'create','2018-01-27 20:02:51','Content Media','log/index/',1),(701,1,8,42,'update','2018-01-27 20:03:20','DataCmsDeptsRel','log/index/',1),(702,1,8,42,'update','2018-01-27 20:03:23','DataCmsDeptsRel','log/index/',1),(703,1,8,42,'delete','2018-01-27 20:03:29','DataCmsDeptsRel','log/index/',1),(704,1,8,1,'update','2018-01-27 20:06:50','DataCmsDeptsRel','log/index/',1),(705,1,8,81,'create','2018-01-27 20:06:50','Content Media','log/index/',1),(706,1,8,57,'create','2018-01-29 08:55:51','Content Details','content/edit/',1),(707,1,8,172,'create','2018-01-29 08:55:51','Content Departments','log/index/',1),(708,1,8,173,'create','2018-01-29 08:55:51','Content Departments','log/index/',1),(709,1,8,82,'create','2018-01-29 08:55:51','Content Media','log/index/',1),(710,1,8,58,'create','2018-01-29 09:00:50','Content Details','content/edit/',1),(711,1,8,174,'create','2018-01-29 09:00:50','Content Departments','log/index/',1),(712,1,8,83,'create','2018-01-29 09:00:50','Content Media','log/index/',1),(713,1,8,59,'create','2018-01-29 09:05:23','Content Details','content/edit/',1),(714,1,8,175,'create','2018-01-29 09:05:23','Content Departments','log/index/',1),(715,1,8,84,'create','2018-01-29 09:05:23','Content Media','log/index/',1),(716,1,8,60,'create','2018-01-29 09:11:42','Content Details','content/edit/',1),(717,1,8,176,'create','2018-01-29 09:11:42','Content Departments','log/index/',1),(718,1,8,85,'create','2018-01-29 09:11:42','Content Media','log/index/',1),(719,1,8,40,'update','2018-01-29 20:11:43','DataCmsDeptsRel','log/index/',1),(720,1,8,7,'update','2018-01-29 20:11:55','DataCmsDeptsRel','log/index/',1),(721,1,8,10,'update','2018-01-29 20:12:04','DataCmsDeptsRel','log/index/',1),(722,1,8,11,'update','2018-01-29 20:12:04','DataCmsDeptsRel','log/index/',1),(723,1,8,7,'update','2018-01-29 20:12:17','DataCmsDeptsRel','log/index/',1),(724,1,8,10,'update','2018-01-29 20:12:17','DataCmsDeptsRel','log/index/',1),(725,1,8,11,'update','2018-01-29 20:12:17','DataCmsDeptsRel','log/index/',1),(726,1,8,43,'create','2018-01-29 20:51:44','DataCmsDeptsRel','log/index/',1),(727,1,8,86,'create','2018-01-29 20:51:44','Content Media','log/index/',1),(728,1,8,61,'create','2018-02-05 09:46:32','Content Details','content/edit/',1),(729,1,8,177,'create','2018-02-05 09:46:32','Content Departments','log/index/',1),(730,1,8,87,'create','2018-02-05 09:46:32','Content Media','log/index/',1),(731,1,8,62,'create','2018-02-05 13:44:39','Content Details','content/edit/',1),(732,1,8,88,'create','2018-02-05 13:44:39','Content Media','log/index/',1),(733,1,8,7,'update','2018-02-06 11:59:22','DataCmsDeptsRel','log/index/',1),(734,1,8,89,'create','2018-02-06 11:59:22','Content Media','log/index/',1),(735,1,8,90,'create','2018-02-06 11:59:22','Content Media','log/index/',1),(736,1,8,91,'create','2018-02-06 11:59:22','Content Media','log/index/',1);
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_exchange_req_reasons`
--

DROP TABLE IF EXISTS `maintenance_exchange_req_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenance_exchange_req_reasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason_title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_exchange_req_reasons`
--

LOCK TABLES `maintenance_exchange_req_reasons` WRITE;
/*!40000 ALTER TABLE `maintenance_exchange_req_reasons` DISABLE KEYS */;
INSERT INTO `maintenance_exchange_req_reasons` VALUES (1,'استبدال مجانا	'),(2,'استبدال مع خصم 10%	');
/*!40000 ALTER TABLE `maintenance_exchange_req_reasons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_pending_req_reasons`
--

DROP TABLE IF EXISTS `maintenance_pending_req_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenance_pending_req_reasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason_title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_pending_req_reasons`
--

LOCK TABLES `maintenance_pending_req_reasons` WRITE;
/*!40000 ALTER TABLE `maintenance_pending_req_reasons` DISABLE KEYS */;
INSERT INTO `maintenance_pending_req_reasons` VALUES (1,'طحالب -فطريات'),(2,'تشقق	'),(3,'تسريب في نبل نحاس ١ بوصه داخلي'),(4,'تسريب في نبل نحاس ٢ بوصه داخلي	'),(5,'تسريب في نبل نحاس ١ بوصه خارجي');
/*!40000 ALTER TABLE `maintenance_pending_req_reasons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `href` varchar(255) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  `is_secured_menu` tinyint(4) NOT NULL DEFAULT '0',
  `menu_cms_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,'Ads','fa fa-bullhorn','ads_module/index',NULL,1,0,0),(2,'المنتجات',' fa fa-briefcase','cms_module/content/productsList/',NULL,1,0,2),(3,'المصنع',' fa fa-cogs','cms_module/content/index/3',NULL,1,0,2),(4,'الفعاليات',' fa fa-calendar','cms_module/content/index/1',NULL,1,0,2),(5,'الصفحات',' fa fa-clone','cms_module/content/index/2',NULL,1,0,2),(6,'البروفايل',' fa fa-id-card-o','cms_module/content/index/4',NULL,1,0,2),(7,'الكتيبات',' fa fa-file-image-o','cms_module/content/index/5',NULL,1,0,2),(8,'الميديا',' fa fa-film','cms_module/content/index/6',NULL,1,0,2),(9,'الفوتر',' fa fa-info-circle','cms_module/content/index/7',NULL,1,0,2),(10,'الاستبيان',' fa fa-pencil-square-o','polls_module/index',NULL,1,0,2),(11,'الاعلانات',' fa fa-bullhorn','ads_module/index',NULL,1,0,2),(12,'اتصل بنا',' fa fa-phone-square','cms_module/data_forms_response/index/1',NULL,1,0,2),(13,'طلبات الشراء',' icon-layers','cms_module/orders/index/8',NULL,1,0,2),(14,'الإشعارات',' icon-bell','notifications_module/index',NULL,1,0,2),(15,'القائمة البريدية',' icon-layers','cms_module/news_letter',NULL,1,0,2),(16,'العملاء','fa fa-users','cms_module/clients/list',NULL,1,0,2),(17,'ألعروض',' fa fa-briefcase','offers_module/index/',NULL,1,0,2),(18,'الخصومات',' fa fa-briefcase','discounts_module/index/',NULL,1,0,2),(19,'الصيانة',' icon-layers','maintenance_module/index',NULL,1,0,2);
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mission_types`
--

DROP TABLE IF EXISTS `mission_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mission_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `name_ar` varchar(35) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mission_types`
--

LOCK TABLES `mission_types` WRITE;
/*!40000 ALTER TABLE `mission_types` DISABLE KEYS */;
INSERT INTO `mission_types` VALUES (1,'Sale','بيع'),(2,'Product View','عرض منتج'),(3,'Expected Client','عميل متوقع'),(4,'Cash Collect','تحصيل مالي');
/*!40000 ALTER TABLE `mission_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsletter`
--

DROP TABLE IF EXISTS `newsletter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail` varchar(50) NOT NULL,
  `application_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsletter`
--

LOCK TABLES `newsletter` WRITE;
/*!40000 ALTER TABLE `newsletter` DISABLE KEYS */;
INSERT INTO `newsletter` VALUES (1,'pentavalue@pentavalue.com',1),(2,'salma@pentavalue.com',1),(3,'wael.fci@gmail.com',1),(11,'testash@test.com',1),(12,'amralaaismail30@gmail.com',1);
/*!40000 ALTER TABLE `newsletter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_types`
--

DROP TABLE IF EXISTS `notification_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_types`
--

LOCK TABLES `notification_types` WRITE;
/*!40000 ALTER TABLE `notification_types` DISABLE KEYS */;
INSERT INTO `notification_types` VALUES (5,'مسج'),(6,'ميل'),(7,'كروم'),(8,'Android'),(9,'iOS');
/*!40000 ALTER TABLE `notification_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `type` int(11) NOT NULL,
  `create_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications_show_type`
--

DROP TABLE IF EXISTS `notifications_show_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications_show_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications_show_type`
--

LOCK TABLES `notifications_show_type` WRITE;
/*!40000 ALTER TABLE `notifications_show_type` DISABLE KEYS */;
INSERT INTO `notifications_show_type` VALUES (1,'now'),(2,'shceduled');
/*!40000 ALTER TABLE `notifications_show_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications_types`
--

DROP TABLE IF EXISTS `notifications_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications_types`
--

LOCK TABLES `notifications_types` WRITE;
/*!40000 ALTER TABLE `notifications_types` DISABLE KEYS */;
INSERT INTO `notifications_types` VALUES (1,'web'),(2,'email'),(3,'sms');
/*!40000 ALTER TABLE `notifications_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_delivery_places`
--

DROP TABLE IF EXISTS `offer_delivery_places`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_delivery_places` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `created_at` varchar(30) NOT NULL,
  `updated_at` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_delivery_places`
--

LOCK TABLES `offer_delivery_places` WRITE;
/*!40000 ALTER TABLE `offer_delivery_places` DISABLE KEYS */;
INSERT INTO `offer_delivery_places` VALUES (1,1,2,'1511186484','1511186492');
/*!40000 ALTER TABLE `offer_delivery_places` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_regions`
--

DROP TABLE IF EXISTS `offer_regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_regions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) NOT NULL,
  `region_id` int(11) NOT NULL,
  `created_at` varchar(30) NOT NULL,
  `updated_at` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_regions`
--

LOCK TABLES `offer_regions` WRITE;
/*!40000 ALTER TABLE `offer_regions` DISABLE KEYS */;
INSERT INTO `offer_regions` VALUES (1,1,1,'1508416160','1511186492'),(2,2,2,'1508416160','1508416160');
/*!40000 ALTER TABLE `offer_regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_rel_items`
--

DROP TABLE IF EXISTS `offer_rel_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_rel_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) NOT NULL,
  `data_cms_id` int(11) NOT NULL,
  `created_at` varchar(30) NOT NULL,
  `updated_at` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_rel_items`
--

LOCK TABLES `offer_rel_items` WRITE;
/*!40000 ALTER TABLE `offer_rel_items` DISABLE KEYS */;
INSERT INTO `offer_rel_items` VALUES (1,1,3,'1508416160','1508416160'),(2,2,2,'1508416160','1508416160'),(3,1,42,'1515508045','1515508045'),(4,1,55,'1516621086','1516621086'),(5,2,56,'1516624120','1516624120'),(6,1,56,'1516624131','1516624131'),(7,1,56,'1516624138','1516624138');
/*!40000 ALTER TABLE `offer_rel_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_rel_types`
--

DROP TABLE IF EXISTS `offer_rel_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_rel_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `start_date` varchar(30) DEFAULT NULL,
  `end_date` varchar(30) DEFAULT NULL,
  `created_at` varchar(30) NOT NULL,
  `updated_at` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_rel_types`
--

LOCK TABLES `offer_rel_types` WRITE;
/*!40000 ALTER TABLE `offer_rel_types` DISABLE KEYS */;
INSERT INTO `offer_rel_types` VALUES (1,1,1,'','','1508416160','1508416160'),(2,1,2,'1508371200','1508371200','1508416160','1511186492'),(3,2,2,'1508416160','1508416160','1508416160','1508416160');
/*!40000 ALTER TABLE `offer_rel_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_types`
--

DROP TABLE IF EXISTS `offer_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` varchar(30) NOT NULL,
  `updated_at` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_types`
--

LOCK TABLES `offer_types` WRITE;
/*!40000 ALTER TABLE `offer_types` DISABLE KEYS */;
INSERT INTO `offer_types` VALUES (1,'Until Finished','',''),(2,'Limited Period','','');
/*!40000 ALTER TABLE `offer_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offers`
--

DROP TABLE IF EXISTS `offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `image` varchar(255) NOT NULL,
  `discount_percent` int(11) NOT NULL,
  `products_number` int(11) NOT NULL,
  `max_purchase_number` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `show_in_homepage` tinyint(1) NOT NULL DEFAULT '0',
  `price` decimal(10,2) NOT NULL,
  `original_price` decimal(10,2) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` varchar(30) NOT NULL,
  `updated_at` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
INSERT INTO `offers` VALUES (1,'Offer1','842225cf-fce4-46b6-b5be-49a8be838f20.',20,3,0,'test offer 1',1,0.00,0.00,1,'1508416160','1511186492'),(2,'Offer2','28cedc13-8d11-49c6-b160-819eb15932fb.png',30,5,3,'test offer 2',1,700.00,1000.00,1,'1508416160','1508416160');
/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_changes`
--

DROP TABLE IF EXISTS `password_changes`;
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
/*!40000 ALTER TABLE `password_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `profilesId` int(10) unsigned NOT NULL,
  `resource` varchar(40) NOT NULL,
  `action` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profilesId` (`profilesId`)
) ENGINE=InnoDB AUTO_INCREMENT=5613 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (2120,2,'users','index'),(2121,2,'users','search'),(2122,2,'users','edit'),(2123,2,'users','create'),(2124,2,'users','delete'),(2125,2,'users','changePassword'),(2126,2,'profiles','index'),(2127,2,'profiles','search'),(2128,2,'profiles','edit'),(2129,2,'profiles','create'),(2130,2,'profiles','delete'),(2131,2,'permissions','index'),(2132,2,'content','index'),(2133,2,'content','edit'),(2134,2,'content','new'),(2135,2,'content','editmedia'),(2136,2,'content','save'),(2137,2,'content','create'),(2138,2,'content','media'),(2139,2,'content','addmedia'),(2140,2,'content','createmedia'),(2141,2,'content','delete'),(2142,2,'content','deletemedia'),(2143,2,'content','main'),(2144,2,'content','mediaMultiUpload'),(2145,2,'content','mediaDelUpload'),(2146,2,'content','statistics'),(2147,2,'content','toggleDisplay'),(2148,2,'departments','index'),(2149,2,'departments','edit'),(2150,2,'departments','new'),(2151,2,'departments','save'),(2152,2,'departments','delete'),(2153,2,'departments','create'),(2154,2,'main-departments','index'),(2155,2,'main-departments','edit'),(2156,2,'main-departments','new'),(2157,2,'main-departments','delete'),(2158,2,'main-departments','create'),(2159,2,'main-departments','save'),(2160,2,'ads','index'),(2161,2,'ads','create'),(2162,2,'ads','store'),(2163,2,'ads','edit'),(2164,2,'ads','update'),(2165,2,'ads','delete'),(2166,2,'ads','getDepartmentsAjax'),(2167,2,'ads','getAjaxContentBuModule'),(2168,2,'ads','getAjaxContentByModule'),(2169,2,'users_application_statistics','index'),(2170,2,'mobile_users','index'),(2171,2,'mobile_users','statistics'),(2172,2,'mobile_users','edit'),(2173,2,'mobile_users','save'),(2174,2,'data_forms','index'),(2175,2,'data_forms','search'),(2176,2,'data_forms','create'),(2177,2,'data_forms','edit'),(2178,2,'data_forms','save'),(2179,2,'data_forms','delete'),(2180,2,'data_forms_response','index'),(2181,2,'data_forms_response','edit'),(2182,2,'data_forms_response','create'),(2183,2,'data_forms_response','delete'),(2184,2,'data_forms_response','view'),(2185,2,'data_forms_response','save'),(2186,2,'data_forms_response','new'),(2187,2,'data_forms_response','replayform'),(2188,2,'data_forms_response','search'),(2189,2,'data_forms_lang','index'),(2190,2,'data_forms_lang','search'),(2191,2,'data_forms_lang','new'),(2192,2,'data_forms_lang','edit'),(2193,2,'data_forms_lang','create'),(2194,2,'data_forms_lang','save'),(2195,2,'data_forms_lang','delete'),(2196,2,'cp_users','index'),(2197,2,'cp_users','new'),(2198,2,'cp_users','create'),(2199,2,'cp_users','edit'),(2200,2,'cp_users','delete'),(2201,2,'cp_users','save'),(2202,2,'users_application_module','index'),(2203,2,'users_application_module','search'),(2204,2,'users_application_module','edit'),(2205,2,'users_application_module','create'),(2206,2,'users_application_module','save'),(2207,2,'users_application_module','delete'),(2208,2,'users_application_module','settings'),(2209,2,'users_application_module','settingssave'),(2210,3,'users','index'),(2211,3,'users','search'),(2212,3,'users','edit'),(2213,3,'users','create'),(2214,3,'users','delete'),(2215,3,'users','changePassword'),(2216,3,'profiles','index'),(2217,3,'profiles','search'),(2218,3,'profiles','edit'),(2219,3,'profiles','create'),(2220,3,'profiles','delete'),(2221,3,'permissions','index'),(2222,3,'content','index'),(2223,3,'content','edit'),(2224,3,'content','new'),(2225,3,'content','editmedia'),(2226,3,'content','save'),(2227,3,'content','create'),(2228,3,'content','media'),(2229,3,'content','addmedia'),(2230,3,'content','createmedia'),(2231,3,'content','delete'),(2232,3,'content','deletemedia'),(2233,3,'content','main'),(2234,3,'content','mediaMultiUpload'),(2235,3,'content','mediaDelUpload'),(2236,3,'content','statistics'),(2237,3,'content','toggleDisplay'),(2238,3,'departments','index'),(2239,3,'departments','edit'),(2240,3,'departments','new'),(2241,3,'departments','save'),(2242,3,'departments','delete'),(2243,3,'departments','create'),(2244,3,'main-departments','index'),(2245,3,'main-departments','edit'),(2246,3,'main-departments','new'),(2247,3,'main-departments','delete'),(2248,3,'main-departments','create'),(2249,3,'main-departments','save'),(2250,3,'ads','index'),(2251,3,'ads','create'),(2252,3,'ads','store'),(2253,3,'ads','edit'),(2254,3,'ads','update'),(2255,3,'ads','delete'),(2256,3,'ads','getDepartmentsAjax'),(2257,3,'ads','getAjaxContentBuModule'),(2258,3,'ads','getAjaxContentByModule'),(2259,3,'users_application_statistics','index'),(2260,3,'mobile_users','index'),(2261,3,'mobile_users','statistics'),(2262,3,'mobile_users','edit'),(2263,3,'mobile_users','save'),(2264,3,'data_forms','index'),(2265,3,'data_forms','search'),(2266,3,'data_forms','create'),(2267,3,'data_forms','edit'),(2268,3,'data_forms','save'),(2269,3,'data_forms','delete'),(2270,3,'data_forms_response','index'),(2271,3,'data_forms_response','edit'),(2272,3,'data_forms_response','create'),(2273,3,'data_forms_response','delete'),(2274,3,'data_forms_response','view'),(2275,3,'data_forms_response','save'),(2276,3,'data_forms_response','new'),(2277,3,'data_forms_response','replayform'),(2278,3,'data_forms_response','search'),(2279,3,'data_forms_lang','index'),(2280,3,'data_forms_lang','search'),(2281,3,'data_forms_lang','new'),(2282,3,'data_forms_lang','edit'),(2283,3,'data_forms_lang','create'),(2284,3,'data_forms_lang','save'),(2285,3,'data_forms_lang','delete'),(2286,3,'cp_users','index'),(2287,3,'cp_users','new'),(2288,3,'cp_users','create'),(2289,3,'cp_users','edit'),(2290,3,'cp_users','delete'),(2291,3,'cp_users','save'),(2292,3,'users_application_module','index'),(2293,3,'users_application_module','search'),(2294,3,'users_application_module','edit'),(2295,3,'users_application_module','create'),(2296,3,'users_application_module','save'),(2297,3,'users_application_module','delete'),(2298,3,'users_application_module','settings'),(2299,3,'users_application_module','settingssave'),(2300,4,'users','index'),(2301,4,'users','search'),(2302,4,'users','edit'),(2303,4,'users','create'),(2304,4,'users','delete'),(2305,4,'users','changePassword'),(2306,4,'profiles','index'),(2307,4,'profiles','search'),(2308,4,'profiles','edit'),(2309,4,'profiles','create'),(2310,4,'profiles','delete'),(2311,4,'permissions','index'),(2312,4,'content','index'),(2313,4,'content','edit'),(2314,4,'content','new'),(2315,4,'content','editmedia'),(2316,4,'content','save'),(2317,4,'content','create'),(2318,4,'content','media'),(2319,4,'content','addmedia'),(2320,4,'content','createmedia'),(2321,4,'content','delete'),(2322,4,'content','deletemedia'),(2323,4,'content','main'),(2324,4,'content','mediaMultiUpload'),(2325,4,'content','mediaDelUpload'),(2326,4,'content','statistics'),(2327,4,'content','toggleDisplay'),(2328,4,'departments','index'),(2329,4,'departments','edit'),(2330,4,'departments','new'),(2331,4,'departments','save'),(2332,4,'departments','delete'),(2333,4,'departments','create'),(2334,4,'main-departments','index'),(2335,4,'main-departments','edit'),(2336,4,'main-departments','new'),(2337,4,'main-departments','delete'),(2338,4,'main-departments','create'),(2339,4,'main-departments','save'),(2340,4,'ads','index'),(2341,4,'ads','create'),(2342,4,'ads','store'),(2343,4,'ads','edit'),(2344,4,'ads','update'),(2345,4,'ads','delete'),(2346,4,'ads','getDepartmentsAjax'),(2347,4,'ads','getAjaxContentBuModule'),(2348,4,'ads','getAjaxContentByModule'),(2349,4,'users_application_statistics','index'),(2350,4,'mobile_users','index'),(2351,4,'mobile_users','statistics'),(2352,4,'mobile_users','edit'),(2353,4,'mobile_users','save'),(2354,4,'data_forms','index'),(2355,4,'data_forms','search'),(2356,4,'data_forms','create'),(2357,4,'data_forms','edit'),(2358,4,'data_forms','save'),(2359,4,'data_forms','delete'),(2360,4,'data_forms_response','index'),(2361,4,'data_forms_response','edit'),(2362,4,'data_forms_response','create'),(2363,4,'data_forms_response','delete'),(2364,4,'data_forms_response','view'),(2365,4,'data_forms_response','save'),(2366,4,'data_forms_response','new'),(2367,4,'data_forms_response','replayform'),(2368,4,'data_forms_response','search'),(2369,4,'data_forms_lang','index'),(2370,4,'data_forms_lang','search'),(2371,4,'data_forms_lang','new'),(2372,4,'data_forms_lang','edit'),(2373,4,'data_forms_lang','create'),(2374,4,'data_forms_lang','save'),(2375,4,'data_forms_lang','delete'),(2376,4,'cp_users','index'),(2377,4,'cp_users','new'),(2378,4,'cp_users','create'),(2379,4,'cp_users','edit'),(2380,4,'cp_users','delete'),(2381,4,'cp_users','save'),(2382,4,'users_application_module','index'),(2383,4,'users_application_module','search'),(2384,4,'users_application_module','edit'),(2385,4,'users_application_module','create'),(2386,4,'users_application_module','save'),(2387,4,'users_application_module','delete'),(2388,4,'users_application_module','settings'),(2389,4,'users_application_module','settingssave'),(5478,1,'users','index'),(5479,1,'users','search'),(5480,1,'users','edit'),(5481,1,'users','create'),(5482,1,'users','delete'),(5483,1,'users','changePassword'),(5484,1,'profiles','index'),(5485,1,'profiles','search'),(5486,1,'profiles','edit'),(5487,1,'profiles','create'),(5488,1,'profiles','delete'),(5489,1,'permissions','index'),(5490,1,'content','index'),(5491,1,'content','edit'),(5492,1,'content','new'),(5493,1,'content','editmedia'),(5494,1,'content','save'),(5495,1,'content','create'),(5496,1,'content','media'),(5497,1,'content','addmedia'),(5498,1,'content','createmedia'),(5499,1,'content','delete'),(5500,1,'content','deletemedia'),(5501,1,'content','main'),(5502,1,'content','mediaMultiUpload'),(5503,1,'content','mediaDelUpload'),(5504,1,'content','statistics'),(5505,1,'content','filterStat'),(5506,1,'content','toggleDisplay'),(5507,1,'content','filterByDept'),(5508,1,'content','ajaxDelete'),(5509,1,'content','advancedSearch'),(5510,1,'content','advancedPost'),(5511,1,'content','ajaxContent'),(5512,1,'content','addbulk'),(5513,1,'content','ajaxActive'),(5514,1,'content','ajaxDeactive'),(5515,1,'content','filterContent'),(5516,1,'content','viewRelatedContent'),(5517,1,'departments','index'),(5518,1,'departments','edit'),(5519,1,'departments','new'),(5520,1,'departments','save'),(5521,1,'departments','delete'),(5522,1,'departments','create'),(5523,1,'departments','ajaxContent'),(5524,1,'departments','ajaxDelete'),(5525,1,'departments','ajaxDeactive'),(5526,1,'departments','ajaxActive'),(5527,1,'departments','search'),(5528,1,'main-departments','index'),(5529,1,'main-departments','edit'),(5530,1,'main-departments','new'),(5531,1,'main-departments','delete'),(5532,1,'main-departments','create'),(5533,1,'main-departments','save'),(5534,1,'ads','index'),(5535,1,'ads','create'),(5536,1,'ads','store'),(5537,1,'ads','edit'),(5538,1,'ads','update'),(5539,1,'ads','delete'),(5540,1,'ads','getDepartmentsAjax'),(5541,1,'ads','getAjaxContentBuModule'),(5542,1,'ads','getAjaxContentByModule'),(5543,1,'users_application_statistics','index'),(5544,1,'mobile_users','index'),(5545,1,'mobile_users','statistics'),(5546,1,'mobile_users','edit'),(5547,1,'mobile_users','save'),(5548,1,'mobile_users','mail'),(5549,1,'mobile_users','sendmail'),(5550,1,'mobile_users','ajaxContent'),(5551,1,'mobile_users','ajaxDelete'),(5552,1,'mobile_users','filterUsers'),(5553,1,'data_forms','index'),(5554,1,'data_forms','search'),(5555,1,'data_forms','create'),(5556,1,'data_forms','edit'),(5557,1,'data_forms','save'),(5558,1,'data_forms','delete'),(5559,1,'data_forms_response','index'),(5560,1,'data_forms_response','edit'),(5561,1,'data_forms_response','create'),(5562,1,'data_forms_response','delete'),(5563,1,'data_forms_response','view'),(5564,1,'data_forms_response','save'),(5565,1,'data_forms_response','new'),(5566,1,'data_forms_response','replayform'),(5567,1,'data_forms_response','search'),(5568,1,'data_forms_lang','index'),(5569,1,'data_forms_lang','search'),(5570,1,'data_forms_lang','new'),(5571,1,'data_forms_lang','edit'),(5572,1,'data_forms_lang','create'),(5573,1,'data_forms_lang','save'),(5574,1,'data_forms_lang','delete'),(5575,1,'cp_users','index'),(5576,1,'cp_users','new'),(5577,1,'cp_users','create'),(5578,1,'cp_users','edit'),(5579,1,'cp_users','delete'),(5580,1,'cp_users','save'),(5581,1,'cp_users','lang'),(5582,1,'cp_users','store'),(5583,1,'cp_users','scheme'),(5584,1,'cp_users','ajaxContent'),(5585,1,'cp_users','ajaxDelete'),(5586,1,'cp_users','delete'),(5587,1,'cp_users','ajaxDeactive'),(5588,1,'cp_users','ajaxActive'),(5589,1,'users_application_module','index'),(5590,1,'users_application_module','search'),(5591,1,'users_application_module','new'),(5592,1,'users_application_module','edit'),(5593,1,'users_application_module','create'),(5594,1,'users_application_module','save'),(5595,1,'users_application_module','delete'),(5596,1,'users_application_module','settings'),(5597,1,'users_application_module','settingssave'),(5598,1,'users_application_module','additionalSettings'),(5599,1,'users_application_module','additionalSave'),(5600,1,'users_application_module','additionalDefault'),(5601,1,'users_application_module','additionalDefaultSave'),(5602,1,'import_data','index'),(5603,1,'import_data','edit'),(5604,1,'import_data','create'),(5605,1,'import_data','save'),(5606,1,'import_data','delete'),(5607,1,'menus','index'),(5608,1,'menus','edit'),(5609,1,'menus','create'),(5610,1,'menus','save'),(5611,1,'menus','delete'),(5612,1,'menus','new');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll_answers`
--

DROP TABLE IF EXISTS `poll_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text,
  `count` int(11) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `question_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll_answers`
--

LOCK TABLES `poll_answers` WRITE;
/*!40000 ALTER TABLE `poll_answers` DISABLE KEYS */;
INSERT INTO `poll_answers` VALUES (1,'Yesman',57,'polls/uploads/f4ba0fcff8c132c72d869d0853c06a97',1),(2,'Noman',24,'polls/uploads/3419ba21cab79c743be744b304047619',1),(3,'Dead',NULL,NULL,14),(4,'Prison',NULL,NULL,14),(5,'Out of Egypt',NULL,NULL,14),(6,'President',NULL,NULL,14),(7,'Assassin',NULL,NULL,14),(8,'Cooking crystal Meth',NULL,NULL,15),(9,'Bike Riding',NULL,NULL,15),(10,'gggggggggg',NULL,NULL,16),(11,'kkkkkkkkkkkk',NULL,NULL,16),(12,'hhh',NULL,'polls/uploads/7ca5ae15f98aed4385750f23057c63d9',17),(13,'sssssss',NULL,'polls/uploads/7495cdcad777877233a039978a557490',17),(14,'gfdsg',NULL,'polls/uploads/2e544433859d8f78e5532643fa1f36f3',18),(15,'gfdsgfdg',NULL,'polls/uploads/5e75fd0d85cc4c99f1315ef1043be726',18),(16,'nbvn',NULL,'polls/uploads/573296aed823106fcb5dde67a567c82f',19),(17,'answer 1',NULL,'polls/uploads/901a2575881419e8669d4f9c2ee0a606',20),(18,'answer 2',NULL,'polls/uploads/d4770ea70d0d8d961dfee403cf58e375',20),(19,'Answer 3',NULL,'polls/uploads/407df147f0a1eb9a39b067563ae08cd3',20),(20,'Answer 4',1,'polls/uploads/bd9bb460f02a1e60131f37f819bec2e9',20),(21,'answer 1',NULL,'polls/uploads/de90b07d693dfdfb02bac76658e12ab5',21),(22,'fdasfdsa',NULL,'polls/uploads/222d06239d26cb34d11c64091ec8be81',1),(23,'Have I ever told you the definition of insanity?',7,'polls/uploads/594e06455266f2703429c7dc092353c1',22),(24,'Democracy is so overrated',1,'polls/uploads/d598abd758cb2fbf1a68a96ba80de461',22),(25,'meh',NULL,'polls/uploads/8d4468b60c72e4a7972adb72dc0fba87',22),(26,'A1',NULL,'polls/uploads/d2af4b3d139add1f94b5034dfb7f5909.jpg',23),(27,'اجابة تفصيلية',NULL,'polls/uploads/48e4d794f8fd4574b2e45242aeafc34e.jpg',24),(28,'اجابة محددة',NULL,'polls/uploads/16998d7040147b0af5403e9c7383653a.jpg',24),(29,'اجاية',NULL,'polls/uploads/c71bce2d7ffb94ebb9d08e3c87393400.jpg',25),(30,'اجابة السؤال الاول اجابة السؤال الاول اجابة السؤال الاول اجابة السؤال الاول اجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاول ',NULL,'polls/uploads/4e787a21d0792178c4a827d1f658a792',26),(31,'اجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاول',NULL,'polls/uploads/5d3ccfa5aeb4b57bd65ea9bcf76a1aaf',26),(32,'اجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاولاجابة السؤال الاول',NULL,'polls/uploads/384acd2530cfb0749793d7286a57b92b',26),(33,'اجابة سؤال تاني  اجابة سؤال تاني  اجابة سؤال تاني  اجابة سؤال تاني  اجابة سؤال تاني  اجابة سؤال تاني  اجابة سؤال تاني  اجابة سؤال تاني  اجابة سؤال تاني  اجابة سؤال تاني  اجابة سؤال تاني  اجابة سؤال تاني  اجابة سؤال تاني  ',NULL,'polls/uploads/504e9efe376da4ef8292d153e73e58e3',27),(34,'A1',NULL,'polls/uploads/e8e2c4803faff13d48ca9ccf81a2bc74.jpg',28),(35,'A2',NULL,NULL,28),(36,'لا يوجد ',NULL,NULL,29),(37,'تاني',NULL,NULL,29),(38,'تالت',NULL,NULL,29),(39,'رابع',NULL,NULL,29),(40,'answer one',4,'polls/uploads/ffc0ea3f5b13f94262ec90175e81e688',30),(41,'answer two',NULL,'polls/uploads/cc8c5a84d4ecb24749bf4e6cf96c8d81',30),(42,'answer one',NULL,'polls/uploads/01ac8c62e92d4ed61b688b88dd6ffdfd',31),(43,'answer two',NULL,'polls/uploads/ed57d79b599df6c0ae35833567a8e782',31),(44,'جيدة',NULL,NULL,32),(45,'سيئة',NULL,NULL,32),(46,'نعم',NULL,NULL,33),(47,'لا',NULL,NULL,33),(48,'تست',NULL,'polls/uploads/08e47aaccc3521c09c059f38c69d70af',34),(49,'نعم تست',NULL,NULL,35);
/*!40000 ALTER TABLE `poll_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll_polls`
--

DROP TABLE IF EXISTS `poll_polls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_polls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `created_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `modified_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `data_cms_depts_rel_id` int(11) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll_polls`
--

LOCK TABLES `poll_polls` WRITE;
/*!40000 ALTER TABLE `poll_polls` DISABLE KEYS */;
INSERT INTO `poll_polls` VALUES (22,'newest poll edited',NULL,'2018-01-20 17:39:23','2018-01-20 17:39:23',41,1,NULL),(23,'استفتاء خدمة ما بعد بيع الخزانات',NULL,'2018-01-20 17:39:27','2018-01-20 17:39:27',41,1,NULL),(24,'اسم تجربه',NULL,'2018-01-20 17:39:32','2018-01-20 17:39:32',41,1,NULL),(27,'تستتتت',NULL,'2018-01-20 17:39:35','2018-01-20 17:39:35',41,1,NULL),(26,'سؤال التست',NULL,'2018-01-20 17:39:38','2018-01-20 17:39:38',41,1,NULL);
/*!40000 ALTER TABLE `poll_polls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll_questions`
--

DROP TABLE IF EXISTS `poll_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text,
  `data_type_id` int(11) DEFAULT NULL,
  `answers_limit` int(11) DEFAULT NULL,
  `total_answers` int(11) DEFAULT NULL,
  `poll_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll_questions`
--

LOCK TABLES `poll_questions` WRITE;
/*!40000 ALTER TABLE `poll_questions` DISABLE KEYS */;
INSERT INTO `poll_questions` VALUES (1,'It\'s only after we\'ve lost everything that we\'re free to do anything ...\r\nbpitt',0,150,140,1),(2,'Array',0,NULL,NULL,2),(3,'Array',0,NULL,NULL,3),(4,'Array',0,NULL,NULL,3),(5,'Array',0,NULL,NULL,4),(6,'Array',0,NULL,NULL,4),(7,'Array',0,NULL,NULL,5),(8,'Array',0,NULL,NULL,5),(9,'Array',0,NULL,NULL,5),(10,'Array',0,NULL,NULL,6),(11,'Array',0,NULL,NULL,6),(12,'asdfasf',0,NULL,NULL,7),(13,'yuuyu',0,NULL,NULL,7),(14,'Where do you see yourself in 5 years?',0,NULL,NULL,9),(15,'What\'s you areas of expertise?',0,NULL,NULL,9),(16,'ffffff',0,NULL,NULL,10),(17,'hhhhh',0,NULL,NULL,11),(18,'fdsaf',0,NULL,NULL,12),(19,'gfdsg',0,NULL,NULL,12),(20,'question 1',0,NULL,NULL,13),(21,'question 2',0,NULL,NULL,13),(22,'Most Memorable quotes',0,NULL,NULL,14),(23,'Q1',0,NULL,NULL,16),(24,'سؤال تجربة',0,NULL,NULL,17),(25,'سؤال',0,NULL,NULL,18),(26,'سؤال أول سؤال أول سؤال أول سؤال أول سؤال أول سؤال أولسؤال أول سؤال أول سؤال أولسؤال أول سؤال أول سؤال أولسؤال أول سؤال أول سؤال أولسؤال أول سؤال أول سؤال أولسؤال أول سؤال أول سؤال أول',0,NULL,NULL,19),(27,'سؤال تاني سؤال تاني سؤال تانيسؤال تانيسؤال تانيسؤال تانيسؤال تانيسؤال تانيسؤال تانيسؤال تانيسؤال تانيسؤال تانيسؤال تانيسؤال تانيسؤال تانيسؤال تانيسؤال تانيسؤال تانيسؤال تاني',0,NULL,NULL,19),(28,'Q1',0,NULL,NULL,20),(29,'السؤال الاول ',0,NULL,NULL,21),(30,'questions number one',0,NULL,NULL,22),(31,'question number 2',0,NULL,NULL,22),(32,'كيف كانت تجربتك',0,NULL,NULL,23),(33,'هل تعيدها مرة اخري',0,NULL,NULL,23),(34,'هل التست',0,NULL,NULL,26),(35,'هل التستينج تست',0,NULL,NULL,27);
/*!40000 ALTER TABLE `poll_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll_questions_users`
--

DROP TABLE IF EXISTS `poll_questions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_questions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll_questions_users`
--

LOCK TABLES `poll_questions_users` WRITE;
/*!40000 ALTER TABLE `poll_questions_users` DISABLE KEYS */;
INSERT INTO `poll_questions_users` VALUES (1,24,366),(2,30,1);
/*!40000 ALTER TABLE `poll_questions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll_settings`
--

DROP TABLE IF EXISTS `poll_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `use_fb` int(11) DEFAULT '0',
  `banner_image` varchar(255) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  `fb_url` varchar(255) DEFAULT NULL,
  `fb_token` varchar(255) DEFAULT NULL,
  `fb_api_key` varchar(255) DEFAULT NULL,
  `fb_db_url` varchar(255) DEFAULT NULL,
  `fb_storage` varchar(255) DEFAULT NULL,
  `fb_project_id` varchar(255) DEFAULT NULL,
  `fb_bucket_name` varchar(255) DEFAULT NULL,
  `fb_service_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll_settings`
--

LOCK TABLES `poll_settings` WRITE;
/*!40000 ALTER TABLE `poll_settings` DISABLE KEYS */;
INSERT INTO `poll_settings` VALUES (1,0,'msg/img/32192f4bdb137cfaca71923238b251d49552-1_img.jpg',573,'https://tabyb-com.firebaseio.com/','bE5pTGY6hd0x5qJNJsSGBXYM3nPhgpQVl8rv8KoP','','','','tabyb-com','tabyb-com.appspot.com','tabyb-com-firebase-adminsdk-elnot-d2e78b2406.json'),(2,0,NULL,576,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,0,NULL,601,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,0,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `poll_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procedure_departments`
--

DROP TABLE IF EXISTS `procedure_departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procedure_departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procedure_departments`
--

LOCK TABLES `procedure_departments` WRITE;
/*!40000 ALTER TABLE `procedure_departments` DISABLE KEYS */;
INSERT INTO `procedure_departments` VALUES (1,'Web Development'),(2,'UX'),(3,'Game Development'),(4,'UI');
/*!40000 ALTER TABLE `procedure_departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procedure_steps`
--

DROP TABLE IF EXISTS `procedure_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procedure_steps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order` int(11) NOT NULL,
  `description` text NOT NULL,
  `procedure_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procedure_steps`
--

LOCK TABLES `procedure_steps` WRITE;
/*!40000 ALTER TABLE `procedure_steps` DISABLE KEYS */;
/*!40000 ALTER TABLE `procedure_steps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procedures`
--

DROP TABLE IF EXISTS `procedures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procedures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `department_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procedures`
--

LOCK TABLES `procedures` WRITE;
/*!40000 ALTER TABLE `procedures` DISABLE KEYS */;
INSERT INTO `procedures` VALUES (1,'فحص الانترنت','',2);
/*!40000 ALTER TABLE `procedures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_extra_fields`
--

DROP TABLE IF EXISTS `product_extra_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_extra_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL COMMENT 'relation with users_application_module',
  `item_id` int(11) NOT NULL COMMENT 'relation with data_cms',
  `price` decimal(10,2) NOT NULL,
  `old_price` decimal(10,2) DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `free_shipping` tinyint(1) DEFAULT NULL,
  `shipping_fee` decimal(10,2) DEFAULT NULL,
  `minimum_in_cart` int(11) NOT NULL DEFAULT '1',
  `maximum_in_cart` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_extra_fields`
--

LOCK TABLES `product_extra_fields` WRITE;
/*!40000 ALTER TABLE `product_extra_fields` DISABLE KEYS */;
INSERT INTO `product_extra_fields` VALUES (1,8,3,210.00,502.50,151.00,0,21.00,2,100),(2,8,200,200.00,500.00,150.00,0,20.00,1,5),(4,8,28,200.00,501.00,150.00,0,10.00,1,5),(5,8,37,100000.00,15000.00,15000.00,1,15000.00,10,20),(6,8,38,100.00,100.00,100.00,127,100.00,100,100),(7,8,39,10.00,10.00,10.00,10,10.00,10,10),(8,8,40,100.00,100.00,100.00,100,100.00,100,100),(9,8,41,100.00,100.00,100.00,100,100.00,100,100),(10,8,42,1000.00,1000.00,1000.00,127,1000.00,1000,1000),(11,8,46,700.00,600.00,750.00,0,0.00,5,5),(12,8,53,4456.00,5455.00,4545.00,1,45.00,2,5),(13,8,55,550.00,210.00,110.00,0,510.00,10,77),(14,8,56,100.00,100.00,1000.00,0,150.00,10,20),(15,8,57,5000.00,4500.00,3200.00,1,1000.00,1,5),(16,8,58,2000.00,1500.00,1200.00,1,200.00,1,3),(17,8,59,2500.00,2000.00,1000.00,1,120.00,1,5),(18,8,60,500.00,500.00,500.00,1,500.00,1,5),(19,8,61,1200.00,1000.00,900.00,0,0.00,1,3),(20,8,62,1200.00,1000.00,900.00,0,20.00,1,3);
/*!40000 ALTER TABLE `product_extra_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_reviews`
--

DROP TABLE IF EXISTS `product_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `product_id` int(11) NOT NULL,
  `rating` int(1) NOT NULL DEFAULT '1',
  `review` text CHARACTER SET utf8mb4 NOT NULL,
  `status_id` int(11) DEFAULT NULL,
  `created_at` varchar(30) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_reviews`
--

LOCK TABLES `product_reviews` WRITE;
/*!40000 ALTER TABLE `product_reviews` DISABLE KEYS */;
INSERT INTO `product_reviews` VALUES (1,1,28,5,'خزان جيد',2,'1509529908'),(2,1,28,5,'this product is very poor',3,'1509529944'),(3,13,28,4,'asas',NULL,'1509980074'),(4,13,28,2,'tttt',NULL,'1509980162'),(5,13,28,3,'test',NULL,'1509980369'),(6,13,28,3,'test',NULL,'1509980423'),(7,13,28,3,'test3',NULL,'1509980596'),(8,13,28,3,'ttees',2,'1509980704'),(9,13,28,5,'test review',NULL,'1509980903'),(10,13,28,4,'test product review',NULL,'1509980961'),(11,13,28,2,'ttt',NULL,'1509981425'),(12,13,28,4,'asd',NULL,'1509981446'),(13,13,28,4,'my final test',NULL,'1509981836'),(14,13,28,1,'my final test 2',NULL,'1509981852'),(15,13,42,4,'my comment',NULL,'1510427657'),(16,13,29,3,'test comment',NULL,'1510751515'),(17,0,42,2,'guest',NULL,'1510822603'),(18,0,42,2,'guest',NULL,'1510823187'),(19,13,42,3,'test logged in',NULL,'1510823385'),(20,13,42,2,'kkk',NULL,'1510823786'),(21,0,42,2,'sss',NULL,'1510824137'),(22,0,42,1,'bad one',NULL,'1510824340'),(23,13,42,5,'good one',NULL,'1510824544'),(24,13,41,4,'my good test',NULL,'1510825340'),(25,0,41,1,'my bad test',NULL,'1510825385'),(27,39,3,4,'track level',NULL,'1517260202');
/*!40000 ALTER TABLE `product_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `active` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'Administrators','Y'),(2,'Users','Y'),(3,'Read-Only','Y'),(4,'Mobile','Y'),(5,'Individuals','');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_client`
--

DROP TABLE IF EXISTS `project_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_client`
--

LOCK TABLES `project_client` WRITE;
/*!40000 ALTER TABLE `project_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_tags`
--

DROP TABLE IF EXISTS `project_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_tags`
--

LOCK TABLES `project_tags` WRITE;
/*!40000 ALTER TABLE `project_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_users`
--

DROP TABLE IF EXISTS `project_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_users`
--

LOCK TABLES `project_users` WRITE;
/*!40000 ALTER TABLE `project_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `note` text,
  `tag` int(11) DEFAULT NULL,
  `source` varchar(1024) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `client_type` varchar(255) DEFAULT NULL,
  `image` varchar(1024) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_feedback`
--

DROP TABLE IF EXISTS `push_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_feedback` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Tokens` text NOT NULL,
  `Feedback` text NOT NULL,
  `Device_Type` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_feedback`
--

LOCK TABLES `push_feedback` WRITE;
/*!40000 ALTER TABLE `push_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_notification`
--

DROP TABLE IF EXISTS `push_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notification` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Admin_ID` int(11) NOT NULL,
  `Message` varchar(256) NOT NULL,
  `Age` varchar(10) DEFAULT NULL,
  `Nearby` tinyint(1) DEFAULT NULL,
  `Raduis` smallint(6) DEFAULT NULL,
  `Favourite` tinyint(1) NOT NULL DEFAULT '0',
  `Like` tinyint(1) NOT NULL DEFAULT '0',
  `Male` tinyint(1) NOT NULL DEFAULT '0',
  `Female` tinyint(1) NOT NULL DEFAULT '0',
  `Stats` mediumtext,
  `Send_Time` varchar(255) DEFAULT NULL,
  `Finished_Time` varchar(15) DEFAULT NULL,
  `Application_ID` int(11) DEFAULT NULL,
  `Module_ID` int(11) DEFAULT NULL,
  `notification_type` varchar(255) DEFAULT NULL,
  `queued` tinyint(4) NOT NULL DEFAULT '0',
  `send_to_guests` tinyint(4) NOT NULL DEFAULT '0',
  `kv` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notification`
--

LOCK TABLES `push_notification` WRITE;
/*!40000 ALTER TABLE `push_notification` DISABLE KEYS */;
INSERT INTO `push_notification` VALUES (1,1,'Hello world','23',NULL,NULL,0,0,0,0,NULL,'',NULL,1,3,'2',1,0,'{\"key1\":\"value1\"}');
/*!40000 ALTER TABLE `push_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_notification_archive`
--

DROP TABLE IF EXISTS `push_notification_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notification_archive` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `User_ID` int(11) NOT NULL,
  `Token_ID` int(11) NOT NULL,
  `Msg_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notification_archive`
--

LOCK TABLES `push_notification_archive` WRITE;
/*!40000 ALTER TABLE `push_notification_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_notification_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_notification_follow_permissions`
--

DROP TABLE IF EXISTS `push_notification_follow_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notification_follow_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `setting_id` int(11) NOT NULL,
  `follow_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notification_follow_permissions`
--

LOCK TABLES `push_notification_follow_permissions` WRITE;
/*!40000 ALTER TABLE `push_notification_follow_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_notification_follow_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_notification_message_filters`
--

DROP TABLE IF EXISTS `push_notification_message_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notification_message_filters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` int(11) NOT NULL,
  `follow_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notification_message_filters`
--

LOCK TABLES `push_notification_message_filters` WRITE;
/*!40000 ALTER TABLE `push_notification_message_filters` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_notification_message_filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_notification_queue`
--

DROP TABLE IF EXISTS `push_notification_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notification_queue` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Msg_ID` int(11) NOT NULL,
  `Token` varchar(256) NOT NULL,
  `Type` tinyint(1) NOT NULL COMMENT '1=> iOS and 2 => Android',
  `User_ID` int(11) DEFAULT NULL,
  `Token_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notification_queue`
--

LOCK TABLES `push_notification_queue` WRITE;
/*!40000 ALTER TABLE `push_notification_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_notification_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_notification_settings`
--

DROP TABLE IF EXISTS `push_notification_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notification_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `android_app_key` varchar(255) DEFAULT NULL,
  `iphone_bundle_id` varchar(255) DEFAULT NULL,
  `enable_sandbox` tinyint(4) DEFAULT '0',
  `sandbox_passphrase` varchar(255) DEFAULT NULL,
  `production_passphrase` varchar(255) DEFAULT NULL,
  `sandbox_certificate` varchar(255) DEFAULT NULL,
  `enable_production` tinyint(4) DEFAULT '0',
  `production_certificate` varchar(255) DEFAULT NULL,
  `enable_schedueling` tinyint(4) NOT NULL DEFAULT '0',
  `use_default_kv` tinyint(4) NOT NULL DEFAULT '0',
  `smtp_server` varchar(255) DEFAULT NULL,
  `smtp_port` varchar(255) DEFAULT NULL,
  `smtp_username` varchar(255) DEFAULT NULL,
  `smtp_password` varchar(255) DEFAULT NULL,
  `mail_from_name` varchar(255) DEFAULT NULL,
  `mail_from_email` varchar(255) DEFAULT NULL,
  `enable_statistics` tinyint(4) NOT NULL DEFAULT '0',
  `filter_mf` tinyint(4) NOT NULL DEFAULT '0',
  `filter_like` tinyint(4) NOT NULL DEFAULT '0',
  `filter_favourite` tinyint(4) NOT NULL DEFAULT '0',
  `filter_guests` tinyint(4) NOT NULL DEFAULT '0',
  `application_id` int(11) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  `banner_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notification_settings`
--

LOCK TABLES `push_notification_settings` WRITE;
/*!40000 ALTER TABLE `push_notification_settings` DISABLE KEYS */;
INSERT INTO `push_notification_settings` VALUES (1,NULL,NULL,0,NULL,NULL,NULL,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,1,NULL,NULL);
/*!40000 ALTER TABLE `push_notification_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_notification_token`
--

DROP TABLE IF EXISTS `push_notification_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notification_token` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `User_ID` int(11) NOT NULL,
  `Token` varchar(256) NOT NULL,
  `Token_MD5` varchar(32) NOT NULL,
  `Type` tinyint(1) NOT NULL COMMENT '1=> iOS and 2 => Android',
  `Latitude` varchar(100) DEFAULT NULL,
  `Longitude` varchar(200) DEFAULT NULL,
  `Online` varchar(15) DEFAULT NULL,
  `Last_Update_Locations` varchar(15) DEFAULT NULL,
  `Last_Time_Receive_Msg` varchar(15) DEFAULT NULL,
  `Msg_All_Count` tinyint(4) DEFAULT NULL,
  `Active` tinyint(1) DEFAULT NULL,
  `Application_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notification_token`
--

LOCK TABLES `push_notification_token` WRITE;
/*!40000 ALTER TABLE `push_notification_token` DISABLE KEYS */;
INSERT INTO `push_notification_token` VALUES (1,0,'gfdsgdfhs','28bdcc5df553e2b4036906b870322b2f',2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `push_notification_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_notification_token_delivery`
--

DROP TABLE IF EXISTS `push_notification_token_delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notification_token_delivery` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `User_ID` int(11) NOT NULL,
  `Token_ID` int(11) NOT NULL,
  `Admin_ID` int(11) NOT NULL,
  `Msg_Count` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notification_token_delivery`
--

LOCK TABLES `push_notification_token_delivery` WRITE;
/*!40000 ALTER TABLE `push_notification_token_delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_notification_token_delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remember_tokens`
--

DROP TABLE IF EXISTS `remember_tokens`;
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
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remember_tokens`
--

LOCK TABLES `remember_tokens` WRITE;
/*!40000 ALTER TABLE `remember_tokens` DISABLE KEYS */;
INSERT INTO `remember_tokens` VALUES (1,8,'a15dea210e4256dfbe68f6b021f7e075','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36',1479115822),(2,8,'a15dea210e4256dfbe68f6b021f7e075','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36',1479676410),(3,8,'a15dea210e4256dfbe68f6b021f7e075','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36',1479809064),(4,8,'a15dea210e4256dfbe68f6b021f7e075','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36',1479901382),(5,8,'a15dea210e4256dfbe68f6b021f7e075','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36',1479904831),(6,8,'29d38a3b09329a763f93736f74cb3aaf','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36',1480584108),(7,8,'29d38a3b09329a763f93736f74cb3aaf','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36',1480866722),(8,8,'25f3ca8be4559a8c75a097c5a4510efc','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36',1481044803),(9,8,'29d38a3b09329a763f93736f74cb3aaf','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36',1481198841),(10,94,'1c72bc3808f3a7fc5698fcb9863ac337','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36',1481636458),(11,94,'2ca395ae85dc36dc10e9e85282900460','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1482063049),(12,94,'2ca395ae85dc36dc10e9e85282900460','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1482511019),(13,94,'2ca395ae85dc36dc10e9e85282900460','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1482521684),(14,94,'2ca395ae85dc36dc10e9e85282900460','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1482521692),(15,94,'2ca395ae85dc36dc10e9e85282900460','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1482521931),(16,94,'2ca395ae85dc36dc10e9e85282900460','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1482619016),(17,94,'2ca395ae85dc36dc10e9e85282900460','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1483257588),(18,94,'757f7d697eb866cfe52d36b9ddd18c41','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1485261481),(19,99,'9e9b42169e2ef24b81ef7a54a161c491','Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.76 Safari/537.36',1485763345),(20,101,'fb4e0bc1e694c3c7d25b1c3e70938b1b','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.21 Safari/537.36',1486648249),(21,94,'8abadb93fadde21fa15774ac80ff85af','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',1486989722),(22,94,'8abadb93fadde21fa15774ac80ff85af','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',1486990517),(23,94,'8abadb93fadde21fa15774ac80ff85af','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',1487003416),(24,94,'8abadb93fadde21fa15774ac80ff85af','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',1487017752),(25,94,'8abadb93fadde21fa15774ac80ff85af','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',1487022322),(26,94,'8abadb93fadde21fa15774ac80ff85af','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',1487069855),(27,94,'8abadb93fadde21fa15774ac80ff85af','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',1487087369),(28,94,'8abadb93fadde21fa15774ac80ff85af','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',1487106706),(29,103,'671727888bb479933fe29d3aa207eed8','Mozilla/5.0 (Windows NT 10.0; WOW64; rv:51.0) Gecko/20100101 Firefox/51.0',1488354217),(30,151,'cb4d7908321659a9d5e9d69c9cc77319','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',1490179222),(31,103,'abc6a71e565b17571809c5c48acac348','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1490559043),(32,155,'d0950d9b1b43f7d0c6f3de127c9e78d8','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',1490696638),(33,156,'111cf1eef6a76bba67e6dd0000129683','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1491212192),(34,156,'245bb3016eca2f1c75609fdc1b13ddfe','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',1491217924),(35,156,'245bb3016eca2f1c75609fdc1b13ddfe','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',1491220131),(36,156,'245bb3016eca2f1c75609fdc1b13ddfe','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',1491220367),(37,156,'64191fed57831127736af22d856ce37a','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',1491817552),(38,156,'64191fed57831127736af22d856ce37a','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',1491828400),(39,156,'64191fed57831127736af22d856ce37a','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',1491897638),(40,156,'a82c1b8f0444045ab1dec8e3e802024e','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',1492068360),(41,155,'f3aac9c6e2df6aac9dd2b02be1c70d1c','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',1492346689),(42,155,'f3aac9c6e2df6aac9dd2b02be1c70d1c','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',1492354876),(43,155,'f57ab38f19fe84fbd737a88a7dc592a0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/601.7.8 (KHTML, like Gecko) Version/9.1.3 Safari/601.7.8',1492414810),(44,156,'a82c1b8f0444045ab1dec8e3e802024e','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',1492693279),(45,156,'a82c1b8f0444045ab1dec8e3e802024e','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',1492699450),(46,156,'a82c1b8f0444045ab1dec8e3e802024e','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',1492701114),(47,156,'a82c1b8f0444045ab1dec8e3e802024e','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',1492701867),(48,156,'a82c1b8f0444045ab1dec8e3e802024e','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',1492702873),(49,155,'f57ab38f19fe84fbd737a88a7dc592a0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/601.7.8 (KHTML, like Gecko) Version/9.1.3 Safari/601.7.8',1492932463),(50,156,'a82c1b8f0444045ab1dec8e3e802024e','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',1493042176),(51,115,'6b6d5cfe31fe0d812aa51527c8650e76','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36',1493825278),(52,115,'37f44ddd1111d745e0f7e7c8a5cc9cb4','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Safari/537.36',1493889951),(53,156,'beb1cff66f7c1faf444fcb20acc2463f','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Safari/537.36',1494251498),(54,155,'f57ab38f19fe84fbd737a88a7dc592a0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/601.7.8 (KHTML, like Gecko) Version/9.1.3 Safari/601.7.8',1494315196),(55,116,'0e758760fbf2bca13284e75426ea148c','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Safari/537.36',1494510784),(56,115,'10c753bba064a89db5a37fc372e22b32','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1494768020),(57,155,'92d7f5720122619718914a2c9e6b06df','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.1 Safari/603.1.30',1495001422),(58,115,'a07b4654148489af8eef060e51954cf0','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1497953515),(59,232,'4aa012ad528b70f73a258b20ae2a2157','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.104 Safari/537.36',1498750375),(60,160,'877946e0747e594dd9f3b31aaec59d83','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36',1498989876),(61,160,'877946e0747e594dd9f3b31aaec59d83','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36',1499597920),(62,156,'6dbc2e7ada0f0f071833c33b1bf52886','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36',1499766989),(63,232,'16d85bb5a9b4efe2cf1b887e0dbf5a12','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36',1500205218),(64,294,'9d7e605ffff712b5bbc339a1213ec025','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.124 Safari/537.36',1500479339),(65,294,'9d7e605ffff712b5bbc339a1213ec025','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.124 Safari/537.36',1500479394),(66,292,'930704251b3d82f53809956ef5f50232','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.124 Safari/537.36',1500557248),(67,292,'930704251b3d82f53809956ef5f50232','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.124 Safari/537.36',1500558977),(68,292,'3f09ceae0ec75be83bc0a597c126d984','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36',1500735096),(69,292,'3f09ceae0ec75be83bc0a597c126d984','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36',1500743667),(70,115,'ee74f28c57cfd85f18cbb2830a73f44f','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR ',1500981496),(71,115,'ee74f28c57cfd85f18cbb2830a73f44f','Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR ',1500981804),(72,115,'e643788357f5146396e3c3b6dfa1a037','Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko',1500983354),(73,271,'1eb8f03e3efdd684550476f3058b12b5','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36',1501068193),(74,296,'a76ffd30a47854c4d9647d2203b79e25','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36',1501154628),(75,296,'a76ffd30a47854c4d9647d2203b79e25','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36',1501170355),(76,296,'807a7f7ba9d0bd6e0dec161639f7a182','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36 Edge',1501181225),(77,296,'807a7f7ba9d0bd6e0dec161639f7a182','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36 Edge',1501188982),(78,232,'16d85bb5a9b4efe2cf1b887e0dbf5a12','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36',1501597869),(79,232,'16d85bb5a9b4efe2cf1b887e0dbf5a12','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36',1501598779),(80,296,'807a7f7ba9d0bd6e0dec161639f7a182','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36 Edge',1501760780),(81,296,'807a7f7ba9d0bd6e0dec161639f7a182','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36 Edge',1501762999),(82,296,'0ff75af855c1475b0230d6fe3c8403d0','Mozilla/5.0 (Windows NT 6.1; rv:54.0) Gecko/20100101 Firefox/54.0',1501770090),(83,232,'695a506b903a671b4bb58a1b2b7f04b6','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1503992934),(84,296,'9dc7397addbb4628c8dfd711ac616874','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1504605144),(85,296,'9dc7397addbb4628c8dfd711ac616874','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1504605184),(86,296,'9dc7397addbb4628c8dfd711ac616874','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1504611859),(87,296,'9dc7397addbb4628c8dfd711ac616874','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1504614970),(88,296,'9dc7397addbb4628c8dfd711ac616874','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1504615422),(89,296,'9dc7397addbb4628c8dfd711ac616874','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1504620327),(90,355,'ac942f574a765324a09479a528c9619d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1504780365),(91,355,'ac942f574a765324a09479a528c9619d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1504794134),(92,355,'1e5bddc1317966ad68426df64822db50','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:55.0) Gecko/20100101 Firefox/55.0',1504889527),(93,355,'1e5bddc1317966ad68426df64822db50','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:55.0) Gecko/20100101 Firefox/55.0',1504889527),(94,355,'2e0a618061b79efca0b3a558366c4fa8','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36',1504889667),(95,355,'2e0a618061b79efca0b3a558366c4fa8','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36',1504889667),(96,385,'6ae2bfa75bac4974e6a4e9ff5f416d1d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505202480),(97,385,'6ae2bfa75bac4974e6a4e9ff5f416d1d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505202480),(98,385,'6ae2bfa75bac4974e6a4e9ff5f416d1d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505202647),(99,385,'6ae2bfa75bac4974e6a4e9ff5f416d1d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505202647),(100,385,'6ae2bfa75bac4974e6a4e9ff5f416d1d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505202747),(101,385,'6ae2bfa75bac4974e6a4e9ff5f416d1d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505202747),(102,355,'2e0a618061b79efca0b3a558366c4fa8','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36',1505202778),(103,355,'2e0a618061b79efca0b3a558366c4fa8','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36',1505202778),(104,355,'ac942f574a765324a09479a528c9619d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505203157),(105,355,'ac942f574a765324a09479a528c9619d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505203157),(106,355,'ac942f574a765324a09479a528c9619d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505203171),(107,355,'ac942f574a765324a09479a528c9619d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505203171),(108,355,'ac942f574a765324a09479a528c9619d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505208179),(109,355,'ac942f574a765324a09479a528c9619d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505208179),(110,386,'e7a0fa3bbcf9c8360c36d3ce2ba8c71b','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505209777),(111,386,'e7a0fa3bbcf9c8360c36d3ce2ba8c71b','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505209777),(112,386,'e7a0fa3bbcf9c8360c36d3ce2ba8c71b','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505209817),(113,386,'e7a0fa3bbcf9c8360c36d3ce2ba8c71b','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',1505209817),(114,396,'5e1f1446e7e252da5255cf0264c3aba5','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',1506420035),(115,396,'5e1f1446e7e252da5255cf0264c3aba5','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',1506527760),(116,296,'807a7f7ba9d0bd6e0dec161639f7a182','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36 Edge',1506950395),(117,296,'096ed9a0b2e1027e25f0eafbc0075d24','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',1507462430),(118,296,'096ed9a0b2e1027e25f0eafbc0075d24','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',1507536244),(119,296,'096ed9a0b2e1027e25f0eafbc0075d24','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',1507640971),(120,296,'096ed9a0b2e1027e25f0eafbc0075d24','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',1507709494);
/*!40000 ALTER TABLE `remember_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reset_passwords`
--

DROP TABLE IF EXISTS `reset_passwords`;
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
/*!40000 ALTER TABLE `reset_passwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `response_comments`
--

DROP TABLE IF EXISTS `response_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `response_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `response_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `type` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `response_comments`
--

LOCK TABLES `response_comments` WRITE;
/*!40000 ALTER TABLE `response_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `response_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews_statuses`
--

DROP TABLE IF EXISTS `reviews_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `name_ar` varchar(40) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews_statuses`
--

LOCK TABLES `reviews_statuses` WRITE;
/*!40000 ALTER TABLE `reviews_statuses` DISABLE KEYS */;
INSERT INTO `reviews_statuses` VALUES (1,'review','تقييم الرأي'),(2,'accepted','موافقة'),(3,'rejected','رفض');
/*!40000 ALTER TABLE `reviews_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_visits`
--

DROP TABLE IF EXISTS `sales_visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_visits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` varchar(20) NOT NULL,
  `mission_type_id` int(11) DEFAULT NULL,
  `representitve_comment` text,
  `client_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` varchar(20) NOT NULL,
  `updated_at` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_visits`
--

LOCK TABLES `sales_visits` WRITE;
/*!40000 ALTER TABLE `sales_visits` DISABLE KEYS */;
INSERT INTO `sales_visits` VALUES (1,'1517184000',1,'Testing new visit',34,1,'1517312636','1517312636');
/*!40000 ALTER TABLE `sales_visits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_types`
--

DROP TABLE IF EXISTS `schedule_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_types`
--

LOCK TABLES `schedule_types` WRITE;
/*!40000 ALTER TABLE `schedule_types` DISABLE KEYS */;
INSERT INTO `schedule_types` VALUES (1,'يومي'),(2,'اسبوعي'),(3,'شهري'),(4,'سنوي'),(5,'مرة واحدة');
/*!40000 ALTER TABLE `schedule_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screen`
--

DROP TABLE IF EXISTS `screen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `des` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screen`
--

LOCK TABLES `screen` WRITE;
/*!40000 ALTER TABLE `screen` DISABLE KEYS */;
/*!40000 ALTER TABLE `screen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screen_media`
--

DROP TABLE IF EXISTS `screen_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screen_media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `media` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `screen_id` int(11) NOT NULL,
  `type` enum('img','video') COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screen_media`
--

LOCK TABLES `screen_media` WRITE;
/*!40000 ALTER TABLE `screen_media` DISABLE KEYS */;
/*!40000 ALTER TABLE `screen_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searched_keywords`
--

DROP TABLE IF EXISTS `searched_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searched_keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searched_keywords`
--

LOCK TABLES `searched_keywords` WRITE;
/*!40000 ALTER TABLE `searched_keywords` DISABLE KEYS */;
INSERT INTO `searched_keywords` VALUES (1,'tank',4),(2,'simple',4),(3,'test',7);
/*!40000 ALTER TABLE `searched_keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seo_settings`
--

DROP TABLE IF EXISTS `seo_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seo_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_cms_id` int(11) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `meta` varchar(255) DEFAULT NULL,
  `meta_description` text,
  `title_description` text,
  `page_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seo_settings`
--

LOCK TABLES `seo_settings` WRITE;
/*!40000 ALTER TABLE `seo_settings` DISABLE KEYS */;
INSERT INTO `seo_settings` VALUES (1,NULL,42,'test,1,2,3','test metaaaaaaaaaaaa','tets titlllllllllllllllle','paaaaaaaaaaaaaaaage'),(2,NULL,1,'meta','mets desc','meta title','page'),(3,NULL,43,'manufacturars,team,track','manufacturars,team,track','manufacturars,team,track','manufacturars,team,track'),(4,3,NULL,'test_meta,another_meta','test','test title desc','the page'),(5,NULL,7,'','','','');
/*!40000 ALTER TABLE `seo_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setup_colors`
--

DROP TABLE IF EXISTS `setup_colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setup_colors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `rgb_decimal_code` varchar(20) DEFAULT NULL COMMENT 'sample : rgb(0,0,0)',
  `hex_code` varchar(20) DEFAULT NULL COMMENT 'sample : #000000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setup_colors`
--

LOCK TABLES `setup_colors` WRITE;
/*!40000 ALTER TABLE `setup_colors` DISABLE KEYS */;
INSERT INTO `setup_colors` VALUES (1,'Red','rgb(255,0,0)','#FF0000	'),(2,'Purple','rgb(128,0,128)','#800080'),(3,'Green','rgb(99, 205, 0)','#63cd00'),(4,'Light Blue','rgb(99, 205, 168)','#63cda8'),(5,'Blue','rgb(3, 2, 244)','#0302f4'),(6,'Black','rgb(1, 4, 2)','#010402'),(7,'Yellow','rgb(254, 251, 2)','#fefb02');
/*!40000 ALTER TABLE `setup_colors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setup_entities`
--

DROP TABLE IF EXISTS `setup_entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setup_entities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `model_name` varchar(255) DEFAULT NULL,
  `displayField` varchar(255) DEFAULT NULL,
  `load_as_keyvalue` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setup_entities`
--

LOCK TABLES `setup_entities` WRITE;
/*!40000 ALTER TABLE `setup_entities` DISABLE KEYS */;
INSERT INTO `setup_entities` VALUES (1,'Data CMS','data_cms','DataCms','title',0),(2,'Data Form','data_forms','Vokuro\\FormBuilder\\Models\\DataForms',NULL,0),(3,'Data Form Groups','data_form_groups','DataFormGroups',NULL,0),(4,'Data Form Field','data_form_fields','DataFormField',NULL,0),(6,'User','users','Models\\UsersMobile',NULL,0),(7,'User Data','user_data','Vokuro\\UsersModule\\Models\\UserData',NULL,0),(8,'City','geo_cities','\\Vokuro\\Geo\\Models\\GeoCities',NULL,0),(9,'Country','geo_countries','\\Vokuro\\Geo\\Models\\GeoCountries',NULL,0),(10,'User Geo','user_geos','UserGeo',NULL,0),(11,'Form Fields','data_form_fields','Vokuro\\FormBuilder\\Models\\FormFields',NULL,0),(12,'Form Fields Options','data_form_field_options','Vokuro\\FormBuilder\\Models\\FormFieldOptions',NULL,0),(13,'Genders','setup_genders','Vokuro\\Models\\SetupGenders','Gender',0),(14,'Forms','data_forms','Vokuro\\FormBuilder\\Models\\DataForms','Forms',0),(15,'Menus','menus','Vokuro\\Models\\Menus','Menus',0),(21,'Company Branches','company_branches','Vokuro\\Models\\CompanyBranches',NULL,1),(22,'Colors','setup_colors','Vokuro\\Models\\SetupColors',NULL,1);
/*!40000 ALTER TABLE `setup_entities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setup_entity_languages`
--

DROP TABLE IF EXISTS `setup_entity_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setup_entity_languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` int(11) DEFAULT NULL,
  `entity_field_name` varchar(255) DEFAULT NULL,
  `translation` varchar(255) DEFAULT NULL,
  `entity_field_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  `lang_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setup_entity_languages`
--

LOCK TABLES `setup_entity_languages` WRITE;
/*!40000 ALTER TABLE `setup_entity_languages` DISABLE KEYS */;
/*!40000 ALTER TABLE `setup_entity_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setup_field_types`
--

DROP TABLE IF EXISTS `setup_field_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setup_field_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `is_filter` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setup_field_types`
--

LOCK TABLES `setup_field_types` WRITE;
/*!40000 ALTER TABLE `setup_field_types` DISABLE KEYS */;
INSERT INTO `setup_field_types` VALUES (1,'autocomplete',1),(2,'button',NULL),(3,'checkbox-group',1),(4,'header',NULL),(5,'number',NULL),(6,'paragraph',NULL),(7,'date',NULL),(8,'file',NULL),(9,'textarea',NULL),(10,'text',NULL),(11,'hidden',NULL),(12,'radio-group',1),(13,'select',1),(14,'starRating',NULL),(15,'multipleGrid',NULL),(16,'LinearScale',NULL);
/*!40000 ALTER TABLE `setup_field_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setup_field_validation`
--

DROP TABLE IF EXISTS `setup_field_validation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setup_field_validation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_setting_id` int(11) NOT NULL COMMENT 'id of setup_field_validaion_settings',
  `validation_rule_id` int(11) NOT NULL COMMENT 'id of setup_field_validation_rules',
  `confirm_password_field_name` varchar(30) DEFAULT NULL COMMENT 'must have value if the validation rule is confirm password',
  `min_value` int(11) DEFAULT NULL,
  `max_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='relation between field and validation rules';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setup_field_validation`
--

LOCK TABLES `setup_field_validation` WRITE;
/*!40000 ALTER TABLE `setup_field_validation` DISABLE KEYS */;
INSERT INTO `setup_field_validation` VALUES (1,1,1,NULL,NULL,NULL),(2,1,5,NULL,5,15),(3,2,4,'confirm_password',NULL,NULL),(4,2,1,NULL,NULL,NULL),(5,5,1,NULL,NULL,NULL),(6,6,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `setup_field_validation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setup_field_validation_actions`
--

DROP TABLE IF EXISTS `setup_field_validation_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setup_field_validation_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(35) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setup_field_validation_actions`
--

LOCK TABLES `setup_field_validation_actions` WRITE;
/*!40000 ALTER TABLE `setup_field_validation_actions` DISABLE KEYS */;
INSERT INTO `setup_field_validation_actions` VALUES (1,'register'),(2,'edit'),(3,'view'),(4,'insert');
/*!40000 ALTER TABLE `setup_field_validation_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setup_field_validation_rules`
--

DROP TABLE IF EXISTS `setup_field_validation_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setup_field_validation_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Table that defines the validation rules for actions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setup_field_validation_rules`
--

LOCK TABLES `setup_field_validation_rules` WRITE;
/*!40000 ALTER TABLE `setup_field_validation_rules` DISABLE KEYS */;
INSERT INTO `setup_field_validation_rules` VALUES (1,'required'),(2,'email'),(3,'alnum'),(4,'passwordConfirm'),(5,'stringLength');
/*!40000 ALTER TABLE `setup_field_validation_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setup_field_validation_settings`
--

DROP TABLE IF EXISTS `setup_field_validation_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setup_field_validation_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` int(11) NOT NULL COMMENT 'id from setup_entities table',
  `action_id` int(11) NOT NULL,
  `field_name` varchar(30) NOT NULL COMMENT 'name of field under validation',
  `entity_field_name` varchar(30) NOT NULL,
  `app_id` int(11) NOT NULL,
  `specific_action_id` int(11) NOT NULL,
  `related_entity_id` int(11) DEFAULT NULL,
  `entity_is_root` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setup_field_validation_settings`
--

LOCK TABLES `setup_field_validation_settings` WRITE;
/*!40000 ALTER TABLE `setup_field_validation_settings` DISABLE KEYS */;
INSERT INTO `setup_field_validation_settings` VALUES (1,6,2,'username','User',1,10,NULL,1),(2,6,2,'password','Pass',1,10,NULL,1),(3,6,2,'image','Img',1,10,NULL,1),(4,6,2,'Vokuro\\UsersModule\\Models\\User','Vokuro\\UsersModule\\Models\\User',1,10,NULL,1),(5,7,2,'gender_id','gender_id',1,10,6,0),(6,7,2,'birthdate','birthdate',1,10,6,0);
/*!40000 ALTER TABLE `setup_field_validation_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setup_field_validation_specific_actions`
--

DROP TABLE IF EXISTS `setup_field_validation_specific_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setup_field_validation_specific_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `general_action_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setup_field_validation_specific_actions`
--

LOCK TABLES `setup_field_validation_specific_actions` WRITE;
/*!40000 ALTER TABLE `setup_field_validation_specific_actions` DISABLE KEYS */;
INSERT INTO `setup_field_validation_specific_actions` VALUES (1,'editProfile',2),(2,'view_cms',3),(3,'edit_user_profile',2),(4,'newContent',4),(6,'newUser',1),(7,'edit_user_account',1),(8,'newUser',1),(9,'editProfile',2),(10,'Edit User Profile',2),(11,'Edit Products',2),(12,'edit test',2);
/*!40000 ALTER TABLE `setup_field_validation_specific_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setup_field_validations`
--

DROP TABLE IF EXISTS `setup_field_validations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setup_field_validations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setup_field_validations`
--

LOCK TABLES `setup_field_validations` WRITE;
/*!40000 ALTER TABLE `setup_field_validations` DISABLE KEYS */;
INSERT INTO `setup_field_validations` VALUES (1,'Number'),(2,'Mobile'),(3,'Time'),(4,'DateTime'),(5,'Link'),(6,'Date'),(7,'Location');
/*!40000 ALTER TABLE `setup_field_validations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setup_genders`
--

DROP TABLE IF EXISTS `setup_genders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setup_genders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setup_genders`
--

LOCK TABLES `setup_genders` WRITE;
/*!40000 ALTER TABLE `setup_genders` DISABLE KEYS */;
INSERT INTO `setup_genders` VALUES (1,'Male'),(2,'Female');
/*!40000 ALTER TABLE `setup_genders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `step_attachments`
--

DROP TABLE IF EXISTS `step_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `step_attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `step_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `step_attachments`
--

LOCK TABLES `step_attachments` WRITE;
/*!40000 ALTER TABLE `step_attachments` DISABLE KEYS */;
INSERT INTO `step_attachments` VALUES (1,14,'image','uploads/procedures/4537e24c3cb873b8c6d6488321c3780a.jpg'),(2,14,'image','uploads/procedures/7f6a862e8d31bf27ffcfd0535e8267e4.jpg'),(3,15,'image','uploads/procedures/cf781126b912247bfaeafa4c67c15cdc.jpg'),(4,15,'image','uploads/procedures/b4adef69127a673c33a247a3c1f2d106.jpg'),(5,16,'image','uploads/procedures/d21172f19273255feaf76a2251c8911a.jpg'),(6,16,'image','uploads/procedures/65fc5cc4b59c2dca61eba10bb468a78e.jpg'),(7,17,'image','uploads/procedures/50813349ac99d3901c80a8992f47abc9.jpg'),(8,18,'image','uploads/procedures/95640f17e562de9069104453949de1fc.jpg'),(9,19,'image','uploads/procedures/88a8d11f97e33cd3a878bb662e02f03b.jpg');
/*!40000 ALTER TABLE `step_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `success_logins`
--

DROP TABLE IF EXISTS `success_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `success_logins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` int(10) unsigned NOT NULL,
  `ipAddress` char(15) NOT NULL,
  `userAgent` varchar(120) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usersId` (`usersId`)
) ENGINE=InnoDB AUTO_INCREMENT=293 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `success_logins`
--

LOCK TABLES `success_logins` WRITE;
/*!40000 ALTER TABLE `success_logins` DISABLE KEYS */;
INSERT INTO `success_logins` VALUES (1,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(2,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(3,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(4,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(5,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(6,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(7,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(8,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(9,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(10,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(11,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(12,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(13,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(14,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(15,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(16,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(17,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(18,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(19,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36'),(20,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(21,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(22,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(23,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(24,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36'),(25,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36'),(26,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36'),(27,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(28,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),(29,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36'),(30,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),(31,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36'),(32,1,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'),(33,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(34,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(35,1,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'),(36,1,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'),(37,1,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'),(38,1,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'),(39,1,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'),(40,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(41,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(42,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(43,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(44,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36'),(45,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36'),(46,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),(47,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(48,1,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'),(49,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36'),(50,1,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'),(51,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36'),(52,1,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'),(53,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(54,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),(55,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36'),(56,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(57,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(58,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(59,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(60,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(61,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(62,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(63,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(64,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(65,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(66,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(67,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(68,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(69,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(70,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(71,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(72,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(73,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(74,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.18 Safari/537.36'),(75,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.18 Safari/537.36'),(76,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(77,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(78,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(79,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(80,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(81,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(82,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(83,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(84,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(85,1,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'),(86,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(87,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(88,1,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'),(89,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(90,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(91,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(92,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(93,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(94,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(95,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(96,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(97,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(98,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(99,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(100,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(101,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(102,1,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'),(103,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(104,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(105,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(106,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(107,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(108,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(109,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(110,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(111,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(112,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(113,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(114,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(115,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(116,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(117,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(118,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(119,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(120,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(121,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(122,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(123,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(124,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(125,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(126,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(127,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(128,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(129,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(130,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(131,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(132,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(133,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'),(134,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(135,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(136,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.30 Safari/537.36'),(137,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.30 Safari/537.36'),(138,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(139,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.30 Safari/537.36'),(140,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.30 Safari/537.36'),(141,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(142,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(143,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(144,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36'),(145,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'),(146,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36'),(147,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(148,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(149,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(150,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(151,1,'127.0.0.1','Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(152,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(153,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(154,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(155,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(156,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(157,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(158,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(159,1,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(160,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(161,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(162,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(163,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(164,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(165,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(166,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(167,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(168,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(169,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),(170,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(171,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(172,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(173,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(174,1,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(175,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(176,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(177,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(178,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(179,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.108 Safari/537.36'),(180,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.108 Safari/537.36'),(181,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(182,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(183,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(184,1,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(185,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(186,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(187,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(188,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(189,1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(190,1,'156.222.223.195','Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(191,1,'197.246.50.28','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(192,1,'197.246.50.28','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(193,1,'197.246.50.28','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(194,1,'197.246.50.28','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(195,1,'197.246.50.28','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(196,1,'197.246.50.28','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(197,1,'197.48.172.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(198,1,'197.48.172.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(199,1,'197.246.43.235','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(200,1,'197.48.12.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(201,1,'197.48.12.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(202,1,'197.246.35.131','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(203,1,'197.246.74.11','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(204,1,'197.246.74.11','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(205,1,'197.246.74.11','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(206,1,'197.246.74.11','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(207,1,'197.246.74.11','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(208,1,'197.246.74.200','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(209,1,'197.246.74.200','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'),(210,1,'197.49.73.254','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(211,1,'197.246.74.200','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(212,1,'41.33.162.115','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(213,1,'41.33.162.115','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(214,1,'41.33.162.115','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(215,1,'197.246.41.77','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(216,1,'197.246.41.77','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(217,1,'197.48.169.127','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(218,1,'41.35.129.4','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(219,1,'41.35.129.4','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(220,1,'41.35.129.4','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(221,1,'41.35.129.4','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(222,1,'41.35.129.4','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(223,1,'197.246.37.204','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(224,1,'197.246.37.204','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(225,1,'197.246.37.204','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(226,1,'197.246.37.204','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(227,1,'197.246.37.204','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(228,1,'197.246.37.204','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(229,1,'197.246.34.135','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(230,1,'197.246.37.204','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(231,1,'197.246.37.204','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(232,1,'197.246.34.135','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(233,1,'41.35.143.59','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(234,1,'197.246.73.238','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(235,1,'197.246.41.169','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(236,1,'105.34.169.169','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(237,1,'197.246.41.169','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(238,1,'197.246.41.169','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(239,1,'197.48.177.6','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(240,1,'197.246.41.169','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(241,1,'197.246.73.97','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(242,1,'197.246.73.97','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(243,1,'197.246.73.97','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(244,1,'197.246.73.97','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(245,1,'197.48.141.2','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(246,1,'197.246.73.97','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(247,1,'197.246.73.97','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(248,1,'197.246.73.97','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(249,1,'197.246.73.97','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(250,1,'197.246.73.97','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(251,1,'197.246.40.244','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(252,1,'197.246.40.244','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(253,1,'197.49.16.134','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(254,1,'197.48.191.80','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(255,1,'197.246.75.189','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(256,1,'197.48.161.229','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(257,1,'197.246.73.74','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(258,1,'41.35.156.182','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(259,1,'197.48.254.32','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(260,1,'197.48.254.32','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(261,1,'197.48.254.32','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(262,1,'197.48.254.32','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(263,1,'196.128.5.43','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(264,1,'196.128.5.43','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(265,1,'196.128.5.43','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(266,1,'197.48.178.81','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(267,1,'156.222.26.20','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(268,1,'197.246.42.48','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(269,1,'197.246.42.48','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(270,1,'197.246.42.48','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(271,1,'197.246.35.227','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(272,1,'197.246.35.227','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(273,1,'197.246.72.189','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(274,1,'197.246.72.189','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(275,1,'197.246.35.227','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(276,1,'197.246.72.189','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(277,1,'197.246.72.189','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(278,1,'197.246.72.189','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(279,1,'197.246.72.189','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(280,1,'197.246.72.189','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(281,1,'197.246.72.189','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(282,1,'197.246.72.189','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(283,1,'197.246.72.189','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(284,1,'197.246.72.189','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(285,1,'197.246.72.189','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(286,1,'197.246.72.189','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(287,1,'197.48.81.39','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(288,1,'197.48.81.39','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(289,1,'197.48.81.39','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'),(290,1,'197.48.81.39','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(291,1,'197.48.81.39','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.10'),(292,1,'197.48.81.39','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36');
/*!40000 ALTER TABLE `success_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'Tag 1'),(2,'Tag 2'),(3,'Tag 3'),(4,'Tag 4'),(5,'Tanks'),(6,'Large Tanks'),(7,'pumps'),(8,'arabia'),(9,'pump'),(10,'test1'),(11,'test2'),(12,'test3'),(13,'my other test');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_problem_details`
--

DROP TABLE IF EXISTS `ticket_problem_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_problem_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `spot_on_photo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_problem_details`
--

LOCK TABLES `ticket_problem_details` WRITE;
/*!40000 ALTER TABLE `ticket_problem_details` DISABLE KEYS */;
INSERT INTO `ticket_problem_details` VALUES (26,10,'تسريب في الخزان','1'),(27,10,'سخونة الخزان','2'),(28,11,'الباب لا يغلق جيدا','1'),(29,11,'الباب يفتح بصعوبة','2'),(30,12,'المضخه لا تتدفع الماء بسهولة','1'),(31,13,'تركيب غير جيد','1');
/*!40000 ALTER TABLE `ticket_problem_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_problems`
--

DROP TABLE IF EXISTS `ticket_problems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_problems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_cms_depts_rel_id` int(11) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `category_attribute_id` int(11) DEFAULT NULL,
  `category_attribute_value` varchar(30) NOT NULL,
  `category_attribute_option_id` int(11) DEFAULT NULL,
  `data_cms_id` int(11) NOT NULL DEFAULT '0' COMMENT 'product_id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_problems`
--

LOCK TABLES `ticket_problems` WRITE;
/*!40000 ALTER TABLE `ticket_problems` DISABLE KEYS */;
INSERT INTO `ticket_problems` VALUES (10,17,'d989bfb8-0051-4a04-9722-ecfb44d40459.png',91,'400',38,0),(11,9,'e440f95a-db8a-4476-a93b-2854e1705f3e.jpg',96,'55',55,0),(12,10,'d38aaa67-432c-42d0-86be-4ddaa9f94378.jpg',98,'63',63,0),(13,31,'59c62ff0-2360-48bb-8100-4aaf9a842a61.jpg',94,'49',49,0);
/*!40000 ALTER TABLE `ticket_problems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_problems_status`
--

DROP TABLE IF EXISTS `ticket_problems_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_problems_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_problems_status`
--

LOCK TABLES `ticket_problems_status` WRITE;
/*!40000 ALTER TABLE `ticket_problems_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_problems_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_number` varchar(255) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `client_notes` text,
  `data_cms_id` int(11) DEFAULT NULL,
  `production_year` int(11) DEFAULT NULL,
  `product_number` int(11) DEFAULT NULL,
  `category_attribute_id` int(11) DEFAULT NULL,
  `category_attribute_value_option_id` int(11) DEFAULT NULL,
  `category_attribute_value` int(11) DEFAULT NULL COMMENT 'The value if the attribute option id',
  `ticket_problem_id` int(11) DEFAULT NULL,
  `installation_status_id` int(11) DEFAULT NULL,
  `installation_reason` varchar(255) DEFAULT NULL,
  `in_guarantee` tinyint(1) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `report_notes` text,
  `ticket_status_id` int(11) DEFAULT NULL,
  `company_branch_id` int(11) DEFAULT NULL,
  `invoice_number` varchar(255) DEFAULT NULL,
  `number_of_products` int(11) DEFAULT NULL,
  `attached_file` varchar(255) DEFAULT NULL,
  `order_notes` varchar(255) DEFAULT NULL,
  `order_region_id` int(11) DEFAULT NULL,
  `order_company_branch_id` int(11) DEFAULT NULL,
  `assigned_technician_id` int(11) DEFAULT NULL,
  `ticket_pending_reason` int(11) DEFAULT '0',
  `ticket_exhcange_reason` int(11) NOT NULL DEFAULT '0',
  `next_activation_date` date DEFAULT NULL,
  `start_datetime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `end_datetime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `actual_start_datetime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `actual_end_datetime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (9,'1517216220',34,'عميل مميز للغاية',57,0,0,91,38,400,26,0,'',0,'','',1,1,'',0,'','الطلب تم بنجاح بدون اي ملاحظات',1,8,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,1),(10,'1517216532',35,'عميل ممتاز',58,0,0,96,55,55,28,0,'',0,'','',1,1,'',0,'','لا يوجد أي ملاحظات',1,3,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,1),(11,'1517216831',34,'عميل مميز جدا',59,0,0,98,63,63,30,0,'',0,'','',1,1,'',0,'','لا يوجد',2,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,1),(12,'1517217182',35,'هذا العميل هو أشرف هشام',60,0,0,94,49,49,31,0,'',0,'','',1,1,'',0,'','الطلب ممتاز جدا',1,8,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,1);
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_installation_status`
--

DROP TABLE IF EXISTS `tickets_installation_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickets_installation_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_installation_status`
--

LOCK TABLES `tickets_installation_status` WRITE;
/*!40000 ALTER TABLE `tickets_installation_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `tickets_installation_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_tech_report_notes`
--

DROP TABLE IF EXISTS `tickets_tech_report_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickets_tech_report_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tech_report_id` int(11) NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_tech_report_notes`
--

LOCK TABLES `tickets_tech_report_notes` WRITE;
/*!40000 ALTER TABLE `tickets_tech_report_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `tickets_tech_report_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_tech_report_photos`
--

DROP TABLE IF EXISTS `tickets_tech_report_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickets_tech_report_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tech_report_id` int(11) NOT NULL,
  `photo` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_tech_report_photos`
--

LOCK TABLES `tickets_tech_report_photos` WRITE;
/*!40000 ALTER TABLE `tickets_tech_report_photos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tickets_tech_report_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_tech_reports`
--

DROP TABLE IF EXISTS `tickets_tech_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickets_tech_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) DEFAULT NULL,
  `data_cms_id` int(11) DEFAULT NULL,
  `product_number` int(11) DEFAULT NULL,
  `manufacturing_year` varchar(255) DEFAULT NULL,
  `installation_reasons` text,
  `in_gurantee` tinyint(1) DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_tech_reports`
--

LOCK TABLES `tickets_tech_reports` WRITE;
/*!40000 ALTER TABLE `tickets_tech_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `tickets_tech_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_addresses`
--

DROP TABLE IF EXISTS `user_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `details` varchar(255) CHARACTER SET utf8 NOT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `is_main` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_addresses`
--

LOCK TABLES `user_addresses` WRITE;
/*!40000 ALTER TABLE `user_addresses` DISABLE KEYS */;
INSERT INTO `user_addresses` VALUES (1,6,2,2,2,'address details updated','11313',0),(2,6,2,2,2,'street 2','33434',0),(3,6,1,1,1,'my details of my address','11312',0),(4,6,1,1,1,'my details of my address','11312',0),(6,6,1,1,1,'address details','11312',0),(8,8,1,1,1,'address 33','45322',0),(9,8,1,1,1,'new address new','78394',0),(10,11,1,1,1,'29 شارع السعودية الجديدة','4324324234',0),(11,11,1,1,1,'29 الرياض','159621',0),(12,11,1,1,1,'23 شارع الحرية','21562030',0),(13,13,1,1,1,'my address details 1','11312',0),(14,13,1,1,1,'my address details 2','1312',0),(15,20,1,1,1,'my details of my address1212','21455',0),(16,20,1,1,1,'New Address 2 ','21455',0),(17,20,1,1,1,'New Address 3 ','21455',0),(18,19,3,1,1,'test','11312',1),(21,32,NULL,1,1,'address1','11312',0),(22,32,NULL,1,1,'address2','11312',0),(23,33,NULL,1,1,'سموحة توت عنخ امون','',0),(24,33,NULL,1,1,'محمد رفعت مصر الجديدة','',0),(25,32,1,1,1,'main one',NULL,1),(26,32,1,1,1,'another main',NULL,1),(32,35,NULL,12,19,'adresssssssssssss','2156214',0),(33,36,NULL,13,13,'address address address address address address address','02526',0),(50,37,NULL,1,8,'address1','11312',0),(51,37,NULL,1,8,'address2','11312',0),(52,38,NULL,1,1,'address1','11312',0),(53,38,NULL,1,1,'address2','11312',0),(54,34,NULL,1,22,'address 1','148562',0),(55,34,NULL,1,22,'address 2','148562',0),(56,34,NULL,1,22,'address 3','148562',1),(57,34,NULL,1,22,'address 4','148562',0),(58,34,NULL,1,22,'address 5','148562',0),(59,34,NULL,1,1,'عنوان جديد تم اضافته من الفيو','148562',0),(60,39,NULL,1,22,'عمارات العبور','3231230',1),(61,39,NULL,1,22,'التجمع الخامس','3231230',0),(62,43,3,1,12,'ن تعررخرو','??????',0),(63,43,3,1,12,'تعديل الي عفيف ','?????',0),(64,43,3,1,1,'الرياض كلو','????',0),(65,47,3,1,1,'Hello from reyad','88844',0);
/*!40000 ALTER TABLE `user_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_categories`
--

DROP TABLE IF EXISTS `user_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `application_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_categories`
--

LOCK TABLES `user_categories` WRITE;
/*!40000 ALTER TABLE `user_categories` DISABLE KEYS */;
INSERT INTO `user_categories` VALUES (1,'شركة',1),(2,'ضيف',1),(6,'عميل فردي',1),(7,'عميل مسجل',1),(8,'موزع',1),(9,'مقاول',1),(10,'مؤسسة',1),(11,'أخرى',1);
/*!40000 ALTER TABLE `user_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_data`
--

DROP TABLE IF EXISTS `user_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `gender_id` int(11) DEFAULT NULL,
  `birthdate` varchar(30) DEFAULT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `postal_code` varchar(30) DEFAULT NULL,
  `last_login_date` varchar(40) DEFAULT NULL COMMENT 'add the date as string (03/01/2018)',
  `supervisor_comment` text,
  `branch_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_data`
--

LOCK TABLES `user_data` WRITE;
/*!40000 ALTER TABLE `user_data` DISABLE KEYS */;
INSERT INTO `user_data` VALUES (1,1,1,'1508959022','Africa/Cairo',1,1,1,NULL,NULL,NULL,NULL,2),(2,NULL,NULL,'',NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,NULL,NULL,'1483228800',NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,NULL,NULL,'1483228800',NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,NULL,NULL,'1483228800',NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,NULL,NULL,'1483228800',NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,13,NULL,'1483228800',NULL,3,1,1,NULL,NULL,NULL,NULL,NULL),(8,19,NULL,'1499385600',NULL,3,6,9,NULL,NULL,NULL,NULL,NULL),(9,20,NULL,'232323',NULL,2,2,2,NULL,NULL,NULL,NULL,NULL),(10,22,NULL,'',NULL,3,1,9,NULL,NULL,NULL,NULL,NULL),(14,35,2,'1514937600',NULL,NULL,12,19,'company','2156214',NULL,'comment',5),(13,34,2,'-125884800',NULL,NULL,1,22,'شركة','148562',NULL,'comment',1),(16,37,1,'1515888000',NULL,NULL,1,8,'company','11312',NULL,'comment',1),(18,39,2,'1514764800',NULL,NULL,11,10,'اي شركة','3231230',NULL,'تعليق',2),(19,43,NULL,'1517308546.967303',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,44,NULL,NULL,NULL,NULL,1,1,NULL,NULL,NULL,NULL,2),(21,47,NULL,'1517750922.974608',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_information`
--

DROP TABLE IF EXISTS `user_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_information` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `mobile2` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `notes` text,
  `tag` int(11) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `user_type` int(11) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `work_location` text,
  `signature` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_information`
--

LOCK TABLES `user_information` WRITE;
/*!40000 ALTER TABLE `user_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_module_login_types`
--

DROP TABLE IF EXISTS `user_module_login_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_module_login_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL COMMENT 'normal | social',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_module_login_types`
--

LOCK TABLES `user_module_login_types` WRITE;
/*!40000 ALTER TABLE `user_module_login_types` DISABLE KEYS */;
INSERT INTO `user_module_login_types` VALUES (1,'normal'),(2,'facebook'),(3,'twitter'),(4,'instagram');
/*!40000 ALTER TABLE `user_module_login_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_module_settings`
--

DROP TABLE IF EXISTS `user_module_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_module_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `application_id` int(11) DEFAULT NULL,
  `login_by_email` tinyint(1) DEFAULT NULL,
  `login_by_username` tinyint(1) DEFAULT NULL,
  `login_by_mobile` tinyint(1) DEFAULT NULL,
  `login_by_facebook` tinyint(1) DEFAULT NULL,
  `login_by_twitter` tinyint(1) DEFAULT NULL,
  `login_by_instagram` tinyint(1) DEFAULT NULL,
  `login_token_expires_in` varchar(15) DEFAULT NULL COMMENT 'holds timestamp of when the user token should expire',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_module_settings`
--

LOCK TABLES `user_module_settings` WRITE;
/*!40000 ALTER TABLE `user_module_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_module_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_module_social_app_info`
--

DROP TABLE IF EXISTS `user_module_social_app_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_module_social_app_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumer_key` varchar(255) DEFAULT NULL,
  `consumer_secret` varchar(255) DEFAULT NULL,
  `social_app_type` int(11) DEFAULT NULL COMMENT 'holds values from user_module_login_types table',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_module_social_app_info`
--

LOCK TABLES `user_module_social_app_info` WRITE;
/*!40000 ALTER TABLE `user_module_social_app_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_module_social_app_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_module_token_secret_keys`
--

DROP TABLE IF EXISTS `user_module_token_secret_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_module_token_secret_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(15) NOT NULL,
  `token_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_module_token_secret_keys`
--

LOCK TABLES `user_module_token_secret_keys` WRITE;
/*!40000 ALTER TABLE `user_module_token_secret_keys` DISABLE KEYS */;
INSERT INTO `user_module_token_secret_keys` VALUES (1,'5351lr6BEy',1),(2,'eOsk19S220',2),(3,'mb10JA411',3),(4,'236T0q14Qz',4),(5,'bw17t449nh',5),(6,'18b731klwp',6),(7,'J1RlD359kz',7),(8,'DTv19Dfu2X',8),(9,'9GuXLDIZ1R',9),(10,'GgT9z17UZQ',10),(11,'ss8Gw18vko',11),(12,'5Finc0Wb9',12),(13,'y0i3RuZ16G',13),(14,'q48c1d711k',14),(15,'TFa1GELFg7',15),(16,'ac668w1Fnk',16),(17,'11Joa6dE71',17),(18,'zRfg131X9i',18),(19,'0AQViC1Mb9',19),(20,'x0EwU8H4b1',20),(21,'A76lTQjq1f',21),(22,'7ssa97kSi',22),(23,'11T4RjnI1i',23),(24,'13XxFnLffb',24),(25,'hK28413m0D',25),(26,'Jos1WH4Vxy',26),(27,'2wf1V118Ia',27),(28,'r12IO15qui',28),(29,'c9oH907A75',29),(30,'40K47KTF2z',30),(31,'VW8Sc2hill',31),(32,'15iV1ZN1G1',32),(33,'n1TqFy2bhG',33),(34,'pkgwWMl17g',34),(35,'xQN1k7o511',35),(36,'71118zrjX1',36),(37,'bszR8w699n',37),(38,'pvY2xf7l3A',38),(39,'weH3257H7z',39),(40,'XmYwiJN657',40),(41,'4669O49356',41),(42,'ok1QO7A7AG',42),(43,'iRhwR161kp',43),(44,'4A7O7afZX6',44),(45,'110v1GvG1W',45),(46,'Q17iIw53mM',46),(47,'By1eO3tjn9',47),(48,'Tm4Y4Ac18l',48),(49,'u2I62flqfj',49),(50,'1kY3iPFUaL',50),(51,'Cdyt7T81Z1',51),(52,'uNSw8jOJ8Q',52),(53,'xA15dIpFt3',53),(54,'46ARz18pnm',54),(55,'OytukcaSmM',55),(56,'b9q17115NE',56),(57,'912kCi11Wp',57),(58,'qLu21E1it9',58),(59,'Y2aCn131py',59),(60,'5q141l1DQ1',60),(61,'Pr1fdMqld1',61),(62,'Y171X8dcT7',62),(63,'HZUoU0M7Z0',63),(64,'18w1Xy3K1W',64),(65,'wx1eHI936K',65),(66,'feY66aSW1w',66),(67,'w25ICt1A15',67),(68,'qHDwIw4J7t',68),(69,'CcUJ1V7Yx1',69),(70,'5dHv1j1eGL',70),(71,'30X5Jmp221',71),(72,'mB1911Bk9e',72),(73,'51pt7T0y0Q',73),(74,'173T3JMx49',74),(75,'3Fs49Lnkw1',75),(76,'1pa1b48131',76),(77,'11mN0LzDkU',77),(78,'1z099788rO',78),(79,'06178y0DRY',79),(80,'1dG4U18ZVG',80),(81,'DuGHx12xd5',81),(82,'416R4HOx44',82),(83,'1115o4n1EA',83),(84,'Ny9l6kBR0K',84),(85,'7j27F11QLc',85),(86,'1mp5AeI12X',86),(87,'LNfvb1o1Iv',87),(88,'Md1aB37jIE',88),(89,'UB95185cHT',89),(90,'X31WhoJB41',90),(91,'A10d1mPG6n',91),(92,'SjEjZ3xSFy',92),(93,'ZGy1f36hKq',93),(94,'14v473B341',94),(95,'Lr1B7131Dp',95),(96,'4Bik384tX0',96),(97,'aL00GOI013',97),(98,'iD31gl7Sk1',98),(99,'ivh12i0BGH',99),(100,'kW5L81Kwrd',100),(101,'q8RlPOD18D',101),(102,'mZEQs66CJW',102),(103,'EC1b19T1TM',103),(104,'A19za180Hg',104),(105,'gZNJeC4HD1',105),(106,'v1jO1n07hM',106),(107,'E1f3661ss2',107),(108,'Wh1173xtTm',108),(109,'1p18d2kl6W',109),(110,'j1H1Meqlm9',110),(111,'zVbkUgeJpZ',111),(112,'B0k2m8v1CA',112),(113,'sp1Edt8J1R',113),(114,'yHjqFeJYww',114),(115,'F14t1Y1b1g',115),(116,'41k10FmLMU',116),(117,'4NA6o1wds1',117),(118,'gEfhMY15a1',118),(119,'5b6gnLffDJ',119),(120,'Nijq1ZwJO2',120),(121,'f4gwqdF7ZD',121),(122,'qsVBt281xG',122),(123,'XScUpIVF7b',123),(124,'Rz1418141e',124),(125,'OYdJj1zxEh',125),(126,'a82bKa92pR',126),(127,'2Hwcv804R7',127),(128,'1861dn11R8',128),(129,'Ev21pvPs9a',129),(130,'0rN3ouJII1',130),(131,'M1CNo442kJ',131),(132,'csvdqRJ812',132),(133,'mfBG5pgfN3',133),(134,'s0dL988leU',134),(135,'F15NxZ5c6R',135),(136,'887vpf1Uha',136),(137,'N1Jl1LN21w',137),(138,'3jvoRIacR7',138),(139,'0I39X73L7m',139),(140,'2j5WuxEvly',140),(141,'7BC4reI11Y',141),(142,'A6qM58qHP3',142),(143,'AgZghj1HX0',143),(144,'SGLdpx85xy',144),(145,'4jI130bL81',145),(146,'ZVs18s503R',146),(147,'Nr5871w1j1',147),(148,'9MLeaY1KdD',148),(149,'G91td1yZS1',149),(150,'1fG4f840c1',150),(151,'a3AP9VgFw9',151),(152,'A09j16Ug7g',152),(153,'pUlU31Ki3b',153),(154,'z8Q51qbk5u',154),(155,'11xa11a172',155),(156,'9b2RNq79gO',156),(157,'QJP16csj81',157),(158,'Y1gY00my12',158),(159,'3zJH6i181p',159),(160,'Y7lN9927c9',160),(161,'5xxPpR2115',161),(162,'pin0S16k71',162),(163,'1GsIJLk49O',163),(164,'586Ef2Go11',164),(165,'BBz1vx7ihB',165),(166,'kd131Swokw',166),(167,'05bq77T215',167),(168,'CnRR7w1141',168),(169,'7o189Mkmhr',169),(170,'075mA2xs11',170),(171,'I7xbH13DIh',171),(172,'U0FSRf70AI',172),(173,'Xfbw365wL1',173),(174,'L11m75Os8j',174),(175,'1RWi1STw1Q',175),(176,'Y6QWD158o3',176),(177,'32mWDPqjDj',177),(178,'T0KlW3KdvG',178),(179,'16aPsPj8AV',179),(180,'m6Awal31P7',180),(181,'c7Ig1f1M81',181),(182,'q4K56KN9qZ',182),(183,'qo1hh1284Y',183),(184,'3EZwXvzuoW',184),(185,'FsqwXw1m1S',185),(186,'8dUkAYaryP',186),(187,'ED10aznj0k',187),(188,'2ctwBT3No9',188),(189,'w5697kT3M8',189),(190,'P111EUj81T',190),(191,'A1i761Ar1G',191),(192,'aR214S1W91',192),(193,'ft21rpsOAd',193),(194,'IAjqerD71D',194),(195,'oaWe8JabIX',195),(196,'AkCSu9bzx5',196),(197,'2Db01I1u11',197),(198,'I1vAogeYje',198),(199,'41sbY11Q0d',199),(200,'Kgs14Uedzk',200),(201,'qWo9Vp3J0S',201),(202,'1vyx1Dz4gZ',202),(203,'q7wLg51c1W',203),(204,'nyLV1lFXVC',204),(205,'8R191eU63S',205),(206,'HLHzz96c05',206),(207,'nT7lBVqH7g',207);
/*!40000 ALTER TABLE `user_module_token_secret_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_module_tokens`
--

DROP TABLE IF EXISTS `user_module_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_module_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) DEFAULT NULL,
  `is_expired` tinyint(1) DEFAULT '0',
  `type` int(11) DEFAULT NULL COMMENT 'holds id of type from the user_module_login_types table',
  `user_id` int(11) DEFAULT NULL,
  `created_at` varchar(20) DEFAULT NULL,
  `expired_at` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_module_tokens`
--

LOCK TABLES `user_module_tokens` WRITE;
/*!40000 ALTER TABLE `user_module_tokens` DISABLE KEYS */;
INSERT INTO `user_module_tokens` VALUES (1,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbG1hQHRlc3QuY29tIiwibmFtZSI6IlNhbG1hIE9tYXIiLCJjcmVhdGVkX2F0IjoxNTA4NjcxODI3fQ.hxJaO7w0jmZ-7pWzYaJT58d6quRGBoS0ylDdNfKli_8',0,1,3,'1508671827',NULL),(2,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImFkbWluQGFkbWluLmNvbSIsIm5hbWUiOiJhZG1pbiIsImNyZWF0ZWRfYXQiOjE1MDg4NDAwMTN9.cAzV5l4wr6HHdzUyveq1XQXSI8y8KOhCYkMokiEspPk',1,1,1,'1508840013','1516459174'),(3,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbG1hQHRlc3QuY29tIiwibmFtZSI6IlNhbG1hIE9tYXIiLCJjcmVhdGVkX2F0IjoxNTA4ODUwNzg5fQ.0iMJKUvpkCZf7rY1FF9X45bS-oL_R-Gyq0EoeAWqz8U',0,1,3,'1508850789',NULL),(4,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbG1hQHRlc3QuY29tIiwibmFtZSI6IlNhbG1hIE9tYXIiLCJjcmVhdGVkX2F0IjoxNTA4ODUxNDgzfQ.cgpmtvgtk4IL4iwHH0JcIr_YK5ko5WYsi4ZRYVAF5y8',0,1,3,'1508851483',NULL),(5,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbG1hQHRlc3QuY29tIiwibmFtZSI6IlNhbG1hIE9tYXIiLCJjcmVhdGVkX2F0IjoxNTA4ODUyMDI4fQ.3t_JmDOiV0oaxdGytmf4n12qNdoxQ6OBpjpm4zEu4b0',0,1,3,'1508852028',NULL),(6,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbG1hQHRlc3QuY29tIiwibmFtZSI6IlNhbG1hIE9tYXIiLCJjcmVhdGVkX2F0IjoxNTA4ODUyMDU0fQ.rK5QEE_cu0MA7er1NfD2IqfZgdHW-W26uEOFdZ__Upg',0,1,3,'1508852054',NULL),(7,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbG1hQHRlc3QuY29tIiwibmFtZSI6IlNhbG1hIE9tYXIiLCJjcmVhdGVkX2F0IjoxNTA4ODUyMDYyfQ.ETvtBOs7WjA128xDVbi9lkvOd2i1KKnrTDh6PSxAA2E',0,1,3,'1508852062',NULL),(8,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbG1hQHRlc3QuY29tIiwibmFtZSI6IlNhbG1hIE9tYXIiLCJjcmVhdGVkX2F0IjoxNTA4ODUyMDg3fQ.9PWvvvsWi9lrX0ddCZV-ROw6gTY3LCAKAuoC_G75dfE',0,1,3,'1508852087',NULL),(9,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImFzaHJvb2ZAZ21haWwuY29tIiwibmFtZSI6IkFzaHJvb2YiLCJjcmVhdGVkX2F0IjoxNTA4OTU3MjY4fQ.7gjVE0kNKesPIgPb7p9NPIFEudPomK_80Umk72A0twc',0,1,6,'1508957268',NULL),(10,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImFzaHJvZjEyM0BnbWFpbC5jb20iLCJuYW1lIjoiYXNocm9mMTIzQGdtYWlsLmNvbSIsImNyZWF0ZWRfYXQiOjE1MDg5NjUwNDR9.5slL0Ad6osUjvhNZnnll3UAvCwWx5rM-QT0uXicxDTg',0,1,7,'1508965044',NULL),(11,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbG1hQHRlc3QuY29tIiwibmFtZSI6IlNhbG1hIE9tYXIiLCJjcmVhdGVkX2F0IjoxNTA4OTcxMjgxfQ.7Zd1j7AaopQ8FAwzC00m6dHeZ_hpB7sz9HeFtdw_DF8',0,1,3,'1508971281',NULL),(12,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbG1hQHRlc3QuY29tIiwibmFtZSI6IlNhbG1hIE9tYXIiLCJjcmVhdGVkX2F0IjoxNTA4OTcxMzI3fQ.c5Z1g6YyMN1jBtYhfSu5eHPqO8ZLQDFBITn7vyzGzy8',0,1,3,'1508971327',NULL),(13,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbG1hQHRlc3QuY29tIiwibmFtZSI6IlNhbG1hIE9tYXIiLCJjcmVhdGVkX2F0IjoxNTA5MDE1ODU1fQ.Oyz63wcfx7nOTnxM3WzEGxekDGr66iWGpzj-2fMW28E',0,1,3,'1509015855',NULL),(14,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5MzYyMDQ2fQ.O4O5E631cgtLccKXbVjn7GHzggA54VOyJKDuM0GbHwM',1,1,8,'1509362046','1509362617'),(15,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5MzYyNjE3fQ.NOp_tJfly1cuxxHSSFzdUjpbptefXE8szsAzIvAH3Is',1,1,8,'1509362617','1509362664'),(16,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5MzYyNjY3fQ.AEuBAQL9TeJGkNkmh-nBLkQwyiYf0KnKlLqqG7eq9fQ',1,1,8,'1509362667','1509362863'),(17,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5MzYyOTI3fQ.Ow5EFhloxeW8_sLRpyd2-KSYWqf38Aoaj-ZIaF557eg',1,1,8,'1509362927','1509363317'),(18,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5MzYzMzE5fQ.WK0cAEREuORiYUvl-AUT5HKT3tAXk3OyknW1MCpLF0s',1,1,8,'1509363319','1509368568'),(19,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjkiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUwOTM2NDI5Nn0.m3gopSjChqpilsCFYexsX7AsuPJUcdJAQP6AysOzpBA',1,1,9,'1509364296','1509365160'),(20,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjkiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUwOTM2NTU4M30.sYB-szg5_4nB3DMO_-D5aQrxunIZjMj5y2k8kQyXT04',1,1,9,'1509365583','1509366369'),(21,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjkiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUwOTM2NjQyMH0.O7jGuJZZh3DPNgS0DI7_X-8LXUzrOFal_MECxKPtYvY',0,1,9,'1509366420',NULL),(22,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5MzY5MjYxfQ.1-M1jzLCOCcw47hCFiHUf0rjydY3RpCmHMWG8lwnt5I',1,1,8,'1509369261','1509369850'),(23,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5MzcwMDIwfQ.gfvxUUqzvDQ2gqz4rOLHMgDzVcgeDcQrfRQDd0uDeSk',1,1,8,'1509370020','1509370072'),(24,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5MzcwMDc0fQ.Tcid-YKl_m0ZP2R-dzWb9ecCgXiO-ty3ENrJcYsrFz0',1,1,8,'1509370074','1509370121'),(25,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5MzcwMTIxfQ.cfLI9PxbrGNVIwi9D6SAo27dDaXkAtHWrhSIeZDIVnQ',1,1,8,'1509370121','1509370160'),(26,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5Mzc0NTkwfQ.3s4uusgqzICG5wZVn-weq8KUtMC4vHxwPMwuslnYlko',1,1,8,'1509374590','1509388396'),(27,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5Mzg4Mzk2fQ.hcxkVI1SbcWkuAtYzHNmdszJJ0W_1Qli279pYvKIJhk',1,1,8,'1509388396','1509388620'),(28,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5Mzg4NjI2fQ.c1lB4ziYNrhDiNlGVzqJ7ieJ3IpowgXDLNR9_3t702E',1,1,8,'1509388626','1509388960'),(29,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5MzkwMTU1fQ.eIzphWnXDBlBYqGe5rKGaocScUkWNeFHtPpt4VGGF6A',1,1,8,'1509390155','1509390594'),(30,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5MzkwNTk0fQ.Ps7s6iOvt-tgYWtO4bw5jK54lL9skOS55yhZ6GGLt5U',1,1,8,'1509390594','1509405123'),(31,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5NDA1MTIzfQ.BZugzrA-VQHmwYEb84QJIpaacBT5Isl2RIn3xm0DN4Y',1,1,8,'1509405123','1509445716'),(32,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5NDQ1NzE2fQ.8t8tbxY_GQx3W3koNtpggGYvVzCd_rbYFwx3NacBIgA',1,1,8,'1509445716','1509446436'),(33,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5NDQ2NDYxfQ.d-XY_d7IFesbo9MmsACR66yUeWJbtNM4jmTnXxiXfmk',1,1,8,'1509446461','1509521645'),(34,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5NTIxNjQ1fQ.sOHVCqZiZCGema7CJijDl8M7wMdfF4H-I90o_Mj0kGs',1,1,8,'1509521645','1509521843'),(35,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IkFzaHJhZiBIZXNoYW0iLCJjcmVhdGVkX2F0IjoxNTA5NTIxODQzfQ.rln3Zwt9Yv_rcqvY-PxBQRkp0sFiCJt0KWn_Se7erSU',1,1,8,'1509521843','1509661920'),(36,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwiZW1haWwiOiJzYWxtYW9tYXJpb0B5YWhvby5jb20iLCJuYW1lIjoiU2FsbWEiLCJjcmVhdGVkX2F0IjoxNTA5NTM4MTUwfQ.FjXtp6t7yT9CxT1cEe0vseE78KPjrfICIVJaKv_P2qo',1,1,11,'1509538150','1509538809'),(37,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwiZW1haWwiOiJzYWxtYW9tYXJpb0B5YWhvby5jb20iLCJuYW1lIjoiU2FsbWEiLCJjcmVhdGVkX2F0IjoxNTA5NTM4ODI3fQ.coWWVSoRT-Nr449j0_xqRCciEO_-kB4CS7tv2QgfWCk',1,1,11,'1509538827','1509547552'),(38,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwiZW1haWwiOiJzYWxtYW9tYXJpb0B5YWhvby5jb20iLCJuYW1lIjoiU2FsbWEiLCJjcmVhdGVkX2F0IjoxNTA5NTQ3NTUyfQ.47kKMuMr9ELZU3pyHQy4csPeema0IILu93Rmt7pBk2k',1,1,11,'1509547552','1509551673'),(39,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwiZW1haWwiOiJzYWxtYW9tYXJpb0B5YWhvby5jb20iLCJuYW1lIjoiU2FsbWEiLCJjcmVhdGVkX2F0IjoxNTA5NTUxNjczfQ.oSUv70U1HAwpB0cBpPsCVS9roDmcvtJb_t743XbHI_E',1,1,11,'1509551673','1509552335'),(40,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwiZW1haWwiOiJzYWxtYW9tYXJpb0B5YWhvby5jb20iLCJuYW1lIjoiU2FsbWEiLCJjcmVhdGVkX2F0IjoxNTA5NTUyMzUwfQ.ueyDnRIX4OtrOeOOhOYUgrbwrAq3tuuuroUygADGGB4',1,1,11,'1509552350','1509552351'),(41,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwiZW1haWwiOiJzYWxtYW9tYXJpb0B5YWhvby5jb20iLCJuYW1lIjoiU2FsbWEiLCJjcmVhdGVkX2F0IjoxNTA5NTUyMzUxfQ.HkrTz39rGplzkC6EgGeqHYo6qtvVY_zH0YTjk4wOFsE',1,1,11,'1509552351','1509619227'),(42,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwiZW1haWwiOiJzYWxtYW9tYXJpb0B5YWhvby5jb20iLCJuYW1lIjoiU2FsbWEiLCJjcmVhdGVkX2F0IjoxNTA5NjE5MjI3fQ.1TFnvlwy4KbRWhB7bLAT8bw0L9ueAcOFZRRXVZjwbuY',1,1,11,'1509619227','1509632737'),(43,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwiZW1haWwiOiJzYWxtYW9tYXJpb0B5YWhvby5jb20iLCJuYW1lIjoiU2FsbWEiLCJjcmVhdGVkX2F0IjoxNTA5NjMyNzM4fQ.IDZ5XKsTPWLpe8iMma84-6H_SUsEVNiXLGhVSR8WgeQ',1,1,11,'1509632738','1509734701'),(44,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IlRlc3QgdXNlciB1cGRhdGUiLCJjcmVhdGVkX2F0IjoxNTA5NjYxOTIwfQ.GLVc3tlWlVm6oojJ0qJWXjGsefKfiCCj7J-avW7tcFc',1,1,8,'1509661920','1509691428'),(45,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IlRlc3QgdXNlciB1cGRhdGUiLCJjcmVhdGVkX2F0IjoxNTA5NjkxNDI4fQ.OF2kB8d9FB9TKy9rvxuq-nLqVJiWgQeCd1exfyUY-NA',1,1,8,'1509691428','1509745823'),(46,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwiZW1haWwiOiJzYWxtYW9tYXJpb0B5YWhvby5jb20iLCJuYW1lIjoiU2FsbWEiLCJjcmVhdGVkX2F0IjoxNTA5NzM0NzAxfQ.oTbprA0tDaJko0G6mdrSdOYmfDh-HB44EPDu-QAeZoQ',1,1,11,'1509734701','1509978812'),(47,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJlbWFpbCI6ImFzaHJhZmhlc2hhbTE5OTJAZ21haWwuY29tIiwibmFtZSI6IlRlc3QgdXNlciB1cGRhdGUiLCJjcmVhdGVkX2F0IjoxNTA5NzQ1ODIzfQ.83000To3olfgS97tiArfuxIE1WtQVLttYjzaB7klw3o',0,1,8,'1509745823',NULL),(48,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEyIiwiZW1haWwiOiJhYmRlbHJhaG1hbi5lbGphenphckBnbWFpbC5jb20iLCJuYW1lIjoiYWJkZWxyYWhtYW4iLCJjcmVhdGVkX2F0IjoxNTA5Nzk1OTI1fQ.auzn2wPlpXuD0eGU6pq0Q6FHYkyqpKCDstOP8-Act-U',1,1,12,'1509795925','1509804610'),(49,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUwOTc5OTAwOX0.MvK0fiAysQWFlqZnvtEDznGrOeyzUifmJpiE4Gjf-sI',1,1,13,'1509799009','1509908209'),(50,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEyIiwiZW1haWwiOiJhYmRlbHJhaG1hbi5lbGphenphckBnbWFpbC5jb20iLCJuYW1lIjoiYWJkZWxyYWhtYW4iLCJjcmVhdGVkX2F0IjoxNTA5ODA0NjEwfQ.XVHMPL5a88jKZLfVYXt5LjCagAzvBXmnbjMFg3G5v1E',1,1,12,'1509804610','1509806664'),(51,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEyIiwiZW1haWwiOiJhYmRlbHJhaG1hbi5lbGphenphckBnbWFpbC5jb20iLCJuYW1lIjoiYWJkZWxyYWhtYW4iLCJjcmVhdGVkX2F0IjoxNTA5ODA2OTkxfQ.KuOkUzCzd8QcfTSPXkxjC-r4hj9wMHazA-spbCJYkLU',0,1,12,'1509806991',NULL),(52,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUwOTkwODIwOX0.7sD68pk_2mvosziZN4hvjg35FFDiKpMedWXUvo629zs',1,1,13,'1509908209','1509914109'),(53,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUwOTkxNDEwOX0.FPoommEeJUDoB0t9J3ip7i0ghLXfZxM7gGmj4l9YdkU',1,1,13,'1509914109','1509954617'),(54,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUwOTk1NDYxN30.CIEXTcZyeZoOLndKKyEtziDmu23uIke_tVu_6LIKd_U',1,1,13,'1509954617','1509960133'),(55,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUwOTk2MDE1MH0.PxnLvD5eRVKztO0bYqrsDLq0EYWTkHWhFYdkXl0Ehoo',1,1,13,'1509960150','1509977697'),(56,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUwOTk3NzY5OH0.n2VGqQHumMC09xlB9C7uH-hquX616TsEZotxeix43M4',1,1,13,'1509977698','1509977794'),(57,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwiZW1haWwiOiJzYWxtYW9tYXJpb0B5YWhvby5jb20iLCJuYW1lIjoiU2FsbWEiLCJjcmVhdGVkX2F0IjoxNTA5OTc4ODEyfQ.ISeTcDJ3MzAwRJlzajkOqwJsyleUaLqHp56byua3i0s',0,1,11,'1509978812',NULL),(58,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUwOTk3OTcyMn0.FKuScDV3BtMfpkJYFvJ-Hht5WGyNugYCHixDBx5igpU',1,1,13,'1509979722','1509981356'),(59,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUwOTk4MTM5Mn0.hU1Xz0CbmQfBH7CxvxWDSvfkLA7ZWFY-L7MAHkwCivI',1,1,13,'1509981392','1510417370'),(60,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMDQxNzM3MH0.3IoZa6rDZxlMMibLJi2-DY8w4V99bzUaFirAjc40f24',1,1,13,'1510417370','1510426066'),(61,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMDQyNjEwMX0.8hMq7Wt1ubCkP6Pkw54vXv5vFIawHp0mY5O5m31xNPk',1,1,13,'1510426101','1510588997'),(62,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMDU4ODk5N30.ND882GSTKQCJ1bciSDeJ8BFvFbfyVtjlVM0uGGBBf7E',1,1,13,'1510588997','1510646659'),(63,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMDY0NjY1OX0.htHmOPrIvWUe21VVcqYCJUtJABTUYwmjU3FFDr_BPAQ',1,1,13,'1510646659','1510735745'),(64,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMDczNTc0NX0.QJ4Uw410jhAyOfLmPgCfgk_Mouq_MrHNwh59AQyj7zs',1,1,13,'1510735745','1510749099'),(65,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMDc0OTEwMH0.8V1Qigumug5lOmfv4WHO5JzcX7ixFaiYyAtoe8lILJE',1,1,13,'1510749100','1510749119'),(66,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMDc0OTExOX0.lKoj_kfvUxQIkxkm6NzUkesu6dQF9RQqA_VMUfSmAEM',1,1,13,'1510749119','1510751450'),(67,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMDc1MTQ1MH0.2TOOMMPrmwQ7UHVUdlVAaSPfpAjU7OcGG1jowvAew9w',1,1,13,'1510751450','1510823345'),(68,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMDgyMzM0NX0.SUHUMuuxpMiDbyQRdfH0Aewtu2joU3JnCLx7ok5lAkI',1,1,13,'1510823345','1510823842'),(69,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMDgyNDM1N30.lLwADCYopWmBIG2xTR_zt-E6xm0rFJb27nglnw2MlYA',1,1,13,'1510824357','1510825357'),(70,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMDgyNjU4NX0.GV1Rz1II9zVX7QEo41i-SSm7lsBCYf8W6oDurvrdx4M',1,1,13,'1510826585','1510832264'),(71,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMDgzMzIzM30.83T2VkTYQmr9-LcrSZCIXzdmfsJiYmga3KG8q3lkJ3Y',1,1,13,'1510833233','1510833477'),(72,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMDgzNTY3Nn0.J-1s6YQBKwwpAAVVz-hyo2ITse78bEZPgk8RwyyN8Y4',1,1,13,'1510835676','1511078442'),(73,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMTA3ODQ0Mn0.EojzMUGIPulgX2AnnNFeQUqVVg00BjqoTOJOuK6zNF0',1,1,13,'1511078442','1511088897'),(74,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMTA4ODg5N30.Y8cJNwJA2jcwpOziMsbRE7Qpbxg8IquwH8HvO1_aWFg',1,1,13,'1511088897','1511090496'),(75,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMTA5MDg4MX0.jO_Cuy4LTnaGAvJLQLhtQRa0GPdal8ly3NW7QUUP5Wg',1,1,13,'1511090881','1511090912'),(76,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE5IiwiZW1haWwiOiJ0ZXN0YXNoQHRlc3QuY29tIiwibmFtZSI6IkFzaCIsImNyZWF0ZWRfYXQiOjE1MTEwOTEwODB9.yJRux8x6D5Zo5KU6Bcg2eu97MrBYLAdy1sLrYtsx2sI',1,1,19,'1511091080','1511170597'),(77,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEzIiwiZW1haWwiOiJhc2hyYWY2NTQzMjFAdGVzdC5jb20iLCJuYW1lIjoiYXNocmFmIiwiY3JlYXRlZF9hdCI6MTUxMTEwMzU4OH0.HUG2tqsWORIcOb-qEKGtVk7xpFMVk9-HM9DqgVx0fOk',0,1,13,'1511103588',NULL),(78,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjIwIiwiZW1haWwiOiJrYW56QHRlc3QuY29tIiwibmFtZSI6IkthbiIsImNyZWF0ZWRfYXQiOjE1MTExMTIwNTB9.7zouyB_DGhaocM0NODz-bOTcd9gqC8fL1h_GWgaFjuU',0,1,20,'1511112050',NULL),(79,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE5IiwiZW1haWwiOiJ0ZXN0YXNoQHRlc3QuY29tIiwibmFtZSI6IkFzaCIsImNyZWF0ZWRfYXQiOjE1MTExNzA1OTd9.fbcxfo9Sh02j0nEivwUdcZp5JeXxDfSHz3fB-lKypps',1,1,19,'1511170597','1511247904'),(80,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE5IiwiZW1haWwiOiJ0ZXN0YXNoQHRlc3QuY29tIiwibmFtZSI6IkFzaCIsImNyZWF0ZWRfYXQiOjE1MTEyNDc5MDV9.DNgOBzWOYdQ3dGYhhufBjVm61wcdFZdao2ODMbBNHUM',0,1,19,'1511247905',NULL),(81,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjIyIiwiZW1haWwiOiJhbXJhbGFhaXNtYWlsMzBAZ21haWwuY29tIiwibmFtZSI6ImFtcm8gYWxhYSIsImNyZWF0ZWRfYXQiOjE1MTIzMDk1MTB9.s7nkatdHQ9g1utmbd0wvZilz6NonZVZo2aVKPOXE7-I',1,1,22,'1512309510','1512313677'),(82,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjIyIiwiZW1haWwiOiJhbXJhbGFhaXNtYWlsMzBAZ21haWwuY29tIiwibmFtZSI6ImFtcm8gYWxhYSIsImNyZWF0ZWRfYXQiOjE1MTIzMTM4NDZ9.SWXFqkf1thvGFwGc-E028jLHxv45KMHa9H8o0pQwQi0',1,1,22,'1512313846','1512377598'),(83,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjIyIiwiZW1haWwiOiJhbXJhbGFhaXNtYWlsMzBAZ21haWwuY29tIiwibmFtZSI6ImFtcm8gYWxhYSIsImNyZWF0ZWRfYXQiOjE1MTIzNzc1OTh9.LtDu6pMLdrUsySfR2Y48oL_4M4JhL43yN2sShkkKbzM',1,1,22,'1512377598','1512383626'),(84,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjIyIiwiZW1haWwiOiJhbXJhbGFhaXNtYWlsMzBAZ21haWwuY29tIiwibmFtZSI6ImFtcm8gYWxhYSIsImNyZWF0ZWRfYXQiOjE1MTIzODM2NTB9.YD7w63-3-4IMNxmmaOLZY9TwJvyeFrrDoqBapP-sb4U',1,1,22,'1512383650','1512383698'),(85,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjIyIiwiZW1haWwiOiJhbXJhbGFhaXNtYWlsMzBAZ21haWwuY29tIiwibmFtZSI6ImFtcm8gYWxhYSIsImNyZWF0ZWRfYXQiOjE1MTIzODM3MTJ9.KkKoSgq17g5_1hcL_DLAWgK8M50rEd7VmT2jnge7_F4',1,1,22,'1512383712','1513088545'),(86,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxMjgzNzA3M30.cjwwOJ47hpP7KPIRpI65mnUuyTdXf3J8DQjTlgQGpKU',1,1,26,'1512837073','1512837286'),(87,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxMjgzNzI4Nn0.5KsFCdg-Im994fu75j_2La2bqyMNPhnIu3S3_DVkVIo',1,1,26,'1512837286','1512864407'),(88,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxMjg2NDQwN30.IpcOjNoZkWnvsYKjD1ZqLgeDikZaF4LwnI3c5eBYuOQ',1,1,26,'1512864407','1512864781'),(89,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxMjg2NDc4MX0.tphcYf5WnGu3qC8MuPhB6EQfWEoD_E1u6bpMnCVrSCc',1,1,26,'1512864781','1512945332'),(90,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxMjk0NTMzMn0.DCLP9NkirGXGpmz9JPr8zdasWUOOExC3x4D13yXwYhw',1,1,26,'1512945332','1512945333'),(91,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxMjk0NTM1M30.3UeKkcrfzuQMhnHdVVbYB0E8QWIm804uRLx5lYcrKhA',1,1,26,'1512945353','1512945415'),(92,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxMjk0NTQxNX0.Z3-lYStXbe1CCN_xv32El1r8ojjdgPtpW0nHUCpR_HA',1,1,26,'1512945415','1512945512'),(93,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxMjk0NTY5OX0.HvnuSODQdJeGhhHdf-m9OoAzty2tuP8o4mor5-sDZic',1,1,26,'1512945699','1512949523'),(94,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxMjk0OTUyM30.edJdjqqLL7WM-geyas6sZo1DO10z4beE_MjPhGVB94I',1,1,26,'1512949523','1512950080'),(95,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxMjk1MDEwNH0.RiPXretOiEx2LrVJfpbnfgVQHIYTR01Jp8vwGjrpEmE',1,1,26,'1512950104','1513787787'),(96,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjIyIiwiZW1haWwiOiJhbXJhbGFhaXNtYWlsMzBAZ21haWwuY29tIiwibmFtZSI6ImFtcm8gYWxhYSIsImNyZWF0ZWRfYXQiOjE1MTMwODg1NDV9.GpEz1akXS1qCSJ1tWi__lkyySxbdC0jgvVCjKzL8j5A',1,1,22,'1513088545','1515412535'),(97,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxMzc4Nzc4N30.CtTgL737bg3ikg2jFl2rRu2DmLGemVVSJSix3zxDfvQ',1,1,26,'1513787787','1513789499'),(98,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxMzc4OTQ5OX0.fMaVf9smvL4t7_kUPqA7tdOJgRFKYwpQa70V_psjy6w',1,1,26,'1513789499','1514206207'),(99,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDIwNjIwOH0.qjBVDjbFOcJ7kqEh-zSXeq1-g_2ZH0IXHWPDlKObF4Q',1,1,26,'1514206208','1514206225'),(100,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDIwNjIyNX0.BzalaU3PLlN52mA3ZT4sNwVoY69dzmzqgi4OcIMg2oY',1,1,26,'1514206225','1514216255'),(101,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDIxNjI1Nn0.OB1-IP3osb87KyimlFJcIGP7qnL0fWq_w-coYm3KInE',1,1,26,'1514216256','1514280302'),(102,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDI4MDMwNH0.H0Gkb0Z5EMX6BnAFf8HFKelt1OPwbRuH3RaDSPv3aQQ',1,1,26,'1514280304','1514289248'),(103,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDI4OTI0OH0.baUPxE9D7R7U76OUi9w8wO6VmK4hR__mAkDAu2hvXsg',1,1,26,'1514289248','1514460266'),(104,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDM4MzI3OH0.5x-eS38Et0F_FrKyE6fiUm3SLVoADpmA-xbOPVvSa_E',1,1,31,'1514383278','1514383341'),(105,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MDQ3MX0.g61oLvT6mG0ERYLXEWd6FF8C_3TryDZc2ltLD7l4704',1,1,26,'1514460471','1514461886'),(106,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MTg4N30.Bgf3GeF3xXCIr7iKnlVnAD1BhlUVy6XiOxUnkm2SBP0',1,1,26,'1514461887','1514462037'),(107,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MjIyNn0.hbFuDjqB_sLCj-dB3eNEsBeYvB5I-l3DfySSh4gxwxI',1,1,31,'1514462226','1514462231'),(108,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MjIzMX0.KQg6XkI3XO3zD5HnqbswFAhCCie9N_S5o_ljh7jISYw',1,1,31,'1514462231','1514462257'),(109,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MjI3Nn0.BmU9_bGRBICDwPLOqXEn4XMXAm_nntX10l3JjkZhwh4',1,1,31,'1514462276','1514462291'),(110,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MjI4NX0.ev3-a3NA-Wyut5oyhlm_f0g8T6ayTZK0pAXQjg7t8ss',1,1,26,'1514462285','1514463828'),(111,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MjI5MX0.Qs9_wCThc7-p_utAX7b2yCLV8xZWEHkSrQCT9fE4vCE',1,1,31,'1514462291','1514462310'),(112,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MjMxMH0.IS8Pl3jkIv6emwTP6uVMHY5QqMkGHy6kaniba4mlJHU',1,1,31,'1514462310','1514462319'),(113,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MjMxOX0.PdrFNAYjMAeNIKQcX6J0lZDbLbwcTslUso1GXpgp1AY',1,1,31,'1514462319','1514462363'),(114,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MjM2M30.WvXhDUk8K0F_q3mwYlBCYS6MPG5dIm-ogHLxQakLheg',1,1,31,'1514462363','1514462420'),(115,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MjQyMH0.KbUUp8xjAdIJbvphnzKJII5XTWuIvsDS8btwsoUsZRc',1,1,31,'1514462420','1514462563'),(116,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MjU2M30.WS0Pz3muN17Mbq5DRWxBoV1oypGnnoiBQVvoj33MkWQ',1,1,31,'1514462563','1514462626'),(117,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MjYyNn0.Q8ucRHNkjVnuuiYQVQdbOdmjpxxSqg6bOOni6N3-moo',1,1,31,'1514462626','1514462644'),(118,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MjY0NH0.BoDTQ1W1zzBlJOTAL48ym2QmEXCwMZHlTr8jvmTouIE',1,1,31,'1514462644','1514462809'),(119,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MjgwOX0.eoykrc8fQ-THeVuREvghYao7BHT7LwJxiDXW4jPIEYo',1,1,31,'1514462809','1514462856'),(120,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2Mjg1N30.QqbwLQii-wUn8DLZGbqrExAJftfBsAqs_Epu8K661zg',1,1,31,'1514462857','1514462881'),(121,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2Mjg4MX0.Ty4C5NP9Xfy7olSCiLUidpvsJFXoHn7pW0MN9Ehf25U',1,1,31,'1514462881','1514462944'),(122,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2Mjk0NH0.l_k22rWAHgC6YwPJ0B7iMa3JLKiLD_8RwvgrIg73nmU',1,1,31,'1514462944','1514462994'),(123,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2Mjk5NH0.QG2FEjl9q4_cKU_vjcA2nh5gLmSEV1F6FXmzhzY4DrM',1,1,31,'1514462994','1514464009'),(124,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MzgyOH0.xFJVlTgALkSjfktU14qjLuu1gJ6Sr7eXz61R1VFFH3o',1,1,26,'1514463828','1514463835'),(125,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDQ2MzgzNX0.UO2rRF0sgOtKwduVVQQlJ6m9iDo8DshTwJtjrtsGl_w',1,1,26,'1514463835','1514974394'),(126,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2NDAwOX0.GXyWTw-eL5sHE-df96ruJSo-VmlQZtCu4ObIRDzYIUA',1,1,31,'1514464009','1514464033'),(127,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2NDAzM30.Tv8TQicZkfdoui5DUjpCkzQYvCan8O8kNLV0Wb6VOj0',1,1,31,'1514464033','1514464433'),(128,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNDQ2NDQzM30.rigeCpha36Ijm-nWuHuhyjzR1xDe6mqUo1TFUXoNEm8',1,1,31,'1514464433','1515501588'),(129,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDk3NDM5NX0.IKdWdvmKGwYC20JOsp3c5caBwpDIiwMp-WSojKHRV2I',1,1,26,'1514974395','1514976045'),(130,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDk3NjA0NX0.wc0FPPipqU6Lc6cBdG8yEPf6w2N1ETR7fDU6-o47Cug',1,1,26,'1514976045','1514980505'),(131,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDk4MTY2M30.xvzIBcRzZuWUC9fvIpUZgNtEOFN4yQp09pmZo1pHKRw',1,1,26,'1514981663','1514982332'),(132,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDk4MjMzMn0.c4Xv1bq5NpPfGP1Acfh_t2-I0sVxeAdDWR3eIWrFYN8',1,1,26,'1514982332','1514982354'),(133,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDk4MjM1NX0.8i6Je1VWHmTE2OW9ZPFd1RbRvaLiOEsxmz0OZFl0Ss8',1,1,26,'1514982355','1514989517'),(134,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDk4OTUxOH0.kM4BDTtQxiWZS9aJt7Rn0u2C8R3AIZq5uHktw5waM9A',1,1,26,'1514989518','1514993586'),(135,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDk5MzU4Nn0.6w4zCanDtkD1CWNxQsErJmxNzBKXi1ykXBXECmSI3iY',1,1,26,'1514993586','1514993957'),(136,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNDk5Mzk1N30.o12tt2D_MGxg2PibUUcortEDD-7ZfLh8E4tWPrtflX8',1,1,26,'1514993957','1515161987'),(137,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNTE2MTk4N30.8g-zhAUOmgbxSJJ56jqE7jjk1X84x5J0c4Krjx8HGnM',1,1,26,'1515161987','1515162680'),(138,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNTE2MjY4MX0.eq3rouayfe200DC1viJ0JYaWFpMSJkaRfnKvBfIBGtM',1,1,26,'1515162681','1515166630'),(139,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNTE2NjYzMX0.07XWQXx-uKyqoOgNFcPX8zEqahjxlbKRS9GyYyMYLMI',1,1,26,'1515166631','1515578373'),(140,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjIyIiwiZW1haWwiOiJhbXJhbGFhaXNtYWlsMzBAZ21haWwuY29tIiwibmFtZSI6ImFtcm8gYWxhYSIsImNyZWF0ZWRfYXQiOjE1MTU0MTI1MzZ9.FzFMjs1VHBxblJKimEJnLpqcZw0Ue04FXqEKJkxXNVs',0,1,22,'1515412536',NULL),(141,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNTUwMTU4OH0.LIJx_uU5-gcpIZYZ-jdpSnadq-SmuZ89kvh1dDZ4Jdg',1,1,31,'1515501588','1516021751'),(142,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNTU3ODM3M30.pH2hQFWkO7ZBR10_DapKMaqpirFWDOEk0cacjNLgrtc',1,1,26,'1515578373','1515578518'),(143,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNTU3ODUxOH0.fswPruIqe2XNHbDAIY8NLS0boEL2DynpK4zRaHUNalc',1,1,26,'1515578518','1515578528'),(144,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNTU3ODUyOH0.OzepOKdPS7nvyFPEGgwqTkCjhv4XOUEykmo1MqV5AMw',1,1,26,'1515578528','1515578536'),(145,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNTU3ODUzNn0.-KOuK9Y9Mp9lvT5RsaAwoy3xYEgkhvjJ0DrBOT1zzcU',1,1,26,'1515578536','1515580227'),(146,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNTU4MDIyOH0.BkJ0457nToRFp9-nZPoQIU6TRLhEzjhDnVdM59jhsx8',1,1,26,'1515580228','1515590633'),(147,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNTU5MDYzM30.gpaX9NIpiuwog-ZnP8-QYvVumLeCjeo7cvSlKsDY2rY',1,1,26,'1515590633','1515590685'),(148,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNTU5MDY4NX0.nbPI5B9zQHjOBpBnJB7PegQulueBTC02OkHBf2WSf7M',1,1,26,'1515590685','1515590692'),(149,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNTU5MDY5Mn0.EQv7eS5aqx7_sxiFnqZJU-yDbXjwHD2Juo6ftaTWX7A',1,1,26,'1515590692','1515591532'),(150,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNTU5MTUzMn0.ieWMbqPWLktZJAqZykRGWN2viQEhk5EE-1k1-HKg4b0',1,1,26,'1515591532','1515591554'),(151,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI2IiwiZW1haWwiOiJ0ZWVlZWVlZWVlZWVAdGVzdC5jb20iLCJuYW1lIjoidGVlZWVlZWVlZWVlIiwiY3JlYXRlZF9hdCI6MTUxNTU5MTU1NX0.9bWI5QKhHe570e1E6ABhA3MdcynpIXSmjg-xt1HSEEI',0,1,26,'1515591555',NULL),(152,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNjAyMTc1MX0.PTJxX04nxKL_w97KNqXltoGt2WeWwml28M6eIyZquoY',1,1,31,'1516021751','1516021775'),(153,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM3IiwiZW1haWwiOiJ0ZXN0QHRlc3QuY29tIiwibmFtZSI6InRlc3QiLCJjcmVhdGVkX2F0IjoxNTE2MDIxNzk0fQ.kFN2l-0TFl183p_6VEq859JwJ3WL-JoKrSyrRDPadY0',1,1,37,'1516021794','1516021799'),(154,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM4IiwiZW1haWwiOiJsb2dpbkB0ZXN0LmNvbSIsIm5hbWUiOiJsb2dpbiB0ZXN0IiwiY3JlYXRlZF9hdCI6MTUxNjAyMTg2Nn0.j2RgcQAfl7nA-JYL572eEmNdjMDMoqNQMaKDv-ZG8u4',0,1,38,'1516021866',NULL),(155,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNjExMTgzMH0.9Q2oW3q3A_CoKZyqZY-skZkgh7R5lnHPyblYCYPbgYI',1,1,31,'1516111830','1517226113'),(156,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM5IiwiZW1haWwiOiJrYW5kYWZAeWFob28ub3YiLCJuYW1lIjoia2FuZGFmIiwiY3JlYXRlZF9hdCI6MTUxNjI4MzgxOH0.DpITit4IM_pwZskCHHTk1gLUN1Sf3y9_p1hklhbRQjo',1,1,39,'1516283818','1517259740'),(157,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImFkbWluQGFkbWluLmNvbSIsIm5hbWUiOiJhZG1pbiIsImNyZWF0ZWRfYXQiOjE1MTY0NTkyMjB9.weRkNVxweTNDSa6wIcP0UOGYAdWKMwOvpRmwk6V8lCg',0,1,1,'1516459220',NULL),(158,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE2Nzg5NzM1fQ.Z43JURG3wnNr0bNkPWs9DoDxdwDY_ZYqTHxgKbeAy8w',1,1,43,'1516789735','1516791583'),(159,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE2NzkxNTgzfQ._qi5P8CFJQFq_iDlb7-b7wT0CB8HqujKm7uDqsgCmzM',1,1,43,'1516791583','1516794206'),(160,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE2Nzk0MjA2fQ.SewdTgNFTGJE7zhNMaLYAgiGsGbkhbbeAgnqBrRWoBo',1,1,43,'1516794206','1516794321'),(161,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE2Nzk0MzIxfQ.BNzUKNIjO6g29dX4L06bLcWPw4Ub2pSKb6q7PzZYlRM',1,1,43,'1516794321','1516794738'),(162,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE2Nzk0NzM4fQ.J0ROapL70MlFhrO6Yn8Ym1rtbVS2xlqm_x-PFDOdUzQ',1,1,43,'1516794738','1516794928'),(163,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE2Nzk0OTI4fQ.mJ1IoiBkZQzsDk-4pxvkiaLTNR-ZWVkvsbTPIrAOg2c',1,1,43,'1516794928','1516795537'),(164,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE2Nzk1NTM3fQ.D86RP-QLxMVge_DFD9T6QCzNlHoDr6zX1Kp3AHl0mKQ',1,1,43,'1516795537','1516797165'),(165,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE2Nzk3MTY1fQ.kTws4KHe1p3AWpKKseWVXoeZXqzGuzvMucXrNR6GuXM',1,1,43,'1516797165','1516797455'),(166,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE2Nzk3NDU1fQ.FFb_nvqJihb-qrvsQ5wNRMdCsPSi_zu7j96OhC9Fz3E',1,1,43,'1516797455','1516798384'),(167,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE2Nzk4Mzg0fQ.OWIpz83st0FC34KTtMzlpipqdubS8XYnI3VC3LNqlTk',1,1,43,'1516798384','1516798429'),(168,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE2Nzk4NDI5fQ.Cnmaj5LFFxLIFt1XEoQUoTIg2-8e1X5hgri2lxnZ1a0',1,1,43,'1516798429','1516798640'),(169,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE2Nzk4NjQwfQ.aRPKm3TGLET1DjItoZ3PdR086zg_1JA1WxL0Fba9Wng',1,1,43,'1516798640','1516798945'),(170,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE2Nzk4OTQ1fQ.2F_1vxt6dlzb3kq6Zc3akQWoTIrhohyx4TZQfcbkH48',1,1,43,'1516798945','1516801820'),(171,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE2ODAxODIwfQ.A3UdoJH8khxiigS_uS02Ozq-AdCO8hnBmKrT2nLPqig',1,1,43,'1516801820','1516806905'),(172,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE2ODA2OTA1fQ.qbVI1yA1TT5aOfHAA5NRmKUrndi7LThk3iycQ-7onRI',1,1,43,'1516806905','1517007132'),(173,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ik5hcmltYW4iLCJjcmVhdGVkX2F0IjoxNTE3MDA3MTMyfQ.DbS3B8I6cNqe7fDgMetg9pLXH96tFVST2qv0feQPWHg',1,1,43,'1517007132','1517255629'),(174,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNzIyNjExM30.XpglnPUnsJx2v1KePqqI2NNaz-AAoJ2Fzl-dbwL4_Sg',1,1,31,'1517226113','1517320037'),(175,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYiLCJjcmVhdGVkX2F0IjoxNTE3MjU1NjI5fQ.FTKl-YiiqZ9pCdo5PYtiiNJiWTRso5xiavZ',1,1,43,'1517255629','1517256062'),(176,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYiLCJjcmVhdGVkX2F0IjoxNTE3MjU2MDYyfQ.jczGyzmjweY6nnqNx7Os9CaIR3Z6oHKnIdx',1,1,43,'1517256062','1517316416'),(177,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM5IiwiZW1haWwiOiJrYW5kYWZAeWFob28ub3YiLCJuYW1lIjoia2FuZGFmIiwiY3JlYXRlZF9hdCI6MTUxNzI1OTc0MH0.OElnlRTI6EMh_K8gI3u16ue2tyFiPnb_fgfYV7R0tUU',1,1,39,'1517259740','1517260171'),(178,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM5IiwiZW1haWwiOiJrYW5kYWZAeWFob28ub3YiLCJuYW1lIjoia2FuZGFmIiwiY3JlYXRlZF9hdCI6MTUxNzI2MDE3MX0.IfIk2CSdbeHJpS-G2L4bWtlqe5qGTiGwXaobGsMSJ-A',0,1,39,'1517260171',NULL),(179,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYgIiwiY3JlYXRlZF9hdCI6MTUxNzMxNjQxNn0.Q25esnFzHHzWPUfhlmjCdJgSjLE_IuI-4p',1,1,43,'1517316416','1517317933'),(180,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYgIiwiY3JlYXRlZF9hdCI6MTUxNzMxNzkzM30.fj6FF9bZi864lWFzp9fCzcWm8-zGOI_icw',1,1,43,'1517317933','1517318467'),(181,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYgIiwiY3JlYXRlZF9hdCI6MTUxNzMxODQ2N30.3wUfKCw-88mSYF-srWg4BtVQ3AzIiT1CzL',1,1,43,'1517318467','1517318528'),(182,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYgIiwiY3JlYXRlZF9hdCI6MTUxNzMxODUyOH0.wC1dg9IJnsfpDuZe3nKGQVb2rOupikqEip',1,1,43,'1517318528','1517318591'),(183,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYgIiwiY3JlYXRlZF9hdCI6MTUxNzMxODU5MX0.rPZ8hx3cseo68UVTqaxMzXQNA4bDKXD1yu',1,1,43,'1517318591','1517318816'),(184,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYgIiwiY3JlYXRlZF9hdCI6MTUxNzMxODgxNn0.BspvY_dyVKlC3L1YyZBj8VORK3_EIOwO-_',1,1,43,'1517318816','1517322654'),(185,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNzMyMDAzN30.LRp9PpDPzCMYjmkp982KbqVctpM7cFaFm_GJRZzFZwM',1,1,31,'1517320037','1517409230'),(186,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYgIiwiY3JlYXRlZF9hdCI6MTUxNzMyMjY1NH0.rGyI9sZbTIowpJmPbX8qZu_E1xLNFx4kt0',1,1,43,'1517322654','1517322866'),(187,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYgIiwiY3JlYXRlZF9hdCI6MTUxNzMyMjg2Nn0.Mv0WBxjOtD71DPEYRKOdFaYC35s8Qihg_P',1,1,43,'1517322866','1517323085'),(188,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYgIiwiY3JlYXRlZF9hdCI6MTUxNzMyMzA4NX0.uCNCHpAm36Z4QYCHTib9cc-ofEf2-N6ZYi',1,1,43,'1517323085','1517323300'),(189,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYgIiwiY3JlYXRlZF9hdCI6MTUxNzMyMzMwMH0.Mew6CApErmGi1R0CmC5lyNgDixye2P7crk',1,1,43,'1517323300','1517323701'),(190,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYgIiwiY3JlYXRlZF9hdCI6MTUxNzMyMzcwMX0.LJlcePXTuT4zzQIBWKcRaRwq49gsgbec7U',1,1,43,'1517323701','1517325697'),(191,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYgIiwiY3JlYXRlZF9hdCI6MTUxNzMyNTY5N30.6CUbGkZrvD5H6xIAcAo7ig0hmOxBUsJjjG',1,1,43,'1517325697','1517399916'),(192,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYgIiwiY3JlYXRlZF9hdCI6MTUxNzM5OTkxNn0.be8NppgVW3qQ8P1SR6TTolVq0TCO6vZFXg',1,1,43,'1517399916','1517399988'),(193,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYgIiwiY3JlYXRlZF9hdCI6MTUxNzM5OTk4OH0.b0_GnjBVeNu7UZtY3IO7UntWPoHbE1HFR7',1,1,43,'1517399988','1517400530'),(194,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQzIiwiZW1haWwiOiJOYW5hQG1haWwuY29tIiwibmFtZSI6Ilx1MDY0Nlx1MDYyN1x1MDYzMVx1MDY0YVx1MDY0NVx1MDYyN1x1MDY0NiBcdTA2MmVcdTA2MjdcdTA2NDRcdTA2MmYgIiwiY3JlYXRlZF9hdCI6MTUxNzQwMDUzMH0.t4oZsUvDINt98-OWjYi5zDcBGboDJxoaJy',0,1,43,'1517400530',NULL),(195,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMxIiwiZW1haWwiOiJhc2hyYWZoZXNoYW0xOTkyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNzQwOTIzMH0.gIAn673_U98hmqbbqDDsAYe8X425GPGJxolzd5Yi0C8',0,1,31,'1517409230',NULL),(196,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQ1IiwiZW1haWwiOiJhc2hyYWYuYXNocmFmQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNzQwOTY1MX0.PGaxfyQoUfhWNN7EZZMzbFm3fJjuOw9rajJ9ayERz2M',1,1,45,'1517409651','1517409713'),(197,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQ1IiwiZW1haWwiOiJhc2hyYWYuYXNocmFmQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2hyYWYgSGVzaGFtIiwiY3JlYXRlZF9hdCI6MTUxNzQwOTcxM30.3ojbG3iJyUx0EYJJAmiIaJzCatG7lBPeTsVNsmHHf70',1,1,45,'1517409713','1517410395'),(198,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQ2IiwiZW1haWwiOiJrYW5kYWZAZ21haWwuY29tIiwibmFtZSI6IkthbmR5IiwiY3JlYXRlZF9hdCI6MTUxNzQ3NTMyNn0.tuMk0osAgPiG3UAJAkxJRBdqVjUq6nbAF_2RDnJXfcg',0,1,46,'1517475326',NULL),(199,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQ3IiwiZW1haWwiOiJNZXpvQG1haWwuY29tIiwibmFtZSI6Ik1hemVuIGhhbnkiLCJjcmVhdGVkX2F0IjoxNTE3NzQ5NzMxfQ.iBGZMYbLqGq8haraM3v-ujxY9hmkdhgtf_iQb0oWkC8',1,1,47,'1517749731','1517749965'),(200,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQ3IiwiZW1haWwiOiJNZXpvQG1haWwuY29tIiwibmFtZSI6Ik1hemVuIGhhbnkiLCJjcmVhdGVkX2F0IjoxNTE3NzQ5OTY1fQ.1U1yBeAO1IOoKgVcSysb2fdfbnIDLrCsiO95-BEdY-8',1,1,47,'1517749965','1517750897'),(201,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQ3IiwiZW1haWwiOiJNZXpvQG1haWwuY29tIiwibmFtZSI6Ik1hemVuIGhhbnkiLCJjcmVhdGVkX2F0IjoxNTE3NzUwODk3fQ.Oi2ZixPJfnoSaL8wfjLasmD2iXt1RuTJfEcmeodn8gI',1,1,47,'1517750897','1517751815'),(202,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQ3IiwiZW1haWwiOiJNZXpvQG1haWwuY29tIiwibmFtZSI6Ik1hemVuIGhhbnkgbWFobW91ZCIsImNyZWF0ZWRfYXQiOjE1MTc3NTE4MTV9.u-GSIjRyik7ZrlKjjYMgYcdROu-kocoS1f-97bFOdSA',1,1,47,'1517751815','1517752096'),(203,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQ3IiwiZW1haWwiOiJNZXpvQG1haWwuY29tIiwibmFtZSI6Ik1hemVuIGhhbnkgbWFobW91ZCIsImNyZWF0ZWRfYXQiOjE1MTc3NTIwOTZ9.MLD1OqQ2W0m052Cp_f9M4i2aYiz7D-59CZeHQugr21s',1,1,47,'1517752096','1517753350'),(204,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQ3IiwiZW1haWwiOiJNZXpvQG1haWwuY29tIiwibmFtZSI6Ik1hemVuIGhhbnkgbWFobW91ZCIsImNyZWF0ZWRfYXQiOjE1MTc3NTMzNTB9.zL9WsdAPNLD1BxDjj-BJ_6PIG-eDTpfOFML7SV2Vya4',1,1,47,'1517753350','1517754025'),(205,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQ3IiwiZW1haWwiOiJNZXpvQG1haWwuY29tIiwibmFtZSI6Ik1hemVuIGhhbnkgbWFobW91ZCIsImNyZWF0ZWRfYXQiOjE1MTc3NTQwMjV9.Evy52cE4RHjnQtntPqAjqjOFAhau0p1mrFSuQus_fJU',1,1,47,'1517754025','1517827326'),(206,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQ3IiwiZW1haWwiOiJNZXpvQG1haWwuY29tIiwibmFtZSI6Ik1hemVuIGhhbnkgbWFobW91ZCIsImNyZWF0ZWRfYXQiOjE1MTc4MjczMjZ9.yOs9xE5AAcIcHFgeJLgvXSDy8wi6oiwtSX4ttB4_tug',1,1,47,'1517827326','1517827439'),(207,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQ3IiwiZW1haWwiOiJNZXpvQG1haWwuY29tIiwibmFtZSI6Ik1hemVuIGhhbnkgbWFobW91ZCIsImNyZWF0ZWRfYXQiOjE1MTc4Mjc0Mzl9.U-SAmHNvO_w515wKeQCfk6iRv5phIKAYGRiHXmi-nI8',0,1,47,'1517827439',NULL);
/*!40000 ALTER TABLE `user_module_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_notifications`
--

DROP TABLE IF EXISTS `user_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_notifications` (
  `user_id` int(11) NOT NULL,
  `notification_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_notifications`
--

LOCK TABLES `user_notifications` WRITE;
/*!40000 ALTER TABLE `user_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tags`
--

DROP TABLE IF EXISTS `user_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tags`
--

LOCK TABLES `user_tags` WRITE;
/*!40000 ALTER TABLE `user_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_types`
--

DROP TABLE IF EXISTS `user_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_types`
--

LOCK TABLES `user_types` WRITE;
/*!40000 ALTER TABLE `user_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `user` varchar(100) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `pass` varchar(500) DEFAULT NULL,
  `img` varchar(100) DEFAULT NULL,
  `gender` tinyint(1) NOT NULL DEFAULT '0',
  `access_token` varchar(255) DEFAULT NULL,
  `social_avatar` varchar(255) DEFAULT NULL,
  `login_type` int(11) DEFAULT NULL COMMENT 'holds value from user_module_login_types table',
  `mail` varchar(255) NOT NULL,
  `city_id` int(4) NOT NULL DEFAULT '0',
  `social_id` varchar(150) DEFAULT NULL,
  `social_type` varchar(20) DEFAULT NULL,
  `join_date` varchar(50) NOT NULL DEFAULT '1446633835',
  `application_id` int(10) NOT NULL,
  `module_id` int(10) NOT NULL,
  `active` enum('1','0') NOT NULL DEFAULT '1',
  `type` int(4) DEFAULT '0',
  `is_admin` tinyint(4) NOT NULL DEFAULT '0',
  `token_id` int(11) DEFAULT NULL,
  `confirm_code` varchar(255) DEFAULT NULL,
  `confirm_code_expired` tinyint(1) DEFAULT NULL,
  `device_token` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Administrator','admin','021548754','$2y$08$OVdYYWJpOU1ScUYrV1ZvN.HuJeXGxYMI8h4oVH7zCIrITIPfrOz/2','15172403378QrUOH3SJ6ip1oSV.jpg',0,'','',0,'admin@tanks.com',0,'','','1508082508',1,20002,'1',0,1,157,'by6BgKmjC1',0,NULL,NULL),(7,'ashrof123@gmail.com','ashrof123@gmail.com','01122336688','$2y$08$NEZiMGxOV2hpWnRUVVBjLuv4e0JGEk7p3ZVBeUs.vOM48Vts4bRG6','',0,'','',1,'ashrof123@gmail.com',0,'0','','1508964817',1,20002,'1',0,0,10,'5t4wtkD1G',0,'asdfgh1232;lnsadn',NULL),(9,'Ashraf Hesham','ashrafhesham92','01133665522','$2y$08$UVQ2Y3FKeFhPcXJCdmdNN.Jx5eIziyHfUp.bQUwADvg1MCC/Nl51a','',0,'','',1,'ashrafhesham92@gmail.com',0,'0','','1509364207',1,20002,'1',0,0,21,'B551ackrd',0,'asdfgh1232;lnsadn',NULL),(11,'Salma','salmaomario','01227775312','$2y$08$UXJkb3NYYXcvNFIvektSaeeJ1z6aJRKh96GkaniLc5mR5/qGI4s0.','',0,'','',1,'salmaomario@yahoo.com',0,'0','','1509531525',1,20002,'1',0,0,57,'Y10lz1f1sE',0,'asdfgh1232;lnsadn',NULL),(12,'abdelrahman','a','01150411110','$2y$08$b1JMdkE3M0VPTEVOQ2RIZ.pBgZQDh9BfxWqTEaaJq7RQZ8xxxncdy','',0,'','',1,'abdelrahman.eljazzar@gmail.com',0,'0','','1509795865',1,20002,'1',0,0,51,'X31mO3L9xO',0,'asdfgh1232;lnsadn',NULL),(13,'ashraf','ashraf654321','01133333333','$2y$08$M3BjaHNVY0lLdnBoSTZIZemVsvyIshiiAvRDcqiBYkNbXoPS4FtM.','',0,'','',1,'ashraf654321@test.com',0,'0','','1509798949',1,20002,'1',0,0,77,'0X1419311n',0,'asdfgh1232;lnsadn',NULL),(14,'TestUser123','testuser123','01123456677','$2y$08$Tms2Z2tERVh4NHlWS1gvee88MsL9pcMo3.4Y6seDlUf96k3sllOte','',0,'','',1,'testuser@test.com',0,'0','','1510433580',1,20002,'0',0,0,NULL,NULL,NULL,'asdfgh1232;lnsadn',NULL),(16,'newuser','newuser','0111','$2y$08$OVFXY0FlRVViajYvWTBpQeBELHnlhELcH0iHDj/lPwwjxe7ZzcYCG','',0,'','',1,'new@mail.com',0,'0','','1510436223',1,20002,'0',0,0,NULL,NULL,NULL,'asdfgh1232;lnsadn',NULL),(17,'Sherif','testSherif','01090878494','$2y$08$czhoS0t4cFRuQzVQTXhOUeIZQD0qTW8AEzO7DM5PHKuUNC0xFXUMW','',0,'','',1,'sherif.alaa55@gmail.com',0,'0','','1510657597',1,20002,'0',0,0,NULL,NULL,NULL,'asdfgh1232;lnsadn',NULL),(18,'TestUser123','aboulfotoh','0123456789','$2y$08$U2o0cUR1UHhCYnI0YlVJOOGD.UxGglxj18/ICoMUFb6GIAyqo158y','',0,'','',1,'aboulfotoh@test.com',0,'0','','1511087368',1,20002,'0',0,0,NULL,NULL,NULL,'asdfgh1232;lnsadn',NULL),(19,'Ash','testAsh','01177778899','$2y$08$VFNpTVhnWEo0ZENTbmhBV.1MK4N2bSOcGYRJBdhblbxVNdsj7ou8y','',0,'','',1,'testash@test.com',0,'0','','1511091018',1,20002,'1',0,0,80,'Y0ZFTqi2Nf',0,'asdfgh1232;lnsadn',NULL),(20,'Kanz profile update','kanzi','0987654321','$2y$08$L05LRUFMTC82dDByUXFnReTtgBwC942r3FZJp1KAVAQNNk653hc7i','',0,'','',1,'kanz@tap.com',0,'0','','1511111161',1,20002,'1',0,0,78,'RBaGwGPe50',0,'asdfgh1232;lnsadn',NULL),(21,'amr alaa','amr','01000007355','$2y$08$ZHgyQTlReDZHY3FLeWprR.neRw2mrbrc9ZvjkrrMtu/vAPvcti2gG','',0,'','',1,'amr.alaa@pentavalue.com',0,'0','','1512216831',1,20002,'0',0,0,NULL,NULL,NULL,'asdfgh1232;lnsadn',NULL),(22,'amro alaa','amro','01000005066','$2y$08$Y2xtZ2FRZmpaWjdxckRuZ.YzpGybERDl2duOYT8V/eLS1C/FpTF7i','',0,'','',1,'amralaaismail30@gmail.com',0,'0','','1512298338',1,20002,'1',0,0,140,'eT1Jc143i1',0,'asdfgh1232;lnsadn',NULL),(23,'Kan','kanzzzi','01553322','$2y$08$dUs4eElvd3VFSVh1Wm4yTehIkhDaPXkGU3CpCM.4Ewzp8uui2GqP2','',0,'','',1,'kanzzz@test.com',0,'0','','1512422361',1,20002,'0',0,0,NULL,NULL,NULL,'asdfgh1232;lnsadn',NULL),(24,'Kan','kanzxxi','01553322x','$2y$08$R2dOQlVtNDlQUHhVQzBQNOFGxYvxNBrOaWEauVhRWGLnWXPi.o8VK','',0,'','',1,'kanzzxxz@test.com',0,'0','','1512424015',1,20002,'0',0,0,NULL,NULL,NULL,'asdfgh1232;lnsadn',NULL),(25,'wael salah','shhdjakw','04783291883','$2y$08$UFNFSVVsZjMwU3dXdlJjMuC1u8IF1gXaoEiLsC./51oUEjOLME4F2','',0,'','',1,'wael.fci@gmail.com',0,'0','','1512504168',1,20002,'0',0,0,NULL,NULL,NULL,'asdfgh1232;lnsadn',NULL),(26,'teeeeeeeeeee','teeeeeeeeeee','888888','$2y$08$VUppNSt4elNPZi9VeXQwYupqv8WUANNOeV5nI/kXNvgI0TxYXk2uq','',0,'','',1,'teeeeeeeeeee@test.com',0,'0','','1512589051',1,20002,'1',0,0,151,'lA14xz1CVW',0,'asdfgh1232;lnsadn',NULL),(27,'MinaSamir','monmonfasfos','23658978','$2y$08$RmE2S0MrTG5vZDc3SVVUcOAvlUuU21h2hvLYRHWccb4tojKLnSCye','',0,'','',1,'mina@min.com',0,'0','','1512607832',1,20002,'0',0,0,NULL,NULL,NULL,'fsdaklfhjkad',NULL),(28,'wael salah','asdfox','04588239394','$2y$08$RFoxbEJKN2UxVDJwNkxNVOT8WQ9DsNmz1udzNIFXT38xd36fQI6Be','',0,'','',1,'asdfox@hotmail.com',0,'0','','1512724873',1,20002,'0',0,0,NULL,NULL,NULL,'asdfgh1232;lnsadn',NULL),(29,'teeeeee','teeeeeee','8887888','$2y$08$Q2dhUG52WHYwVTJ4aTg3e.GaQw3f7yZNP16ZTjffDZlfrkJAvMYwi','',0,'','',1,'teeeeee@test.com',0,'0','','1512833737',1,20002,'0',0,0,NULL,NULL,NULL,'asdfgh1232;lnsadn',NULL),(30,'minasamir','minasamir','369369369','$2y$08$TGxxOUkxU1RNSkNXQ296UuX3RdvfBoO/iQ7nHi19IvxE0FqIdskVC','',0,'','',1,'minasamir@minasamir.com',0,'0','','1512864744',1,20002,'0',0,0,NULL,NULL,NULL,'asdfgh1232;lnsadn',NULL),(31,'Ashraf Hesham','Ash','01111220000','$2y$08$TSthUkRhRm5LTy9GSUUxa.k6m7ROkI3ZXRVa/zEJrhR.7Lkujzpue','',0,'','',1,'ashrafhesham1992@gmail.com',0,'0','','1514383173',1,20002,'1',0,0,195,'b1F1LL4bON',0,'asdfgh1232;lnsadn',NULL),(34,'Salma Omar',NULL,'01128678877','$2y$08$ZUtNLzB4dmREY0xVLzhHdOjpLXjERnOM1MCvO0vx65raKemBv1aSi',NULL,0,NULL,NULL,NULL,'salmaomario@yahoo.com',0,NULL,NULL,'1446633835',1,20002,'1',0,0,NULL,NULL,NULL,NULL,10),(35,'Ashraf',NULL,'012563154','$2y$08$RTV4SHZqZ0xqVm52STloN.OjgEo4OJF0ZZfyaYvjVJZImLN/PtSc2',NULL,0,NULL,NULL,NULL,'ashrafhesham1992@gmail.com',0,NULL,NULL,'1446633835',1,20002,'1',0,0,NULL,NULL,NULL,NULL,2),(37,'test',NULL,'01111220000','$2y$08$MUszMmV2cTdFOE5Jdjg3UOOPlPcYz/zJEr8MOsAbhHdtf0UoUPemy',NULL,0,NULL,NULL,NULL,'test@test.com',0,NULL,NULL,'1446633835',1,20002,'1',0,0,153,'I1wX18Tw6F',0,NULL,9),(39,'kandaf',NULL,'02154623016','$2y$08$WG9XVWxtcmZUK0MzZm9Hee0t8mPPNG4VkR0t7VrWDs73b9FI0/7Na',NULL,0,NULL,NULL,NULL,'kandaf@yahoo.ov',0,NULL,NULL,'1446633835',1,20002,'1',0,0,178,'s39VGP1A0O',0,NULL,1),(40,'Nvm','N','01012345678','$2y$08$S2xPL3ZYU2tEK1MyOUVPNeI3nlggOTRlL9ksthxnmT5wo7dKQyUJy','',0,'','',1,'Nn@mail.com',0,'0','','1516715176',1,20002,'0',0,0,NULL,NULL,NULL,'96824f1f08bb7a95f18ef80312ca9cef808da1a1008ceea63ce9d1a3c0d98c74',NULL),(41,'He','Hehe','01012345677','$2y$08$U21IRnFxNXBFNWZ5dFNOUelhhU1MNTjUnl2pBTVei3OX4efsLtPRK','',0,'','',1,'Hehe@mail.com',0,'0','','1516715610',1,20002,'0',0,0,NULL,NULL,NULL,'96824f1f08bb7a95f18ef80312ca9cef808da1a1008ceea63ce9d1a3c0d98c74',NULL),(42,'Lol','Lol','0132165487','$2y$08$R1NVeExWMUFwb0dVODdob.mASjxRC0hRlIEkNihLuAb7dehRY/b.C','',0,'','',1,'Lol@mail.com',0,'0','','1516716249',1,20002,'1',0,0,NULL,NULL,NULL,'96824f1f08bb7a95f18ef80312ca9cef808da1a1008ceea63ce9d1a3c0d98c74',NULL),(43,'ناريمان خالد ','Nana','01064512378','$2y$08$UTIxWkhidzdZdlQydVBKdunXaYVTC4bCwIJs4LTjzFin7cr4E7d6C','',2,'','',1,'Nana@mail.com',0,'0','','1516786273',1,20002,'1',0,0,194,'G83a71y1ji',0,'6d979802c1a48c81990b58e77a32ae7a888306c6ba60c2b70f4e4e4516ea1dc9',NULL),(44,'Salma Ahmed Omar',NULL,'021546320','$2y$08$eG9xL1BuR2w5Z0F6TmJVduhAP4eyz4E7RAdBXJBSITYi6VoUHKZdy','1517241945qmoKkj2OOfpjw1cw.jpg',0,NULL,NULL,NULL,'salma.omar@future-group.com',0,NULL,NULL,'1446633835',1,1,'1',0,0,NULL,NULL,NULL,NULL,NULL),(45,'Ashraf Hesham','ashrafhesham','01125556688','$2y$08$WnkxeTBEaU1zaVE1bERlWOSwQyGVE.kgv7MloM3uRtqsrElJQoaJ.','',0,'','',1,'ashraf.ashraf@gmail.com',0,'0','','1517409416',1,20002,'1',0,0,197,'R8iXcW5T11',0,'44lkakal;ksj5778',NULL),(46,'Kandy','kandaf','010203040506','$2y$08$ZjJZNHMxUVY2TjVJSWZQeOY76sNoOpoO17LgfbDbkx1Q9sFLxjzUy','',0,'','',1,'kandaf@gmail.com',0,'0','','1517475236',1,20002,'1',0,0,198,'WBE3r012Y2',0,'44lkakal;ksj5778',NULL),(47,'Mazen hany mahmoud','Mezo','01061345721','$2y$08$QklJdlJyb2RQMS9NZnVLaOwizoI0/Tk47a5fH2Y3cAaDxrRsU/YpK','',2,'','',1,'Mezo@mail.com',0,'0','','1517744267',1,20002,'1',0,0,207,'9221AW4k92',0,'6d979802c1a48c81990b58e77a32ae7a888306c6ba60c2b70f4e4e4516ea1dc9',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_advanced`
--

DROP TABLE IF EXISTS `users_advanced`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_advanced` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `class_id` int(5) DEFAULT NULL,
  `user_id` int(4) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `date_birth` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_advanced`
--

LOCK TABLES `users_advanced` WRITE;
/*!40000 ALTER TABLE `users_advanced` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_advanced` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_application`
--

DROP TABLE IF EXISTS `users_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_application` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `account_id` int(10) NOT NULL COMMENT 'صاحب التطبيق',
  `title` varchar(255) NOT NULL,
  `des` varchar(255) NOT NULL,
  `type_app_platform` varchar(10) NOT NULL COMMENT 'ايفون - اندرويد - ايباد',
  `type_app_lang` varchar(50) NOT NULL COMMENT 'اللغه',
  `menu_depts_id` int(5) NOT NULL COMMENT 'Menu_Version_ID',
  `menu_version_id` int(5) NOT NULL COMMENT 'رقم المنيو الفعلي الموبيل يجيبه',
  `menu_layout_id` int(11) NOT NULL COMMENT 'دي الموجوده في الكور عشان اجيب التصميم ',
  `field_id` int(11) NOT NULL COMMENT 'مجال ايه سياحه - رياضه الخ',
  `icon` varchar(100) NOT NULL,
  `splash_screen` varchar(100) NOT NULL,
  `bg` varchar(100) NOT NULL,
  `logo` varchar(100) NOT NULL,
  `date` varchar(50) NOT NULL,
  `color_id` int(4) NOT NULL,
  `ads_setting` varchar(255) NOT NULL COMMENT 'خيارات الاعلانات من جوجل او نوعها او بيانات جوجل',
  `setting_cache` smallint(6) NOT NULL,
  `setting_app` varchar(255) NOT NULL,
  `theme_color_id` int(5) NOT NULL COMMENT 'الثيم بتاع الاب في الكور ',
  `menu_updated` int(1) NOT NULL COMMENT 'العميل عامل تقطيع جديد للمنيو',
  `push_notifications` varchar(255) NOT NULL,
  `live` int(1) NOT NULL DEFAULT '0' COMMENT 'التطبيق يظهر ليكم في الموبيل ولا لا',
  `new_dz` int(1) NOT NULL COMMENT 'العميل رافع تقطيع جديد لنفسه',
  `splash_screen_iphone` varchar(255) NOT NULL,
  `splash_screen_ipad` varchar(255) NOT NULL,
  `splash_screen_android` varchar(255) NOT NULL,
  `free` int(2) NOT NULL COMMENT 'هل التطبيق مجاني وساعتها ينفع احط فيه اعلانات ليا ',
  `main_page_layout_id` int(10) NOT NULL DEFAULT '0',
  `main_page_api` varchar(255) NOT NULL,
  `entry_point` int(4) NOT NULL DEFAULT '0',
  `application_route` varchar(30) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `Account_ID` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_application`
--

LOCK TABLES `users_application` WRITE;
/*!40000 ALTER TABLE `users_application` DISABLE KEYS */;
INSERT INTO `users_application` VALUES (1,0,'Tanks',' ','3,2,1','1',9,8,5,2,'uploads/00c559d8245105b22c6747a15fba4ce8.png','uploads/00c559d8245105b22c6747a15fba4ce8.png','uploads/00c559d8245105b22c6747a15fba4ce8.png','uploads/00c559d8245105b22c6747a15fba4ce8.png','1508082508',9,'a:5:{s:4:\"Type\";s:1:\"3\";s:16:\"iOS_Publisher_ID\";s:0:\"\";s:20:\"Android_Publisher_ID\";s:0:\"\";s:12:\"Ads_Provider\";s:0:\"\";s:8:\"Position\";s:6:\"bottom\";}',17,'a:5:{s:4:\"Type\";s:1:\"3\";s:16:\"iOS_Publisher_ID\";s:0:\"\";s:20:\"Android_Publisher_ID\";s:0:\"\";s:12:\"Ads_Provider\";s:0:\"\";s:8:\"Position\";s:6:\"bottom\";}',9,0,'0',0,0,'uploads/f1e1dafce1e52be704b9f7baf41714a8.png','uploads/f1e1dafce1e52be704b9f7baf41714a8.png','uploads/f1e1dafce1e52be704b9f7baf41714a8.png',1,0,'0',0,'0');
/*!40000 ALTER TABLE `users_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_application_ads`
--

DROP TABLE IF EXISTS `users_application_ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_application_ads` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `des` varchar(255) DEFAULT NULL,
  `dept_id` int(11) DEFAULT '0',
  `count` int(10) DEFAULT NULL,
  `action_id` int(10) DEFAULT NULL,
  `img` varchar(100) DEFAULT NULL,
  `height` smallint(6) DEFAULT NULL,
  `width` smallint(6) DEFAULT NULL,
  `active` int(10) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `startdate` varchar(50) DEFAULT NULL,
  `enddate` varchar(50) DEFAULT NULL,
  `application_id` int(10) DEFAULT NULL,
  `module_id` int(10) DEFAULT NULL,
  `orginal_id` int(10) DEFAULT NULL,
  `target_action_id` int(11) DEFAULT '0',
  `target_layout_id` int(11) DEFAULT '0',
  `api` varchar(255) DEFAULT NULL,
  `target_module_id` int(10) DEFAULT '0',
  `key` int(10) DEFAULT NULL,
  `visit_num` int(3) DEFAULT '0',
  `main` int(1) DEFAULT '0',
  `orders` int(5) DEFAULT '0',
  `thumbnail` varchar(255) DEFAULT NULL,
  `is_video` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`,`module_id`),
  KEY `Application_ID_2` (`application_id`,`module_id`,`orginal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_application_ads`
--

LOCK TABLES `users_application_ads` WRITE;
/*!40000 ALTER TABLE `users_application_ads` DISABLE KEYS */;
INSERT INTO `users_application_ads` VALUES (6,'اعلان جديد',NULL,NULL,NULL,NULL,'uploads/amodule/70b40e0114f81009c12493b2075240fc-charly-birdsinger-113463.jpg',NULL,NULL,NULL,'https://www.youtube.com/watch?v=ejvpVhvKesM','10/15/2017',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(7,'اعلان خزان',NULL,NULL,NULL,NULL,'uploads/amodule/d90d3904932b14d3a5917d18c1108a0e-advertise-with-us-header-640.png',NULL,NULL,NULL,'https://www.youtube.com/watch?v=ejvpVhvKesM','10/01/2017',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(9,'testing',NULL,NULL,NULL,NULL,'uploads/amodule/0aa3811c986280bed73ceac5fa3e04d8-test.jpg',NULL,NULL,NULL,'https://www.youtube.com/watch?v=9jGbWK8tyDE','12/03/2017',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(10,'test2',NULL,NULL,NULL,NULL,'uploads/amodule/4bd1fed973bf1c0f8cc173d13e9872a8-quality_control_tests_pharmaceutical_capsules.jpg',NULL,NULL,NULL,'https://www.youtube.com/watch?v=Ah4SFoYVdeA','12/03/2017',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(13,'testing3',NULL,NULL,NULL,NULL,'uploads/amodule/e12174f7e67b962cac1509f15e9dfe24-test 3.jpg',NULL,NULL,NULL,'https://www.youtube.com/watch?v=pBQNltb8BDY','12/03/2017',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `users_application_ads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_application_ads_settings`
--

DROP TABLE IF EXISTS `users_application_ads_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_application_ads_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enable_width` tinyint(4) DEFAULT '0',
  `enable_height` tinyint(4) DEFAULT '0',
  `enable_start_date` tinyint(4) DEFAULT '0',
  `enable_end_date` tinyint(4) DEFAULT '0',
  `enable_picture` tinyint(4) DEFAULT '0',
  `enable_thumbnail` tinyint(4) DEFAULT '0',
  `application_id` int(11) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  `banner_image` varchar(255) DEFAULT NULL,
  `enable_is_video` tinyint(4) DEFAULT '0',
  `enable_section` tinyint(4) DEFAULT '0',
  `enable_content` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_application_ads_settings`
--

LOCK TABLES `users_application_ads_settings` WRITE;
/*!40000 ALTER TABLE `users_application_ads_settings` DISABLE KEYS */;
INSERT INTO `users_application_ads_settings` VALUES (1,NULL,NULL,1,NULL,1,NULL,1,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users_application_ads_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_application_menu`
--

DROP TABLE IF EXISTS `users_application_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_application_menu` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `ISMenu` int(11) NOT NULL DEFAULT '0' COMMENT 'لو بشاور على المنيو الفرعيه بشاور هنا',
  `Title` varchar(255) NOT NULL,
  `TitleEn` varchar(255) NOT NULL,
  `Des` varchar(255) NOT NULL,
  `Pic` varchar(100) NOT NULL,
  `Pic_Selected` varchar(255) NOT NULL,
  `Main_Module_ID` int(10) NOT NULL,
  `Module_ID` int(10) NOT NULL,
  `Action_ID` int(10) NOT NULL,
  `Key_ID` int(10) NOT NULL,
  `Depts_ID` int(10) NOT NULL,
  `Orders` int(10) NOT NULL,
  `Application_ID` int(10) NOT NULL,
  `Form_Generator` int(10) NOT NULL DEFAULT '0' COMMENT 'هل هي فورم جينراتور ولا لا لو اه بنحط 1',
  `Active` int(10) NOT NULL DEFAULT '1',
  `Var` varchar(50) NOT NULL COMMENT 'لو في فاريبل للفلتره',
  `Content` text NOT NULL COMMENT 'عاده في موديول ال page بنحط القيمه هنا على طول بدل مانعمل كويري',
  `Login` int(1) NOT NULL DEFAULT '0' COMMENT 'هل الايتم يظهر ولا محتاج لوجن ',
  `Filter` varchar(255) NOT NULL,
  `Target_Layout_ID` int(5) NOT NULL,
  `Integrated_ID` int(10) NOT NULL COMMENT 'لنظام الانتجريت مع سستم خارجي ولسه ماتعملش',
  `Menu_Navigate_ID` int(5) NOT NULL DEFAULT '0' COMMENT 'الايتم دا تبع اي منيو',
  `Header` int(1) NOT NULL DEFAULT '0' COMMENT 'هل الايتم في الهيدر ولا لا',
  `Header_Target_Type` int(3) NOT NULL DEFAULT '0' COMMENT 'نوع الاكشن الهايتفتح دايلوج - قائمه جانبيه',
  `Old_Target_Action_ID` int(4) NOT NULL DEFAULT '0',
  `Old_Target_Module_ID` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `Application_ID` (`Application_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_application_menu`
--

LOCK TABLES `users_application_menu` WRITE;
/*!40000 ALTER TABLE `users_application_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_application_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_application_module`
--

DROP TABLE IF EXISTS `users_application_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_application_module` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `application_id` int(10) NOT NULL,
  `package_id` int(11) NOT NULL COMMENT 'مؤجله - بس فكره وجود بكج لمجموعه موديول زي الرسم',
  `orginal_id` int(10) NOT NULL COMMENT 'دا الرئيسي واوقات يكون وهمي لو الموديول الرئيسي مبني على وهمي ',
  `copy_module_id` int(10) NOT NULL COMMENT 'لو الموديول الرئيسي كان معمول من موديول وهمي ',
  `title` varchar(255) NOT NULL,
  `login` tinyint(1) NOT NULL COMMENT 'هل الموديول اجباري اللوجين او لا ',
  `setting` mediumtext NOT NULL COMMENT 'دي ستنيج للموديول هل هو ويب فيوهل ',
  `auth_setting` mediumtext NOT NULL COMMENT 'الاكشن الموجوده في الموديول',
  `bg_iphone` varchar(255) NOT NULL,
  `bg_ipad` varchar(255) NOT NULL,
  `bg_android` varchar(255) NOT NULL,
  `base_url` varchar(255) NOT NULL COMMENT 'اللنك الاساسي لجلب الداتا',
  `get_orders_setting` mediumtext NOT NULL COMMENT 'دي بحتاجها في ال api عشان اعرف ارجعلك الداتا بأي ترتيب ',
  `color` varchar(255) NOT NULL,
  `with_key_value` int(11) NOT NULL COMMENT 'هل في كي وفاليو اضافت ولا لا',
  `mapping_api` tinyint(1) NOT NULL COMMENT 'هل الموديولبيقرأ من الخارج',
  `plugin_api` tinyint(1) NOT NULL COMMENT 'هل الموديولبلجن',
  `active` int(1) NOT NULL DEFAULT '1' COMMENT 'حاله الموديول',
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_application_module`
--

LOCK TABLES `users_application_module` WRITE;
/*!40000 ALTER TABLE `users_application_module` DISABLE KEYS */;
INSERT INTO `users_application_module` VALUES (1,1,0,2,0,'Events',0,'a:15:{i:2;s:1:\"1\";i:6;s:1:\"1\";i:3;s:1:\"1\";i:24;s:1:\"1\";i:25;s:1:\"1\";i:26;s:1:\"1\";i:27;s:1:\"1\";i:28;s:1:\"1\";i:29;s:1:\"1\";i:30;s:1:\"1\";i:43;s:1:\"1\";i:1;s:1:\"1\";i:7;s:1:\"1\";i:5;s:1:\"1\";i:4;s:1:\"1\";}','a:3:{s:7:\"webview\";i:0;s:5:\"login\";i:0;s:8:\"showtime\";i:0;}',' ',' ',' ',' ',' ',' ',0,0,0,1),(2,1,0,2,0,'Pages',0,'a:15:{i:2;s:1:\"1\";i:6;s:1:\"1\";i:3;s:1:\"1\";i:24;s:1:\"1\";i:25;s:1:\"1\";i:26;s:1:\"1\";i:27;s:1:\"1\";i:28;s:1:\"1\";i:29;s:1:\"1\";i:30;s:1:\"1\";i:43;s:1:\"1\";i:1;s:1:\"1\";i:7;s:1:\"1\";i:5;s:1:\"1\";i:4;s:1:\"1\";}','a:3:{s:7:\"webview\";i:0;s:5:\"login\";i:0;s:8:\"showtime\";i:0;}',' ',' ',' ',' ',' ',' ',0,0,0,1),(3,1,0,2,0,'Factory',0,'a:15:{i:2;s:1:\"1\";i:6;s:1:\"1\";i:3;s:1:\"1\";i:24;s:1:\"1\";i:25;s:1:\"1\";i:26;s:1:\"1\";i:27;s:1:\"1\";i:28;s:1:\"1\";i:29;s:1:\"1\";i:30;s:1:\"1\";i:43;s:1:\"1\";i:1;s:1:\"1\";i:7;s:1:\"1\";i:5;s:1:\"1\";i:4;s:1:\"1\";}','a:3:{s:7:\"webview\";i:0;s:5:\"login\";i:0;s:8:\"showtime\";i:0;}',' ',' ',' ',' ',' ',' ',0,0,0,1),(4,1,0,2,0,'Profile',0,'a:15:{i:2;s:1:\"1\";i:6;s:1:\"1\";i:3;s:1:\"1\";i:24;s:1:\"1\";i:25;s:1:\"1\";i:26;s:1:\"1\";i:27;s:1:\"1\";i:28;s:1:\"1\";i:29;s:1:\"1\";i:30;s:1:\"1\";i:43;s:1:\"1\";i:1;s:1:\"1\";i:7;s:1:\"1\";i:5;s:1:\"1\";i:4;s:1:\"1\";}','a:3:{s:7:\"webview\";i:0;s:5:\"login\";i:0;s:8:\"showtime\";i:0;}',' ',' ',' ',' ',' ',' ',0,0,0,1),(5,1,0,2,0,'Brochures',0,'a:15:{i:2;s:1:\"1\";i:6;s:1:\"1\";i:3;s:1:\"1\";i:24;s:1:\"1\";i:25;s:1:\"1\";i:26;s:1:\"1\";i:27;s:1:\"1\";i:28;s:1:\"1\";i:29;s:1:\"1\";i:30;s:1:\"1\";i:43;s:1:\"1\";i:1;s:1:\"1\";i:7;s:1:\"1\";i:5;s:1:\"1\";i:4;s:1:\"1\";}','a:3:{s:7:\"webview\";i:0;s:5:\"login\";i:0;s:8:\"showtime\";i:0;}',' ',' ',' ',' ',' ',' ',0,0,0,1),(6,1,0,2,0,'Media',0,'a:15:{i:2;s:1:\"1\";i:6;s:1:\"1\";i:3;s:1:\"1\";i:24;s:1:\"1\";i:25;s:1:\"1\";i:26;s:1:\"1\";i:27;s:1:\"1\";i:28;s:1:\"1\";i:29;s:1:\"1\";i:30;s:1:\"1\";i:43;s:1:\"1\";i:1;s:1:\"1\";i:7;s:1:\"1\";i:5;s:1:\"1\";i:4;s:1:\"1\";}','a:3:{s:7:\"webview\";i:0;s:5:\"login\";i:0;s:8:\"showtime\";i:0;}',' ',' ',' ',' ',' ',' ',0,0,0,1),(7,1,0,2,0,'Footer',0,'a:15:{i:2;s:1:\"1\";i:6;s:1:\"1\";i:3;s:1:\"1\";i:24;s:1:\"1\";i:25;s:1:\"1\";i:26;s:1:\"1\";i:27;s:1:\"1\";i:28;s:1:\"1\";i:29;s:1:\"1\";i:30;s:1:\"1\";i:43;s:1:\"1\";i:1;s:1:\"1\";i:7;s:1:\"1\";i:5;s:1:\"1\";i:4;s:1:\"1\";}','a:3:{s:7:\"webview\";i:0;s:5:\"login\";i:0;s:8:\"showtime\";i:0;}',' ',' ',' ',' ',' ',' ',0,0,0,1),(8,1,0,2,0,'Products',0,'a:15:{i:2;s:1:\"1\";i:6;s:1:\"1\";i:3;s:1:\"1\";i:24;s:1:\"1\";i:25;s:1:\"1\";i:26;s:1:\"1\";i:27;s:1:\"1\";i:28;s:1:\"1\";i:29;s:1:\"1\";i:30;s:1:\"1\";i:43;s:1:\"1\";i:1;s:1:\"1\";i:7;s:1:\"1\";i:5;s:1:\"1\";i:4;s:1:\"1\";}','a:3:{s:7:\"webview\";i:0;s:5:\"login\";i:0;s:8:\"showtime\";i:0;}',' ',' ',' ',' ',' ',' ',0,0,0,1),(9,1,0,0,0,'Polls',0,'a:15:{i:2;s:1:\"1\";i:6;s:1:\"1\";i:3;s:1:\"1\";i:24;s:1:\"1\";i:25;s:1:\"1\";i:26;s:1:\"1\";i:27;s:1:\"1\";i:28;s:1:\"1\";i:29;s:1:\"1\";i:30;s:1:\"1\";i:43;s:1:\"1\";i:1;s:1:\"1\";i:7;s:1:\"1\";i:5;s:1:\"1\";i:4;s:1:\"1\";}','a:3:{s:7:\"webview\";i:0;s:5:\"login\";i:0;s:8:\"showti...',' ',' ',' ',' ',' ',' ',0,0,0,1),(10,1,0,2,0,'Orders',0,'a:15:{i:2;s:1:\"1\";i:6;s:1:\"1\";i:3;s:1:\"1\";i:24;s:1:\"1\";i:25;s:1:\"1\";i:26;s:1:\"1\";i:27;s:1:\"1\";i:28;s:1:\"1\";i:29;s:1:\"1\";i:30;s:1:\"1\";i:43;s:1:\"1\";i:1;s:1:\"1\";i:7;s:1:\"1\";i:5;s:1:\"1\";i:4;s:1:\"1\";}','a:3:{s:7:\"webview\";i:0;s:5:\"login\";i:0;s:8:\"showti...',' ',' ',' ',' ',' ',' ',0,0,0,1),(11,1,0,2,0,'Services',0,'a:15:{i:2;s:1:\"1\";i:6;s:1:\"1\";i:3;s:1:\"1\";i:24;s:1:\"1\";i:25;s:1:\"1\";i:26;s:1:\"1\";i:27;s:1:\"1\";i:28;s:1:\"1\";i:29;s:1:\"1\";i:30;s:1:\"1\";i:43;s:1:\"1\";i:1;s:1:\"1\";i:7;s:1:\"1\";i:5;s:1:\"1\";i:4;s:1:\"1\";}','a:3:{s:7:\"webview\";i:0;s:5:\"login\";i:0;s:8:\"showtime\";i:0;}',' ',' ',' ',' ',' ',' ',0,0,0,1);
/*!40000 ALTER TABLE `users_application_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_application_module_data`
--

DROP TABLE IF EXISTS `users_application_module_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_application_module_data` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Module_ID` int(11) NOT NULL,
  `Application_ID` int(10) NOT NULL,
  `Url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Attributes` mediumtext COLLATE utf8_unicode_ci,
  `Account` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Search` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Data` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Dept_ID` int(5) NOT NULL,
  `Source_ID` int(5) NOT NULL,
  `Author_ID` int(5) NOT NULL,
  `Sort` int(1) NOT NULL COMMENT '[1:Newest][4:Oldest][3:most relevant][2-Most viewed]',
  `Playlist` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Type` int(2) NOT NULL COMMENT '[1-Channel][2-Favorite][3-Search][4-Playlist]',
  `Basic_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_application_module_data`
--

LOCK TABLES `users_application_module_data` WRITE;
/*!40000 ALTER TABLE `users_application_module_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_application_module_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_application_module_lang`
--

DROP TABLE IF EXISTS `users_application_module_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_application_module_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL,
  `lang_id` int(11) NOT NULL,
  `title` varchar(50) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_application_module_lang`
--

LOCK TABLES `users_application_module_lang` WRITE;
/*!40000 ALTER TABLE `users_application_module_lang` DISABLE KEYS */;
INSERT INTO `users_application_module_lang` VALUES (1,1,1,'الفعاليات'),(2,1,2,'Events'),(3,2,1,'الصفحات'),(4,2,2,'Pages'),(5,3,1,'المصنع'),(6,3,2,'Factory'),(7,4,1,' البروفايل'),(8,4,2,'Profile'),(9,5,1,'الكتيبات '),(10,5,2,'Brochures'),(11,6,1,'الميديا'),(12,6,2,'Media'),(13,7,1,'الفوتر'),(14,7,2,'Footer'),(15,8,1,'المنتجات'),(16,8,2,'Products'),(17,9,1,' الإستبيان'),(18,9,2,'Polls'),(19,11,1,'الخدمات'),(20,11,2,'Services');
/*!40000 ALTER TABLE `users_application_module_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_application_module_layout_action_new`
--

DROP TABLE IF EXISTS `users_application_module_layout_action_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_application_module_layout_action_new` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Layout_ID` int(10) NOT NULL,
  `Action_ID` int(10) NOT NULL,
  `First_Cell` int(10) NOT NULL,
  `Remaining_Cell` int(10) NOT NULL,
  `Control` int(10) NOT NULL DEFAULT '1',
  `Target_Action_ID` int(10) NOT NULL,
  `Target_Module_ID` int(5) NOT NULL DEFAULT '0',
  `Application_ID` int(10) NOT NULL,
  `Module_ID` int(11) NOT NULL,
  `Orginal_ID` int(11) NOT NULL,
  `Login` tinyint(1) NOT NULL DEFAULT '0',
  `Design_Updated` int(1) NOT NULL COMMENT 'المفروض لو العميل عمل ابديت للديزاين يتم عمل ابديت هنا',
  `Default_Layout` tinyint(1) NOT NULL DEFAULT '0',
  `Key_Value_ID` int(10) NOT NULL,
  `Iframe_Cell_ID` int(11) NOT NULL,
  `Type_Mobile` int(1) NOT NULL,
  `Main` int(1) NOT NULL DEFAULT '1',
  `Loop` int(4) NOT NULL DEFAULT '0',
  `BgColor` varchar(255) NOT NULL,
  `Webview` enum('yes','no') NOT NULL DEFAULT 'yes',
  `Header_Setting` int(5) NOT NULL DEFAULT '1',
  `Header_Layout_ID` int(5) NOT NULL DEFAULT '1',
  `Footer_Layout_ID` int(3) NOT NULL DEFAULT '1',
  `Menu_Version_ID` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `Application_ID` (`Application_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_application_module_layout_action_new`
--

LOCK TABLES `users_application_module_layout_action_new` WRITE;
/*!40000 ALTER TABLE `users_application_module_layout_action_new` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_application_module_layout_action_new` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_application_module_setting`
--

DROP TABLE IF EXISTS `users_application_module_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_application_module_setting` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `action_id` int(10) NOT NULL,
  `module_ID` int(10) NOT NULL,
  `setting` tinyint(1) NOT NULL DEFAULT '0',
  `application_id` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`module_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_application_module_setting`
--

LOCK TABLES `users_application_module_setting` WRITE;
/*!40000 ALTER TABLE `users_application_module_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_application_module_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_application_statistics`
--

DROP TABLE IF EXISTS `users_application_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_application_statistics` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `session_user_id` int(10) NOT NULL,
  `token` text NOT NULL,
  `application_id` int(10) NOT NULL,
  `module_ID` int(10) NOT NULL,
  `action_ID` int(4) NOT NULL,
  `key_id` int(11) NOT NULL,
  `key_user_id` int(11) NOT NULL,
  `depts_id` int(11) NOT NULL,
  `source_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `request_data` text NOT NULL,
  `datetime` double NOT NULL,
  `type_module` int(4) NOT NULL,
  `base_url` varchar(255) NOT NULL,
  `mobile` int(4) NOT NULL,
  `mobile_type` varchar(255) NOT NULL,
  `duration` int(11) NOT NULL,
  `ip_id` int(11) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `online` int(2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`,`module_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_application_statistics`
--

LOCK TABLES `users_application_statistics` WRITE;
/*!40000 ALTER TABLE `users_application_statistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_application_statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_application_statistics_ip`
--

DROP TABLE IF EXISTS `users_application_statistics_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_application_statistics_ip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` int(11) NOT NULL,
  `ip` varchar(100) CHARACTER SET latin1 NOT NULL,
  `country` varchar(100) CHARACTER SET latin1 NOT NULL,
  `city` varchar(100) CHARACTER SET latin1 NOT NULL,
  `http_user_agent` varchar(255) CHARACTER SET latin1 NOT NULL,
  `token` varchar(255) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_application_statistics_ip`
--

LOCK TABLES `users_application_statistics_ip` WRITE;
/*!40000 ALTER TABLE `users_application_statistics_ip` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_application_statistics_ip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_intro`
--

DROP TABLE IF EXISTS `users_intro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_intro` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `Title_En` varchar(255) NOT NULL,
  `Des` varchar(255) NOT NULL,
  `Img` varchar(255) NOT NULL,
  `Application_ID` int(5) NOT NULL,
  `Lang_ID` int(5) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_intro`
--

LOCK TABLES `users_intro` WRITE;
/*!40000 ALTER TABLE `users_intro` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_intro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_module_users`
--

DROP TABLE IF EXISTS `users_module_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_module_users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `user` varchar(100) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `pass` varchar(500) DEFAULT NULL,
  `img` varchar(100) DEFAULT NULL,
  `gender` tinyint(1) NOT NULL DEFAULT '0',
  `access_token` varchar(255) DEFAULT NULL,
  `social_avatar` varchar(255) DEFAULT NULL,
  `login_type` int(11) DEFAULT NULL COMMENT 'holds value from user_module_login_types table',
  `mail` varchar(255) NOT NULL,
  `city_id` int(4) NOT NULL DEFAULT '0',
  `social_id` varchar(150) DEFAULT NULL,
  `social_type` varchar(20) DEFAULT NULL,
  `join_date` varchar(50) NOT NULL DEFAULT '1446633835',
  `application_id` int(10) NOT NULL,
  `module_id` int(10) NOT NULL,
  `active` enum('1','0') NOT NULL DEFAULT '1',
  `type` int(4) DEFAULT '0',
  `is_admin` tinyint(4) NOT NULL DEFAULT '0',
  `token_id` int(11) DEFAULT NULL,
  `confirm_code` varchar(10) DEFAULT NULL,
  `confirm_code_expired` tinyint(1) DEFAULT NULL,
  `device_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`,`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_module_users`
--

LOCK TABLES `users_module_users` WRITE;
/*!40000 ALTER TABLE `users_module_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_module_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_push_archive`
--

DROP TABLE IF EXISTS `users_push_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_push_archive` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Message` text COLLATE utf8_unicode_ci NOT NULL,
  `Type` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `Action_ID` int(11) NOT NULL,
  `Module_ID` int(11) NOT NULL,
  `Orginal_ID` int(11) NOT NULL,
  `Id_Num` int(11) NOT NULL,
  `Number` int(11) NOT NULL,
  `Picture` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Sound` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Send_Time` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `Finished` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Num_Msgs` int(11) NOT NULL,
  `Application_ID` int(11) NOT NULL,
  `Layout_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_push_archive`
--

LOCK TABLES `users_push_archive` WRITE;
/*!40000 ALTER TABLE `users_push_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_push_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_rel_type`
--

DROP TABLE IF EXISTS `users_rel_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_rel_type` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(5) NOT NULL,
  `type_id` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_rel_type`
--

LOCK TABLES `users_rel_type` WRITE;
/*!40000 ALTER TABLE `users_rel_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_rel_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_rules`
--

DROP TABLE IF EXISTS `users_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `application_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_rules`
--

LOCK TABLES `users_rules` WRITE;
/*!40000 ALTER TABLE `users_rules` DISABLE KEYS */;
INSERT INTO `users_rules` VALUES (1,'الادارة - مدير ',1),(2,'الادارة - موظف ',NULL),(3,'مدخل بيانات ',NULL),(4,'تسويق',NULL),(5,'خدمة العملاء -  مدير',NULL),(6,'خدمة العملاء - موظف ',NULL),(7,'مندوب مبيعات',NULL),(8,'مدير فرع',NULL),(9,'فني صيانة',NULL);
/*!40000 ALTER TABLE `users_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_rules_menus`
--

DROP TABLE IF EXISTS `users_rules_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_rules_menus` (
  `id` int(11) NOT NULL,
  `rule_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_rules_menus`
--

LOCK TABLES `users_rules_menus` WRITE;
/*!40000 ALTER TABLE `users_rules_menus` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_rules_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_shipping_addresses`
--

DROP TABLE IF EXISTS `users_shipping_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_shipping_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address_name` varchar(30) DEFAULT NULL,
  `street_name` varchar(35) DEFAULT NULL,
  `extra_directions` varchar(100) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `building_number` int(11) DEFAULT NULL,
  `floor` int(11) DEFAULT NULL,
  `appartment_number` int(11) DEFAULT NULL,
  `block_number` int(11) DEFAULT NULL,
  `area_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_shipping_addresses`
--

LOCK TABLES `users_shipping_addresses` WRITE;
/*!40000 ALTER TABLE `users_shipping_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_shipping_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_token`
--

DROP TABLE IF EXISTS `users_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_token` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `token_md5` varchar(32) NOT NULL,
  `user_id` int(10) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '1 => ios & 2 => android',
  `application_id` int(10) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `Application_ID` (`application_id`),
  KEY `Token` (`token`),
  KEY `Type` (`type`,`application_id`,`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_token`
--

LOCK TABLES `users_token` WRITE;
/*!40000 ALTER TABLE `users_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_users_rules`
--

DROP TABLE IF EXISTS `users_users_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_users_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `rule_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_users_rules`
--

LOCK TABLES `users_users_rules` WRITE;
/*!40000 ALTER TABLE `users_users_rules` DISABLE KEYS */;
INSERT INTO `users_users_rules` VALUES (1,1,1),(2,44,1);
/*!40000 ALTER TABLE `users_users_rules` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-06 19:57:27
