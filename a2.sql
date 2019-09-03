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
) ENGINE=InnoDB AUTO_INCREMENT=308 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(274,'2019-08-24 02:15:23','zzzzzzzzz','zzzzzzzz',254,1,1,0,0),
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
(293,'2019-08-30 15:55:04','<script>alert(\'zzz\');</script>','fsfsfsfssdfs',254,2,1,0,0),
(294,'2019-08-30 15:56:47','<script>alert(\'zzz\');</script>','sdfssfsdfsd',254,2,1,0,0),
(295,'2019-08-30 15:57:37','<script>alert(\'zzz\');</script>','sdfsdfsdf',254,2,1,0,0),
(296,'2019-08-30 16:14:31','33333','# 제목1\r\n## 제목2\r\n\r\n절취선\r\n***\r\n  \r\n  \r\n제목 1\r\n======\r\n\r\n제목 2\r\n------\r\n\r\n이텔릭체는 *별표(asterisks)* 혹은 _언더바(underscore)_를 사용하세요.  \r\n두껍게는 **별표(asterisks)** 혹은 __언더바(underscore)__를 사용하세요.  \r\n  \r\n<br>  \r\n<br>  \r\n<br>  \r\n  \r\n  \r\n  **_이텔릭체_와 두껍게**를 같이 사용할 수 있습니다.  \r\n취소선은 ~~물결표시(tilde)~~를 사용하세요.  \r\n<u>밑줄</u>은 `<u></u>`를 사용하세요.\r\n\r\n1. 순서가 필요한 목록\r\n1. 순서가 필요한 목록\r\n  - 순서가 필요하지 않은 목록(서브) \r\n  - 순서가 필요하지 않은 목록(서브) \r\n1. 순서가 필요한 목록\r\n  1. 순서가 필요한 목록(서브)\r\n  1. 순서가 필요한 목록(서브)\r\n1. 순서가 필요한 목록\r\n\r\n- 순서가 필요하지 않은 목록에 사용 가능한 기호\r\n  - 대쉬(hyphen)\r\n  * 별표(asterisks)\r\n  + 더하기(plus sign)\r\n\r\n[GOOGLE](https://google.com)  \r\n\r\n[NAVER](https://naver.com \"링크 설명(title)을 작성하세요.\")  \r\n\r\n[상대적 참조](../users/login)  \r\n\r\n[Dribbble][Dribbble link]  \r\n\r\n[GitHub][1]  \r\n\r\n문서 안에서 [참조 링크]를 그대로 사용할 수도 있습니다.  \r\n\r\n다음과 같이 문서 내 일반 URL이나 꺾쇠 괄호(`< >`, Angle Brackets)안의 URL은 자동으로 링크를 사용합니다.  \r\n구글 홈페이지: https://google.com  \r\n네이버 홈페이지: <https://naver.com>  \r\n\r\n[Dribbble link]: https://dribbble.com  \r\n[1]: https://github.com\r\n[참조 링크]: https://naver.com \"네이버로 이동합니다!\"\r\n\r\n![대체 텍스트(alternative text)를 입력하세요!](http://www.gstatic.com/webp/gallery/5.jpg \"링크 설명(title)을 작성하세요.\")\r\n\r\n![Kayak][logo]\r\n\r\n[logo]: http://www.gstatic.com/webp/gallery/2.jpg \"To go kayaking.\"\r\n\r\n[![Vue](/images/vue.png)](https://kr.vuejs.org/)  \r\n\r\n`background`혹은 `background-image` 속성으로 요소에 배경 이미지를 삽입할 수 있습니다.  \r\n\r\n```html\r\n<a href=\"https://www.google.co.kr/\" target=\"_blank\">GOOGLE</a>\r\n```\r\n\r\n```css\r\n.list > li {\r\n  position: absolute;\r\n  top: 40px;\r\n}\r\n```\r\n\r\n```javascript\r\nfunction func() {\r\n  var a = \'AAA\';\r\n  return a;\r\n}\r\n```\r\n\r\n```bash\r\n$ vim ./~zshrc\r\n```\r\n\r\n```python\r\ns = \"Python syntax highlighting\"\r\nprint s\r\n```\r\n\r\n```\r\nNo language indicated, so no syntax highlighting. \r\nBut let\'s throw in a tag.\r\n```  \r\n\r\n| 값 | 의미 | 기본값 |  \r\n|---|:---:|---:|  \r\n| `static` | 유형(기준) 없음 / 배치 불가능 | `static` |  \r\n| `relative` | 요소 자신을 기준으로 배치 |  |  \r\n| `absolute` | 위치 상 부모(조상)요소를 기준으로 배치 |  |  \r\n| `fixed` | 브라우저 창을 기준으로 배치 |  |  \r\n\r\n값 | 의미 | 기본값  \r\n---|:---:|---:  \r\n`static` | 유형(기준) 없음 / 배치 불가능 | `static`  \r\n`relative` | 요소 **자신**을 기준으로 배치 |  \r\n`absolute` | 위치 상 **_부모_(조상)요소**를 기준으로 배치 |  \r\n`fixed` | **브라우저 창**을 기준으로 배치 |  \r\n\r\n| Header  | Another header |  \r\n|---------|----------------|  \r\n| field 1 | something      |  \r\n| field 2 | something else |  \r\n\r\n인용문(blockQuote)\r\n\r\n> 남의 말이나 글에서 직접 또는 간접으로 따온 문장.\r\n> _(네이버 국어 사전)_\r\n\r\nBREAK!\r\n\r\n> 인용문을 작성하세요!\r\n>> 중첩된 인용문(nested blockquote)을 만들 수 있습니다.\r\n>>> 중중첩된 인용문 1\r\n>>> 중중첩된 인용문 2\r\n>>> 중중첩된 인용문 3  \r\n\r\n<u>마크다운에서 지원하지 않는 기능</u>을 사용할 때 유용하며 대부분 잘 동작합니다.\r\n\r\n<img width=\"150\" src=\"http://www.gstatic.com/webp/gallery/4.jpg\" alt=\"Prunus\" title=\"A Wild Cherry (Prunus avium) in flower\">\r\n\r\n![Prunus](http://www.gstatic.com/webp/gallery/4.jpg)  \r\n\r\n| Hello   `|` You |\r\n| -------- | ---- |\r\n| Foo      | Bar  |',254,2,1,0,0),
(297,'2019-08-30 17:53:45','ㄴㅇㄹㄴㄹㄷㄹㄴ','# 제목1\r\n\r\n<u>zzzzz</u>\r\n~~안녕하세요~~',254,2,1,0,0),
(298,'2019-08-30 18:35:21','ㅋㅋㅋㅋㅋㅋㅋㅋㅋ','ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋ\r\nㅋ\r\nㅋ\r\nㅋ\r\nㅋㅋ\r\nㅋ\r\n\r\n\r\n\r\n\r\n\r\n~~ㅋㅋㅋ~~\r\nㅋㅋㅋ',254,2,1,0,0),
(302,'2019-08-31 17:31:07','sefesfs','fsefsefesf',260,2,1,1,1),
(303,'2019-09-01 00:23:11','수정 됨','# 이거슨 제목\r\n## 이거슨 부제목\r\n\r\n\r\n~~수정됨~~',254,2,1,0,0),
(304,'2019-09-01 00:46:06','sffsef','zzzzzzzzzzzzzz  \r\nzzzzzz  \r\nzzzzz  \r\nzzzzzzz  \r\n\r\n\r\n\r\n~~sfsdfsfsdf~~',237,2,1,0,0),
(305,'2019-09-01 00:46:38','fsef','zzzzzzz  \r\nzzzzzzzzzzzz  \r\nzzzzz  \r\nzzzzzzzzzzzzzzzzz  \r\n\r\n\r\n~~dsfsd~~',254,2,1,0,0),
(306,'2019-09-03 21:11:31','33333','# 마크다운\r\n## 마크다운 사용한 것..  \r\nㅎㅎ  \r\n---\r\n***\r\nㄴㄷㄴㅅㄴㄷ\r\nㄴㄷㄹㄴㄷㄹㄷㄴ  \r\nㄴㄹㄴㄷㄹㄷㄴ  \r\nㄹㄴㄷㄹㄴㄷㄹ\r\n~~지우기~~\r\nㄴㄷㄹㄴㄷㄹ  ㄷㄴㄹㄴㄷㄹㄷ  ㄴㄷㄹㄴㄷ',263,2,1,0,0),
(307,'2019-09-03 21:15:11','ㄹㄴㄷㄹ','ㄴㄷㄹㄴㄷㄹ    ㄴㄷㄹㄴㄷㄹㄴㄷ    ㄴㄹㄴㄷㄹㄴㄷㄹㄷㄴ    ㄴㄷㄹㄴㄷㄹㄷㄴ    ㄴㄷㄹㄴㄷㄹㄷ\r\n\r\nㄴㄹㄷㄴㄹ\r\n\r\nㄴㄷㄹㄴㄷㄹ\r\n\r\nㄴㄷㄹㄴㄷ\r\n\r\nㄴㄷㄹㄴㄷㄹ  \r\n  \r\n\r\n  sef  \r\n  \r\n\r\nㄴㄹㄷㄴㄹ',263,2,0,0,0);

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
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `articleFile` */

insert  into `articleFile`(`id`,`regDate`,`articleId`,`prefix`,`originFileName`,`type2`,`type`) values 
(84,'2019-08-26 00:32:07',237,'90a271e5-17a6-4a71-a958-79b4cd0ee203-','test.jpg','image/jpeg','body'),
(86,'2019-08-26 14:57:20',248,'9c186d4a-a20e-4e97-ad42-1829f1299663-','test.jpg','image/jpeg','body'),
(87,'2019-08-26 15:09:58',249,'1e7d684f-e229-4751-a73b-0941ea9639d1-','test.jpg','image/jpeg','body'),
(93,'2019-08-29 00:39:21',279,'a8115e71-24ae-4c58-ae73-971a71b813d6-','test.jpg','image/jpeg','body'),
(95,'2019-09-01 00:24:14',303,'a3560716-2da3-4d5a-8550-b70ff0130198-','변경정보.JPG','image/jpeg','body'),
(96,'2019-09-01 00:24:14',303,'116b37f7-f494-444b-9659-dec4a8e4d4af-','새로만들었어요.JPG','image/jpeg','body'),
(97,'2019-09-03 21:12:39',306,'c6b13a71-6f86-4f55-a3ab-cf195f9bb7e0-','test.jpg','image/jpeg','body');

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
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `articleReply` */

insert  into `articleReply`(`id`,`regDate`,`articleId`,`memberId`,`body`,`boardId`,`delStatus`,`blindStatus`) values 
(100,'2019-08-30 18:58:11',254,254,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx<br>x<br>x<br><br>xx<br><br>x<br>x<br><br>x<br>x<br>x<br>x<br>xx<br><br>xx<br>x<br>x<br>x<br>x',1,0,0),
(101,'2019-08-26 23:02:43',249,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',1,0,0),
(102,'2019-08-29 01:01:21',279,254,'와 댓글',2,1,0),
(103,'2019-08-29 01:01:28',279,254,'곧 삭제될 예정',2,1,0),
(104,'2019-08-29 01:01:36',279,254,'관리자에 의해',2,0,0),
(248,'2019-08-24 20:27:42',248,235,'sdfdsfdfd',1,0,0),
(249,'2019-08-24 20:31:54',248,237,'sfefsef',1,0,0),
(250,'2019-08-29 16:38:57',277,237,'ㅇㄹ',2,1,0),
(251,'2019-08-29 17:03:15',276,237,'dhdh',2,1,1),
(252,'2019-08-30 20:25:32',254,254,'z\nz\nzz\nz\n\nzz\nzzzzzz\nz\n\nzzzz\n\n&amp;lt;br&amp;gt;\n\n&amp;',1,0,0),
(253,'2019-08-30 20:35:39',254,254,'<ㅠㅠㅠㅠ>\n<ㅋㅋㅋㅋㅋ>\n`네 네네네네`\n\'\'\n/\nㅋ\nㅋ\nㅋㅋ',1,0,0),
(254,'2019-08-31 00:03:45',298,254,'zzzzz\\n\\n\\n\\n\\n\\n\\n\\n\\n\n\\n\\n\\n\\nzzzzzzzzzzzzzzz',2,0,0),
(255,'2019-08-31 19:56:33',302,260,'dfsdfdd\nd\nf\nd\nd\nd\nd\nd',2,0,0),
(256,'2019-08-31 17:31:15',298,260,'sfsefsef',2,0,0),
(257,'2019-08-31 17:31:41',298,260,'아 수정 중입니다.ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ',2,0,0),
(258,'2019-08-31 19:52:57',302,254,'ggsrgrdg',2,1,0);

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
  `viewStatus` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `letter_toMemberId` (`toMemberId`),
  CONSTRAINT `letter_toMemberId` FOREIGN KEY (`toMemberId`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=268 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `letter` */

insert  into `letter`(`id`,`regDate`,`fromMemberId`,`toMemberId`,`body`,`viewStatus`) values 
(80,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz',0),
(81,'2019-08-07 23:18:52',234,236,'fffffffffffff',0),
(82,'2019-08-07 23:19:10',234,236,'ggggggggggggggg',0),
(83,'2019-08-08 01:24:37',237,236,'iyu',0),
(84,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ',0),
(86,'2019-08-24 22:47:08',254,237,'sfefsfs',1),
(87,'2019-08-24 22:48:32',254,237,'kl',1),
(88,'2019-08-24 22:49:05',254,237,'g',1),
(89,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',1),
(90,'2019-08-25 23:44:53',257,254,'ㅋㅋㅋㅋㅋㅋ 안녕하세요\n저는 1234입니다.',0),
(91,'2019-08-25 23:49:44',257,254,'테스트용 입니다.',0),
(92,'2019-08-25 23:50:45',257,254,'ㅋㅋㅋㅋㅋ',0),
(93,'2019-08-25 23:51:27',257,254,'ㄹㅇㄴㄹ',0),
(94,'2019-08-25 23:51:45',257,254,'123145215125',0),
(95,'2019-08-25 23:54:02',254,257,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz\nsssssssssssssssssssssssssssssssssssssss\nfsdf\nsf\nsf\nsf\nsf\ns\nfsd\nf\nsf\nsf\ns\nf',0),
(96,'2019-08-27 15:39:41',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',1),
(97,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz',0),
(98,'2019-08-07 23:18:52',234,236,'fffffffffffff',0),
(99,'2019-08-07 23:19:10',234,236,'ggggggggggggggg',0),
(100,'2019-08-08 01:24:37',237,236,'iyu',0),
(101,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ',0),
(102,'2019-08-24 22:47:08',254,237,'sfefsfs',1),
(103,'2019-08-24 22:48:32',254,237,'kl',1),
(104,'2019-08-24 22:49:05',254,237,'g',1),
(105,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',1),
(106,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz',0),
(107,'2019-08-07 23:18:52',234,236,'fffffffffffff',0),
(108,'2019-08-07 23:19:10',234,236,'ggggggggggggggg',0),
(109,'2019-08-08 01:24:37',237,236,'iyu',0),
(110,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ',0),
(111,'2019-08-24 22:47:08',254,237,'sfefsfs',1),
(112,'2019-08-24 22:48:32',254,237,'kl',1),
(113,'2019-08-24 22:49:05',254,237,'g',1),
(114,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',1),
(115,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz',0),
(116,'2019-08-07 23:18:52',234,236,'fffffffffffff',0),
(117,'2019-08-07 23:19:10',234,236,'ggggggggggggggg',0),
(118,'2019-08-08 01:24:37',237,236,'iyu',0),
(119,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ',0),
(120,'2019-08-24 22:47:08',254,237,'sfefsfs',1),
(121,'2019-08-24 22:48:32',254,237,'kl',1),
(122,'2019-08-24 22:49:05',254,237,'g',1),
(123,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',1),
(124,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz',0),
(125,'2019-08-07 23:18:52',234,236,'fffffffffffff',0),
(126,'2019-08-07 23:19:10',234,236,'ggggggggggggggg',0),
(127,'2019-08-08 01:24:37',237,236,'iyu',0),
(128,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ',0),
(129,'2019-08-24 22:47:08',254,237,'sfefsfs',1),
(130,'2019-08-24 22:48:32',254,237,'kl',1),
(131,'2019-08-24 22:49:05',254,237,'g',1),
(132,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',1),
(133,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz',0),
(134,'2019-08-07 23:18:52',234,236,'fffffffffffff',0),
(135,'2019-08-07 23:19:10',234,236,'ggggggggggggggg',0),
(136,'2019-08-08 01:24:37',237,236,'iyu',0),
(137,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ',0),
(138,'2019-08-24 22:47:08',254,237,'sfefsfs',1),
(139,'2019-08-24 22:48:32',254,237,'kl',1),
(140,'2019-08-24 22:49:05',254,237,'g',1),
(141,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',1),
(142,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz',0),
(143,'2019-08-07 23:18:52',234,236,'fffffffffffff',0),
(144,'2019-08-07 23:19:10',234,236,'ggggggggggggggg',0),
(145,'2019-08-08 01:24:37',237,236,'iyu',0),
(146,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ',0),
(147,'2019-08-24 22:47:08',254,237,'sfefsfs',1),
(148,'2019-08-24 22:48:32',254,237,'kl',1),
(149,'2019-08-24 22:49:05',254,237,'g',1),
(150,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',1),
(151,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz',0),
(152,'2019-08-07 23:18:52',234,236,'fffffffffffff',0),
(153,'2019-08-07 23:19:10',234,236,'ggggggggggggggg',0),
(154,'2019-08-08 01:24:37',237,236,'iyu',0),
(155,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ',0),
(156,'2019-08-24 22:47:08',254,237,'sfefsfs',1),
(157,'2019-08-24 22:48:32',254,237,'kl',1),
(158,'2019-08-24 22:49:05',254,237,'g',1),
(159,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',1),
(160,'2019-08-07 23:17:13',234,236,'zzzzzzzzzzzzzzzzz',0),
(161,'2019-08-07 23:18:52',234,236,'fffffffffffff',0),
(162,'2019-08-07 23:19:10',234,236,'ggggggggggggggg',0),
(163,'2019-08-08 01:24:37',237,236,'iyu',0),
(164,'2019-08-08 01:24:51',237,236,'한번ㄷ ㅓ',0),
(165,'2019-08-24 22:47:08',254,237,'sfefsfs',1),
(166,'2019-08-24 22:48:32',254,237,'kl',1),
(167,'2019-08-24 22:49:05',254,237,'g',1),
(168,'2019-08-24 22:51:56',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',1),
(169,'2019-08-29 17:52:11',254,237,'ㅎㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌ',1),
(170,'2019-08-30 23:54:57',237,254,'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz\nz\nz\nzz\nz\nzz\nz\n\n\n\n\n\n\n\n\n\n\nzzzzzzz\n\n\n\n\n\n\nz\nz\n\nz\n\nz\nz\nz\nzz\nz\nz\nz',1),
(171,'2019-08-30 23:58:59',254,237,'zzzzzzzzzzz\nzz\nzzz\nzz\nzzz\nzzz\nzzzz\nzzz\nzzzz\nzzz\nzzzzz\nzzz\nzz',1),
(172,'2019-08-31 17:02:22',259,254,'dfdfsdfd\nfd\ndfd\nfd\nfd\nd\nfd\nfd\nfdfdfdfd\nfd\nfd\nf\ndf',0),
(173,'2019-08-31 17:02:33',259,254,'ddddddddddddddd\nddddddddddddddddddddddddddddddd\nd\nddddddddddddddddddddddd\ndddddddddd\nddddddddddddddddddddddd\nddddd\nd\nd\ndd',0),
(174,'2019-08-31 18:30:52',261,254,'sefesfsefsesfs\nef\nsef\nse\nfse\nfsefe\ns\nfse\nfesf',1),
(175,'2019-09-01 16:35:50',254,261,'ㅇㅁㄹㄴㄷㄹ',1),
(176,'2019-09-01 16:58:56',254,261,'ㄹㄴㄹㄷㄴ',1),
(177,'2019-09-01 17:31:50',254,261,'ㅋㅋㅋㅋㅋㅋ',1),
(178,'2019-09-01 17:46:27',254,261,'ㅋㅋㅋㅋㅋㅋ',1),
(179,'2019-09-01 17:46:32',254,261,'아닝 이거 되는건가',1),
(180,'2019-09-01 17:46:38',254,261,'흐음..',1),
(181,'2019-09-01 17:46:42',254,261,'되는거지?',1),
(182,'2019-09-01 17:52:52',254,261,'ㅋㅋㅋ',1),
(183,'2019-09-01 17:52:58',254,261,'ㄴㄷㄹㄷ',1),
(184,'2019-09-01 17:54:10',254,261,'ㅎㅇㄱㅎㄱㅇ',1),
(185,'2019-09-01 17:54:16',254,261,'우리가',1),
(186,'2019-09-01 17:55:18',254,261,'올',1),
(187,'2019-09-01 17:59:48',254,261,'ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ\nㅋㅋㅋㅋ\nㅋ\nㅋㅋ\nㅋ\nㅋ\nㅋ\n\nㅋ\nㅋ\nㅋ\n\nㅋ\nㅋㅋ\nㅋ\nㅋ\n\nㅋㅋ\n\nㅋ',1),
(188,'2019-09-01 17:59:55',254,261,'ㅋㄴㄹㄴㄹ\nㅋ\nㄴㄹ\nㄷㄴㄹ\nㄴ\nㄹㄴ\nㄹ\nㄷㄴㄹ\nㄴㄷㄹ\nㄴㄷㄹ\nㄴㄷㄹ\nㄷㄴㄹ\nㄴㄷ\nㄹㄷ\nㄹ\nㄴㄹㄴㄷㄹㄷ',1),
(189,'2019-09-01 18:00:43',254,261,'ㅇㅇㄹㅇㄹㅇ\nㄹㅇㄹ\nㅇ\nㄹㅇ\nㄹㅇ\nㄹㅇㄹ\nㅇㄹ\nㅇ\nㄹㅇ\nㄹㅇ\nㄹ\nㅇㄹ\nㅇㄹ\nㅇㄹ\nㅇㄹㅇㄹ\nㅇ\nㄹㅇ\nㄹㅇ\nㄹㅇ\nㄹ\nㅇ\nㄹㅇ',1),
(190,'2019-09-01 18:00:53',254,261,'ㄴㄹㄷㄹㅇㄹㄴㅇ로냐도ㅑ소ㅑㄴ오ㅑ샌왜ㅑ뢔놰ㅑㄷ랴ㅗㄴㅇ래ㅗ냐ㅗㅑㄹㄷ냐론ㄷㄹㄷㄴㄹㄴㄷㄹㄴㄷㄹㄴㄷㄹ',1),
(191,'2019-09-01 18:01:03',254,261,'아아앙아아아앙\nㅇ아아앙ㅇ\nㅇ\nㅇㅇ\nㅇ\nㅇ\nㅇ\nㅇㅇ\n\nㅇ\nㅇ\nㅇ\nㅇ\nㅇㅇ\nㅇ\nㅇ\nㅇ\nㅇ\nㅇ\nㅇ\nㅇ\nㅇ\nㅇ',1),
(192,'2019-09-01 18:01:08',254,261,'ㄴㄹㄷㄹㄷㄹㄴㄷ',1),
(193,'2019-09-01 18:09:20',254,261,'fsesfsefse',1),
(194,'2019-09-01 18:09:24',254,261,'xxxxxxxxxxx',1),
(195,'2019-09-01 18:09:29',254,261,'dgrdgrd',1),
(196,'2019-09-01 18:30:18',254,261,'sefse',1),
(197,'2019-09-01 18:30:24',254,261,'sfsefsefsef\nsef\nsefse\nsef\nsef\nes\nfs\nf\nsf\nse\nf\nsef\nse\nfs\nefs\nf\nse\nfs\n\nesf\nse\nfs',1),
(199,'2019-09-01 18:36:12',237,254,'앜ㅋㅋㅋㅋ',1),
(200,'2019-09-01 18:36:20',237,254,'저... 저기..ㄴㅇㄹ',1),
(201,'2019-09-01 23:32:43',254,261,'fsfefsfeefxdfxef',1),
(202,'2019-09-02 16:16:11',254,261,'오오미',1),
(203,'2019-09-02 16:16:16',254,261,'ㅋㅋㅋㅋㅋㄴㅇㄹㄴㄹㄷ',1),
(204,'2019-09-02 16:16:24',254,261,'아닝 이거보셈ㅋㅋㅋ\nㅋ\nㅋㅋ\nㅋ\nㅋ',1),
(205,'2019-09-02 16:18:43',254,261,'ㄹㄴㄷㄹ',1),
(206,'2019-09-02 20:43:26',254,261,'sefesf',1),
(207,'2019-09-02 20:43:29',254,261,'sefexxfxefec',1),
(208,'2019-09-02 20:43:38',254,261,'아니 ㅋㅋㅋㅋㅋ',1),
(209,'2019-09-02 20:43:43',254,261,'ㅏ요론댯큐ㅠㅇㄹ',1),
(210,'2019-09-02 20:43:46',254,261,'ㄴ댜ㅠㅎ새뉴앳ㄴ',1),
(211,'2019-09-02 21:11:27',254,261,'ㄹㄴㄷㄹㄷㅌㄾㄷ',1),
(212,'2019-09-02 21:11:30',254,261,'ㄹㄷㅌㄹㅊㄾㅊㄹ',1),
(213,'2019-09-02 21:11:42',261,254,'fsef',1),
(214,'2019-09-02 21:14:05',254,261,'dkssud',1),
(215,'2019-09-02 21:14:34',261,254,'vhvjj',1),
(216,'2019-09-02 21:14:52',254,261,'sef',1),
(217,'2019-09-02 21:14:56',254,261,'sf',1),
(218,'2019-09-02 21:15:51',254,261,'sefes',1),
(219,'2019-09-02 21:15:54',254,261,'sef',1),
(220,'2019-09-02 21:19:58',254,261,'a',1),
(221,'2019-09-02 21:20:01',254,261,'b',1),
(222,'2019-09-02 21:24:25',254,261,'c',1),
(223,'2019-09-02 21:24:27',254,261,'d',1),
(224,'2019-09-02 21:25:39',254,261,'sef',1),
(225,'2019-09-02 21:25:41',261,254,'sef',1),
(226,'2019-09-02 21:26:02',254,261,'xcf',1),
(227,'2019-09-02 21:26:03',261,254,'esef',1),
(228,'2019-09-02 21:26:07',254,261,'sef',1),
(229,'2019-09-02 21:26:16',261,254,'sefse',1),
(230,'2019-09-02 21:27:34',261,254,'sf',1),
(231,'2019-09-02 21:27:39',254,261,'sefes',1),
(232,'2019-09-02 21:30:13',254,261,'sefs',1),
(233,'2019-09-02 21:30:21',261,254,'sef',1),
(234,'2019-09-02 21:30:26',254,261,'sefesf',1),
(235,'2019-09-02 21:30:30',261,254,'sefesf',1),
(236,'2019-09-02 21:34:40',261,254,'안녕하세요...',1),
(237,'2019-09-02 21:34:47',254,261,'아 읽으셨네요',1),
(238,'2019-09-02 21:34:54',254,261,'ㅋㅋㅋㅋㅋㅋㅋ',1),
(239,'2019-09-02 21:34:54',261,254,'ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ',1),
(240,'2019-09-02 21:34:59',261,254,'ㄴㄹㄷㄴㄹㄴㄷㄹ',1),
(241,'2019-09-02 21:35:02',254,261,'ㄴㄹㄷㄹㄴㄷㄹ',1),
(242,'2019-09-02 21:35:08',254,261,'ㄴㄹㄴㄷ',1),
(243,'2019-09-02 21:35:27',254,261,'ㄴㄹㄷㄴㄹ',1),
(244,'2019-09-02 21:35:31',254,261,'ㄴㄷㄹㄷㄴㄾㄹ',1),
(245,'2019-09-02 21:35:34',254,261,'ㄷㄹㄴㄹㄴㄷㄹㄴ',1),
(246,'2019-09-02 21:35:53',254,261,'ㄴㄹ',1),
(247,'2019-09-02 21:36:40',261,254,'ㄴㄷㄹㄷㄴ',1),
(248,'2019-09-02 21:36:42',261,254,'ㄴㄷㄹㄴㄷ',1),
(249,'2019-09-02 21:38:42',261,254,'ㄴㄷㄹㄷㄴㄹㄴ',1),
(250,'2019-09-02 21:38:47',254,261,'ㄴㄷㄹㄴㄷㄹㄷ',1),
(251,'2019-09-02 21:38:52',261,254,'ㅋㅋㅋㅋㅋㅋ',1),
(252,'2019-09-02 21:38:52',254,261,'ㅋㅋㅋㅋㅋㅋ',1),
(253,'2019-09-02 21:39:01',254,261,'5556546456',1),
(254,'2019-09-02 21:39:01',261,254,'ㄴㄹㄷㄹㄹㄹㄹㄹㄹㄹ',1),
(255,'2019-09-03 16:52:59',261,237,'안녕하세요 ㅋㅋㅋㅋ',1),
(256,'2019-09-03 16:53:34',261,237,'ㅎㅎㅎㅎㅎ',1),
(257,'2019-09-03 16:53:44',261,237,'아닠ㅋㅋㅋㅋ',1),
(258,'2019-09-03 16:53:53',261,237,'뭐하고 지내세요?',1),
(259,'2019-09-03 16:54:02',237,261,'그냥 뭐 그냥 지내죸ㅋㅋㅋㅋ',1),
(260,'2019-09-03 16:54:08',261,237,'아 그렇구낰ㅋㅋㅋ',1),
(261,'2019-09-03 16:54:12',237,261,'아 안녕하세요',1),
(262,'2019-09-03 16:54:22',237,261,'저 어디갔어요?',1),
(263,'2019-09-03 16:54:28',237,261,'저기요?',1),
(264,'2019-09-03 16:54:32',237,261,'아니 ㅋㅋㅋ',1),
(265,'2019-09-03 16:54:36',237,261,'ㅠㅠㅠ 머하세요',1),
(266,'2019-09-03 16:54:47',261,237,'오오',1),
(267,'2019-09-03 20:51:43',261,254,'ㅋㄴㄷㄹ',1);

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
  `delStatus` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`loginId`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `member` */

insert  into `member`(`id`,`regDate`,`loginId`,`loginPw`,`name`,`email`,`authKey`,`emailAuthStatus`,`delStatus`) values 
(226,'2019-08-06 18:00:32','ddd','9c969ddf454079e3d439973bbab63ea6233e4087','ddd','ddd@ddd.ddd','pqf318YTaCvatS8FSx70xB6VqzDb7A',0,0),
(228,'2019-08-06 18:03:09','eee','637a81ed8e8217bb01c15c67c39b43b0ab4e20f1','eee','eee@eee.eee','0qeOFvnbTgn1OCL3zPJCFRiysNRZ8B',1,0),
(230,'2019-08-06 18:08:04','fff','f6949a8c7d5b90b4a698660bbfb9431503fbb995','fff','fff@fff.fff','s9ckpV4iu06I3SXLtq3opCcdLr3KHB',0,0),
(231,'2019-08-06 18:22:04','ggg','07dcd371560bc43c48f56a2f55739ac66741d59d','ggg','ggg@ggg.ggg','jBHavd0ggVcYpPFVWdgtNlPCNkLX4b',0,0),
(232,'2019-08-06 18:23:01','hhh','effdb5f96a28acd2eb19dcb15d8f43af762bd0ae','hhh','hhh@hhh.hhh','LoOhXDR0uiFfGhFwKJcyrTkkbqqYD7',0,0),
(233,'2019-08-06 18:23:36','iii','425ffc1422dc4f32528bd9fd5af355fdb5c96192','iii','iii@iii.iii','5FFudc2HRMRY0Akp1NnQbtnAlzGvp7',0,0),
(234,'2019-08-06 18:24:29','kkk','5150d2104c8cd974b27fad3f25ec4e8098bb7bbe','kkk','kkk@kkk.kkk','llu0fgG7pqSAMw8ScNwhWFZ8CzFd5w',0,0),
(235,'2019-08-06 18:25:59','nnn','7f88bb68e14d386d89af3cf317f6f7af1d39246c','nnn','nnn@nnn.nnn','gTWwSpJMv90yvXs3e6V31aRyJRIHpE',0,0),
(236,'2019-08-06 18:27:06','qqq','a056c8d05ae9ac6ca180bc991b93b7ffe37563e0','qqq','qqq@qqq.qqq','a6t5XGWpaf8CbGqYpXtZZuucc9H332',0,0),
(237,'2019-08-06 18:28:46','www','c50267b906a652f2142cfab006e215c9f6fdc8a0','www','www@www.www','II6P5nx741kUeFg6isl8pGGJsfUmS2',0,0),
(239,'2019-08-22 16:18:37','123','123','123','123@123.123','1234545',0,0),
(240,'2019-08-22 16:49:01','1233','123','123','123@123.123','1234545',0,0),
(243,'2019-08-22 18:12:20','ㅁㅁㅁ','ㅁㅁㅁ','ㅊㅊㅊ','shdzl@naver.com5','yMX1UkJ6QUq3GDgiuIQIUY4V8m2Uwx',0,0),
(245,'2019-08-22 18:15:35','ㅠㅠㅠ12','9844f81e1408f6ecb932137d33bed7cfdcf518a3','ㅠㅠㅠ','ssd357@naver.com12','6t7BLVmHbT3wVVBEkBFmsslbWVBk3J',0,0),
(246,'2019-08-22 18:18:32','ㅁㄴㅇ','9844f81e1408f6ecb932137d33bed7cfdcf518a3','ㅁㄴㅇ','asf@sfsf.sdf','ksKfblOc1JDbhOQl2gqPg1QhEGO417',0,0),
(248,'2019-08-22 18:49:11','yyy','9844f81e1408f6ecb932137d33bed7cfdcf518a3','yyy','yyy@yyy.yyy','XQeNMcNGirpRRsmcjgdFlhSwuB8mIO',0,0),
(250,'2019-08-22 23:47:05','ㅁㅁㅁㅁㅁ','9844f81e1408f6ecb932137d33bed7cfdcf518a3','ㅁㅁㅁㅁㅁ','sdf@naver.com','83M7UQUOc4WxOkhLH8S5tHPBXqPdLg',0,0),
(251,'2019-08-22 23:48:40','1231212','9844f81e1408f6ecb932137d33bed7cfdcf518a3','1231232','sdf@naver.com1','14FFLlu4UxTTkj7xUdxisXJc76PMoP',0,0),
(254,'2019-08-23 00:06:01','nnnn','07962e32beac4da179b30c06f1c1e71bd220f782','nnnn','nnnn@nnnn.nnnn','7kP1UDDm1P6NiUpfXKOGhrRqFwqkBg',0,0),
(257,'2019-08-25 23:24:15','1234','7110eda4d09e062aa5e4a390b0a572ac0d2c0220','1234','123@123.1233','SYoVJpBMSoenR4f5SoIr8uHcCnbXd7',0,0),
(259,'2019-08-31 17:02:06','zzz','40fa37ec00c761c7dbb6ebdee6d4a260b922f5f4','zzz','zzz@zzz.zzz','kyEdC2sjK3wRVWXIPiC7kCyimLoQPp',0,1),
(260,'2019-08-31 17:30:56','abc','a9993e364706816aba3e25717850c26c9cd0d89d','abc','abc@abc.abc','uWMdVIwIUQvTCINPCX62e3TJI86u8Y',0,1),
(261,'2019-08-31 18:30:38','aab','40b904fd8852297daeaeb426b1bca46fd2454aa3','aab','ab@fd.dfod','4iSCvfU66QXkCJSM4mbEsqQD8ROigR',0,0),
(262,'2019-09-03 21:04:02','ccd','6b6efb9b042cd8fb7e3f7bd6130c49cbbb216bde','ccd','ccd@ccd.ccd','YkqvrIjtcHMHUnrlfJFKgVqPbyY8Dr',0,1),
(263,'2019-09-03 21:05:44','ccd','6b6efb9b042cd8fb7e3f7bd6130c49cbbb216bde','ccd','ccd@ccd.ccd','kwp84UIVLV5geR8Wl7I5xg2xViGN8v',0,0);

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

/*Table structure for table `memberProfileImg` */

DROP TABLE IF EXISTS `memberProfileImg`;

CREATE TABLE `memberProfileImg` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL DEFAULT current_timestamp(),
  `memberId` int(10) unsigned NOT NULL,
  `fileName` char(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `memberProfileImg` */

insert  into `memberProfileImg`(`id`,`regDate`,`memberId`,`fileName`) values 
(3,'2019-09-03 04:42:37',254,'nnnn-test.jpg');

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
