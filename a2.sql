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
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `article` */

insert  into `article`(`id`,`regDate`,`title`,`body`,`memberId`,`boardId`,`view`,`delStatus`,`blindStatus`) values 
(236,'2019-08-26 00:32:07','첫번째 공지사항입니다.','ㅋㅋㅋ\r\nㅋ\r\nㅋ\r\nㅋㅋ\r\nㅋ\r\nㅋ\r\nㅋㅋ\r\nㅋ\r\nㅋ\r\nㅋ\r\nㅋ\r\nㅋ',237,2,0,0,0),
(237,'2019-08-26 00:32:07','첫번째 공지사항입니다.','ㅋㅋㅋ\r\nㅋ\r\nㅋ\r\nㅋㅋ\r\nㅋ\r\nㅋ\r\nㅋㅋ\r\nㅋ\r\nㅋ\r\nㅋ\r\nㅋ\r\nㅋ',237,2,1,0,0),
(238,'2019-08-26 00:33:07','두번째 입니다.','ㅋ\r\nㅋ\r\nㅋ\r\nㅋ\r\nㅋ',237,2,0,0,0),
(239,'2019-08-26 00:33:07','두번째 입니다.','ㅋ\r\nㅋ\r\nㅋ\r\nㅋ\r\nㅋ',237,2,1,0,0),
(240,'2019-08-26 00:34:22','엥?','엥',237,2,4,0,0),
(241,'2019-08-26 00:34:22','엥?','엥',237,2,3,0,0),
(242,'2019-08-26 00:37:21','아니 ㅋㅋㅋㅋ','첫번째 인데요 ㅋㅋㅋ',237,2,25,0,0),
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
(275,'2019-08-24 22:35:04','zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz','sdfs',254,1,3,0,0),
(276,'2019-08-27 23:46:10','ㅋㅋㅋㅋㅋㅋㅋ','#제목입니다.',254,2,1,0,0),
(277,'2019-08-27 23:55:37','zzzzz','<h1>댓글</h1>',254,2,0,1,1),
(278,'2019-08-27 23:57:34','zzzzzzz','#제목ㅇ빈다.',254,2,2,1,0),
(279,'2019-08-29 00:39:21','sdf','sdf',237,2,1,1,1),
(280,'2019-08-29 23:51:41','<a>zzz</a>','<script>\r\nalert(\'ㅋㅋㅋㅋ\');\r\n</script>',254,2,1,0,0),
(281,'2019-08-30 00:34:37','zzzzzzzzzzzzzzzzzzzz','zzzzzzz\r\nzzzzzzzzz     zzzzzz\r\nzzzzz\r\nz\r\nzz\r\nz\r\nz\r\nz\r\nzz\r\n\r\nzzz',254,2,1,0,0),
(282,'2019-08-30 00:35:44','123','456789',254,2,0,0,0),
(283,'2019-08-30 00:38:12','zzsdfdsfsef','<a>\r\n달라 달라 달라\r\n</a>',254,2,1,0,0),
(284,'2019-08-30 03:19:20','제발 되라...','*안녕\r\n  *안녕\r\n    *안녕\r\n\r\n###이제부터 코드\r\n``` This is a code block```',254,2,0,0,0),
(285,'2019-08-30 03:21:22','sdfsdfsd','``` This is a normal paragraph: This is a code block. end code block. ```\r\n* 빨강\r\n  * 녹색\r\n    * 파랑\r\n\r\n+ 빨강\r\n  + 녹색\r\n    + 파랑\r\n\r\n- 빨강\r\n  - 녹색\r\n    - 파랑',254,2,0,0,0),
(286,'2019-08-30 03:23:10','sdfsdfsfs','```\r\n1. List item one.\r\n+\r\nList item one continued with a second paragraph followed by an\r\nIndented block.\r\n+\r\n.................\r\n$ ls *.sh\r\n$ mv *.sh ~/tmp\r\n.................\r\n+\r\nList item continued with a third paragraph.\r\n\r\n2. List item two continued with an open block.\r\n+\r\n--\r\nThis paragraph is part of the preceding list item.\r\n\r\na. This list is nested and does not require explicit item\r\ncontinuation.\r\n+\r\nThis paragraph is part of the preceding list item.\r\n\r\nb. List item b.\r\n\r\nThis paragraph belongs to item two of the outer list.\r\n--\r\n```\r\n\r\nAnd here is the equivalent in Markdown:\r\n```',254,2,0,0,0),
(287,'2019-08-30 03:26:51','zzzzzzz','*  Item 1\r\n*  Item 2\r\n*  Item 3\r\n    *  Item 3a\r\n    *  Item 3b\r\n    *  Item 3c\r\n\r\n\r\n*Italic characters* \r\n_Italic characters_\r\n**bold characters**\r\n__bold characters__\r\n~~strikethrough text~~\r\n\r\nParagraph 1\r\n\r\nParagraph 2\r\n\r\n# This is an H1\r\n## This is an H2\r\n###### This is an H6\r\n\r\nThis is also an H1\r\n==================\r\n\r\nThis is also an H2\r\n------------------',254,2,0,0,0),
(288,'2019-08-30 03:29:25','dfsdfsdfsdf','*Italic     \r\n          characters* \r\n_Italic characters_\r\n**bold characters**\r\n__bold characters__\r\n~~strikethrough text~~\r\n*  Item 1\r\n*  Item 2\r\n*  Item 3\r\n    *  Item 3a\r\n    *  Item 3b\r\n    *  Item 3c\r\n\r\n# This is an H1\r\n## This is an H2\r\n###### This is an H6\r\n\r\nThis is also an H1\r\n==================\r\n\r\nThis is also an H2\r\n------------------\r\n\r\nsfsd\r\nsdfsdf\r\nsdfd\r\nfsd',254,2,0,0,0),
(289,'2019-08-30 14:47:33','zzzzzzzzzzzz','# 제목 1\r\n## 제목 2\r\n### 제목 3\r\n#### 제목 4\r\n##### 제목 5\r\n###### 제목 6\r\n\r\n\r\n제목 1\r\n======\r\n\r\n제목 2\r\n------\r\n\r\n\r\n이텔릭체는 *별표(asterisks)* 혹은 _언더바(underscore)_를 사용하세요.\r\n두껍게는 **별표(asterisks)** 혹은 __언더바(underscore)__를 사용하세요.\r\n**_이텔릭체_와 두껍게**를 같이 사용할 수 있습니다.\r\n취소선은 ~~물결표시(tilde)~~를 사용하세요.',254,2,0,0,0),
(290,'2019-08-30 14:49:02','2322323','<u>밑줄</u>은 `<u></u>`를 사용하세요.\r\n\r\n\r\n1. 순서가 필요한 목록\r\n1. 순서가 필요한 목록\r\n  - 순서가 필요하지 않은 목록(서브) \r\n  - 순서가 필요하지 않은 목록(서브) \r\n1. 순서가 필요한 목록\r\n  1. 순서가 필요한 목록(서브)\r\n  1. 순서가 필요한 목록(서브)\r\n1. 순서가 필요한 목록\r\n\r\n- 순서가 필요하지 않은 목록에 사용 가능한 기호\r\n  - 대쉬(hyphen)\r\n  * 별표(asterisks)\r\n  + 더하기(plus sign)\r\n\r\n[GOOGLE](https://google.com)',254,2,0,0,0),
(291,'2019-08-30 14:58:38','q121','[Dribbble][Dribbble link]\r\n\r\n[GitHub][1]\r\n\r\n문서 안에서 [참조 링크]를 그대로 사용할 수도 있습니다.\r\n\r\n\r\n구글 홈페이지: https://google.com\r\n네이버 홈페이지: \r\n\r\n[Dribbble link]: https://dribbble.com\r\n[1]: https://github.com\r\n[참조 링크]: https://naver.com \"네이버로 이동합니다!\"\r\n\r\n[Dribbble][Dribbble link]\r\n\r\n[GitHub][1]\r\n\r\n문서 안에서 [참조 링크]를 그대로 사용할 수도 있습니다.\r\n\r\n\r\n구글 홈페이지: https://google.com  \r\n\r\n\r\n네이버 홈페이지: \r\n\r\n[Dribbble link]: https://dribbble.com\r\n[1]: https://github.com\r\n[참조 링크]: https://naver.com \"네이버로 이동합니다!\"\r\n```html\r\n<a href=\"https://www.google.co.kr/\" target=\"_blank\">GOOGLE</a>\r\n```\r\n<script>\r\n  alert(\'이거 되나?\');\r\n</script>',254,2,0,0,0),
(292,'2019-08-30 15:54:05','<만나면 좋은 친구>','ㅋㄴㄹㄴㅇㄹㄴㄹㄴㄹㄴㅇ\r\nㄹㄴ\r\nㄹ\r\nㄴㄹ\r\nㄴㄹ\r\nㄴㄹㄴ\r\nㅇㄹㄴ\r\n\r\nㄹㄴ\r\nㄹ\r\nㄴㄹ\r\nㄴㄹ\r\nㄴㄹ\r\nㄴㅇ\r\nㄹㄴ',254,2,1,0,0),
(293,'2019-08-30 15:55:04','<script>alert(\'zzz\');</script>','fsfsfsfssdfs',254,2,0,0,0),
(294,'2019-08-30 15:56:47','<script>alert(\'zzz\');</script>','sdfssfsdfsd',254,2,1,0,0),
(295,'2019-08-30 15:57:37','<script>alert(\'zzz\');</script>','sdfsdfsdf',254,2,1,0,0),
(296,'2019-08-30 16:14:31','33333','# 제목1\r\n## 제목2\r\n\r\n절취선\r\n***\r\n\r\n\r\n제목 1\r\n======\r\n\r\n제목 2\r\n------\r\n\r\n이텔릭체는 *별표(asterisks)* 혹은 _언더바(underscore)_를 사용하세요.  \r\n두껍게는 **별표(asterisks)** 혹은 __언더바(underscore)__를 사용하세요.  \r\n**_이텔릭체_와 두껍게**를 같이 사용할 수 있습니다.  \r\n취소선은 ~~물결표시(tilde)~~를 사용하세요.  \r\n<u>밑줄</u>은 `<u></u>`를 사용하세요.\r\n\r\n1. 순서가 필요한 목록\r\n1. 순서가 필요한 목록\r\n  - 순서가 필요하지 않은 목록(서브) \r\n  - 순서가 필요하지 않은 목록(서브) \r\n1. 순서가 필요한 목록\r\n  1. 순서가 필요한 목록(서브)\r\n  1. 순서가 필요한 목록(서브)\r\n1. 순서가 필요한 목록\r\n\r\n- 순서가 필요하지 않은 목록에 사용 가능한 기호\r\n  - 대쉬(hyphen)\r\n  * 별표(asterisks)\r\n  + 더하기(plus sign)\r\n\r\n[GOOGLE](https://google.com)  \r\n\r\n[NAVER](https://naver.com \"링크 설명(title)을 작성하세요.\")  \r\n\r\n[상대적 참조](../users/login)  \r\n\r\n[Dribbble][Dribbble link]  \r\n\r\n[GitHub][1]  \r\n\r\n문서 안에서 [참조 링크]를 그대로 사용할 수도 있습니다.  \r\n\r\n다음과 같이 문서 내 일반 URL이나 꺾쇠 괄호(`< >`, Angle Brackets)안의 URL은 자동으로 링크를 사용합니다.  \r\n구글 홈페이지: https://google.com  \r\n네이버 홈페이지: <https://naver.com>  \r\n\r\n[Dribbble link]: https://dribbble.com  \r\n[1]: https://github.com\r\n[참조 링크]: https://naver.com \"네이버로 이동합니다!\"\r\n\r\n![대체 텍스트(alternative text)를 입력하세요!](http://www.gstatic.com/webp/gallery/5.jpg \"링크 설명(title)을 작성하세요.\")\r\n\r\n![Kayak][logo]\r\n\r\n[logo]: http://www.gstatic.com/webp/gallery/2.jpg \"To go kayaking.\"\r\n\r\n[![Vue](/images/vue.png)](https://kr.vuejs.org/)  \r\n\r\n`background`혹은 `background-image` 속성으로 요소에 배경 이미지를 삽입할 수 있습니다.  \r\n\r\n```html\r\n<a href=\"https://www.google.co.kr/\" target=\"_blank\">GOOGLE</a>\r\n```\r\n\r\n```css\r\n.list > li {\r\n  position: absolute;\r\n  top: 40px;\r\n}\r\n```\r\n\r\n```javascript\r\nfunction func() {\r\n  var a = \'AAA\';\r\n  return a;\r\n}\r\n```\r\n\r\n```bash\r\n$ vim ./~zshrc\r\n```\r\n\r\n```python\r\ns = \"Python syntax highlighting\"\r\nprint s\r\n```\r\n\r\n```\r\nNo language indicated, so no syntax highlighting. \r\nBut let\'s throw in a tag.\r\n```  \r\n\r\n| 값 | 의미 | 기본값 |  \r\n|---|:---:|---:|  \r\n| `static` | 유형(기준) 없음 / 배치 불가능 | `static` |  \r\n| `relative` | 요소 자신을 기준으로 배치 |  |  \r\n| `absolute` | 위치 상 부모(조상)요소를 기준으로 배치 |  |  \r\n| `fixed` | 브라우저 창을 기준으로 배치 |  |  \r\n\r\n값 | 의미 | 기본값  \r\n---|:---:|---:  \r\n`static` | 유형(기준) 없음 / 배치 불가능 | `static`  \r\n`relative` | 요소 **자신**을 기준으로 배치 |  \r\n`absolute` | 위치 상 **_부모_(조상)요소**를 기준으로 배치 |  \r\n`fixed` | **브라우저 창**을 기준으로 배치 |  \r\n\r\n| Header  | Another header |  \r\n|---------|----------------|  \r\n| field 1 | something      |  \r\n| field 2 | something else |  \r\n\r\n인용문(blockQuote)\r\n\r\n> 남의 말이나 글에서 직접 또는 간접으로 따온 문장.\r\n> _(네이버 국어 사전)_\r\n\r\nBREAK!\r\n\r\n> 인용문을 작성하세요!\r\n>> 중첩된 인용문(nested blockquote)을 만들 수 있습니다.\r\n>>> 중중첩된 인용문 1\r\n>>> 중중첩된 인용문 2\r\n>>> 중중첩된 인용문 3  \r\n\r\n<u>마크다운에서 지원하지 않는 기능</u>을 사용할 때 유용하며 대부분 잘 동작합니다.\r\n\r\n<img width=\"150\" src=\"http://www.gstatic.com/webp/gallery/4.jpg\" alt=\"Prunus\" title=\"A Wild Cherry (Prunus avium) in flower\">\r\n\r\n![Prunus](http://www.gstatic.com/webp/gallery/4.jpg)  \r\n\r\n| Hello   `|` You |\r\n| -------- | ---- |\r\n| Foo      | Bar  |',254,2,1,0,0),
(297,'2019-08-30 17:53:45','ㄴㅇㄹㄴㄹㄷㄹㄴ','# 제목1\r\n\r\n<u>zzzzz</u>\r\n~~안녕하세요~~',254,2,1,0,0),
(298,'2019-08-30 18:35:21','ㅋㅋㅋㅋㅋㅋㅋㅋㅋ','ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋ\r\nㅋ\r\nㅋ\r\nㅋ\r\nㅋㅋ\r\nㅋ\r\n\r\n\r\n\r\n\r\n\r\n~~ㅋㅋㅋ~~\r\nㅋㅋㅋ',254,2,1,0,0);

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
) ENGINE=InnoDB AUTO_INCREMENT=255 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `articleReply` */

insert  into `articleReply`(`id`,`regDate`,`articleId`,`memberId`,`body`,`boardId`,`delStatus`,`blindStatus`) values 
(100,'2019-08-30 18:58:11',254,254,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx<br>x<br>x<br><br>xx<br><br>x<br>x<br><br>x<br>x<br>x<br>x<br>xx<br><br>xx<br>x<br>x<br>x<br>x',1,0,0),
(101,'2019-08-26 23:02:43',249,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',1,0,0),
(102,'2019-08-29 01:01:21',279,254,'와 댓글',2,1,0),
(103,'2019-08-29 01:01:28',279,254,'곧 삭제될 예정',2,1,0),
(104,'2019-08-29 01:01:36',279,254,'관리자에 의해',2,1,1),
(248,'2019-08-24 20:27:42',248,235,'sdfdsfdfd',1,0,0),
(249,'2019-08-24 20:31:54',248,237,'sfefsef',1,0,0),
(250,'2019-08-29 16:38:57',277,237,'ㅇㄹ',2,1,0),
(251,'2019-08-29 17:03:15',276,237,'dhdh',2,1,1),
(252,'2019-08-30 20:25:32',254,254,'z\nz\nzz\nz\n\nzz\nzzzzzz\nz\n\nzzzz\n\n&amp;lt;br&amp;gt;\n\n&amp;',1,0,0),
(253,'2019-08-30 20:35:39',254,254,'<ㅠㅠㅠㅠ>\n<ㅋㅋㅋㅋㅋ>\n`네 네네네네`\n\'\'\n/\nㅋ\nㅋ\nㅋㅋ',1,0,0),
(254,'2019-08-31 00:03:45',298,254,'zzzzz\\n\\n\\n\\n\\n\\n\\n\\n\\n\n\\n\\n\\n\\nzzzzzzzzzzzzzzz',2,0,0);

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
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(169,'2019-08-29 17:52:11',254,237,'ㅎㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌ'),
(170,'2019-08-30 23:54:57',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz\nz\nz\nzz\nz\nzz\nz\n\n\n\n\n\n\n\n\n\n\nzzzzzzz\n\n\n\n\n\n\nz\nz\n\nz\n\nz\nz\nz\nzz\nz\nz\nz'),
(171,'2019-08-30 23:58:59',254,237,'zzzzzzzzzzz\nzz\nzzz\nzz\nzzz\nzzz\nzzzz\nzzz\nzzzz\nzzz\nzzzzz\nzzz\nzz');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(10,'2019-08-29 17:51:59','article',249,'ㅗㄹ호',254),
(11,'2019-08-30 23:00:33','article',297,'아니\n이거\n신고\n합니다.',254),
(12,'2019-08-30 23:08:26','article',298,'gfsdgsfsfsfd',254);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
