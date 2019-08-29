/*
SQLyog Community v13.1.3  (64 bit)
MySQL - 10.3.16-MariaDB : Database - a2
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`a2` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `a2`;

/*Table structure for table `article` */

DROP TABLE IF EXISTS `article`;

CREATE TABLE `article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL DEFAULT current_timestamp(),
  `title` char(100) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `boardId` int(10) unsigned NOT NULL,
  `view` int(11) NOT NULL DEFAULT 0,
  `delStatus` tinyint(1) NOT NULL DEFAULT 0,
  `blindStatus` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `boardId` (`boardId`),
  KEY `article_memberId` (`memberId`),
  CONSTRAINT `article_memberId` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=280 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `article` */

insert  into `article`(`id`,`regDate`,`title`,`body`,`memberId`,`boardId`,`view`,`delStatus`,`blindStatus`) values 
(236,'2019-08-26 00:32:07','첫번째 공지사항입니다.','ㅋㅋㅋ\r\nㅋ\r\nㅋ\r\nㅋㅋ\r\nㅋ\r\nㅋ\r\nㅋㅋ\r\nㅋ\r\nㅋ\r\nㅋ\r\nㅋ\r\nㅋ',237,2,0,0,0),
(237,'2019-08-26 00:32:07','첫번째 공지사항입니다.','ㅋㅋㅋ\r\nㅋ\r\nㅋ\r\nㅋㅋ\r\nㅋ\r\nㅋ\r\nㅋㅋ\r\nㅋ\r\nㅋ\r\nㅋ\r\nㅋ\r\nㅋ',237,2,1,0,0),
(238,'2019-08-26 00:33:07','두번째 입니다.','ㅋ\r\nㅋ\r\nㅋ\r\nㅋ\r\nㅋ',237,2,0,0,0),
(239,'2019-08-26 00:33:07','두번째 입니다.','ㅋ\r\nㅋ\r\nㅋ\r\nㅋ\r\nㅋ',237,2,1,0,0),
(240,'2019-08-26 00:34:22','엥?','엥',237,2,4,0,0),
(241,'2019-08-26 00:34:22','엥?','엥',237,2,3,0,0),
(242,'2019-08-26 00:37:21','아니 ㅋㅋㅋㅋ','첫번째 인데요 ㅋㅋㅋ',237,2,24,0,0),
(248,'2019-08-26 02:25:08','dsfdsfs관리자에 의해 수정','sdfsd관리자에 의해 수정sdffe',237,1,12,0,0),
(249,'2019-08-26 15:09:58','zzzcccczzzzzzzzz','zzzzzzzzcccczzzzzzzz',254,1,24,1,1),
(254,'2019-08-26 15:56:15','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz\r\nz\r\nz\r\nz\r\nzzz\r\nz\r\n\r\nz\r\nzz\r\nz\r\nz',237,1,25,0,0),
(255,'2019-08-23 18:54:50','zzzzzzzzzz','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',254,1,0,0,0),
(256,'2019-08-24 02:15:23','zzzzzzzzz','zzzzzzzz',254,1,0,0,0),
(257,'2019-08-24 22:35:04','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz','sdfs',254,1,0,0,0),
(258,'2019-08-23 18:54:50','zzzzzzzzzz','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',254,1,0,0,0),
(259,'2019-08-24 02:15:23','zzzzzzzzz','zzzzzzzz',254,1,0,0,0),
(260,'2019-08-24 22:35:04','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz','sdfs',254,1,0,0,0),
(261,'2019-08-23 18:54:50','zzzzzzzzzz','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',254,1,0,0,0),
(262,'2019-08-24 02:15:23','zzzzzzzzz','zzzzzzzz',254,1,0,0,0),
(263,'2019-08-24 22:35:04','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz','sdfs',254,1,0,0,0),
(264,'2019-08-23 18:54:50','zzzzzzzzzz','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',254,1,0,0,0),
(265,'2019-08-24 02:15:23','zzzzzzzzz','zzzzzzzz',254,1,0,0,0),
(266,'2019-08-24 22:35:04','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz','sdfs',254,1,0,0,0),
(267,'2019-08-23 18:54:50','zzzzzzzzzz','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',254,1,0,0,0),
(268,'2019-08-24 02:15:23','zzzzzzzzz','zzzzzzzz',254,1,0,0,0),
(269,'2019-08-24 22:35:04','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz','sdfs',254,1,0,0,0),
(270,'2019-08-23 18:54:50','zzzzzzzzzz','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',254,1,0,0,0),
(271,'2019-08-24 02:15:23','zzzzzzzzz','zzzzzzzz',254,1,0,0,0),
(272,'2019-08-24 22:35:04','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz','sdfs',254,1,0,0,0),
(273,'2019-08-23 18:54:50','zzzzzzzzzz','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',254,1,0,0,0),
(274,'2019-08-24 02:15:23','zzzzzzzzz','zzzzzzzz',254,1,0,0,0),
(275,'2019-08-24 22:35:04','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz','sdfs',254,1,2,0,0),
(276,'2019-08-27 23:46:10','ㅋㅋㅋㅋㅋㅋㅋ','#제목입니다.',254,2,1,0,0),
(277,'2019-08-27 23:55:37','zzzzz','<h1>댓글</h1>',254,2,0,1,1),
(278,'2019-08-27 23:57:34','zzzzzzz','#제목ㅇ빈다.',254,2,2,1,0),
(279,'2019-08-29 00:39:21','sdf','sdf',237,2,1,1,1);

/*Table structure for table `articleFile` */

DROP TABLE IF EXISTS `articleFile`;

CREATE TABLE `articleFile` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `articleId` int(10) unsigned NOT NULL,
  `prefix` char(200) COLLATE utf8_unicode_ci NOT NULL,
  `originFileName` char(200) COLLATE utf8_unicode_ci NOT NULL,
  `type2` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `type` char(10) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `articleId` (`articleId`),
  CONSTRAINT `articleId` FOREIGN KEY (`articleId`) REFERENCES `article` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `articleFile` */

insert  into `articleFile`(`id`,`regDate`,`articleId`,`prefix`,`originFileName`,`type2`,`type`) values 
(84,'2019-08-26 00:32:07',237,'90a271e5-17a6-4a71-a958-79b4cd0ee203-','test.jpg','image/jpeg','body'),
(86,'2019-08-26 14:57:20',248,'9c186d4a-a20e-4e97-ad42-1829f1299663-','test.jpg','image/jpeg','body'),
(87,'2019-08-26 15:09:58',249,'1e7d684f-e229-4751-a73b-0941ea9639d1-','test.jpg','image/jpeg','body'),
(93,'2019-08-29 00:39:21',279,'a8115e71-24ae-4c58-ae73-971a71b813d6-','test.jpg','image/jpeg','body');

/*Table structure for table `articleReply` */

DROP TABLE IF EXISTS `articleReply`;

CREATE TABLE `articleReply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `articleId` int(10) unsigned NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `boardId` int(10) unsigned NOT NULL,
  `delStatus` tinyint(1) NOT NULL DEFAULT 0,
  `blindStatus` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `memberId` (`memberId`),
  KEY `reply_articleId` (`articleId`),
  CONSTRAINT `memberId` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reply_articleId` FOREIGN KEY (`articleId`) REFERENCES `article` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `articleReply` */

insert  into `articleReply`(`id`,`regDate`,`articleId`,`memberId`,`body`,`boardId`,`delStatus`,`blindStatus`) values 
(100,'2019-08-26 23:01:10',254,254,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nx\nx\n\nxx\n\nx\nx\n\nx\nx\nx\nx\nxx\n\nxx\nx\nx\nx\nx',1,0,0),
(101,'2019-08-26 23:02:43',249,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',1,0,0),
(102,'2019-08-29 01:01:21',279,254,'와 댓글',2,1,0),
(103,'2019-08-29 01:01:28',279,254,'곧 삭제될 예정',2,1,0),
(104,'2019-08-29 01:01:36',279,254,'관리자에 의해',2,1,1),
(248,'2019-08-24 20:27:42',248,235,'sdfdsfdfd',1,0,0),
(249,'2019-08-24 20:31:54',248,237,'sfefsef',1,0,0),
(250,'2019-08-29 16:38:57',277,237,'ㅇㄹ',2,1,0),
(251,'2019-08-29 17:03:15',276,237,'dhdh',2,1,1);

/*Table structure for table `board` */

DROP TABLE IF EXISTS `board`;

CREATE TABLE `board` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `name` char(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `board` */

insert  into `board`(`id`,`regDate`,`name`) values 
(1,'2019-05-27 22:54:25','공지사항'),
(2,'2019-05-27 22:54:36','자유게시판');

/*Table structure for table `letter` */

DROP TABLE IF EXISTS `letter`;

CREATE TABLE `letter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL DEFAULT current_timestamp(),
  `fromMemberId` int(10) unsigned NOT NULL,
  `toMemberId` int(10) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `letter_toMemberId` (`toMemberId`),
  CONSTRAINT `letter_toMemberId` FOREIGN KEY (`toMemberId`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `letter` */

insert  into `letter`(`id`,`regDate`,`fromMemberId`,`toMemberId`,`body`) values 
(80,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz'),
(81,'2019-08-07 23:18:52',234,236,'fffffffffffff'),
(82,'2019-08-07 23:19:10',234,236,'ggggggggggggggg'),
(83,'2019-08-08 01:24:37',237,236,'iyu'),
(84,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ'),
(86,'2019-08-24 22:47:08',254,237,'sfefsfs'),
(87,'2019-08-24 22:48:32',254,237,'kl'),
(88,'2019-08-24 22:49:05',254,237,'g'),
(89,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'),
(90,'2019-08-25 23:44:53',257,254,'ㅋㅋㅋㅋㅋㅋ 안녕하세요\n저는 1234입니다.'),
(91,'2019-08-25 23:49:44',257,254,'테스트용 입니다.'),
(92,'2019-08-25 23:50:45',257,254,'ㅋㅋㅋㅋㅋ'),
(93,'2019-08-25 23:51:27',257,254,'ㄹㅇㄴㄹ'),
(94,'2019-08-25 23:51:45',257,254,'123145215125'),
(95,'2019-08-25 23:54:02',254,257,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz\nsssssssssssssssssssssssssssssssssssssss\nfsdf\nsf\nsf\nsf\nsf\ns\nfsd\nf\nsf\nsf\ns\nf'),
(96,'2019-08-27 15:39:41',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'),
(97,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz'),
(98,'2019-08-07 23:18:52',234,236,'fffffffffffff'),
(99,'2019-08-07 23:19:10',234,236,'ggggggggggggggg'),
(100,'2019-08-08 01:24:37',237,236,'iyu'),
(101,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ'),
(102,'2019-08-24 22:47:08',254,237,'sfefsfs'),
(103,'2019-08-24 22:48:32',254,237,'kl'),
(104,'2019-08-24 22:49:05',254,237,'g'),
(105,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'),
(106,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz'),
(107,'2019-08-07 23:18:52',234,236,'fffffffffffff'),
(108,'2019-08-07 23:19:10',234,236,'ggggggggggggggg'),
(109,'2019-08-08 01:24:37',237,236,'iyu'),
(110,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ'),
(111,'2019-08-24 22:47:08',254,237,'sfefsfs'),
(112,'2019-08-24 22:48:32',254,237,'kl'),
(113,'2019-08-24 22:49:05',254,237,'g'),
(114,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'),
(115,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz'),
(116,'2019-08-07 23:18:52',234,236,'fffffffffffff'),
(117,'2019-08-07 23:19:10',234,236,'ggggggggggggggg'),
(118,'2019-08-08 01:24:37',237,236,'iyu'),
(119,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ'),
(120,'2019-08-24 22:47:08',254,237,'sfefsfs'),
(121,'2019-08-24 22:48:32',254,237,'kl'),
(122,'2019-08-24 22:49:05',254,237,'g'),
(123,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'),
(124,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz'),
(125,'2019-08-07 23:18:52',234,236,'fffffffffffff'),
(126,'2019-08-07 23:19:10',234,236,'ggggggggggggggg'),
(127,'2019-08-08 01:24:37',237,236,'iyu'),
(128,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ'),
(129,'2019-08-24 22:47:08',254,237,'sfefsfs'),
(130,'2019-08-24 22:48:32',254,237,'kl'),
(131,'2019-08-24 22:49:05',254,237,'g'),
(132,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'),
(133,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz'),
(134,'2019-08-07 23:18:52',234,236,'fffffffffffff'),
(135,'2019-08-07 23:19:10',234,236,'ggggggggggggggg'),
(136,'2019-08-08 01:24:37',237,236,'iyu'),
(137,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ'),
(138,'2019-08-24 22:47:08',254,237,'sfefsfs'),
(139,'2019-08-24 22:48:32',254,237,'kl'),
(140,'2019-08-24 22:49:05',254,237,'g'),
(141,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'),
(142,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz'),
(143,'2019-08-07 23:18:52',234,236,'fffffffffffff'),
(144,'2019-08-07 23:19:10',234,236,'ggggggggggggggg'),
(145,'2019-08-08 01:24:37',237,236,'iyu'),
(146,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ'),
(147,'2019-08-24 22:47:08',254,237,'sfefsfs'),
(148,'2019-08-24 22:48:32',254,237,'kl'),
(149,'2019-08-24 22:49:05',254,237,'g'),
(150,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'),
(151,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz'),
(152,'2019-08-07 23:18:52',234,236,'fffffffffffff'),
(153,'2019-08-07 23:19:10',234,236,'ggggggggggggggg'),
(154,'2019-08-08 01:24:37',237,236,'iyu'),
(155,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ'),
(156,'2019-08-24 22:47:08',254,237,'sfefsfs'),
(157,'2019-08-24 22:48:32',254,237,'kl'),
(158,'2019-08-24 22:49:05',254,237,'g'),
(159,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'),
(160,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz'),
(161,'2019-08-07 23:18:52',234,236,'fffffffffffff'),
(162,'2019-08-07 23:19:10',234,236,'ggggggggggggggg'),
(163,'2019-08-08 01:24:37',237,236,'iyu'),
(164,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ'),
(165,'2019-08-24 22:47:08',254,237,'sfefsfs'),
(166,'2019-08-24 22:48:32',254,237,'kl'),
(167,'2019-08-24 22:49:05',254,237,'g'),
(168,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'),
(169,'2019-08-29 17:52:11',254,237,'ㅎㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌ');

/*Table structure for table `like` */

DROP TABLE IF EXISTS `like`;

CREATE TABLE `like` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL DEFAULT current_timestamp(),
  `relType` varchar(10) NOT NULL,
  `relId` int(10) unsigned NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `val` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `like_memberId` (`memberId`),
  CONSTRAINT `like_memberId` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=latin1;

/*Data for the table `like` */

insert  into `like`(`id`,`regDate`,`relType`,`relId`,`memberId`,`val`) values 
(28,'2019-08-05 16:59:39','article',230,226,-1),
(65,'2019-08-23 22:21:42','article',230,254,1),
(76,'2019-08-23 22:43:38','article',92,254,-1),
(77,'2019-08-23 22:43:25','article',90,254,-1),
(81,'2019-08-23 22:45:30','reply',90,254,-1),
(83,'2019-08-23 22:45:36','reply',92,254,-1),
(86,'2019-08-24 00:41:40','reply',92,237,-1),
(90,'2019-08-26 17:20:20','article',248,237,1),
(91,'2019-08-26 17:20:07','article',254,237,-1),
(92,'2019-08-26 17:59:18','article',250,254,1),
(93,'2019-08-26 17:59:37','article',253,254,1),
(94,'2019-08-27 15:50:39','article',249,254,-1);

/*Table structure for table `member` */

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL DEFAULT current_timestamp(),
  `loginId` char(100) COLLATE utf8_unicode_ci NOT NULL,
  `loginPw` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `name` char(100) COLLATE utf8_unicode_ci NOT NULL,
  `email` char(100) COLLATE utf8_unicode_ci NOT NULL,
  `authKey` char(30) COLLATE utf8_unicode_ci NOT NULL,
  `emailAuthStatus` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`loginId`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=258 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `member` */

insert  into `member`(`id`,`regDate`,`loginId`,`loginPw`,`name`,`email`,`authKey`,`emailAuthStatus`) values 
(226,'2019-08-06 18:00:32','ddd','9c969ddf454079e3d439973bbab63ea6233e4087','ddd','ddd@ddd.ddd','pqf318YTaCvatS8FSx70xB6VqzDb7A',0),
(228,'2019-08-06 18:03:09','eee','637a81ed8e8217bb01c15c67c39b43b0ab4e20f1','eee','eee@eee.eee','0qeOFvnbTgn1OCL3zPJCFRiysNRZ8B',1),
(230,'2019-08-06 18:08:04','fff','f6949a8c7d5b90b4a698660bbfb9431503fbb995','fff','fff@fff.fff','s9ckpV4iu06I3SXLtq3opCcdLr3KHB',0),
(231,'2019-08-06 18:22:04','ggg','07dcd371560bc43c48f56a2f55739ac66741d59d','ggg','ggg@ggg.ggg','jBHavd0ggVcYpPFVWdgtNlPCNkLX4b',0),
(232,'2019-08-06 18:23:01','hhh','effdb5f96a28acd2eb19dcb15d8f43af762bd0ae','hhh','hhh@hhh.hhh','LoOhXDR0uiFfGhFwKJcyrTkkbqqYD7',0),
(233,'2019-08-06 18:23:36','iii','425ffc1422dc4f32528bd9fd5af355fdb5c96192','iii','iii@iii.iii','5FFudc2HRMRY0Akp1NnQbtnAlzGvp7',0),
(234,'2019-08-06 18:24:29','kkk','5150d2104c8cd974b27fad3f25ec4e8098bb7bbe','kkk','kkk@kkk.kkk','llu0fgG7pqSAMw8ScNwhWFZ8CzFd5w',0),
(235,'2019-08-06 18:25:59','nnn','7f88bb68e14d386d89af3cf317f6f7af1d39246c','nnn','nnn@nnn.nnn','gTWwSpJMv90yvXs3e6V31aRyJRIHpE',0),
(236,'2019-08-06 18:27:06','qqq','a056c8d05ae9ac6ca180bc991b93b7ffe37563e0','qqq','qqq@qqq.qqq','a6t5XGWpaf8CbGqYpXtZZuucc9H332',0),
(237,'2019-08-06 18:28:46','www','c50267b906a652f2142cfab006e215c9f6fdc8a0','www','www@www.www','II6P5nx741kUeFg6isl8pGGJsfUmS2',0),
(239,'2019-08-22 16:18:37','123','123','123','123@123.123','1234545',0),
(240,'2019-08-22 16:49:01','1233','123','123','123@123.123','1234545',0),
(243,'2019-08-22 18:12:20','ㅁㅁㅁ','ㅁㅁㅁ','ㅊㅊㅊ','shdzl@naver.com5','yMX1UkJ6QUq3GDgiuIQIUY4V8m2Uwx',0),
(245,'2019-08-22 18:15:35','ㅠㅠㅠ12','9844f81e1408f6ecb932137d33bed7cfdcf518a3','ㅠㅠㅠ','ssd357@naver.com12','6t7BLVmHbT3wVVBEkBFmsslbWVBk3J',0),
(246,'2019-08-22 18:18:32','ㅁㄴㅇ','9844f81e1408f6ecb932137d33bed7cfdcf518a3','ㅁㄴㅇ','asf@sfsf.sdf','ksKfblOc1JDbhOQl2gqPg1QhEGO417',0),
(248,'2019-08-22 18:49:11','yyy','9844f81e1408f6ecb932137d33bed7cfdcf518a3','yyy','yyy@yyy.yyy','XQeNMcNGirpRRsmcjgdFlhSwuB8mIO',0),
(250,'2019-08-22 23:47:05','ㅁㅁㅁㅁㅁ','9844f81e1408f6ecb932137d33bed7cfdcf518a3','ㅁㅁㅁㅁㅁ','sdf@naver.com','83M7UQUOc4WxOkhLH8S5tHPBXqPdLg',0),
(251,'2019-08-22 23:48:40','1231212','9844f81e1408f6ecb932137d33bed7cfdcf518a3','1231232','sdf@naver.com1','14FFLlu4UxTTkj7xUdxisXJc76PMoP',0),
(254,'2019-08-23 00:06:01','nnnn','07962e32beac4da179b30c06f1c1e71bd220f782','nnnn','nnnn@nnnn.nnnn','7kP1UDDm1P6NiUpfXKOGhrRqFwqkBg',0),
(257,'2019-08-25 23:24:15','1234','7110eda4d09e062aa5e4a390b0a572ac0d2c0220','1234','123@123.1233','SYoVJpBMSoenR4f5SoIr8uHcCnbXd7',0);

/*Table structure for table `memberAttr` */

DROP TABLE IF EXISTS `memberAttr`;

CREATE TABLE `memberAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL DEFAULT current_timestamp(),
  `memberId` int(10) unsigned NOT NULL,
  `attrName` char(20) COLLATE utf8_unicode_ci NOT NULL,
  `attrValue` blob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `memberAttr` */

insert  into `memberAttr`(`id`,`regDate`,`memberId`,`attrName`,`attrValue`) values 
(1,'2019-08-06 16:44:26',222,'ROLE','admin'),
(2,'2019-08-06 19:21:42',237,'ROLE','admin');

/*Table structure for table `report` */

DROP TABLE IF EXISTS `report`;

CREATE TABLE `report` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL DEFAULT current_timestamp(),
  `relType` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `relId` int(10) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `memberId` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `report` */

insert  into `report`(`id`,`regDate`,`relType`,`relId`,`body`,`memberId`) values 
(1,'2019-08-29 14:19:20','article',248,'너무 재미없음',235),
(2,'2019-08-29 14:19:50','article',249,'너무 재미없음249',237),
(3,'2019-08-29 14:19:59','article',248,'너무 재미없음zzzzzzzzzzzzzzzzzzz',237),
(4,'2019-08-29 14:21:24','reply',102,'너무 재미없음zzzzzzzzzzzzzzzzzzz',237),
(5,'2019-08-29 14:21:29','reply',102,'너무 재미없음zzzzzzzzzzzzzzzzzzz',236),
(6,'2019-08-29 14:21:52','reply',102,'댓글 너무 재미없음zzzzzzzzzzzzzzzzzzz',235),
(7,'2019-08-29 14:21:52','reply',102,'댓글 너무 재미없음zzzzzzzzzzzzzzzzzzz',235),
(8,'2019-08-29 17:47:35','article',249,'냥냥공주',254),
(9,'2019-08-29 17:50:33','article',249,'다시 신고합',254),
(10,'2019-08-29 17:51:59','article',249,'ㅗㄹ호',254);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
