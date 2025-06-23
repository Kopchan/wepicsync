-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: wepicsync
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access_rights`
--

DROP TABLE IF EXISTS `access_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `access_rights` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `album_id` bigint unsigned NOT NULL,
  `allowed` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `access_rights_user_id_foreign` (`user_id`),
  KEY `access_rights_album_id_foreign` (`album_id`),
  CONSTRAINT `access_rights_album_id_foreign` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `access_rights_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_rights`
--

LOCK TABLES `access_rights` WRITE;
/*!40000 ALTER TABLE `access_rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `access_rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `age_ratings`
--

DROP TABLE IF EXISTS `age_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `age_ratings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level` int NOT NULL DEFAULT '0',
  `preset` enum('show','blur','hide') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'show',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `age_ratings_code_unique` (`code`),
  UNIQUE KEY `age_ratings_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `age_ratings`
--

LOCK TABLES `age_ratings` WRITE;
/*!40000 ALTER TABLE `age_ratings` DISABLE KEYS */;
INSERT INTO `age_ratings` VALUES (1,'G','General','Anybody can view','#00a74f',10,'show','2025-06-23 00:51:26','2025-06-23 00:51:26'),(2,'PG12','Parental Guidance 12','Mild violence or hints of romance','#00afef',20,'show','2025-06-23 00:51:26','2025-06-23 00:51:26'),(3,'R15','Restricted 15+','More explicit scenes, blood, moderate violence','#ed008d',30,'blur','2025-06-23 00:51:26','2025-06-23 00:51:26'),(4,'R18','Restricted 18+','Explicit sex, cruelty','#ee151f',40,'blur','2025-06-23 00:51:26','2025-06-23 00:51:26'),(5,'R18G','Restricted 18+ Graphic','Extremely shocking or explicitly violent content','#5915eb',50,'hide','2025-06-23 00:51:26','2025-06-23 00:51:26');
/*!40000 ALTER TABLE `age_ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `albums` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(1023) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hash` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_indexation` datetime DEFAULT NULL,
  `parent_album_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `_lft` int unsigned NOT NULL,
  `_rgt` int unsigned NOT NULL,
  `guest_allow` tinyint(1) DEFAULT NULL,
  `age_rating_id` bigint unsigned DEFAULT NULL,
  `order_level` int NOT NULL DEFAULT '0',
  `alias` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `view_settings` json DEFAULT NULL,
  `natural_sort_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `albums_hash_unique` (`hash`),
  UNIQUE KEY `albums_alias_hash_unique` (`alias`,`hash`),
  UNIQUE KEY `albums_alias_unique` (`alias`),
  KEY `albums_parent_album_id_foreign` (`parent_album_id`),
  KEY `albums_age_rating_id_foreign` (`age_rating_id`),
  KEY `albums_owner_user_id_foreign` (`owner_user_id`),
  CONSTRAINT `albums_age_rating_id_foreign` FOREIGN KEY (`age_rating_id`) REFERENCES `age_ratings` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `albums_owner_user_id_foreign` FOREIGN KEY (`owner_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `albums_parent_album_id_foreign` FOREIGN KEY (`parent_album_id`) REFERENCES `albums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
INSERT INTO `albums` VALUES (1,'','/','root','2025-06-23 09:31:20',NULL,'2025-06-23 02:21:30','2025-06-23 02:31:20',1,14,1,NULL,0,NULL,NULL,'',NULL),(2,'Unsplash','/Unsplash/','3kdILB2G6Y7zRSutF9ZYdKAPC','2025-06-23 09:31:20',1,'2025-06-23 02:31:16','2025-06-23 02:31:20',2,9,NULL,NULL,0,NULL,NULL,'Unsplash',NULL),(3,'Videos','/Videos/','jkbh7aeJW4KYrLKc1Dubx5hlr','2025-06-23 09:31:31',1,'2025-06-23 02:31:16','2025-06-23 02:31:31',10,13,NULL,NULL,0,NULL,NULL,'Videos',NULL),(4,'City','/Unsplash/City/','mGooBM9rr2c7agNdNnyXyjUqK','2025-06-23 09:31:24',2,'2025-06-23 02:31:20','2025-06-23 02:31:24',3,4,NULL,NULL,0,NULL,NULL,'City',NULL),(5,'Nature','/Unsplash/Nature/','NOhBuYrj7kZg7P74haJAZfYYV','2025-06-23 09:31:27',2,'2025-06-23 02:31:20','2025-06-23 02:31:27',5,6,NULL,NULL,0,NULL,NULL,'Nature',NULL),(6,'Water','/Unsplash/Water/','ckeSxQblUWpxHFuLXR1HgtoK2','2025-06-23 09:31:31',2,'2025-06-23 02:31:20','2025-06-23 02:31:31',7,8,NULL,NULL,0,NULL,NULL,'Water',NULL),(7,'Records','/Videos/Records/','74SWO5l2qjDG0hv6MzoWBi0XP','2025-06-23 09:31:32',3,'2025-06-23 02:31:31','2025-06-23 02:31:32',11,12,NULL,NULL,0,NULL,NULL,'Recors',NULL);
/*!40000 ALTER TABLE `albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_duplica`
--

DROP TABLE IF EXISTS `image_duplica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image_duplica` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `image_duplica_name_image_id_unique` (`name`,`image_id`),
  KEY `image_duplica_image_id_foreign` (`image_id`),
  CONSTRAINT `image_duplica_image_id_foreign` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_duplica`
--

LOCK TABLES `image_duplica` WRITE;
/*!40000 ALTER TABLE `image_duplica` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_duplica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hash` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `size` bigint unsigned NOT NULL,
  `width` int NOT NULL,
  `height` int NOT NULL,
  `album_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `natural_sort_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age_rating_id` bigint unsigned DEFAULT NULL,
  `type` enum('image','video','audio','imageAnimated') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'image',
  `codec_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frame_count` bigint unsigned DEFAULT NULL,
  `duration_ms` bigint unsigned DEFAULT NULL,
  `avg_frame_rate_num` bigint unsigned DEFAULT NULL,
  `avg_frame_rate_den` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `images_album_id_hash_unique` (`album_id`,`hash`),
  UNIQUE KEY `images_album_id_name_unique` (`album_id`,`name`),
  KEY `images_age_rating_id_foreign` (`age_rating_id`),
  CONSTRAINT `images_age_rating_id_foreign` FOREIGN KEY (`age_rating_id`) REFERENCES `age_ratings` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `images_album_id_foreign` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (1,'101028782_p0.png','E7EAjMD6q5c','2025-04-29 03:23:18',2445339,2983,1213,1,'2025-06-23 02:31:17','2025-06-23 02:31:17','000101028782_p000000000000.png',NULL,'image',NULL,NULL,NULL,NULL,NULL),(2,'105812972_p0.png','MxGNtqkQuz8','2025-04-29 02:24:53',5275147,2770,1069,1,'2025-06-23 02:31:17','2025-06-23 02:31:17','000105812972_p000000000000.png',NULL,'image',NULL,NULL,NULL,NULL,NULL),(3,'106049336_p0.jpg','xsf4ulTND-0','2025-04-29 02:49:52',2970572,5000,2174,1,'2025-06-23 02:31:17','2025-06-23 02:31:17','000106049336_p000000000000.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(4,'107871192_p0.jpg','Re9bFWF5L0o','2025-04-29 02:50:54',1973035,3400,1802,1,'2025-06-23 02:31:18','2025-06-23 02:31:18','000107871192_p000000000000.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(5,'108439008_p2.jpg','W-kvVGp2OcE','2025-04-29 02:46:38',546089,3440,1440,1,'2025-06-23 02:31:18','2025-06-23 02:31:18','000108439008_p000000000002.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(6,'108478559_p0.jpg','wbD56roZHr0','2025-04-29 02:50:11',4811007,5602,2587,1,'2025-06-23 02:31:18','2025-06-23 02:31:18','000108478559_p000000000000.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(7,'115355234_p0.jpg','2fWS23RPKDc','2025-04-29 02:49:41',942025,3400,1444,1,'2025-06-23 02:31:18','2025-06-23 02:31:18','000115355234_p000000000000.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(8,'115355234_p1.jpg','6XH-bXHFvJY','2025-04-29 02:49:44',3256472,3000,1274,1,'2025-06-23 02:31:18','2025-06-23 02:31:18','000115355234_p000000000001.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(9,'115355234_p2.jpg','J6OjFalQQXc','2025-04-29 02:49:39',1790103,3840,1632,1,'2025-06-23 02:31:19','2025-06-23 02:31:19','000115355234_p000000000002.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(10,'115506855_p0.png','U0EZMaCYYkY','2025-04-29 03:36:46',7005782,2829,1558,1,'2025-06-23 02:31:19','2025-06-23 02:31:19','000115506855_p000000000000.png',NULL,'image',NULL,NULL,NULL,NULL,NULL),(11,'124124000_p0.jpg','8jI8Zu1HaiE','2025-04-27 01:10:19',4379805,2972,1238,1,'2025-06-23 02:31:19','2025-06-23 02:31:19','000124124000_p000000000000.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(12,'125045923_p0.png','OmOZ0pGqbpI','2025-04-27 01:10:07',7264789,3541,1366,1,'2025-06-23 02:31:19','2025-06-23 02:31:19','000125045923_p000000000000.png',NULL,'image',NULL,NULL,NULL,NULL,NULL),(13,'97936487_p0.jpg','rZeU4o4bmTM','2025-04-29 02:49:58',7794074,4318,1886,1,'2025-06-23 02:31:20','2025-06-23 02:31:20','000097936487_p000000000000.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(14,'adam-borkowski--K3gnBy0LlA-unsplash.jpg','bPckgus9G9Q','2022-05-04 16:25:04',3361932,5015,6269,4,'2025-06-23 02:31:20','2025-06-23 02:31:20','adam-borkowski--K000000000003gnBy000000000000LlA-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(15,'adam-borkowski-s1oMlP-RlqU-unsplash.jpg','b5pmLMTwDko','2021-07-25 10:33:37',4173060,5222,6527,4,'2025-06-23 02:31:20','2025-06-23 02:31:20','adam-borkowski-s000000000001oMlP-RlqU-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(16,'adam-borkowski-z0FZkW71Zzw-unsplash.jpg','Hr6Umnr03Jk','2022-05-04 16:40:21',1863105,4249,5311,4,'2025-06-23 02:31:20','2025-06-23 02:31:20','adam-borkowski-z000000000000FZkW000000000071Zzw-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(17,'aleksey-kuprikov-WO3TGyb3-zc-unsplash.jpg','Vt8mEf2L0pg','2022-05-04 16:40:35',2837596,3912,5868,4,'2025-06-23 02:31:20','2025-06-23 02:31:20','aleksey-kuprikov-WO000000000003TGyb000000000003-zc-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(18,'alex-ovs-AdtLLfFFVPg-unsplash.jpg','exEs082qHHE','2021-11-06 22:20:11',1146050,3025,4032,4,'2025-06-23 02:31:21','2025-06-23 02:31:21','alex-ovs-AdtLLfFFVPg-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(19,'alex-quezada-C4mvvT2nqb0-unsplash.jpg','AqCZA0wx_wo','2022-05-04 16:36:04',4833513,3911,5867,4,'2025-06-23 02:31:21','2025-06-23 02:31:21','alex-quezada-C000000000004mvvT000000000002nqb000000000000-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(20,'alexandr-bormotin-FuHKcKoPl0c-unsplash.jpg','drQLmI8QDZA','2021-07-25 10:37:49',1947967,4160,6240,4,'2025-06-23 02:31:21','2025-06-23 02:31:21','alexandr-bormotin-FuHKcKoPl000000000000c-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(21,'andre-benz-CTGuAeOBxB4-unsplash.jpg','iUvaL_KlKn0','2020-08-03 21:42:31',5681585,4480,6720,4,'2025-06-23 02:31:21','2025-06-23 02:31:21','andre-benz-CTGuAeOBxB000000000004-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(22,'andre-benz-lIa03ti94ec-unsplash.jpg','eZCkGSZ63Pk','2020-07-26 18:25:45',3235541,4480,6720,4,'2025-06-23 02:31:22','2025-06-23 02:31:22','andre-benz-lIa000000000003ti000000000094ec-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(23,'andre-benz-qi2hmCwlhcE-unsplash.jpg','6F1rbuDPqI4','2020-07-26 18:29:07',6381741,6720,4480,4,'2025-06-23 02:31:22','2025-06-23 02:31:22','andre-benz-qi000000000002hmCwlhcE-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(24,'andrea-de-santis-R6NINiZR8rU-unsplash.jpg','gjeX8Zt_DKE','2022-05-04 16:39:34',3555409,4000,6000,4,'2025-06-23 02:31:22','2025-06-23 02:31:22','andrea-de-santis-R000000000006NINiZR000000000008rU-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(25,'anna-hunko-v92XmU-URlU-unsplash.jpg','Bvz-Kn0h8iA','2022-01-12 00:40:15',3161204,4000,6000,4,'2025-06-23 02:31:22','2025-06-23 02:31:22','anna-hunko-v000000000092XmU-URlU-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(26,'anne-nygard-Rr1VBGVQMOg-unsplash.jpg','Ux7k2bY605M','2022-05-04 16:20:25',1085030,3456,5184,4,'2025-06-23 02:31:22','2025-06-23 02:31:22','anne-nygard-Rr000000000001VBGVQMOg-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(27,'arseniy-volkov-1iHwdO1wcS8-unsplash.jpg','gydk35EEi5s','2022-05-04 16:25:28',2716745,5012,3341,4,'2025-06-23 02:31:23','2025-06-23 02:31:23','arseniy-volkov-000000000001iHwdO000000000001wcS000000000008-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(28,'ben-o-bro-wpU4veNGnHg-unsplash.jpg','CzDqyW74rz4','2023-01-02 15:14:14',2535596,5472,3648,4,'2025-06-23 02:31:23','2025-06-23 02:31:23','ben-o-bro-wpU000000000004veNGnHg-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(29,'brandon-erlinger-ford-11bxAxAsCnU-unsplash.jpg','urnKvh_jyjY','2020-12-26 19:37:59',1048232,2357,4192,4,'2025-06-23 02:31:23','2025-06-23 02:31:23','brandon-erlinger-ford-000000000011bxAxAsCnU-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(30,'cameron-venti-XUGsoYhKzUM-unsplash.jpg','DR_25g-xIic','2021-07-25 10:34:07',5839782,5472,3648,4,'2025-06-23 02:31:23','2025-06-23 02:31:23','cameron-venti-XUGsoYhKzUM-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(31,'charlie-harris-uQGdRigVAPU-unsplash.jpg','BhM6ONLR6T8','2022-05-05 07:54:38',4450737,5159,7735,4,'2025-06-23 02:31:24','2025-06-23 02:31:24','charlie-harris-uQGdRigVAPU-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(32,'gerda-sXKm4HRYdBM-unsplash.jpg','_5iH-JOrjV4','2022-05-06 14:03:11',2276999,3024,4032,5,'2025-06-23 02:31:24','2025-06-23 02:31:24','gerda-sXKm000000000004HRYdBM-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(33,'giordano-rossoni-Px04ZVAgqLM-unsplash.jpg','omQGruj62Vc','2022-05-04 16:40:25',3714880,4000,6000,5,'2025-06-23 02:31:24','2025-06-23 02:31:24','giordano-rossoni-Px000000000004ZVAgqLM-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(34,'gonzalo-kenny-J9kw6Rmytx0-unsplash.jpg','5OHEnmLrmwo','2022-05-06 14:03:09',1761885,3024,4032,5,'2025-06-23 02:31:24','2025-06-23 02:31:24','gonzalo-kenny-J000000000009kw000000000006Rmytx000000000000-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(35,'grant-mccurdy-KOKxOB8550Q-unsplash.jpg','xCwN4J1ZNDc','2020-08-15 19:49:14',2274840,6016,4016,5,'2025-06-23 02:31:24','2025-06-23 02:31:24','grant-mccurdy-KOKxOB000000008550Q-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(36,'greyson-joralemon-GPkO3IxsDaM-unsplash.jpg','6o6ODhIGOaI','2020-07-07 15:47:03',773147,3280,5831,5,'2025-06-23 02:31:25','2025-06-23 02:31:25','greyson-joralemon-GPkO000000000003IxsDaM-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(37,'gryffyn-m-DgWkgSYvSRY-unsplash.jpg','WQCPBSc7-u8','2020-08-15 19:47:25',1418469,4000,6000,5,'2025-06-23 02:31:25','2025-06-23 02:31:25','gryffyn-m-DgWkgSYvSRY-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(38,'guillaume-bolduc-p-VEOdwoZmI-unsplash.jpg','HBE_zebxtRo','2020-08-15 19:49:52',1366827,3648,5241,5,'2025-06-23 02:31:25','2025-06-23 02:31:25','guillaume-bolduc-p-VEOdwoZmI-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(39,'guillermo-alvarez-kF5nFbHBG5E-unsplash.jpg','Q4r2Fp85WcU','2021-11-07 14:42:28',4294696,5158,3424,5,'2025-06-23 02:31:25','2025-06-23 02:31:25','guillermo-alvarez-kF000000000005nFbHBG000000000005E-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(40,'hamidreza-torabi-9ggFurIDYdA-unsplash.jpg','EpBADvXXAvI','2020-12-26 19:32:39',313586,3024,4032,5,'2025-06-23 02:31:26','2025-06-23 02:31:26','hamidreza-torabi-000000000009ggFurIDYdA-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(41,'hamish-kale-Esg6jPg4o2I-unsplash.jpg','b60V6lvfmjU','2020-12-26 19:33:34',2009377,2790,3720,5,'2025-06-23 02:31:26','2025-06-23 02:31:26','hamish-kale-Esg000000000006jPg000000000004o000000000002I-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(42,'hert-niks--ICPwnZ0GnY-unsplash.jpg','AyyYuWT7058','2020-12-26 19:41:54',2020269,3578,4472,5,'2025-06-23 02:31:26','2025-06-23 02:31:26','hert-niks--ICPwnZ000000000000GnY-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(43,'ingmar-B4VfYCEtlo0-unsplash.jpg','qvEO1Li-uSA','2020-12-26 19:44:57',2980884,4733,7097,5,'2025-06-23 02:31:26','2025-06-23 02:31:26','ingmar-B000000000004VfYCEtlo000000000000-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(44,'ingmar-F4w_T20l4-o-unsplash.jpg','k1MNVJX45RE','2020-12-26 19:44:54',7511106,4165,6243,5,'2025-06-23 02:31:27','2025-06-23 02:31:27','ingmar-F000000000004w_T000000000020l000000000004-o-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(45,'ingmar-ZW5U9xNMr3U-unsplash.jpg','HXUGDJcgoiU','2020-08-15 19:47:22',8625487,4000,6000,5,'2025-06-23 02:31:27','2025-06-23 02:31:27','ingmar-ZW000000000005U000000000009xNMr000000000003U-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(46,'ivana-cajina-4htlh979uRM-unsplash.jpg','Jb3omC5ToCs','2020-12-01 15:43:42',3993973,3648,5472,5,'2025-06-23 02:31:27','2025-06-23 02:31:27','ivana-cajina-000000000004htlh000000000979uRM-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(47,'ivana-cajina-9LwCEYH1oW4-unsplash.jpg','BATrw74ZAag','2022-05-25 17:04:57',3293119,3648,5472,5,'2025-06-23 02:31:27','2025-06-23 02:31:27','ivana-cajina-000000000009LwCEYH000000000001oW000000000004-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(48,'izuddin-helmi-adnan-8VJDHw3daGk-unsplash.jpg','YEPs1dMI26Q','2022-05-25 17:03:42',4844183,3073,5464,5,'2025-06-23 02:31:27','2025-06-23 02:31:27','izuddin-helmi-adnan-000000000008VJDHw000000000003daGk-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(49,'francesca-grima-0ItQsGoizDw-unsplash.jpg','wVoQ0JuHF-o','2021-04-13 07:37:30',3716177,3648,4569,6,'2025-06-23 02:31:28','2025-06-23 02:31:28','francesca-grima-000000000000ItQsGoizDw-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(50,'geran-de-klerk-OomNPPv1Rpk-unsplash.jpg','-mzIhFBIuq4','2020-07-07 15:40:42',1930116,3992,2992,6,'2025-06-23 02:31:28','2025-06-23 02:31:28','geran-de-klerk-OomNPPv000000000001Rpk-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(51,'geran-de-klerk-m4z1GFECZrU-unsplash.jpg','XLDJ-vee-H4','2021-04-13 07:40:51',2468653,2992,3992,6,'2025-06-23 02:31:28','2025-06-23 02:31:28','geran-de-klerk-m000000000004z000000000001GFECZrU-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(52,'graeme-cross-3An1DDKwroI-unsplash.jpg','UM2dhFP2i38','2021-11-07 14:46:59',1270975,2829,2158,6,'2025-06-23 02:31:28','2025-06-23 02:31:28','graeme-cross-000000000003An000000000001DDKwroI-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(53,'hans-isaacson-Dq6ErkQ_RxE-unsplash.jpg','BDwTu3R-_AQ','2022-01-12 00:29:09',2955715,4041,6061,6,'2025-06-23 02:31:29','2025-06-23 02:31:29','hans-isaacson-Dq000000000006ErkQ_RxE-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(54,'hoodh-ahmed-6mzjJDqYU0g-unsplash.jpg','TR7PFXFntFw','2021-11-07 14:42:24',1170084,2898,2434,6,'2025-06-23 02:31:29','2025-06-23 02:31:29','hoodh-ahmed-000000000006mzjJDqYU000000000000g-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(55,'hoodh-ahmed-h2Uf8Kd6MN0-unsplash.jpg','kG_ZkaatKFI','2021-11-07 14:45:03',3221244,5397,3598,6,'2025-06-23 02:31:29','2025-06-23 02:31:29','hoodh-ahmed-h000000000002Uf000000000008Kd000000000006MN000000000000-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(56,'hrvoje_photography-pdRsf77OBoo-unsplash.jpg','PpGqWk6S64k','2021-11-07 14:46:58',3041854,5472,3648,6,'2025-06-23 02:31:29','2025-06-23 02:31:29','hrvoje_photography-pdRsf000000000077OBoo-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(57,'inggrid-koe-kbKEuU-YEIw-unsplash.jpg','H9cK9JoxKgs','2021-07-25 10:46:31',544714,3152,2304,6,'2025-06-23 02:31:29','2025-06-23 02:31:29','inggrid-koe-kbKEuU-YEIw-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(58,'jack-bassingthwaighte-YPZPUwJIwak-unsplash.jpg','WL_9ZBLXLno','2021-11-07 14:54:36',6629097,4000,6000,6,'2025-06-23 02:31:30','2025-06-23 02:31:30','jack-bassingthwaighte-YPZPUwJIwak-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(59,'jailam-rashad-hXmefoHzgKc-unsplash.jpg','eZ46QZApZ24','2021-11-07 14:46:20',2899287,2897,3621,6,'2025-06-23 02:31:30','2025-06-23 02:31:30','jailam-rashad-hXmefoHzgKc-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(60,'jake-allison-MNspPBIcWbo-unsplash.jpg','-7ZEzWxT1bA','2022-07-10 20:16:55',1276348,3750,3000,6,'2025-06-23 02:31:30','2025-06-23 02:31:30','jake-allison-MNspPBIcWbo-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(61,'javier-haro-ab_eUWfT9wg-unsplash.jpg','Qc_otJV7-oc','2022-05-05 07:54:40',1898918,5616,3744,6,'2025-06-23 02:31:30','2025-06-23 02:31:30','javier-haro-ab_eUWfT000000000009wg-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(62,'jeremy-bishop-d3fZSXlJ3Ok-unsplash.jpg','eNSsrypseWg','2020-07-07 15:39:34',3080022,4096,2730,6,'2025-06-23 02:31:31','2025-06-23 02:31:31','jeremy-bishop-d000000000003fZSXlJ000000000003Ok-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(63,'johannes-plenio-NVMF-cAHxCg-unsplash.jpg','EJ-DzyEFkTs','2020-12-26 19:44:34',3014646,5757,3238,6,'2025-06-23 02:31:31','2025-06-23 02:31:31','johannes-plenio-NVMF-cAHxCg-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(64,'john-koliogiannis-x7k_AhvO0Q8-unsplash.jpg','07GpCVw9q1o','2020-12-26 19:44:20',2760379,4000,5822,6,'2025-06-23 02:31:31','2025-06-23 02:31:31','john-koliogiannis-x000000000007k_AhvO000000000000Q000000000008-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(65,'jose-duarte-yfQRbv7oYCg-unsplash.jpg','qLeBT_6LPf0','2020-12-01 15:43:23',3304521,3456,5184,6,'2025-06-23 02:31:31','2025-06-23 02:31:31','jose-duarte-yfQRbv000000000007oYCg-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(66,'joshua-reddekopp--3uIUqsR-Rw-unsplash.jpg','gCzTN3V6lZY','2021-07-25 10:46:27',1887095,3823,2549,6,'2025-06-23 02:31:31','2025-06-23 02:31:31','joshua-reddekopp--000000000003uIUqsR-Rw-unsplash.jpg',NULL,'image',NULL,NULL,NULL,NULL,NULL),(67,'Запись экрана 2025-04-25 221459.mp4','OWio6Smfua0','2025-04-25 15:14:59',54070531,1940,1202,7,'2025-06-23 02:31:32','2025-06-23 02:31:32','Запись экрана 000000002025-000000000004-000000000025 000000221459.mp000000000004',NULL,'video','h264',1309,43633,30,1),(68,'Запись экрана 2025-04-26 002945.mp4','k4gfNstH-CQ','2025-04-25 17:29:45',1154781,498,1380,7,'2025-06-23 02:31:32','2025-06-23 02:31:32','Запись экрана 000000002025-000000000004-000000000026 000000002945.mp000000000004',NULL,'video','h264',130,4333,30,1),(69,'Запись экрана 2025-05-19 154904.mp4','SZhW6w4z3tk','2025-05-19 08:49:04',5330716,1576,820,7,'2025-06-23 02:31:32','2025-06-23 02:31:32','Запись экрана 000000002025-000000000005-000000000019 000000154904.mp000000000004',NULL,'video','h264',227,7566,30,1),(70,'Запись экрана 2025-06-13 222036.mp4','thcuEzeJZo0','2025-06-13 15:20:36',5442988,1970,1244,7,'2025-06-23 02:31:32','2025-06-23 02:31:32','Запись экрана 000000002025-000000000006-000000000013 000000222036.mp000000000004',NULL,'video','h264',133,4433,30,1);
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invitations`
--

DROP TABLE IF EXISTS `invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invitations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint unsigned NOT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `join_limit` int DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invitations_link_unique` (`link`),
  KEY `invitations_album_id_foreign` (`album_id`),
  CONSTRAINT `invitations_album_id_foreign` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invitations`
--

LOCK TABLES `invitations` WRITE;
/*!40000 ALTER TABLE `invitations` DISABLE KEYS */;
/*!40000 ALTER TABLE `invitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `legacy_aliases`
--

DROP TABLE IF EXISTS `legacy_aliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legacy_aliases` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `album_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `legacy_aliases_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `legacy_aliases`
--

LOCK TABLES `legacy_aliases` WRITE;
/*!40000 ALTER TABLE `legacy_aliases` DISABLE KEYS */;
/*!40000 ALTER TABLE `legacy_aliases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2019_12_14_000001_create_personal_access_tokens_table',1),(2,'2022_12_14_083707_create_settings_table',1),(3,'2024_02_25_112518_create_albums_table',1),(4,'2024_02_26_110117_create_images_table',1),(5,'2024_02_26_110305_create_tags_table',1),(6,'2024_02_26_110351_create_reactions_table',1),(7,'2024_02_27_092108_create_tag_image_table',1),(8,'2024_02_27_092208_create_users_table',1),(9,'2024_02_27_092255_create_reaction_images_table',1),(10,'2024_02_27_110435_create_access_rights_table',1),(11,'2024_03_05_085323_create_tokens_table',1),(12,'2024_03_24_165412_create_cache_table',1),(13,'2024_09_20_110117_create_image_duplica_table',1),(14,'2025_03_14_100100_add_nestedset_albums_table',1),(15,'2025_03_14_100200_add_natural_sort_key_images_table',1),(16,'2025_03_14_100300_add_guest_allow_albums_table',1),(17,'2025_04_12_100400_add_age_rating',1),(18,'2025_04_12_100500_add_order_level_albums_table',1),(19,'2025_04_12_100600_add_aliases',1),(20,'2025_04_12_100700_add_view_settings_albums_table',1),(21,'2025_04_28_100800_add_natural_sort_key_albums_table',1),(22,'2025_05_12_100900_recalc_hashes_images_table',1),(23,'2025_05_12_101000_reformat_hashes_images_table',1),(24,'2025_05_12_101100_reformat_hashes_thumbs_folder',1),(25,'2025_05_12_101200_add_video_fields_image_table',1),(26,'2025_05_12_101300_retype_gif_image_table',1),(27,'2025_05_22_160822_create_jobs_table',1),(28,'2025_06_16_101400_add_quota_and_ownership',1),(29,'2025_06_16_101500_create_invitations_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reaction_images`
--

DROP TABLE IF EXISTS `reaction_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reaction_images` (
  `image_id` bigint unsigned NOT NULL,
  `reaction_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`image_id`,`reaction_id`,`user_id`),
  KEY `reaction_images_reaction_id_foreign` (`reaction_id`),
  KEY `reaction_images_user_id_foreign` (`user_id`),
  CONSTRAINT `reaction_images_image_id_foreign` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reaction_images_reaction_id_foreign` FOREIGN KEY (`reaction_id`) REFERENCES `reactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reaction_images_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reaction_images`
--

LOCK TABLES `reaction_images` WRITE;
/*!40000 ALTER TABLE `reaction_images` DISABLE KEYS */;
INSERT INTO `reaction_images` VALUES (1,4,1,'2025-06-23 02:48:46','2025-06-23 02:48:46'),(1,4,2,'2025-06-23 02:56:01','2025-06-23 02:56:01'),(1,10,1,'2025-06-23 02:52:41','2025-06-23 02:52:41'),(3,3,2,'2025-06-23 02:56:18','2025-06-23 02:56:18'),(4,8,1,'2025-06-23 02:52:21','2025-06-23 02:52:21'),(4,12,1,'2025-06-23 02:49:10','2025-06-23 02:49:10'),(4,12,2,'2025-06-23 02:56:05','2025-06-23 02:56:05'),(6,10,1,'2025-06-23 02:52:26','2025-06-23 02:52:26'),(10,1,1,'2025-06-23 02:48:36','2025-06-23 02:48:36'),(10,1,2,'2025-06-23 02:56:02','2025-06-23 02:56:02'),(10,5,1,'2025-06-23 02:50:14','2025-06-23 02:50:14'),(13,11,2,'2025-06-23 02:56:15','2025-06-23 02:56:15');
/*!40000 ALTER TABLE `reaction_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reactions`
--

DROP TABLE IF EXISTS `reactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reactions_value_unique` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reactions`
--

LOCK TABLES `reactions` WRITE;
/*!40000 ALTER TABLE `reactions` DISABLE KEYS */;
INSERT INTO `reactions` VALUES (1,'👍','2025-06-23 00:51:26','2025-06-23 00:51:26'),(2,'👎','2025-06-23 00:51:26','2025-06-23 00:51:26'),(3,'⚡','2025-06-23 00:51:26','2025-06-23 00:51:26'),(4,'✨','2025-06-23 00:51:26','2025-06-23 00:51:26'),(5,'❤️','2025-06-23 00:51:26','2025-06-23 00:51:26'),(6,'📌','2025-06-23 00:51:26','2025-06-23 00:51:26'),(7,'🎉','2025-06-23 00:51:26','2025-06-23 00:51:26'),(8,'💀','2025-06-23 00:51:26','2025-06-23 00:51:26'),(9,'🍗','2025-06-23 00:51:26','2025-06-23 00:51:26'),(10,'👀','2025-06-23 00:51:26','2025-06-23 00:51:26'),(11,'🌚','2025-06-23 00:51:26','2025-06-23 00:51:26'),(12,'🫣','2025-06-23 00:51:26','2025-06-23 00:51:26'),(13,'🤨','2025-06-23 00:51:26','2025-06-23 00:51:26'),(14,'🤤','2025-06-23 00:51:26','2025-06-23 00:51:26');
/*!40000 ALTER TABLE `reactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `payload` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_group_name_unique` (`group`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_image`
--

DROP TABLE IF EXISTS `tag_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag_image` (
  `image_id` bigint unsigned NOT NULL,
  `tag_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`image_id`,`tag_id`),
  KEY `tag_image_tag_id_foreign` (`tag_id`),
  CONSTRAINT `tag_image_image_id_foreign` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tag_image_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_image`
--

LOCK TABLES `tag_image` WRITE;
/*!40000 ALTER TABLE `tag_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tags_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`value`,`user_id`),
  UNIQUE KEY `tokens_value_unique` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES ('0V6NrOpYO2SazM1AFsefGYqTvdsSrlGuJMQMTUIMR5gLuo7uJRd3CIYRu8Xr7UsjnFwC9FMNn3jTAEhLSISlErkRDYQqhj7RJKgSx7vcigS31eWHmbM2QV6OkB7a4bY8tADXFFQqNMUC8zOzDQvJxJst7sa4VGwaGFLs6vJPDCOAFbsFFB8zVkIuDRz9a9cu79ST4kgigOFLPvh4jmXsFIH3yui6HcbtV9X0HUO2A70E7dz9qLhAXixc1PjwhsS',2,'2025-06-23 02:53:05','2025-06-23 02:53:05'),('bD7JrT67xAw5ijmi7tcUE9Hj2ziatvrI1mieBmKCrhCZDG7Oq7oM41E4yYlfMcSkmLIuS8FDaDz8Ls2uBear17VQUHzKajb0NJy6R87RwR0BAXqD0gMCKsgSGwO601VGU9q4wNTX1Gs2OoTmF0iMedOqXWbi2p3ivUqUnP5HwmyRUsktQjktIqGA4ac4tIok2NwfudPcLt2NHa7dnoFApR5Y31Qfsy9YEgr1naW8cOwUPkpv42XGyeXTjfLuiCf',1,'2025-06-23 02:54:02','2025-06-23 02:54:02'),('GKQaeaj4iZSypv6ngLHBgAoiiJ9RnIbLaZ4HHpIKlucf5FtKxGg43GEnot3bxZvOegG6Nu7CjGTN1yoKaZhcNHGzfy8V3o6uEo0ulstCSTiflzFcjrBjrChge31Yf0YYuUvVJ5eeJjRjojNX6QzMatcYqbxRzBbjH4RuAwv2mFFxADTcKLulNnqM2oLSfx6H5rlgWpH91wjMzIClqR27Diua6cKwCSFsOWyU3DcUmP77XC9ddNLJEd0UIL4Y2LF',1,'2025-06-23 02:54:02','2025-06-23 02:54:02'),('heOocQDB6OmtoKedhXSSOdlD5XyUS5mmgZUR2gIJPNQpku2KsJY4ciz3ssSbviHy9HmhkORNDjTEXiwIgZpvPV0WeTHu5jQxQG8qdm3bxupvrfWlVBf5PFskVhTtPL6xlI6naoEHfAQhhCRaJqqTHPyGzLsAoG8SUqE58dCppaofuYMJoYzbglJ7FsBgYFnxDIOpUt0t1Q4Oyfnx7Z3ydztt6Q30ZB2I4adJgSKWx2Npp2gLh3lrRbtzwYlHpp4',2,'2025-06-23 02:55:13','2025-06-23 02:55:13'),('hkSIxN8XlICOhZwYr0krL2BXYjstbsR2RKCHwCq6qLaUddNjEwMXo5hHjU87yk2Gtuq5J08tQDLgJCFueYZCF9aDFST5EfBF40hhwq0VepVawzmstO300O45TKlgZoDXKHqre4BmWkW9vYK0qemafzLhxfxdkqcssmoNfdYs7xZd19bCeIuCwIt0QY5nIt0reh9Ikw1BzBnSDUPQANo15f2cm2YzPWitRJrBKclMcAomfPnofStL0yvEF8ufpxN',2,'2025-06-23 02:55:14','2025-06-23 02:55:14'),('KjleKmY9Aul2PKr4nHpkw8CtI0VuWzXPMzinLSRy8bUW5TeSlYYApa17HyFq9Z5rmv0ybM6YWVuZV0GilgLIiMvhcqy0OTnfHrNB31DGEZD94UoIXjse6wmoVJ8QWT9o8fnD0rZWFkTOAWV8kESwOV8UujdFcL1c11il2SxfOgZ8wq74tN5kb85DjJmNdKwRIhXCptsYnWTdh836Up4eSD1kDZmH88Eq39GTeazRfY7pH625TU4rQ1QVpHJU5xE',2,'2025-06-23 02:53:50','2025-06-23 02:53:50'),('ld756XzTYEGO2SkZwCGlfzl6oguICuqgPFBqyQISPyrJd01xNqGqdNbfSK7D8Y0YkPGcZhzyxwyBb0uoPxEnKN2NVzGIyDPXoinqq2DrUZfbt1BVxdlXTudDmZ00HvJcyG0CAioFWy4rNaD1IEDyzNzUF1gkGQtoF2TnY1W2pzMnyVum8ITiCWtyZEvqG4o4JMghe7xFoFljTY6dw6WP1MV1nZASx9dYu7aF3ACEE0ZDuX6kA6g4Tv0Zmxyy64N',1,'2025-06-23 02:21:44','2025-06-23 02:21:44'),('xqXqFc0ngHtKEM2VJTyGd3rpCCoqjuvukd0pv8iecyaiyJSQCyIXXeU83ENDD6rneh0vmyyTkY79lPOPaw0VwzPadKlqYReFyruuxuypDEKzaey8LoMmNfmup4iTO67L5v19OTvFoBdQMyDCFhQq4dr71aPxuR3swpFdm9fEKzvTfG2EkUdC34QcK2jZxBS56KOlftvbNbG6mlg9cnoLguarOfGX0eDAzD1nH9dOq56V4zHmu8e4ntC2wFtlyRI',1,'2025-06-23 02:21:44','2025-06-23 02:21:44'),('YcnppNqywGF421zIU3gMJu5eZzw1PZTQ1bvpkLcwu6mDSHIhtuHxlhAT6xw559eoG8n6I4HTfEZuJxNlWHvF8GlW5rGI1dwbz34b53iiSWnYULxaHss7HsEfgasNAfpsYplEvT9AUr8KPCwgTltwqKXTGVEcpaFCE2h3P8Dct674xQwOo2vS2HVpzE9SEESDuOG2tAtwAO3NIYN1PQo1Udz5N5JDHEkSyfpQ3TGXn7hZFb5gaDiMoMJ3hMgO4nc',2,'2025-06-23 02:53:49','2025-06-23 02:53:49');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nickname` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `login` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `view_settings_presets` json DEFAULT NULL,
  `quota` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_login_unique` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Administrator','admin','$2y$12$5KBA2mCYTRiX1X0dnxSBq.yS89PUuDbJcmk1Rt1qZgZu9AeteuDIW',1,'2025-06-23 00:51:26','2025-06-23 00:51:26',NULL,0),(2,'Test user','test','$2y$12$pR6IUV4jvriY15gOKkEjxuW0aewS0Encn.I5RagCizZZE.SpSlX1K',0,'2025-06-23 02:53:05','2025-06-23 02:53:05',NULL,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'wepicsync'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-23 16:57:34
