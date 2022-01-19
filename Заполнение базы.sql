-- MariaDB dump 10.19  Distrib 10.5.12-MariaDB, for Linux (x86_64)
--
-- Host: mysql.hostinger.ro    Database: u574849695_23
-- ------------------------------------------------------
-- Server version	10.5.12-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ad`
--
DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS `ad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ad` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned DEFAULT NULL,
  `price` bigint(20) unsigned DEFAULT NULL,
  `ad_text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','saled','remove') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `ad_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ad_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ad`
--

LOCK TABLES `ad` WRITE;
/*!40000 ALTER TABLE `ad` DISABLE KEYS */;
INSERT INTO `ad` VALUES (1,1,1,307534478,NULL,'saled','1970-06-30 08:49:40'),(2,2,2,3317855,NULL,'remove','2019-06-30 12:30:20'),(3,3,3,6321721,NULL,'remove','1996-09-27 15:44:53'),(4,4,4,1085,NULL,'active','1994-09-06 15:26:02'),(5,5,5,1,NULL,'active','1973-10-19 01:34:29'),(6,6,6,1906,NULL,'remove','1991-02-16 15:19:47'),(7,7,7,8797864,NULL,'active','2019-10-11 20:36:30'),(8,8,8,45,NULL,'remove','2021-04-26 02:52:59'),(9,9,9,1777826,NULL,'active','1994-10-20 19:06:44'),(10,10,10,1874341,NULL,'saled','1996-04-24 03:59:43');
/*!40000 ALTER TABLE `ad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `communities`
--

DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `communities_name_idx` (`name`),
  KEY `admin_user_id` (`admin_user_id`),
  CONSTRAINT `communities_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities`
--

LOCK TABLES `communities` WRITE;
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
INSERT INTO `communities` VALUES (1,'iure',1),(2,'consectetur',2),(3,'iusto',3),(4,'molestias',4),(5,'repellat',5),(6,'ullam',6),(7,'harum',7),(8,'eum',8),(9,'similique',9),(10,'laudantium',10);
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deal`
--

DROP TABLE IF EXISTS `deal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deal` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ad_id` bigint(20) unsigned NOT NULL,
  `seller_id` bigint(20) unsigned NOT NULL,
  `buyer_id` bigint(20) unsigned NOT NULL,
  `complited_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ad_id` (`ad_id`),
  KEY `seller_id` (`seller_id`),
  KEY `buyer_id` (`buyer_id`),
  CONSTRAINT `deal_ibfk_1` FOREIGN KEY (`ad_id`) REFERENCES `ad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `deal_ibfk_2` FOREIGN KEY (`seller_id`) REFERENCES `ad` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `deal_ibfk_3` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deal`
--

LOCK TABLES `deal` WRITE;
/*!40000 ALTER TABLE `deal` DISABLE KEYS */;
INSERT INTO `deal` VALUES (1,1,1,1,'2006-04-26 18:13:38'),(2,2,2,2,'1999-11-02 14:45:25'),(3,3,3,3,'2002-02-17 23:28:07'),(4,4,4,4,'1993-07-14 10:57:03'),(5,5,5,5,'2020-11-13 14:31:31'),(6,6,6,6,'1973-04-16 09:26:20'),(7,7,7,7,'2015-05-20 09:13:25'),(8,8,8,8,'2018-06-29 08:31:49'),(9,9,9,9,'1974-02-25 10:39:14'),(10,10,10,10,'2017-08-30 15:38:24');
/*!40000 ALTER TABLE `deal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_requests`
--

DROP TABLE IF EXISTS `friend_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_requests` (
  `initiator_user_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `status` enum('requested','approved','declined','unfriended') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requested_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_requests`
--

LOCK TABLES `friend_requests` WRITE;
/*!40000 ALTER TABLE `friend_requests` DISABLE KEYS */;
INSERT INTO `friend_requests` VALUES (1,1,'declined','2013-09-01 07:54:56','1986-10-08 02:10:51'),(2,2,'requested','2015-07-31 04:39:17','2015-08-24 06:40:51'),(3,3,'approved','1999-04-13 17:57:12','1990-07-29 21:42:56'),(4,4,'approved','1987-06-08 07:17:01','1984-01-26 17:34:00'),(5,5,'declined','2016-12-28 23:31:23','2020-11-13 20:07:35'),(6,6,'requested','1989-06-23 05:02:55','1987-01-06 11:24:51'),(7,7,'approved','2016-07-28 10:25:41','2000-06-15 00:08:12'),(8,8,'unfriended','1990-02-21 12:21:09','1983-05-23 07:40:31'),(9,9,'unfriended','2011-02-21 01:36:46','1975-02-15 17:13:39'),(10,10,'approved','1997-11-10 11:20:02','2021-11-21 22:35:36');
/*!40000 ALTER TABLE `friend_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,1,1,'2014-08-15 13:23:50'),(2,2,2,'2003-07-31 18:27:56'),(3,3,3,'2002-08-31 09:15:58'),(4,4,4,'1972-08-29 14:34:20'),(5,5,5,'2001-06-13 18:19:08'),(6,6,6,'1989-02-04 19:04:19'),(7,7,7,'2017-03-22 13:06:02'),(8,8,8,'1991-09-19 15:50:16'),(9,9,9,'1982-07-19 14:15:42'),(10,10,10,'2013-11-13 17:18:55');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `media_type_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,1,1,'At dignissimos deserunt voluptates ullam quod deleniti sit. Sint enim nemo id. Sed sit unde dicta cupiditate. Earum velit animi rerum.','blanditiis',6524073,NULL,'1975-01-13 08:19:02','2014-06-25 23:30:58'),(2,2,2,'Unde neque quam illo dolor. Tempora odit rerum ullam velit quasi fuga quod. Omnis ut repudiandae eos a harum ullam.','odit',2393,NULL,'2016-12-25 03:41:28','2008-12-01 06:17:20'),(3,3,3,'Nostrum delectus velit temporibus architecto ut rerum sint. Et sapiente nihil iste. Maxime voluptas doloremque ut aut est eius nobis.','voluptate',139,NULL,'2012-05-05 10:56:12','1971-05-07 15:17:36'),(4,4,4,'Culpa earum omnis explicabo. Beatae voluptatem suscipit voluptates sequi.','voluptas',198,NULL,'2011-11-19 13:33:48','1999-11-21 23:10:59'),(5,5,5,'Et aut alias pariatur est nemo sed temporibus. Ut voluptatem doloremque minus delectus. Numquam ut distinctio in quidem ea facilis odit. Quisquam ipsam reiciendis ex quia eveniet.','ipsam',8,NULL,'1985-09-05 02:36:14','1980-10-11 22:37:48'),(6,1,6,'Illo eos accusantium fuga id optio amet atque ipsum. Quia aperiam eveniet enim deserunt aspernatur blanditiis. Accusamus quaerat qui soluta inventore culpa quisquam deleniti. Et corrupti commodi necessitatibus quam ad.','ipsam',622,NULL,'1986-01-27 05:14:16','1973-08-26 21:26:07'),(7,2,7,'Nulla voluptatem esse vel est. Qui explicabo quo voluptatem quia. Laborum dolores velit iusto expedita perspiciatis neque.','id',2388,NULL,'1975-10-05 06:25:44','2021-11-23 13:35:26'),(8,3,8,'Rerum deserunt odit facere reprehenderit dolor tempora beatae. Deleniti omnis amet illum facilis nobis. Officiis dolores quis perferendis possimus non.','rem',1444527,NULL,'2011-07-14 00:53:15','1998-04-11 08:38:44'),(9,4,9,'Consectetur enim nulla quae qui itaque explicabo. Rerum quasi quae et adipisci cum autem. Natus ut placeat fuga. Enim dicta non ullam enim quod. Repellat dolorem rerum omnis nesciunt eum eos numquam veritatis.','sit',1,NULL,'2008-11-01 02:42:37','1997-01-02 08:30:01'),(10,5,10,'Dignissimos id consequatur voluptas porro quia quia. Atque quis inventore non quia dolores est. Ea odit nam odio est quis dolore.','sint',5362,NULL,'1987-05-07 10:04:39','2019-07-25 15:19:15');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_types`
--

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_types`
--

LOCK TABLES `media_types` WRITE;
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
INSERT INTO `media_types` VALUES (1,'veniam','2009-01-29 04:36:02','1996-10-01 14:06:15'),(2,'est','2019-09-28 15:43:05','2004-10-23 02:11:58'),(3,'reiciendis','2007-02-08 06:57:25','2005-06-04 17:57:41'),(4,'facilis','2009-10-31 15:53:13','1986-12-03 21:11:22'),(5,'et','1970-06-06 15:51:23','2018-11-21 04:58:53');
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,1,'Facere consequatur alias recusandae est aut. Et enim recusandae et explicabo non consectetur soluta. Magni magnam maxime fugiat. Tempora nam nostrum voluptate.','1992-09-15 00:10:52'),(2,2,2,'Saepe deleniti earum optio expedita rerum et consequatur. Cupiditate quidem velit quisquam ut. Qui et optio exercitationem quis officiis pariatur. Sed est corrupti doloribus reprehenderit quisquam pariatur. Consequatur numquam quae dolor qui.','1977-08-30 14:01:10'),(3,3,3,'Sed sunt eaque omnis dolore. Mollitia fuga qui quia.','1985-06-29 15:06:07'),(4,4,4,'Sint enim porro dolor eum. Officia aut fugit non mollitia. Ut et cum et inventore a omnis nesciunt.','1999-02-17 19:45:54'),(5,5,5,'Quis doloribus fugiat est. Unde beatae nihil itaque assumenda. Et voluptas consequatur officiis et nihil. Excepturi suscipit atque delectus qui quia.','1982-02-11 15:50:15'),(6,6,6,'Enim magni harum et et consequatur nostrum ut. Id aut velit dolor occaecati eos. Nihil amet est itaque.','1990-10-17 02:00:28'),(7,7,7,'Repellendus eaque aut ut placeat cupiditate. Ex tempore est maxime quia tempore.','2000-12-23 13:11:23'),(8,8,8,'Eum est quo quibusdam ipsum dicta at. Odit sunt pariatur nihil officiis occaecati commodi reiciendis. Quia consequatur et maiores rerum inventore minus aspernatur error.','1999-05-02 04:31:36'),(9,9,9,'Cumque dolores et sapiente. Soluta dignissimos dicta quisquam libero ratione officia. Ex sequi saepe explicabo blanditiis itaque ipsum. Repudiandae odio voluptas est voluptatem. Quis veniam minus qui repudiandae corrupti.','1985-07-19 06:13:57'),(10,10,10,'Hic tempore aut magni et molestiae sit accusantium. Dolorem nostrum reiciendis asperiores natus illum. Itaque distinctio quos asperiores recusandae ut.','1996-04-08 14:20:38');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_albums`
--

DROP TABLE IF EXISTS `photo_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photo_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo_albums`
--

LOCK TABLES `photo_albums` WRITE;
/*!40000 ALTER TABLE `photo_albums` DISABLE KEYS */;
INSERT INTO `photo_albums` VALUES (1,'veniam',1),(2,'praesentium',2),(3,'suscipit',3),(4,'dolores',4),(5,'ab',5),(6,'quas',6),(7,'blanditiis',7),(8,'aut',8),(9,'et',9),(10,'molestiae',10);
/*!40000 ALTER TABLE `photo_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10);
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gender` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `photo_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `hometown` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_photo_id` (`photo_id`),
  CONSTRAINT `fk_photo_id` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'f','1978-11-06',1,'1989-02-21 07:11:16',NULL),(2,'f','2002-02-21',2,'1978-07-27 20:28:24',NULL),(3,'m','1990-04-13',3,'2014-10-22 19:30:21',NULL),(4,'m','1973-06-02',4,'1982-02-09 12:57:11',NULL),(5,'m','2003-02-19',5,'1976-09-27 06:28:20',NULL),(6,'f','1988-06-28',6,'2018-07-11 19:08:58',NULL),(7,'f','1975-02-12',7,'1983-05-12 09:44:59',NULL),(8,'m','1985-06-30',8,'1999-07-30 17:56:18',NULL),(9,'m','2017-02-14',9,'1993-12-27 16:40:23',NULL),(10,'f','2000-05-14',10,'1994-06-18 03:04:37',NULL);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_ads`
--

DROP TABLE IF EXISTS `user_ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_ads` (
  `user_id` bigint(20) unsigned NOT NULL,
  `ad_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`ad_id`),
  KEY `ad_id` (`ad_id`),
  CONSTRAINT `user_ads_ibfk_1` FOREIGN KEY (`ad_id`) REFERENCES `ad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_ads_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_ads`
--

LOCK TABLES `user_ads` WRITE;
/*!40000 ALTER TABLE `user_ads` DISABLE KEYS */;
INSERT INTO `user_ads` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `user_ads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_deals`
--

DROP TABLE IF EXISTS `user_deals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_deals` (
  `user_id` bigint(20) unsigned NOT NULL,
  `deal_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`deal_id`),
  KEY `deal_id` (`deal_id`),
  CONSTRAINT `user_deals_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_deals_ibfk_2` FOREIGN KEY (`deal_id`) REFERENCES `deal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_deals`
--

LOCK TABLES `user_deals` WRITE;
/*!40000 ALTER TABLE `user_deals` DISABLE KEYS */;
INSERT INTO `user_deals` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `user_deals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Фамилия',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Salvatore','Wolff','xhintz@example.org','90f3567b35321f1b74f9dcece1b521f1b248b930','9574021392','\0'),(2,'Irma','Johns','west.gino@example.net','8222e6bc379f1b9466d571882b1a688e8c8d357c','9095321111',''),(3,'Ariel','Bernhard','crona.bill@example.org','881a9dcc60da4f4f3e19cdf533e97faf56e59d58','9442756085','\0'),(4,'Francisca','Wisozk','jdavis@example.org','554bc09a31328bcbcda459d18cb4276be1d4ad0b','9817564575',''),(5,'Nelda','Spencer','odenesik@example.net','2f4d7b9166eb012655f678790e8a8b58e2695a79','9351392015',''),(6,'Jensen','Fadel','abbigail59@example.net','349269da0d5872d505305fc5de245b5424fa7bc6','9505642844',''),(7,'Whitney','Friesen','rzulauf@example.com','3089fe13343714d77c0187c2d99dc82205e24ef2','9934772810','\0'),(8,'Susana','Hudson','kub.isabelle@example.net','7e863725b659cf1fd5c2bfe2bb248fe85ac34cd8','9275940323',''),(9,'Breana','Schowalter','quinn.schaefer@example.com','45d1801d95a59dfc22e0bbd28e7279617b4fcb14','9870387520',''),(10,'Shane','Grant','cathryn.schimmel@example.net','cbb5636d97f07294db108e3f32bd77609fd04c1c','9563530128','\0');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_communities`
--

DROP TABLE IF EXISTS `users_communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_communities` (
  `user_id` bigint(20) unsigned NOT NULL,
  `community_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_communities`
--

LOCK TABLES `users_communities` WRITE;
/*!40000 ALTER TABLE `users_communities` DISABLE KEYS */;
INSERT INTO `users_communities` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `users_communities` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-05 14:17:11
