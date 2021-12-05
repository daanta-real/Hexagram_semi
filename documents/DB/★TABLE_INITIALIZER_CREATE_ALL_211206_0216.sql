
CLEAR SCREEN;


-- ★★★★★★★★★★ users ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (users)

-- 테이블/시퀀스 새로 정의 (users)
CREATE SEQUENCE users_seq;
CREATE TABLE    users (
  users_idx   NUMBER(20)   CONSTRAINT users_PK PRIMARY KEY,
  users_id    VARCHAR2(20) CONSTRAINT users_id_not_null NOT NULL
                           CONSTRAINT users_id_unique UNIQUE
                           CONSTRAINT users_id_check CHECK(
                                  REGEXP_LIKE(users_id, '^[a-z0-9_]{4,20}$')
                                  	AND
                                  REGEXP_LIKE(users_id, '.*?[a-z]+')
                           ),
  users_pw    VARCHAR2(150) CONSTRAINT users_pw_not_null    NOT NULL
                            CONSTRAINT users_pw_check       CHECK(REGEXP_LIKE(users_pw, '.*?[a-zA-Z0-9-\$]+') OR users_pw IN('admin')),
  users_nick  VARCHAR2(30)  CONSTRAINT users_nick_not_null  NOT NULL
                            CONSTRAINT users_nick_unique    UNIQUE
                            CONSTRAINT users_nick_check     CHECK(REGEXP_LIKE(users_nick, '^[a-zA-Zㄱ-ㅎ가-힣0-9]{2,10}$')),
  users_email VARCHAR2(30)  CONSTRAINT users_email_not_null NOT NULL
                            CONSTRAINT users_email_unique   UNIQUE
                            CONSTRAINT users_email_check    CHECK(REGEXP_LIKE(users_email, '^[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\.([a-zA-Z])+$')),
  users_phone CHAR(11)      CONSTRAINT users_phone_check    CHECK(REGEXP_LIKE(users_phone, '^(01[016-9])[0-9]{4}[0-9]{4}$')),
  users_join  DATE          DEFAULT SYSDATE CONSTRAINT users_join_not_null   NOT NULL,
  users_point NUMBER(20)    DEFAULT 0       CONSTRAINT users_number_not_null NOT NULL
                                            CONSTRAINT users_point_check     CHECK(users_point >= 0),
  users_grade CHAR(9)       DEFAULT '준회원' CONSTRAINT users_grade_not_null  NOT NULL
                                            CONSTRAINT users_grade_check_in  CHECK(users_grade IN('준회원', '정회원', '관리자'))
);


-- 데이터 생성 (users)
-- ※ 관리자1: ID admin1   , PW admin1@, 닉네임 관리자1
-- ※ 관리자2: ID admin2   , PW Admin1@, 닉네임 관리자2
-- ※ 회원1  : ID testtest , PW testtest1!  , 닉네임 test1
-- ※ 회원2  : ID testtest2, PW testtest2!  , 닉네임 테스트2


INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email, users_grade) VALUES(users_seq.NEXTVAL, 'admin', 'SHA-256$c9efe9476133c9f576514a3cf3abd37bb337334d0b706e510604f3215f17ddc0$ac55a3bceac096f13600e67325c031b99d6a673e6239349f0e74aa12001b43cd', '슈퍼 관리자', 'adm@a.com', '관리자');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email, users_grade) VALUES(users_seq.NEXTVAL, 'admin2', 'SHA-256$9eaf18f1dfc3ce419374cb021177e3a6f2b66d8bddbb27a73c94db357d30e8d5$8450302cf36ed7d2a5ccc33bea99b398e3f3b9e3f1f2efd4771446ad5bf287bf', '관리자2', 'vtitomm21@osmye.com', '관리자');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email, users_grade) VALUES(users_seq.NEXTVAL, 'admin3', 'SHA-256$b659984b28a2eaa833ae67f7d86be9e826159fb20f51b5b2afa4e43958082150$693efe51687c3958736dea52fda7532e7ba20ee4995c212a6c2ba108195c9b54', '관리자3', 'niwajeh557@incoware.com', '관리자');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email, users_grade) VALUES(users_seq.NEXTVAL, 'admin4', 'SHA-256$2ba096ee506a33aaad086389c38b287ed4e15131a09a2c489679c6ea984f8dac$18b2b5bcc520baae30f9dbdc83f6c4adcb2ef451a909e816b583acc9b0379677', '관리자4', 'nicktrig@gmail.com', '관리자');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email, users_grade) VALUES(users_seq.NEXTVAL, 'admin5', 'SHA-256$260b5bd0f1a6f12654a5ccdbc74fd2396b40b318d07424c16c7e370f39c9ef9e$ef4396237d135dfe19a2efbad0302a80e25419ed6856eaacbe2a4447daa0533b', '관리자5', 'noodles@msn.com', '관리자');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email, users_grade) VALUES(users_seq.NEXTVAL, 'admin6', 'SHA-256$4cb4ac0751c756cd70b9efa7623142e3ddebb6b30c9ff98f2ada93fb5c37b9ff$f35ffe4ff60a4c26e0bfebf9a3b26cddd9bf0aee366ab60a76d5af74faf9e070', '관리자6', 'gward@att.net', '관리자');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'testtest', 'SHA-256$a2b05c746ae4cd20bfac43bf1b9596578c15f1b9a915c17321593719da24197c$ad7844a81fba8563bcb84ebbb4798cd90f3236e0d0d7504334f915a3aafb144d', 'test1', 'wkrebs@outlook.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'testtest2', 'SHA-256$af1e627759bf06e2b8fb709af41c8beaad1f7a552ba5fe211df18216e2049b18$5619a4790ece7b1426cb70d4033ad3accb5234abf6ff7669a367a266b90cce0d', '테스트2', 'jeteve@att.net');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'ciga_rette', 'SHA-256$0254622de8c452b5f9c3061c26b5b37635c3d8adac5f2fc02a3d17f0e4d05f3b$856c76007813cf375b08e5cb7422eaf61c92d59ca6383f986c345676b604fc29', 'nickname5', 'elmer@yahoo.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'birthday', 'SHA-256$71e0517ac5c6718490fca9969bd5fc956a1c8fdb5eeaf24e61a11352d703da5f$5497cab985aef45f0f1d089a3f6e752a6f9f9bb87eb57189d59239f5dc28c304', '닉네임15', 'ajlitt@comcast.net');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'village', 'SHA-256$c366acd18990433483fedb97254da7c4fba4baeb4c3b2d6ac9dc7c499f7db656$1b03c2a0c8966418c5322324e493f2fb1edbbe398f61c268e812d6308ed5a26b', '닉네임17', 'mhoffman@me.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'intention', 'SHA-256$c9b3e8304ad07efa6b43b0ecc317017ba307fe38e7143253fea9534db6cfa58e$6dcf1bd555ae8afcf7464f18d756734cf7ba33baee9dab2e4bb700a22a881d13', '닉네임18', 'majordick@live.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'government', 'SHA-256$e253f4fb95a6cc375727a4cd35c66743ba1b31cdaf4629eb63bb4cd6098ad648$456fe1417297bf350edee2b8b337edb139a670ca971b5a7f1a949e2c40272bf9', '닉네임19', 'phyruxus@me.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'beer', 'SHA-256$e01033446685ef37a356ad9e617eb4fc71b990cef51bb9f823d521fdc1bb6100$7f9776f89d264cb9e33f1d1d985c77d7ac74d0c87ad8b8597b13e97a3d02b47a', '닉네임20', 'tbmaddux@yahoo.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'climate', 'SHA-256$1246e07b7e21152086587f897ce56fa0debaebfd962996f840ec8f892786548f$78b46ef688ba339adc107bb29ea74750958ebe1fa0f5343a7a27c83a0b0ded5c', '닉네임21', 'hling@live.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'sirr', 'SHA-256$deeca38690c8c738d56c66a3ceb0299c235302e3b927e4d7236b27c749557304$636850a40e6d6bb10153bcb4425f81c5254e5b34a48418f8cd997dd5b7ea9913', '닉네임22', 'jfreedma@msn.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'poet', 'SHA-256$ac8b3be851fabb1272d260dff44c0a951a3e647890affb47724700574f766487$601c86f9427b71c74d28bc114943b123b48760cc619cc26d87bb30302fcb2e00', '닉네임23', 'juliano@hotmail.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'basket', 'SHA-256$ca0347d06f7fdc70d6b0709a0a2d0e24bd7b487b332c1d43ee62d8f74ceeffef$51fc7d759372d4c16d6395b9177742a117a50655e749d97a3910367907c20b62', '닉네임24', 'rcwil@comcast.net');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'championship', 'SHA-256$ab2d74128faf50778d5fb976b8f4c78928a31829a4f170fcf3d11a54c97d4fe8$fe6dbb95ee3fbdcd35483c4874cb1d29b7253070fa5d5f76ce274e1994b9ef1a', '닉네임25', 'kmiller@comcast.net');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'ratio9', 'SHA-256$cfcd27bf147ae7f89c10149fa563f32cb11b8e06fda87b061807bb26f33b4a81$0e6fd284165b720705ccb17707908a77b3e4c697379b3ade5afba43b26eced76', '닉네임26', 'rfoley@att.net');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'coke1', 'SHA-256$decab83f3433161cff462a8fbba92ccb6b0c4f650dc0773eef3b156e46222984$94c24794e1b14c211bb1d31e9e09fae61d50b0dc312bf2b4b730a2a6853f70c2', '닉네임27', 'wenzlaff@hotmail.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'melon2', 'SHA-256$73b05e423cb29e64dbecf7e6680c6f709200628c45e6c9e33ddabf97fa79805d$997677f37c9b88385f810e3fc0f728c59ad3799bc8945ca8ec49e37e0047b9d6', '닉네임28', 'errxn@msn.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'melong3', 'SHA-256$ae0c7251291b78706fe985182aeed0306a40576e1ec40c52a1a4add1c9436ce2$18972b004e6a9bac95e3f18e8912956414c7f4ed1bab99a8648ab7d05a62e09f', '닉네임29', 'esbeck@yahoo.ca');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'session2', 'SHA-256$9d23c469fc9144a47e5ef70940eddf6548e3ad29f8e5c1770f79735871e508c0$352d012f211b3fdd8589c83852dab76e079cbab7abec04842974a38f17c91c9d', '닉네임30', 'paley@comcast.net');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'teacher9', 'SHA-256$f48c73fe23a616108b9ee131477073e7b1ebdd86c1ac7c7def932d7c716f4fdf$a8a86f2d511af384b1984fb9541103ef417b85e9eb7f78f0b615bdcd91308072', '닉네임31', 'chance@yahoo.ca');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'operation4', 'SHA-256$deab3ec6446223018edd7c7ce088e0fa27d297f02ac267f1b8c8d46d18f4f265$d59eefdddf2f4706acd1aecb524a6b1034cae5ea08e0efc374bcae7338b84847', '닉네임32', 'spadkins@icloud.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'basis9', 'SHA-256$be28808aa5b0250fbf85549eb62aca97037f2649ea6de80c5dd998b3a7dbda61$8240e88b872835bca5739e0134a47e9d89b68d969978b030ab21d69cb12bab85', '닉네임33', 'eminence@live.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'child7', 'SHA-256$bcd86e08d6629d00f58a1f82d106320830948e8521e5a8e1a5cb33ba1f706393$38f288056be52a145c6c91d3bec2422f5a6ab04ed94d4515ad6f8e1011041d80', '닉네임34', 'kingjoshi@aol.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'perception0', 'SHA-256$b1d720ca113ea606a7b5e95ac878a882451de5aec985d33d1ae2a028c953704c$6bbfe321e5d5046bcf8b485fe522878eb0e14a4ac445abe425f7eed685f26c2e', '닉네임35', 'research@msn.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'difference8', 'SHA-256$f75119b72319a46be296be3c50d0f1a8edf0f7169985b7f7aa479b57935d747f$d7fe9b48ae91a5245202ffb0c376792a4f99eaa10e91766b93de7b5c489f642b', '닉네임36', 'munson@yahoo.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'temperature1', 'SHA-256$33b75eb54aad696cd22226dc149afde30bc63376102e2a69027b4d7fb49df071$f8da7a21ef4bd12c368dd981366a625d6829d513b8368829f4ac1a399c2558f2', '닉네임37', 'cremonini@gmail.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'cell9', 'SHA-256$642ea2f77af720f21a36196b071a5357c64eda448651b3935ec4fe496d1fa51c$0560b65aa6fd883631de780e6d0fad4a9390ac5a50fa5dd85052566765362cff', '닉네임38', 'gboss@msn.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'player3', 'SHA-256$53f1bfef221f47a82651a7e8703bb9e2d462258abe55af288c5d3b9b06f0aa66$43101ceb8ba1bcafc8e7537b2526086e93b42dc74173add5e1334dbbbd34ee6a', '닉네임39', 'chrisk@optonline.net');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'depression6', 'SHA-256$66eba0d5ae3c12ae9bf76b5dda2f82ef4650b362537a3e6962aaa98474378274$e8dbc4d540cd1734561bb1fa8ceb8fccef6d629e6e84db77fba706483783bee2', '닉네임40', 'laird@outlook.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'two2', 'SHA-256$4b473cbff282122d091f52857e253b13ea8acd436a879b02b1580458348ee9f7$9755345e71c042be0f54bf2c8f30fe8e635e62f22e207d7e7b0e884fc7b23dcf', '닉네임41', 'zavadsky@hotmail.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'actor7', 'SHA-256$d54f7c1cb0e8fa7eaabb2839351f5737cb89c17b4e8121d9d1ecee9db98dfed4$b34240d4eac4910aaa8c5049cc3838cbe1834b148876a674bd8f015adf105cf7', '닉네임42', 'research@live.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'editor5', 'SHA-256$73fdf55c1f52fa5ea646b987e91934fedd022335ba94f27e259f6302170a794e$f1e34aed7c9af280d58bdb3ea263c01d2c90c7b5b625cd159fe44b4dd129cab0', '닉네임43', 'crimsane@aol.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'insurance9', 'SHA-256$ae99cceccebc55d765999e8b65d4f3a3e9eb043aff7b5f648f6ba36d4842e777$f6a8f71b419d486c9d85b574fea816e5929a34ebff9dd82d290cda12649773eb', '닉네임44', 'emcleod@msn.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'steak1', 'SHA-256$4fed7fdd9d224362cf7c39b321c7316327ecfa7ca6cf94ccd298bfe53d1137da$01d1a46b6dbe898efb69f20aa079f1eec4b3bd58efafedda5c161e23db999842', '닉네임45', 'bmcmahon@optonline.net');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'wife2', 'SHA-256$ed045d3c044a504965c23838dd48bd6c1999a99057a90a17d9232b954bb741b4$3948684561c71fba06f407dc1ce7984e8a7b01e8d5bd5fbc8175010b6770cde2', '닉네임46', 'seano@att.net');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'entry6', 'SHA-256$76f4ba0b011ebea18f06b6caa4c07ba75fd1f04893e98bb8d1cfdd7cac7e9163$8955c82589a581517a16a09784d987118528f0345f5cfc11a77dc7da81bd5910', '닉네임48', 'giafly@hotmail.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'storage5', 'SHA-256$6d658b676a9130c19f67af4ffd705601ea8276087a21328992c80c9d3e4b8c0f$75fbc4cde6fb5c708d4718b3dac463728d28951f535a1cdd46c3800a896e03fd', '닉네임49', 'kramulous@mac.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'video9', 'SHA-256$b20b5605ce22c362f0acf71cbe13446ce60c9fa4d6172d0689e887f825b19e6b$2647dee90feabd8f4bfe84f75c0d8cfe87721c05dbd2e66d3bfbc644e1a3fe63', '닉네임50', 'cgreuter@optonline.net');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'attitude6', 'SHA-256$691d3cdfca404e63e9175f007c39ac64527933fe93b99d8442101d1880775cc1$2d7dc4b54a6ffb1076837fd8d01b1b072e2612a29ce2e135ab2ad25c5ca66e2b', '닉네임51', 'loscar@verizon.net');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'dealer1', 'SHA-256$5259bc77e06c575fb847918adf9358e287ca66e51e86635669d5bc516dc4766f$8af44b18e57ce3e8bc98b6346c77f9caa379b68171c53bfc1a08f6c45aea3b20', '닉네임52', 'gavinls@verizon.net');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'love9', 'SHA-256$bfb79bedbb1a1e78604bb4cd34755339e0a89ee5646cf139190d114d9a5e0088$f28411a9fa2b78ffc7d8bb1a32ea88acaff1c49f7f7e51078eb7c238ff5c25d4', '닉네임53', 'nachbaur@icloud.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'candidate9', 'SHA-256$068f9ebaf34a900cf4fca73a54f5c9385d8cf0ac75fe20a21a3b1cb896d75f87$24bdc5a7fa383e28cac5a2c3736c9c424d1d3cb277e600c234805323bc2375a7', '닉네임54', 'metzzo@outlook.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'dad8', 'SHA-256$aa0eea0980133f9f0b624f5e9bb8bd640aa9e64fcd46a2f0452dfdf4acd8c562$a6039d505f1419db9214045688b7761a885d57c02e7845ab015df57e92c97262', '닉네임55', 'moonlapse@mac.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'midnight3', 'SHA-256$be86c36b08861e9009575821541227846db3ddcada28408f4aa8bb7a1d8a2101$a928bad4aa4886b8e30a4af8f851183c3ae0be38cc864f3f2c41e80f2e21d058', '닉네임56', 'kosact@me.com');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'africa5', 'SHA-256$97aaf067c8abe120d0e21dc8a23976bfa913d9123b8aaca1e31bb59253862065$b1a7e2c0b105b9f2bae785751d77f2af92633fc08c529d0a2d7b08834732886f', '닉네임57', 'kingjoshi@icloud.com');


-- 저장 (users)
COMMIT;

-- 테이블 데이터 보기 (users)
SELECT * FROM users;



-- ★★★★★★★★★★ item ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (item)

-- 테이블/시퀀스 새로 정의 (item)
CREATE SEQUENCE item_seq;
CREATE TABLE    item(
  item_idx         NUMBER(20)                     NOT NULL CONSTRAINT item_PK PRIMARY KEY,
  users_idx        REFERENCES users (users_idx)  ON DELETE CASCADE,
  item_type        CHAR(9)                        NOT NULL CONSTRAINT item_type_check_in  CHECK (item_type IN ('관광지', '축제')),
  item_name        VARCHAR2(100)                  NOT NULL CONSTRAINT item_name_unique UNIQUE,
  item_detail      VARCHAR2(2000)                 NOT NULL,
  item_period      VARCHAR2(100),
  item_time        VARCHAR2(100),
  item_homepage    VARCHAR2(100),
  item_parking     VARCHAR2(1000),
  item_address     VARCHAR2(200)                  NOT NULL,
  item_date        DATE                           DEFAULT SYSDATE NOT NULL,
  item_count_view  NUMBER(20)                     DEFAULT 0 NOT NULL,
  item_count_reply NUMBER(20)                     DEFAULT 0 NOT NULL
);

-- 데이터 생성 (item)

--홍대
insert into item values(item_seq.nextval, 1, '관광지','양화진외국인선교사묘원','양화진외국인선교사묘원은 서울 마포구 합정동에 위치한 외국인 선교사들의 공동묘지이다. 한국을 사랑하고 한국에 묻히기를 원했던 외국인 선교사들과 그 가족의 안식처이다. 한국기독교 선교 100주년기념교회가 관리하고 있으며 한국선교기념관이 설립되어있다.','없음','개방시간 10:00~17:00, 안내시간 월~토요일 AM 10:00, 11:30 / PM 02:00, 03:30','http://www.yanghwajin.net/v2/index.html','주차없음','서울 마포구 양화진길 46 (합정동, 양화진홍보관) ',sysdate, 0, 0);

--부산(해운대)
insert into item values(item_seq.nextval, 1, '관광지','거가대교 홍보전시관','부산-거제 간 연결도로의 기술력과 편의성 홍보를 위해 설립되었으며 부산 가덕도 가덕해양파크(휴게소) 내에 위치하고 있다. 국내 최대수심 48M에 건설된 가덕해저터널과 뛰어난 경관을 가진 사장교의 건설과정을 한눈에 볼 수 있다.
1층은 사업소개 및 건설과정에 관한 전시관이 구성되어 있으며 2층은 고객휴식공간으로 남해바다와 거가대교를 마음껏 감상할 수 있다. 전시관 투어 예약 시 전문 홍보요원의 설명과 함께 전시관 관람이 가능하다.','없음','5-10월 9시~17시 / 11월-4월 10시~17시','https://www.gklink.com','휴게소 주차시설 이용, 장애인전용 주차구역 있음 (약 소형 180대, 대형12대 주차가능)','부산광역시 강서구 거가대로 2571',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','파라다이스 카지노','부산 바다와 가장 가까운 곳에서 다양한 카지노 게임을 즐길 수 있다. 파라다이스 카지노는 본관 1층에 있으며 외국인 전용 시설로 블랙잭, 바카라, 룰렛, 슬롯머신 등 다양한 게임을 구비하고 있다.','없음','24시간','https://www.busanparadisehotel.co.kr/','주차 가능','부산광역시 해운대구 해운대해변로 296',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','영상복합문화공간','다양한 장르의 영화와 품격 있는 공연을 감상할 수 있는 부산을 대표하는 영상복합문화공간이다.
영화의전당은 다양한 장르의 영화와 품격 있는 공연을 감상할 수 있는 영상복합문화공간이다. 부산국제영화제 개·폐막식이 열리는 4000석 규모의 야외극장을 포함해 중·소극장, 시네마테크, 하늘연극장, 인디플러스 등 다양한 규모의 극장을 갖췄다.','없음','영화 상영 시간 마다 상이, 영화전문자료실 10:00~19:00','http://www.dureraum.org','있음 (소형 501면)','부산광역시 해운대구 수영강변대로 120',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','부산시립미술관','미술인구의 저변확산과 미술창작의 활성화를 목적으로 하여 1998년 3월 20일 개관한 최첨단 감각의 현대적 미술관이다. 여러 장르의 작품 전시와 각종 사회교육 프로그램을 실시하여 일반시민들에게 다양한 문화향유 기회를 제공하는 열린미술관을 지향하고 있다.
건물은 지하 2층·지상 3층으로, 전시실과 수장고, 교육연구실, 사무공간, 야외조각공원 등이 있다. 전시실은 13개의 전시실과 160석의 강당을 비롯하여 전시의 내용에 따라 내부를 적절하게 쓸 수 있도록 개폐식 구조로 되어 있다. 시립미술관에서는 격년제로 짝수 해에 개최되는 비엔날레(현대미술전) 축제의 행사장이며, 1년 내내 기획전, 소장품전, 해외미술전 등이 열려 시민들에게 예술과의 만남의 기회를 제공한다.','없음','[본관/별관] 10:00~18:00','http://art.busan.go.kr/','주차가능','부산광역시 해운대구 APEC로 58',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','해운대시장','해운대시장은 해운대해수욕장과 인접해 있어 피서철 많은 관광객들이 찾는 명소이다. 해수욕장에서 맥도날드 쪽 횡단보도를 건너 우측으로 돌아서면 여기서부터가 해운대시장 입구이다. 물론 버스가 다니는 쪽에도 입구가 있지만, 어느 쪽으로 들어오던 길은 한 방향이니 여러 군데를 돌아보면서 쇼핑을 즐기면 된다. 만일 피서철에 해운대로 온다면 부식 등은 반드시 해운대시장에서 구입하라고 권하고 싶다. 짐도 무거운데 굳이 부식까지 가져올 필요는 없다. 시장 안에 싸고 싱싱한 야채며 고기 어패류 그리고 온갖 먹을거리가 즐비하고 김밥이며 떡볶이 등과 가정의 잡다한 생활용품까지 우리를 반긴다. 물론 대형 할인점이 해운대 주변에 많지만 걸어서 먼 길 가는 것보다 사람의 정도 느끼면서 시장 구경도 하면서 필요한 것들을 구입하는 것이 재래시장의 멋이요 재미다. 고향의 추억과 구수한 인심이 살아 있는 한국의 재래시장. 그중에서도 아담하고 소박한 해운대 시장은 해운대를 찾는 내외국인 관광객들에게 인심까지 얹어주는 우리네 장터이다. 한국의 맛 김치, 쫀득한 족발, 맵삭한 곰장어, 그리고 길가에서 맛보는 만찬인 분식 등은 한국재래시장의 둘도 없는 풍물이다.','없음','09:00 ~ 22:00','https://www.haeundae.go.kr','주차가능','부산광역시 해운대구 구남로41번길 22-1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','해운대도서관','* 주민들에게 열려있는 정보 공간, 부산해운대도서관 *

새천년 지식정보화 시대를 맞이하여 해운대도서관은 지역 주민들에게 정보의 공간, 문화생 활 공간으로서의 역할을 하고 있다. 1982년 6월 부산직할시립 해운대도서관으로 개관하고 1995년 1월 부산광역시립 해운대도서관으로 명칭을 변경하였고, 2010년 1월 6일 기존 도서관은 ''부산광역시립해운대도서관 우동분관''으로 명칭을 변경하였고, 해운대 양운로에 새로 신축한 도서관을 ''부산광역시립해운대 도서관''으로 칭하였다. 이용자들의 정보욕구를 충족시키기 위해 멀티미디어실 을 운영하여 인터넷을 통한 최신의 정보를 제공하고 있으며, 또한 관광·여행자료 특성화 도서관으로서 도서, 비디오, CD-ROM, 지도 등 다양한 관광자료를 구축하여지역문화 발전에 이바지하고자 하고 있다.

* 해운대도서관의 다양한 시설 안내 *

해운대도서관은 주민 문화활동을 위해 다양한 시설을 조성, 운영하고 있다. 시설현황은 ① 종합자료실:전 주제 분야의 일반도서와 참고자료 ② 어린이실: 동화책 및 과학책, 역사책, 신문, 잡지, 인터넷 정보검색 등을 이용할 수 있는 자료실 ③ 어린이영어도서관: 영ㆍ유아들의 연령대에 맞는 다양한 영어 그림책과, 잡지, CD-ROM 자료 등 ④ 디지털자료실·연속간행물실: 다양한 콘텐츠, 국내 주요 일간지, 잡지 등이다','없음','월,토 : 09:00~18:00 / 일 09:00~17:00','https://www.haeundae.go.kr','주차 가능(지상 25면, 지하 90면, 총 115면) - 운영시간 07:00~23:00','부산광역시 해운대구 양운로 183',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','영화촬영스튜디오','부산영화촬영스튜디오는 국내 스튜디오 중 단일규모로는 최상의 사운드 스테이지를 보유하고 있으며, 완벽한 방·차음과 특수촬영시설 및 각종 부대시설을 고루 갖추고 있다. 부산영상위원회에서 운영하는 견학 프로그램을 이용하면 일부 시설 관람이 가능하다. 매주 금요일에 영화 산업 전반에 관한 이해와 더불어 영화 세트장 견학이 가능하다.','없음','월~금 09:00~18:00 (견학 매주 금요일 14:00 ~ 17:00 / 단체 일정 협의)','http://www.bfc.or.kr','인근 공영주차장 이용','부산광역시 해운대구 해운대해변로 52',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','올림픽동산','부산 올림픽동산은 제24회 서울올림픽 요트경기를 수영만에서 개최한 것을 기념하기 위해 1988년 7월 97,000㎡ 부지에 조성되었다. 올림픽동산은 야외조각공원, 자전거 놀이마당, 잔디광장, 자동차 야외극장(시네파크), 산책로 등 다양한 문화시설이 있어 부산 시민들의 휴식처로 사랑받고 있다. 요트경기장을 중심으로 하여 주변에는 길게 연결된 산책로가 있으며, 산책로를 따라 가지각색의 조형물이 자리한 야외조각공원이 있어 다양한 조각품 등을 감상할 수 있다. 그리고 넓은 잔디광장 안에 드문드문 심어져 있는 울창하고 큰 나무 그늘아래 한가로이 휴식을 취할 수 있다. 또 공원 안에는 자전거도로가 있어 관광객뿐만 아니라 부산 시민들도 많이 이용하고 있다.','없음','상시가능','https://www.visitbusan.net/kr/index.do','장애인 전용 주차구역 있음(벡스코 건물 주차장)_무장애 편의시설','부산광역시 해운대구 APEC로 58',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','SEA LIFE 부산아쿠아리움','새롭게 개장한 SEA LIFE 부산아쿠아리움은 놀라운 바닷속 세상으로 우리를 안내한다. 연면적 4,000평 규모로 지상 1층에서
지하 3층까지 이루어져 있으며, 테마별로 특성을 살린 수조와 해저터널, 수중생태계의 모든 것을 체험할 수 있는 시설을 갖추고 있다. 커다란 상어와 거북이뿐만 아니라 작은 불가사리와 해마에서부터 우아한 가오리까지 다양한 바다친구들을 가깝게 만날 수 있다. 250종, 10,000여 마리의 해양생물을 전시하고, 새롭게 변한 8개의 전시존을 통해 놀라운 경험을 선사하고자 한다. SEA LIFE 부산아쿠아리움은 바다친구들의 아름다움을 공유하고 해양 자원을 보존하기 위해 노력하고 있다.','없음','10:00 ~ 19:00 ※ 마지막 입장은 18시까지 가능','http://www.busanaquarium.com','장애인 전용 주차구역 있음(벡스코 건물 주차장)_무장애 편의시설','부산광역시 해운대구 해운대해변로 266',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','장산 (부산 국가지질공원)','부산의 도심에서 남해 바다를 내려다보며 우뚝 솟아 있는 장산은 그 범위가 넓어 다양한 등산 코스가 만들어져 있다. 해운대 마린시티와 광안대교를 조망하고 있다. 유문암질 화산활동으로 분출된 화산재, 용암, 화쇄류로 이루어진 산으로 다양한 화산암들과 장산폭포, 돌서렁 등의 웅장한 지형이 넘쳐나며 뛰어난 해안도심 경관을 즐길 수 있는 명소이다.
장산은 백악기말 칼데라의 잔존구조인 화산함몰체로 한반도 남동부의 화산활동사를 연구하는데 높은 학술적 가치를 지니고 있다. 특히 장산 자락에는 화산암 암벽에서 떨어진 거력들이 산의 경사면을 따라 길게 뻗어있는 암괴류(block stream)를 관찰할 수 있다. 총 아홉 줄기로 나뉘어져 있으며, 각각의 암괴류를 연결한 “재송너덜길”을 통해 남해, 동해 바다의 경치를 즐길 수 있는 명소이다.','없음','상시','https://www.visitbusan.net/','없음','부산광역시 해운대구 장산로 331-18',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','엑스더스카이','‘부산엑스더스카이(BUSAN X the SKY)’는 국내 두 번째 높이(411.6m)인 ‘해운대 엘시티 랜드마크타워’에 위치하고 있으며, 씨사이드뷰(Sea Side View)와 씨티뷰를 함께 조망할 수 있는 국내 최대 규모 전망대 입니다. 전망대 각 층마다 특화된 해운대 해변과 도시 야경, 광안대교, 부산항대교, 이기대, 달맞이 고개, 동백섬 등 부산의 명소를 조망할 수 있는 ‘파노라믹 오션뷰’를 자랑한다. 편안한 휴식 공간을 제공하는 ‘엑스 더 라운지’, 하늘 위의 바다를 배경으로 특별한 기억을 기록하는 ‘엑스 더 포토’, 추억을 오래도록 간직할 수 있는 기념품샵 ‘엑스 더 기프트’ 등 부산엑스더스카이만의 특화된 서비스를 제공한다.','없음','월~일 : 10:00 ~ 21:00(입장마감 20:30)','https://www.visitbusan.net/','소형/대형 주차 가능','부산광역시 해운대구 달맞이길 30',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','키자니아','2016년 4월 오픈한 키자니아 부산은 전 세계 5,000만 명 이상이 경험한 글로벌 직업체험 테마파크다. 일반적인 놀이공원과는 차별되는 ‘직업’을 테마로 하는 리얼 테마파크로, 서울 잠실에 이어 국내에서는 2번째, 전 세계 22번째로 오픈 했다.해운대 신세계 센텀시티몰 4~6층에 위치하고 있으며, 부산 및 영남권 아이들에게 70여 가지 전문적인 직업 체험 활동을 제공한다.키자니아 부산은 도시의 특색을 살려 수영만을 재현한 스크린을 통해 보트를 조종하는 ‘보트 조종스쿨’ , 야구의 도시답게 피칭캠을 통해 투수 체험을 해 볼 수 있는 ‘스포츠 중계센터’ 등 차별화 한 체험 활동을 제공하며, 진에어, 오뚜기, 신세계, MBC 등 국내외 대표기업, 공공기관과의 파트너십을 통해 전문적이고 리얼한 체험 컨텐츠를 선보이고 있다.또한 관광객의 라이프스타일에 맞춰 부모는 자유롭게 쇼핑하고, 아이는 전문 인력의 케어 아래 직업체험을 할 수 있는 ‘나홀로 키자니아’, 프라이빗 파티룸에서 생일파티를 하고 키자니아를 즐기는 ‘생일을 부탁해’ 등의 프로그램을 준비하고 있다.','없음','오전 10시 ~ 저녁 7시30분','http://www.kidzania.co.kr/web/busan/','있음','부산광역시 해운대구 센텀4로 15',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','추리문학관','* 우리나라 최초 추리문학 전문도서관, 김성종 추리문학관 *

우리나라 추리문학의 대가인 김성종씨가 문화공간의 확보와 추리문학의 활성화를 기하고자 1992년 3월 22일에 개관한 우리나라 최초의 추리문학 전문도서관이다. 1층은 카페식 열람실, 2·3층은 일반열람실로 구성되어 있다. 관람객들은 개가식 서가에서 차 한 잔과 함께 달맞이고개와 청사포 앞바다의 아름다운 풍경을 바라다보며 마음껏 책을 읽을 수 있다.

* 추리문학관에서 만날 수 있는 색다른 즐거움 *

김성종 추리문학관의 색다른 즐거움은 카페식으로 운영되는 1층. 탐정의 대명사인 셜록 홈즈의 이름을 따 ‘셜록 홈스의 집’으로 이름한 1층은 독서와 함께 차를 마시면서 담소를 나눌 수 있는 공간이다. 또한, 문학관에서는《안네의 일기 The Diary of a Young Girl Anne Frank》의 작가 안네 프랑크(Anne Frank), 표도르 도스토옙스키(Fyodor Dostoevskii), 시몬 드 보부아르(Simone de Beauvoir), 에밀 졸라(?mile Zola) 등 세계문학사에 빛나는 113명의 세계유명작가사진전을 이벤트로 상시 개최하고 있다.','없음','1층 09:00~18:30, 2,3층 09:00~18:00','없음','주차 가능(주차공간이 협소하므로 가급적 대중교통 이용)','부산광역시 해운대구 달맞이길117번나길 111',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','벡스코(BEXCO)','국제 규모의 전시·컨벤션센터, 벡스코 BEXCO(부산전시·컨벤션센터)

BEXCO는 연면적 92,761m² 건설된 국제규모의 전시·컨벤션센터이다. 21세기 세계화를 지향하는 초일류 전시컨벤션기업 건설, 수도권에 집중되어 있는 전시회 및 국제회의의 부산 개최를 통한 부산·경남 지역의 국제화·산업화·정보화에 목적을 두고 있다.

기둥이 없는 초대형 단층공간으로 공인 축구장 3배 크기의 전문전시장과, 다목적홀, 야외전시장, 상설전시장을 갖추고 있으며, 각종 첨단설비가 완벽하게 갖춰져 있어 국제전시회 및 국내전시회, 대규모 회의, 공연, 이벤트, 스포츠 행사장으로 활용되고 있다.','없음','연중무휴','http://www.bexco.co.kr','주차 가능','부산광역시 해운대구 APEC로 55',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','해운대해수욕장','* 부산 대표 해수욕장, 해운대해수욕장

부산의 대표 해수욕장인 해운대해수욕장. 백사장의 길이 1.5km, 너비 30~50m, 평균수심 1m, 면적 58,400㎥의 규모로 넓은 백사장과 아름다운 해안선을 자랑하고 있으며 얕은 수심과 잔잔한 물결로 해수욕장의 최적 조건을 갖추고 있다.''부산'' 하면 제일 먼저 떠올리는 곳이 해운대 해수욕장이라고 할 만큼 부산을 대표하는 명소이며, 해마다 여름철 피서객을 가늠하는 척도로 이용될 만큼 국내 최대 인파가 몰리는 곳이기도 하다. 특히, 해안선 주변에 크고 작은 빌딩들과 고급 호텔들이 우뚝 솟아있어 현대적이고 세련된 분위기의 해수욕장으로 유명하기 때문에 여름 휴가철뿐만 아니라 사시사철 젊은 열기로 붐비고 해외 관광객들에게도 잘 알려져 있어 외국인들이 많이 찾는 곳이다.

* 해운대해수욕장의 다양한 축제와 즐길거리

해운대해수욕장에서는 매년 정월 대보름날의 달맞이 축제를 진행하고 있다. 또한, 매년 겨울 주최하고 있는 북극곰수영대회는 이미 겨울철 대표 축제로 자리잡았다. 이외에도 모래 작품전, 부산 바다 축제 등 각종 크고 작은 행사들이 열리고 있다. 또한, 해수욕장 주변에 동백섬, 오륙도, 아쿠아리움 , 요트경기장, 벡스코 달맞이고개, 드라이브코스 등 볼거리가 많으며, 국내 1급 해수욕장답게 주변에는 일급 호텔을 비롯한 숙박, 오락시설 및 유흥 시설들이 잘 정비되어 있어 편안한 휴식을 즐길 수 있다.','없음','09:00 ~ 18:00','http://sunnfun.haeundae.go.kr','주차가능','부산광역시 해운대구 해운대해변로 264',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','마린시티','밤이 되면 화려하게 불을 밝히는 마린시티는 세계적으로 유명한 홍콩이나 상하이도 부럽지 않은 아경을 가지고 있는 곳이다. 마린시티의 야경을 보고 있으면, 외국의 도시에 있는 듯한 착각을 불러일으킨다. 거리에는 외국 음식점은 물론이고 고풍스러운 카페와 주점이 있어 많은 관광객들이 찾고 있다.',NULL,NULL,'http://www.haeundae.go.kr/tour/index.do',NULL,'부산광역시 해운대구 우동',sysdate, 0, 0);

-- 인천(중구)
insert into item values(item_seq.nextval, 1, '관광지','중구문화원','인천중구문화원은 지역문화진흥을 위한 사업을 함으로써 지역주민들이 문화를 공유하고 가치 있는 삶을 누리게 하는 것이 우선이다. 인천중구문화원은 문화예술강좌 12개 과목 및 각종 문화행사 개최 지역축제의 주관 등 다양한 사업을 하고 있다. 나아가 중구민의 풍요로운 삶의 추구, 지속적인 지역문화 공동체 교육, 구민의 건강·정서·문화·복지·참여기회 확대라는 중구문화원의 본연의 목적으로 새롭고 특성화된 프로그램 연구·개발을 하고 있다.',NULL,'09:00~18:00','http://jemulpo.kccf.or.kr','주차 가능','인천광역시 중구 축항대로296번길 81',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','생활사전시관','과거와 현재가 넘나드는 이곳, 역사와 문화가 공존하는 인천중구, 중구생활전시관은 제1관 대불호텔 전시관과 제2관 생활사전시관(1960~1970년대)으로 되어 있다. 대불호텔 전시관은 우리나라 최초의 서양식 호텔인 대불호텔의 역사를 소개하는 전시관이며, 생활사 전시관에서는 1960~1970년대 인천중구의 생활사를 볼 수 있다.',NULL,'09:00~18:00(입장마감 17:30)','https://www.icjg.go.kr/tour/index','주차 가능','인천광역시 중구 신포로23번길 101',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','개항박물관','과거와 현재가 넘나드는 이곳, 인천개항역사의 중심지에 자리 잡은 인천개항박물관은 개항기 인천을 통해 소개된 근대문화의 다양한 모습을 통해 개항이후 근대 인천의 면모를 학습할 수 있는 박물관입니다.',NULL,'09:00~18:00(입장마감 17:30)','http://www.icjgss.or.kr/open_port/','주차 가능','인천광역시 중구 신포로23번길 89',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','차이나타운','인천 차이나타운은 1883년 인천항이 개항되고 1884년 이 지역이 청의 치외법권(治外法權, extraterritoriality) 지역으로 지정되면서 생겨났다. 과거에는 중국에서 수입된 물품들을 파는 상점들이 대부분이었으나 현재는 거의가 중국 음식점이다. 현재 이 거리를 지키고 있는 한국 내 거주 중국인들은 초기 정착민들의 2세나 3세들이어서 1세들이 지키고 있었던 전통문화를 많이는 지키지 못하고 있지만 중국의 맛만은 고수하고 있다.',NULL,'09:00~18:00(입장마감 17:30)','http://chinatown.alltheway.kr/','주차 가능','인천광역시 중구 차이나타운로59번길 20',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','삼치거리','동인천역 앞 인천학생문화회관 옆 골목이 삼치골목이다. 이골목은 지금부터 40여 년 전 ''인하의 집'' 이라는 식당이 생기면서 시작됐다. 당시 인하의 집은 가정집에서 손님을 받았다. 또한 지금 삼치골목이 아니라 그 뒷골목에 인하의 집이 있었다. 지금처럼 식당을 차린 것은 30년이 약간 못 된다. 그때부터 지금의 삼치골목 거리에 삼치집이 하나 둘씩 생기기 시작했다. 삼치골목도 처음부터 삼치를 구워냈던 것은 아니다. 다른 여러 안주 가운데 삼치가 인기를 끌어서 삼치가 대표메뉴가 됐던 것이다. 이렇게 해서 삼치골목으로 자리잡게 됐다.
지금 삼치골목 인하의집 근처 벽면에 보면 처음 이 거리에서 삼치를 구웠던 인하의집 할머니와 아주머니가 벽화에 등장한다. 그 두 분의 힘으로 삼치골목이 지금처럼 꾸며지게 된 것이다. 십여 집이 이 골목에서 성업중이다. 2002년에는 구에서 삼치구이거리로 지정하여 골목 입구에 입간판을 세우기도 했다. 지금은 예전의 대문짝만한 간판을 다 없애고 각 식당마다 특색 있고 예쁜 간판으로 다 바꿨다. 간판이 바뀌니 골목 분위기도 그럴듯 하게 바뀌었다. 이 골목 삼치는 뉴질랜드 산이다. 삼치를 구워내는 방식과 찍어 먹는 소스에 따라 약간의 맛 차이가 난다. 또한 삼치 이외의 안주도 집 마다 많이 내놓고 있다.',NULL,'점포마다 다름','http://itour.incheon.go.kr','주차 가능','인천광역시 중구 우현로67번길 57',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','갑문홍보관','인천항은 우리나라의 대표 항만시설 중 하나로써, 중국과 수도권 물류의 교류거점 역할을 담당하고 있다. 갑문이 있는 항구에는 5만 톤급의 대형선박도 입출항이 가능한 수출입 화물 전용부두가 운영되고 있다. 인천항 갑문홍보관 4층에는 홍보관과 야외공원이 있고, 5층에는 전망대가 자리하고 있다.',NULL,'월~금 09:00~18:00 (토·일 및 공휴일,근로자의 날(5.1) 휴무)','https://www.icpa.or.kr/request/step1.do?menuKey=48','주차 가능','인천광역시 중구 월미로 376',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','인천대교','첨단공학의 집합체로 수많은 기록과 화제를 낳은 인천대교가 52개월의 역사 끝에 드디어 2009년 10월 16일 개통했다.바다를 가로지는 그 길이와 웅장함에 사업기간 내내 세간의 관심을 한몸에 받았고 또한 국내 최초로 사회간접자본 사업에 외국인이 사업시행자로 참여하여 시공과 시행을 분리한 국제금융 프로젝트로 추진되어 사업추진방식의 혁신성으로도 높이 평가되었다.21.38km로 우리나라 최장 다리가 된 인천대교는 다리 길이로는 세계7위, 교량으로 연결된 18.38km의 사장교 길이로는 세계6위, 주탑과 주탑 사이를 가리키는 주경간 800m 거리의 사장교 규모로는 세계5위이다.2조 4,234억이 투입된 총 21.38km의 인천대교는 해상교량 부분 12.34km이며, 왕복 6차선이며, 인천대교의 하이라이트인 주탑 높이는 230.5m로 63빌딩 높이에 육박하니 그 규모를 짐작할 것이다. 인천대교를 달릴 때, 첫 번째는 바다를 가르는 청량감에, 두 번째는 차를 춤추게 하는 거친 바람에, 마지막의 거대한 주탑의 위세에 놀라게 될 것이다. 파리의 에펠탑, 뉴욕의 자유여신상, 시드니의 오페라하우스에 비견되는 인천의 인천대교를 꼭 한번 드라이브 해보시길 권한다.인천대교는 국제비지니스 도시로 발돋움하는 송도와 국제공항이 갖춰 세계적 물류복합단지로 조성중인 영종을 20분안에 연결하며, 제2, 제3경인고속도로 및 서해안 고속도로와 연결되어 서울 남부 및 수도권 이남의 인천공항까지의 통행시간은 40분 이상 단축된다.',NULL,NULL,'http://www.incheonbridge.com','장애인 전용 주차구역 있음(인천대교 기념관,달빛축제공원 역도경기장)_무장애 편의시설','인천광역시 중구 인천대교고속도로 3',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','인천국제공항','인천국제공항은 21세기 수도권 항공운송 수요를 분담하고 동북아시아 허브(Hub)공항으로서의 역할을 담당하기 위해 개항한 대한민국의 대표 국제공항으로 1992년 영종도와 용유도 사이의 매립공사를 시작으로 8년 4개월을 거쳐 2001년 3월 29일 개항하였다. 제1·제2 여객터미널과 탑승동, 활주로 3본, 제1·제2 교통센터, 여객계류장과 화물계류장, 화물터미널, 관제탑 등이 있다. 제1 여객터미널은 지하 1층 지상 4층 규모로 44개의 탑승구가 있으며, 아시아나항공을 비롯한 42개 항공사가 배치되어 있다. 제2 여객터미널은 지하 2층, 지상 5층 규모로 대한항공이 실질적인 전용으로 사용하는 가운데 에어프랑스·KLM항공·델타항공이 함께 배치되어 있다.',NULL,'NULL','https://www.airport.kr/ap/ko/index.do','장애인 주차장 있음_무장애 편의시설','인천광역시 중구 공항로 272',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','인천국제공항 제2여객터미널','2001년 개항 이래 세계 공항서비스 평가에서 12년 연속 1위를 하며 세계인들에게 인정받은 인천국제공항이 2018년 제2여객터미널을 공식 개장했다. 2009년 공사에 착수한 지 9년 만에 문을 연 제2여객터미널은 아트포트(Artport·Art+Airport) 개념의 엔터테인먼트 공간으로 꾸며져 볼거리, 즐길 거리가 가득하다. 승객을 위한 편의도 한층 업그레이드 되어 무인탑승수속기와 스마트카운터에서 자동 수화물 위탁을 이용하여 탑승시간을 줄이며 안내로봇, 양방향 정보안내 등 각종 첨단기술로 여행객 안내를 강화하고 항공보안 또한 강화했다. 현저히 줄어든 탑승수속시간에는 공항에서 제공하는 각종 문화공간 및 볼거리를 즐길 수 있다. 전국에서 엄선한 맛집이 모여있는 ''한식미담길''부터 프랜차이즈 식당과 다양한 디저트까페까지 입점해 있으며, 실내정원과 각종 설치미술, 전시관이 꾸며져 있어 문화예술공간으로써의 기능도 갖추고 있다. 또한, 한국전통문화센터 앞에서 각종 공연도 펼쳐진다.',NULL,'NULL','http://airport.kr','장애인 주차장 있음_무장애 편의시설','인천광역시 중구 제2터미널대로 446',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','인천항 갑문','인천항 갑문은 해발 102m의 풍광이 수려한 월미산과 소월미도 사이에 위치하고 있으며, 갑문주변의 2만여평에 달하는 조경지역에는 넓은 잔디밭과 해송, 은행나무, 벗나무를 비롯한 수십종의 수목이 주변을 수려하게 장식하고 있다. 특히 봄철에는 연산홍, 벚꽃, 철쭉, 목련 등이 아름다운 경관을 연출한다. 갑문개방행사 기간중에 가족과 함께 인천항 갑문을 방문하면 바다 전경은 물론, 갑문식 도크를 통하여 대형화물선 및 여객선 등이 입출항하는 모습을 가까이서 지켜볼 수 있으며, 갑문조경지역내에서 휴식과 갑문관리소 상황실에서 인천항을 소개하는 멀티비젼을 볼 수 있어 교육적 효과를 누릴 수 있다. 축조된 갑문은 2기로서 1기는 폭 36m, 길이 363m이며, 다른 1기는 폭 22.5m, 길이 202m이다. 전자는 5만 DWT급, 후자는 1만 DWT급 선박의 통행이 가능하며,갑문의 1일 최대처리능력은 입항 20척, 출항 20척이다.',NULL,'NULL','http://www.icpa.or.kr','장애인 전용 주차구역 있음','인천광역시 중구 월미로 376',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','자유공원(인천)','자유공원은 인천항 개항 5년 만에 만들어진 우리나라 최초의 서구식 공원이다. 지대가 높은데다 터가 넓고 숲이 울창해 산책하기 알맞다. 정상엔 한미수교 백주년기념탑이 있다. 1882년 4월 우리나라와 미국 사이에 조인된 한미수호 통상조약체결을 기념하기 위해 100주년이 되는1982년에 세운 것이다. 한국전쟁 당시 인천상륙작전을 성공시킨 맥아더장군의 전공을 기리는 맥아더장군 동상도 그 옆에 있다. 인천상륙작전 성공 이후 7주년이 되는 1957년 9월 15일에 완공됐다. 자유공원 정상에서는 멀리 인천 앞바다까지도 훤히 내려다보인다. 자유공원 안에는 소규모 동물원과 팔각정, 연오정, 의자 등 쉼터가 마련되어 있다. 맥아더 동상이 있어 자녀와 함께 온다면 교육적으로도 좋다.

매년 4월이면 자유공원으로 오르는 길은 벚꽃으로 만발한다. 이를 기념해 벚꽃축제가 이곳에서 열린다. 공원 정상에서 인천항과 월미도를 바라보는 맛도 그만이다. 늦은 밤 이곳에서 바라보는 인천항의 밤 경치는 연인들의 데이트코스로도 유명하다. 인근에 중국인촌, 신포동시장, 인천백화점, 올림포스관광호텔 등이 있다. 약간 멀리는 연안부두, 월미도가 있다. 시간이 허락한다면 내려오는 길에 홍예문을 보고 오는 것도 좋다. 일본인들이 자국의 조계와 축현역(현 동인천 역)을 연결시키려고 응암산 줄기를 뚫어 1906년 착공했다. 1908년 준공했는데 고개문의 형태가 무지개와 같아 홍예문이라고 불렀다.',NULL,'상시 가능','http://www.icpa.or.kr','공영주차장 주차 가능','인천광역시 중구 제물량로232번길 46',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','용궁사(인천)','지금부터 1,300여 년 전인 신라 문무왕 10년(670년)에 원효대사가 창건하여 산 이름을 백운산, 절 이름을 백운사라 하였다. 흥선대원군이 이 절에 머물면서 10년 동안 기도를 했다. 1864년에 아들이 왕위에 오르자, 흥선대원군은 절을 옛터에 옮겨 짓고, 구담사에서 용궁사로 이름을 바꾸었다. 일설에는 영종도 중산 월촌에 사는 윤공이란 어부가 꿈을 꾼 뒤 바다에서 작은 옥불을 어망으로 끌어올려 이 절에 봉안했다는 전설에 따라 붙여진 이름이라고도 한다. 현재 대원군이 중건한 관음전과 대원군의 친필 현판이 걸려 있는 대방, 그리고 칠성각과 용황각 등의 객사가 남아 있다. 이곳 관음전에는 관음상이 고풍스러운 후불탱화를 배경으로 앉아있다. 절 기둥에는 해강 김규진이 쓴 시가 새겨져 있다. 절 입구에는 둘레가 5.63m, 수령 1,000년이 넘는 느티나무 고목 두 그루가 서 있다. 용궁사로 향하는 오솔길은 사색의 숲이다. 햇빛 한 점 들어올 틈 없이 빽빽이 들어선 나무 숲길을 한 15분쯤 걸어가면 그림을 그린듯이 산 중턱에 사찰이 안겨 있다.',NULL,'00:00~24:00','http://itour.incheon.go.kr','주차 가능(약 15대)','인천광역시 중구 운남로 199-1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','짜장면박물관','짜장면박물관은 개항기 인천에서 탄생해 이제는 “한국 100대 민족문화 상징”의 반열에 오른 한국식 짜장면의 역사와 문화적 가치를 조명하기 위해 건립된 박물관이다.

* 개관일 : 2012년 4월 28일
* 문화재명 : 인천 선린동 공화춘(共和春) - 등록문화재 제246호(2006.04.14 지정)',NULL,'09:00~18:00 (입장마감 17:30)','http://www.icjgss.or.kr/jajangmyeon/','없음(공영주차장 이용)','인천광역시 중구 차이나타운로 56-14',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','월미테마파크','자연풍광이 뛰어난 월미도에서 1992년 개장이래 많은 사랑을 받아오던 마이랜드를 시작으로, 2009년 월미테마파크라는 4000평 규모의 대규모 시설로 재 탄생하였다. 월미테마파크는 지상 70M높이 하이퍼 샷·드롭 부터 월미도의 타가다디스코, 2층바이킹, 115M 대관람차 등어트랙션이 완비되어 있어 ''우리결혼했어요'', ''1박 2일'', ''런닝맨'' 등 다양한 방송출연지로 전국적인 유명세를 떨치고 있다. 2,500평 규모 실내 어린이 놀이체험관 차피패밀리파크와 물놀이 시설 미니후룸라이드, 물놀이보트, 물공놀이 등 어린이 놀이시설, 4D영상관 까지 어린아이부터 어른까지 모두가 즐길 수 있는 곳이다.',NULL,'평일 10:00~21:00, 주말/공휴일 10:00~23:00','http://www.my-land.co.kr','있음(한국 이민사박물관 옆 월미공원 박물관 주차장)','인천광역시 중구 월미문화로 81',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','송월동 동화마을','송월동은 소나무가 많아 솔골 또는 송산으로 불리다가 소나무 숲 사이로 보이는 달이 운치가 있어 지금의 이름으로 불리우고 있다. 1883년 인천항이 개항된 후에는 독일인들을 비롯한 외국인들이 거주하기 시작하면서 부촌을 형성하였으나, 수십 년 전부터 젊은 사람들이 떠나고 마을에는 연로하신 분들이 살다 보니 활기를 잃고 침체되었으며, 빈집들은 방치되고 있었다. 이런 열악한 주거환경을 개선하기 위해 꽃길을 만들고 세계 명작 동화를 테마로 담벼락에 색칠을 하여 동화마을로 변화하였다.',NULL,'연중무휴','http://www.icjg.go.kr/tour','있음(주변주차장 이용)','인천광역시 중구 동화마을길 38',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','선녀바위','용유도 남쪽 거잠포에서 마시안해변을 지나 선녀바위와 을왕리/왕산해변까지 이어지는 수도권에서 가까운 해변이 있는 곳이다. 그 중 선녀바위는 선녀가 무지개를 타고 내려와 놀았다고 해서 이름붙여졌다고 한다. 뾰족한 바위가 바다의 풍광과 잘 어우러지고 바위로 잔잔하게 부서지는 파도가 일품이라 이곳의 풍경을 캔버스 위의 수채화로 담기 위하여 사생지로도 많이 이용되고 또, 어둠이 깔리는 해질녘 검은 바위 너머로 붉게 물드는 낙조를 감상하기 위해 찾아오는 관광객 또한 많다. 선녀바위 뒷편에 있는 작은 선착장에는 아담하고 낡은 고깃배와 어부들이 조용한 시골 어촌의 소박하고 멋스러운 풍경을 연출한다. 이 곳은 을왕리나 왕산 해수욕장에 비해 한적하게 해수욕과 캠핑을 즐기기에 좋다.
선녀바위 윗쪽으로 난 골목을 따라 언덕 위로 올라가면 언덕 끝에 예쁜 까페가 있어, 조용히 차를 마시며 까페 창가에 앉거나 야외테라스에서 바라보는 바다의 절경이 일품이다. 또, 까페의 뒤에는 바다가 바라보이는 정원이 있어 소나무 사이로 감상하는 일몰 또한 아름답다.',NULL,'연중무휴','http://www.icjg.go.kr/tour',NULL,'인천광역시 중구 용유로380번길 21',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','을왕리해수욕장','인천광역시 중구 을왕동에 있는 해수욕장으로, 늘목 또는 얼항으로도 불리며 1986년 국민관광지로 지정되었다. 백사장 길이는 약 700m, 평균 수심은 1.5m로 비교적 규모가 큰 편이다. 울창한 송림과 해수욕장 양쪽 옆으로 기암괴석이 늘어서 있어 경관이 매우 아름답다. 특히 낙조가 아름답기로 서해안에서 손꼽힌다. 간조 때에는 백사장의 폭이 200m 정도 드러난다. 해수욕장으로는 드물게 넓은 잔디밭과 충분한 숙박시설이 갖춰져 있어 각종 스포츠를 즐길 수 있으며, 청소년들의 단체 수련을 위한 학생야영장, 수련장 등이 마련되어 있다. 배를 빌려 바다로 나가면 망둥어와 우럭·노래미·병어·준치 등도 많이 잡을 수 있다. 해수욕과 스포츠, 낚시 등을 다양하게 즐길 수 있는 종합휴양지로 적격이다.',NULL,'연중무휴','http://rwangni-beach.co.kr/','주차 가능','인천광역시 중구 용유서로302번길 16-15',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','용동큰우물','인천광역시 중구 인현동에 있는 조선 후기 우물이다. 1996년 6월 12일 인천광역시민속자료로 지정되었다. 처음에는 자연 연못으로 수량이 많고 물 맛도 좋아 식수로 이용되어왔다. 그후 1883년 제물포구를 기점으로 한 인천의 개항과 함께 현재와 같은 우물로 만들어졌다. 내부는 자연석과 가공된 돌을 둥글게 쌓아 만들었고 지상에 드러난 부분은 원형의 콘크리트 관으로 마감하였다. 1967년 우물을 보호하기 위해 한식 기와 지붕의 육각형 정자를 건립하였고 현판은 인천 출신의 서예가 박세림(朴世霖)이 썼다. 이 주변을 큰 우물 거리라고 부르며 상수도가 보급되기 전까지 용동 일대의 상수원이었다.',NULL,NULL,'http://www.icjg.go.kr/tour',NULL,'인천광역시 중구 우현로90번길 19-13',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','무의도','무의도는 인천광역시 중구에 위치한 섬이다. 과거에는 배를 타야만 갈 수 있었으나, 2019년 무의대교가 개통되면서 차량 접근이 가능해졌다. 다만 다리 개통 이후 교통량이 10배 가까이 늘면서 2019년 7월 29일까지 주말과 공휴일 무의도 입도 차량을 900대로 제한한다. 무의도 주변에는 실미도, 소무의도 등의 섬이 있는데 연륙교가 연결되어 있어(광명항선착장에서 소무의도)도보로 10분~15분이면 소무의도에 갈 수 있다.
큰무리선착장에서 광명항까지는 무의도 마을버스로 이동할 수 있다. 소무의도의 아름다운 풍경을 제대로 감상하기 위해서는 무의바다누리길 8코스를 걸어야 한다. 1시간 정도 소요되며 ''소무의 인도교길''과 ''명사의 해변길''을 따라 서해바다의 아름다운 경치를 감상할 수 있다.
무의도에는 두개의 해수욕장이 유명하다. 하나개 해수욕장과 사유지인 실미해수욕장이다. 특히 실미해수욕장에서는 썰물 때 바닷길이 열려 실미도까지 걸어갈 수 있다. 또 하나개해수욕장에서는 호룡곡산, 국사봉 등의 등산까지 즐길 수 있도록 되어 있다.
* 실미해수욕장
실미 해수욕장은 2km에 달하는 초승달 모양의 해변 모래사장과 100여년씩 된 아름드리 소나무가 군락을 이루고 있다. 또한 썰물 때에는 실미해수욕장과 실미도 사이의 갯벌에는 아직도 낙지가 집을 짓고 민챙이와 칠게, 고동이 살아숨쉬는 등 갯벌이 살아있는 곳이기도 하다. 또한 울창한 노송숲을 사이에 두고 산림욕장과 텐트야영장 등이 있다.',NULL,'연중무휴','http://muui-do.co.kr/','주차 가능','인천광역시 중구 대무의로 310-11',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','씨사이드파크하늘구름광장','영종도 하늘구름광장에서 영종진공원 구간은 영종도 트레킹 코스로 유명하다.
하늘구름광장에는 레일바이크 매표소와 승강장이 있어 가족 단위 영종도 관광객들이 많이 찾는다.
영종진 공원에는 영종 역사관과 세계여행 박물관이 있으며 숲속 야외무대도 있다.
여름이 되면 어린이 물놀이 시설이 가동되며 특히 경관 폭포는 레일바이크길 양쪽에서 시원한 물줄기를 쏟아내 하늘 구름광장의 대표 볼거리 중 하나이다.',NULL,'상시 개방','https://www.insiseol.or.kr/institution_guidance/seaside/sub/institution.asp#institution07','주차 가능','인천광역시 중구 하늘달빛로2번길 6',sysdate, 0, 0);

--대구 (무작위)
insert into item values(item_seq.nextval, 1, '관광지','팔공산도립공원(갓바위지구)','팔공산은 경산시의 북쪽에 위치한 해발 1192.3 m의 높은 산으로 신라시대에는 중악, 부악으로 알려진 명산이다. 이곳에는 관봉석조여래좌상(갓바위), 원효사, 천성사, 불굴사 등 신라 고찰과 문화유적이 많다.
* 전체면적 - 95.687㎢(9,569ha)
* 공원구역 - 91.487㎢(9,149ha)
* 공원보호구역 - 4.2㎢(420ha)',NULL,'00:00~24:00','https://www.gb.go.kr/Main/open_contents/section/palgong/index.do','주차 가능','경상북도 경산시 와촌면 갓바위로81길 716-64',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','불로동 고분군','* 삼국시대 고분군, 불로동 고분공원 *

금호강이 흘러가는 동구 불로동 일대 야산에 200여기의 고분군이 있다. 불로동은 왕건이 동수전투(일명 : 공산전투)에서 패하여 도주하다 이 지역에 이르자 어른들은 피난가고 어린아이들만이 남아있어 붙여진 이름이다. 이 고분들은 삼국시대의 것으로 추정되며 사적으로 지정되었다. 이미 일제 강점기 때 이 고분들을 조사한 적이 있는데 당시에는 경북 달성군 해안면에 속하여 해안면 고분군이라 불렀다. 이곳 불로동 고분들은 삼국시대에 조성된 것으로 옛날 이 지역을 다스렸던 토착지배세력의 집단묘지로 추정된다.

* 불로동 고분군의 유물 *

불로동 고분군은 불로동과 입석동의 구릉에 분포하고 있었는데, 1938년 11월 입석동 쪽 고분 2기를 조사하여 해안면 고분으로 불려졌다. 그 뒤 1963년 12월과 이듬해 1월 두 차례에 걸쳐 경북대학교 박물관에서 불로동 고분 2기를 조사한 뒤 입석동 고분을 포함하여 대구 불로동 고분군으로 알려지게 되었다. 봉토의 지름은 1∼28m 내외이고 높이는 4∼7m 정도이다. 전체적으로 불로동 고분군은 위치가 구릉이라는 점과 봉토 내부가 돌무지 무덤과 비슷하게 할석으로 축조된 점, 그리고 돌방이 지나치게 세장(細長)한 점 등이 구암동과 내당동 고분군과 유사하여, 같은 계열임을 짐작케 한다. 전체 고분군의 축조시기는 대략 5∼6세기에 걸치는 것으로 추정된다.',NULL,'연중무휴','https://dong.daegu.kr/main/',NULL,'대구광역시 동구 불로동',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','동화사','대구 도심에서 동북쪽으로 22km 떨어진 팔공산 남쪽 기슭에 신라 소지왕 15년(493년)에 극달화상이 세운 절로, 그때 이름은 유가사였으나, 흥덕왕 7년(832년)에 심지왕사가 다시 세울 때 겨울철인데도 경내에 오동나무가 활짝 피었다고 해서 동화사라 이름을 고쳐 불렀다고 한다. 절 입구는 수목이 우거져 있고 사철 맑은 물이 폭포를 이루며 흐른다. 지금의 대웅전은 1727년에 중건한 것이며 염불암을 비롯하여 6개의 암자를 거느리고 있다. 대웅전 앞 누각에 ""영남치영아문""이라는 현판이 있어 사명대사가 임진왜란때 승군을 지휘한 본부가 동화사임을 알 수 있다. 한편, 동화사 경내에는 통일을 기원하는 높이 33m의 통일약사여래대불을 세워 온 국민의 통일 염원을 모으고 있으며, 대구 경북지역을 관리하는 대한 불교 조계종의 9교구 본사이다.

[팔공산약사여래통일대불]
동화사 경내에 있는 석조대불이다. 이 대불은 1990년 11월 부터 조성에 착수하여 2년여의 대대적인 공사 끝에 1992년 11월 27일 점안법회를 가짐으로써 완공되었다. 불상의 총 높이는 30m이며, 그 중 좌대의 높이가 13m에 달하고 둘레는 16.5m에 이르러 세계 최대의 석불로 알려져 있다. 전북 익산에서 나오는 화강암 5천여톤이 소요되었다고 하는데, 불상에 2천톤, 좌대에 3천톤이 들어갔다고 한다. 이 불상을 조성하게 된 것은 통일에 장애가 되는 갈등을 치유해 7천만 겨레의 염원인 민족대화합이 하루 빨리 이루어지기를 바라는 뜻이 담겨져 있다고 한다.',NULL,'일출~일몰','http://www.donghwasa.net','주차 가능','대구광역시 동구 동화사1길 1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','시민안전테마파크','생동감 넘치는 체험교육을 통해 시민들이 안전에 대한 소중함을 느낄 수 있는 시민안전교육 및 시민안전 문화정착을 위해 설립되었다. 대구시민안전테마파크는 실질적인 안전체험을 위하여 제1관에는 특화된 지하철안전 체험장을 비롯하여 지진안전 체험장, 미래안전영상관(4D), 교통안전 체험장, 어린이 제품 안전체험관등을 운영하여 안전의식 고취와 함께 우리가 일상에서 접할 수 있는 재난상황을 실감나게 체험할 수 있다. 특히 2020년 10월에 개장한 교통안전 체험장은 미니자동차를 타면서 각종 교통안전에 대한 체험을 할 수 있어 어린이 체험객에게 많은 인기를 누리고 있다.

제2관에는 위기대응 체험장으로 화재진압, 농연 및 완강기 체험, 대구 도시철도3호선을 그대로 옮겨온 모노레일 체험장을 운영하고 있으며, 심폐소생술 교육장에서는 심정지 상황에서 대처할 수 있는 CPR교육을 진행함으로써 다양한 체험과 함께 응급교육도 병행하고 있다. 야외에는 어린이들에게 가장 인기있는 소방차, 구급차 등이 전시되어 있어 언제든지 관람하며 멋진 팔공산의 풍경과 함께 사진을 찍을 수 있는 공간이 있다.',NULL,'09:00~18:00','http://safe119.daegu.go.kr','주차 가능','대구광역시 동구 팔공산로 1155',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','앞산 케이블카(앞산 전망대)','앞산전망대는 대구광역시 남구에 위치한 전망대로 대구시가지를 한눈에 조망할 수 있는 대구관광의 명소이다. 앞산전망대의 건축물은 도시와 자연, 역사와 미래를 함께 엮어낸 성공적인 건축물로 평가되고 있다. 관광객들도 많이 찾고 있지만 무엇보다 대구에서 먹고 자고 살아가는 대구 시민에게 대구가 어떤 도시라는 산교육을 할 수 있는 교육장의 역할도 하고 있다.',NULL,'09:00~18:00','http://www.apsan-cablecar.co.kr/','공영주차장 이용','대구광역시 남구 앞산순환로 574-114',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','앞산카페거리','대구시 남구 앞산 부근, 대명 9동 일대에 카페들이 밀집한 골목을 ''앞산커페거리''라 부른다. 주택을 개조한 카페, 레스토랑, 갤러리 카페 40여 개가 줄지어 있는 활기찬 거리이다. 이곳에는 커피, 샌드위치, 디저트 등을 취급하는 카페가 가장 많고, 피자, 파스타, 스테이크를 판매하는 레스토랑, 일식당, 맥주 전문점, 파이 전문점 등이 있다. 데이트를 즐기는 연인, 휴일 나들이를 나온 가족들이 달콤한 먹거리와 향기로운 커피를 즐기기 좋은 곳이다.인근에 앞산공원, 안지랑곱창거리 등이 있어, 먹고, 마시고, 휴식하기에 좋다. 대구지하철 1호선 안지랑역에서 걸어서 5~10분 거리이다.',NULL,NULL,'http://nam.daegu.kr','공영주차장 이용','대구광역시 남구 대명남로 191',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','앞산 해넘이전망대','일몰과 함께 대구의 경관을 한눈에 담을 수 있는‘앞산 해넘이전망대’는 남구의 앞산빨래터공원에 위치한다. 앞산빨래터공원의 역사와 상징을 담아 전망대 디자인은 빨래 짜는 모습을 형상화했다. 전망대를 향하는 경사로는 앞산의 전경과 주변 경관을 볼 수 있어 산책하기 좋다.

시설규모 : 앞산 해넘이전망대(타워형)13m, 경사로 243m',NULL,'09:00~21:00','http://nam.daegu.kr/tour/','공영주차장 이용','대구광역시 남구 대명동',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','99계단 벽화마을','이곳은 서울의 인사동 거리처럼 고미술거리로 널리 알려진 대구 남구 이천동 고미술 거리 건너편으로, 전통사찰인 서봉사가 있고 그 아래 나지막하면서 오래된 한옥이 밀집해 있는 수도산 자락에 있다. 어둡고 칙칙한 시멘트 담장만 있던 골목 99계단에 99세까지 88하게라는 타이틀의 벽화를 조성하여 밝고 아름다운 벽화 골목으로 조성했기 때문에 더욱 의미가 있는 곳이다.',NULL,NULL,'https://blog.naver.com/daegu_namgu','공영주차장 이용','대구광역시 남구 이천로29길 28-1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','고미술거리','1960년대부터 형성된 문화재매매업소가 모여있는 곳으로 과거 우리선인들이 사용한 민속품,도자기,고가구를 많이 보유하고 있고 현대인에게 생소한 조상들의 생필품들이 가득하여 구경하는 재미가 쏠쏠하다. 외국인에게 인기가 많으며 특히, 일본인은 지도와 정보를 입수하여 찾아온다고 한다. 외국인에게 많은 사랑을 받으며 경외감을 주는 우리 고미술품에 우리나라사람들의 관심과 사랑이 어느때보다 필요하다. 고미술품에 관심이 있다면 꼭 한번 방문할 만한 관광지로 추천한다.',NULL,'연중무휴','http://nam.daegu.kr/tour/','공영주차장 이용','대구광역시 남구 명덕로 262',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','봉덕시장','봉덕시장은 대구광역시 남구의 대표적 시장 가운데 하나이다. 한국전쟁을 거치면서 시장에는 주변 미군부대에서 흘러들어온 물건들이 흘러넘쳤다. 씨레이션부터 시작해 워카, 담요, 재봉틀, 프라이팬까지 온갖 구제품과 군사보급품들이 시장 안을 가득 채웠다. 그렇게 불행한 역사 속에서 자연발생적으로 생겨난 대구 남구 봉덕시장은 70년대와 80년대 최고의 호황기를 누리며 대구의 4대 시장으로 성장했지만 대형마트와 인터넷 쇼핑몰로 화려했던 출발과는 달리 요즘 시장 경기는 좋지 않다. 이후 2004년 중소기업청의 지원으로 아케이드 설치, 주차장 확보 등 시설현대화를 통해 고객들의 편리한 쇼핑을 돕고자 노력하고 있다.',NULL,'점포마다 다름','http://nam.daegu.kr/tour/','가능(공용주차장)','대구광역시 남구 봉덕로 115',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','선교사스윗즈주택','본 건물은 1910년경 미국인 선교사들이 그들의 주택으로 지은 것으로 스윗즈 선교사 등이 거주하였다. 평면구성은 남쪽 우측부에 현관으로 이어지는 베란다를 두고 현관홀을 통하여 거실과 응접실을 직접 연결하였으며, 거실을 중심으로 침실, 계단실, 욕실, 부엌, 식당 등을 배치하였다. 외관은 안산암의 성돌로 바른층 쌓기의 기초를 하고 그 위에 붉은 벽돌을 4단 길이로 1단은 마구리로 쌓았다. 지붕은 한식기와를 이은 박공지붕이었으나 후에 함석으로 개조하였다. 이 집은 지붕재료와 마감재료의 일부가 바뀌었지만 건물 전체의 형태 및 내부구조는 당시의 모습을 잘 유지하고 있다. 스윗즈 주택은 동산의료원 개원 100주년 기념사업의 하나로 의료선교박물관으로 조성중이다.',NULL,NULL,'http://gu.jung.daegu.kr/culture',NULL,'대구광역시 중구 달구벌대로 2029',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','달성공원','대구의 여러 공원 가운데 가장 오래되고 시민과 친근한 공원이 달성공원이다. 달성공원 안에는 지방문화재 자료인 관풍루가 있다. 관풍루는 경상감영의 정문이었다. 대구에 감영이 설치되면서 선화당의 남쪽에 포정문을 세우고 그 위에 문루를 만들었는데 그것이 관풍루였다. 달성공원은 삼한시대의 부족국가였던 달구벌의 성지 토성이었다. 이곳은 청일전쟁(1894년∼1895년) 때 일본군이 주둔했고 그 후 고종 광무 9년(1905)에 공원으로 만들어졌는데 1965년 2월 대구시에서 새로운 종합 공원 조성계획을 세워 오늘날과 같은 대공원을 만든 것이다. 잔디광장, 종합문화관 외에 이상화 시비 등과 같은 기념물도 있다.',NULL,'05:00~21:00','https://tour.daegu.go.kr/','있음(주차공간이 협소)','대구광역시 중구 달성공원로 35',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','서부 오미(味)가미(味)거리','오미(味)가미(味)에서 유추할 수 있 듯, ''오면서 먹고 가면서 먹는다''라는 뜻으로 다양한 국적의 음식과 더불어 독특한 메누들도 함께 즐길 수 있다. 가게명도 상당히 독특하고 취급하고 있는 음식이나 상품 또한 지역내 그 어디에서도 찾아보기 힘들기에 기존 먹자거리에서 식상함을 느낀 이들의 발길이 이어져 빠르게 사람들의 입소문을 타고 있다.
50여개의 음식점뿐만 아니라, 공방, 악세사리점, 전통 시장 점포 등이 함께 어우러져 있기에 임으로 눈으로 즐길 수 있다.',NULL,'점포마다 상이함','https://tour.daegu.go.kr/','주차가능(서부시장 공영주차장)','대구광역시 서구 국채보상로75길 25-1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','아나고골목','시골읍내의 정서가 그대로 묻어나는 곳으로, 달성공원 담벼락에서 북비산네거리 쪽으로 150m에 이른다. 현재 20여개의 식당이 새벽까지 손님맞이에 여념이 없다. 아나고는 회로 먹어도 좋고, 구워 먹어도 그 맛이 일품이다. 술안주로도 제격이며, 양념장에 버무려 시원한 물김치와 함께 먹기도 한다. 단백질과 아미노산이 풍부해 여름철 기력회복에 좋다.',NULL,'연중무휴','https://blog.naver.com/happyseogu',NULL,'대구광역시 서구 북비산로74길 49',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','신숭겸장군유적','신숭겸(?∼927)은 평산 신씨의 시조로서, 918년 배현경, 홍유, 복지겸 등과 함께 궁예를 몰아내고 왕건을 추대하여, 고려의 건국에 이바지한 인물이다. 고려개국의 1등 공신인 신숭겸 장군은 궁예가 세운 나라인 태봉의 기병장수였다. 그런데 궁예가 왕위에 즉위한 지 몇년 만에 처자식을 살해하고 백성을 혹사하는 등 폭정이 심해지자 동료 기장들과 함께 궁예를 몰아내고 왕건을 받들어 고려를 개국하였다. 고려 태조 10년(927) 신라를 침공한 후백제 견훤의 군사를 물리치기 위해 왕건과 함께 출전하였다. 왕건이 이 곳 공산싸움에서 후백제군에 포위되어 위기에 빠지자, 왕건의 옷을 입고 변장하여 맞서 싸우다 전사하였으며, 왕건을 그 틈을 이용하여 홀로 탈출하였다고 한다. 왕건은 장군의 죽음을 애통히 여겨 그의 시신을 거두어 지금의 춘천인 광해주에서 예를 갖추어 장례를 치웠다. 그리고 신숭겸이 순절한 이 곳에 순절단과 지묘사(미리사)를 세워 그의 명복을 빌게하고, 토지를 내려 이 곳을 지키게 하였다고 한다.

1607년(선조 40)에 없어진 지묘사 자리에 경상도 관찰사 유영순이 서원인 충렬사를 세워 장군을 모셨으며, 1672년(현종 13)에 표충사는 사액서원이 되었다. 1871년(고종 8)에 서원철폐령으로 표충사가 없어진 뒤에 후손들이 재사를 지어 이 곳을 지켜오던 중 1993년에 표충사를 복원하였다. 고려태사 장절공 신숭겸 장군의 유적은 지난 74년 대구광역시 기념물로 지정, 장절공의 충절을 기리는 위패(位牌)와 영정(影幀)이 모셔져 있으며, 순절단(殉節壇)과 충렬비(忠烈碑)등이 있다.',NULL,'10:00~17:00','http://www.dong.daegu.kr','있음','대구광역시 동구 신숭겸길 17',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','김광석 길 (김광석다시그리기길)','김광석 길은 故 김광석이 살았던 대봉동 방천시장 인근 골목에 김광석의 삶과 음악을 테마로 조성한 벽화거리이다. 2010년 ''방천시장 문정성시 사업''의 하나로 방천시장 골목길에 11월부터 조성하기 시작한 김광석 길은 중구청과 11팀의 작가들이 참여하였다. 350m 길이의 벽면을 따라 김광석 조형물과 포장마차에서 국수 말아주는 김광석, 바다를 바라보고 있는 김광석 등 골목의 벽마다 김광석의 모습과 그의 노래 가사들이 다양한 모습의 벽화로 그려졌다. 매년 가을에는 방천시장과 동성로 일대에서 ''김광석 노래 부르기 경연대회''를 개최하여 故 김광석을 추억하고 있다.',NULL,'24시간','https://www.jung.daegu.kr',NULL,'대구광역시 중구 달구벌대로 2238',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','근대골목(근대로의 여행)','대구 근대골목은 대구의 골목을 걸으며 살아있는 역사를 만나는 체험여행이다. 대구는 한국전쟁 당시 다른 지역에 비해 피해가 크지 않았다. 덕분에 전시 전후의 생활상이 비교적 잘 유지된 편이다. 곳곳이 역사적으로 다뤄지는 중요한 장소이면서, 우리네 아버지와 어머니 그리고 할아버지와 할머니의 온기가 느껴지는 곳이기도 하다.',NULL,'24시간','https://www.jung.daegu.kr','곳곳에 공영, 또는 민영 주차장이 있음','대구광역시 중구 경상감영길 99',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','아양기찻길','78년이란 긴세월동안 금호강을 가로지르는 아양철교로 운영하던 역사성과 산업문화유산의 가치를 고려해 폐철교를 도심 속 시민문화 여가공간으로 아양기찻길이라는 새로운 관광지로 새롭게 태어났다. 아양기찻길은 길이 277m, 높이 14.2m, 연면적 427.75㎡ 로 전망대와 갤러리 전시장, 디지털 다리 박물관, 카페등을 갖추고 있으며, 폐철교를 공공디자인과 접목해 복원한 점을 높이 평가받고 독일의 레드닷 디자인 어워드 상을 받고, 현재는 드라마 촬영지로 각광을 받고 있다. 주변에 십리 벚꽃길, 노래비, 동촌유원지, 옹기종기 행복마을을 관광할 수 있다.',NULL,'00:00~24:00','https://tour.daegu.go.kr','주차가능','대구광역시 동구 해동로 82',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','대견사','대견사는 설악산의 봉정암, 지리산의 법계사와 더불어 1,000m이상에 자리 잡은 사찰 중 한 곳이다. 유가면 용리 산1-2번지에 위치하고 있으며, 삼층석탑, 석축, 우물, 마애불 등만 남아 있던 절터에 부지면적 3,633㎡, 건축면적 186㎡로 총 50억원의 동화사 예산을 들여 대웅전 64.17㎡, 선당 58.32㎡, 종무소 58.32㎡, 산신각 5.04㎡등의 4동 규모로 2014년 3월 1일에 준공된 건물이다.일연스님이 1227년 22세의 나이로 승과에 장원급제하여 초임주지로 온 이래, 22년간을 주석한 곳으로 삼국유사 자료수집 및 집필을 구상한 사찰로 유명하다. 일제강점기 때 조선총독부에 의해 일본의 기를 꺾는다는 이유 강제 폐사된 후 100여 년만인 2014년 3월 1일 달성군에 의해 중창되어 민족문화유산을 재현하고 민족정기를 바로 세우고 있다.대견사에는 불상이 아닌 부처님의 진신사리가 모셔져있어 적멸보궁이라 한다. 대견사에 봉안한 진신사리는 2013년 11월 동화사가 스리랑카 쿠루쿠데사원에서 모시던 부처님 진신사리 1과를 기증받아 이운한 것이다. 이 진신사리는 서기 103년부터 스리랑카 도와사원에서 보관해오다 1881년부터 쿠루쿠데 사원에 모셔진 사리 4과중 하나다.',NULL,NULL,'http://www.cha.go.kr',NULL,'대구광역시 달성군 유가읍 일연선사길 177',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','도동서원 [유네스코 세계문화유산]','도동서원은 조선 5현(五賢)으로 문묘에 종사된 한훤당(寒暄堂) 김굉필(金宏弼)을 향사한 서원으로 1568년(원조원년) 지방유림에서 현풍 비슬산 동쪽 기슭에 세워 쌍계서원(雙溪書院)이라 불렀는데 창건 5년 뒤인 1573년(선조6)에 같은 이름으로 사액되었으며 임진왜란 때 소실되었다. 그 후 1604년(선조37)에 지방의 사림들이 지금의 자리에 사우를 중건하여 보로동 서원(甫老洞書院)이라 불렀다. 이황은 김굉필을 두고 ‘동방도학지종(東方道學之宗)’이라고 칭송했다. 1607년(선조40) 도동서원(道東書院)이라 사액하였으며, 마을 이름도 도동리라 고쳐 불렀다. 도동서원은 대원군의 서원철폐 때에도 전국 서원 중 철폐 되지 않은 전국 47개 중요서원의 하나로 사림과 후손들의 두터운 보호 하에 지금에 이르고 있다.',NULL,NULL,'http://www.cha.go.kr',NULL,'대구광역시 달성군 구지면 구지서로 726',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','달성습지','낙동강과 금호강, 진천천과 대명천이 합류하는 지역에 자리한 총면적 2㎢(약 60만 5,000평)의 하천습지이다. 보기 드문 범람형 습지로 사계절 다양한 식생을 볼 수 있는 자연생태의 보고이다. 개방형 습지, 폐쇄형 습지, 수로형 습지로 구성되어 있다. 봄이면 갓꽃, 여름이면 기생초, 가을이면 억새와 갈대가 장관을 이룬다. 철새도 빼놓을 수 없다. 잡풀과 뽕나무들이 들어서기 전, 달성습지에 모래사장이 펼쳐졌던 시절 이곳은 천연기념물 흑두루미 등 철새들의 천국이었다. 지금은 백로나 왜가리 등의 철새와 멸종위기 야생동식물 2종으로 지정된 맹꽁이 등을 볼 수 있다.',NULL,'연중무휴','http://tour.daegu.go.kr','주차가능','대구광역시 달성군 다사읍 죽곡리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','국립대구과학관','국립대구과학관은 놀이를 통해 쉽게 과학을 배우고 체험하는 과학놀이터이다. 직접 보고 만지고 체험할 수 있는 다양한 과학체험프로그램이 마련되어 있다. 또한 국립대구과학관은 다양한 과학프로그램이 있어서 프로그램을 참여할 수 있으며 또래와 함께 무한한 상상력을 펼칠 수 있다.',NULL,'09:30~17:30','http://www.dnsm.or.kr','입차 09:00~16:30 / 출차 09:00~18:00','대구광역시 달성군 유가읍 테크노대로6길 20',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','두류공원','달서구의 북동쪽이자 대구의 중심부에 두류공원이 있다. 1977년에 조성된 이 공원은 두류산과 금봉산을 주봉으로 두리봉과 모그동산을 포함하고 있다. 이월드(구, 우방타워랜드)가 들어선 곳은 두류산이고 문화예술회관 뒷산은 금봉산이다. 두류산은 역사적 기록에 의하면 산이 둥글게 펼쳐져 있다고 해서 두리산으로 부르던 것을 지명이 한자화 될 때 같은 의미의 주산 또는 두류봉으로 쓰여오다가 근래에 와서 두류산으로 굳어졌다.

공원은 면적이 51만평. 해발 135m의 야산을 개발해 공원으로 만들었다. 두류공원 순환도로를 걷다보면 민주화에 대한 열망과 옛 문인들의 향취를 맛볼 수 있다. 4.19혁명의 시발점이 된 대구시내 고등학생들의 의거를 기리기 위한 2.28 학생의거기념 탑이 있고, 또 순환도로를 따라가다 보면 민족시인 이상화의 동상과 빙허 현진건, 고월 이장희, 목우 백기만의 시비도 만난다. 1977년 10월 대구시민 헌장비가 세워졌고 축구장, 야구장 및 각종 위락시설과 사립도서관인 두류도서관이 준공되어 시민문화생활 및 청소년 선도에 크게 이바지하고 있다.',NULL,'연중무휴','https://dalseo.daegu.kr/tour','있음(4개소)','대구광역시 달서구 공원순환로 36',sysdate, 0, 0);

--대전 (무작위)
insert into item values(item_seq.nextval, 1, '관광지','대청호오백리길','대청호오백리길은 대전(동구, 대덕구)과 충북(청원, 옥천, 보은)에 걸쳐 있는 약 220km의 도보길이며 대청호 주변 자연부락과 소하천, 등산길, 임도, 옛길 등을 포함하고 있다. 또한 서울, 부산에서 대청호까지 거리가 약 오백리 정도가 되어 그 상징적 의미를 더하고 있다. 특히, 대청호를 중심으로 해발 200~300m의 야산과 수목들이 빙 둘러져 있어 경관이 아주 뛰어나며 구간마다 특별한 재미를 느낄 수 있는 길들이 많다. 연인끼리 낭만을 즐길 수 있는 데이트 코스, 푸른 호수를 감상하며 생각에 잠길 수 있는 사색 코스, 등산이 가능한 산행 코스, 농촌체험과 문화답사를 겸하여 걸을 수 있는 가족여행 코스, 자전거 드라이브 코스 등 보고, 느끼고, 체험하고 즐길 수 있는 다양한 테마가 펼쳐진 길이다. 이러한 자연경관을 인정받아 유엔해비타트(UN-HABITAT)가 수여하는 아시아도시경관상도 수상하였다.
또한, 대청호오백리길 주변에는 대청호물문화관과 대청호조각공원, 대청호미술관, 대청호자연생태관 등이 개관하여 대청호오백리길과 연계한 체험 및 관람시설로 이용이 가능하며, 청원 청남대, 문의문화재단지, 보은 속리산, 옥천 둔주봉, 정지용생가, 육영수생가지 등 많은 역사문화 관광지가 있다. 갈대밭이 펼쳐진 대청호를 따라 걷는 곳으로 대청호 중에서도 가장 아름다운 곳이다. 몇 년 전 권상우와 김희선 주연인 ''슬픈연가''를 촬영했던 장소이기도 해 많은 사랑을 받고 있다. 그 밖에 조각공원, 미술관, 자연생태관등을 함께 감상할 수 있다.',NULL,'연중개방','http://www.dc500.org','주차가능','대전광역시 동구 천개동로 34',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','계족산 황톳길','계족산 황톳길은 2006년 임도 총14.5km에 질 좋은 황토 2만여톤을 투입하여 조성한 맨발 트래킹의 명소이다. 경사가 완만해 맨발로 걷기 무리 없을 뿐 아니라, 여름에는 발끝부터 황토의 시원한 기운이 올라와 무더위를 식히기 좋다. 신발을 신고 걸을 수 있는 둘레길도 있으며, 산책로의 시작지점에는 황톳길 이야기와 미술 작품을 살펴볼 수 있는 ''숲 속 광장''이 있다. 놀이터나 정자 등 편의시설, 세족장이 있어 발을 담그고 잠시 머물기 좋다.

한국관광공사에서 선정한 ‘한국관광 100선’, ‘5월에 꼭 가 볼만한 곳’, 여행전문기자들이 뽑은 ‘다시 찾고 싶은 여행지 33선’에 선정, KBS1TV ‘생로병사의 비밀’에서 대표적인 맨발걷기 장소로 소개된 바 있으며, 연간 100만명 이상이 방문하는 대전 대표 관광지이다. 또한, 매년 5월 ''계족산맨발축제''를 개최하며 4월~10월까지 다채로운 주말 프로그램을 진행한다.



놓치지 말 것

황톳길을 걷다가 푯말을 따라 20분간 더 오르면 계족산성으로 향한다. 해발 420m에 위치한 계족산성을 외부의 침입을 방어하는 삼국시대의 성벽으로 현재는 계족산의 대표 전망대로 자리매김했다. 곳곳에 벤치가 있어 산책 도중 쉬기 좋고, 자리에 앉으면 대청호, 벚꽃 나무 군락 등 대전 시내가 한 눈에 담긴다.',NULL,'09:00 ~ 24:00','http://www.daedeok.go.kr','주차가능','대전광역시 대덕구 장동 산85',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','천연기념물센터','"천연기념물센터는 자연유산인 천연기념물과 명승에 대한 체계적인 조사·연구와 전시·교육을 통하여 그 가치와 중요성을 국민에게 널리 알리기 위하여 설립된 국가연구기관입니다. 천연기념물센터 전시관에는 자연유산에 대한 연구 결과물인 공룡알·발자국 등의 화석, 반달가슴곰, 수달, 독수리 등의 동물 박제 표본, 존도리 소나무 등의 식물 표본 등을 전시하여 전문연구자와 청소년의 학습에 도움을 주고 있으며, 체험 공간, 검색 키오스크, 영상실 등을 통하여 독창적인 체험학습 기회를 제공하고 있습니다. 또한 유네스코와 세계 여러나라의 자연유산 전문기관 및 자연사박물관과의 학술교류를 통하여 명실상부한 자연유산 전문연구기관으로 발전해 나가고 있습니다.',NULL,'하절기(3~10월) 09:30~17:30, 동절기(11~2월) 10:00~17:00','http://www.nhc.go.kr/main/main.do','주차가능','대전광역시 서구 유등로 927',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','한밭수목원','지리적으로는 정부대전청사와 엑스포과학공원의 중앙 부분에 자리 잡고 있다. 1991년 6월 7일 근린공원으로 지정된 둔산대공원은 총 569천㎡으로 대전예술의전당, 평송청소년문화센터, 시립미술관, 이응노미술관 등 명실상부한 문화 예술의 메카이며, 수목원과 어우러져 문화가 가장 잘 갖추어져 있는 곳이기도 하다. 도심 속의 한밭수목원은 정부대전청사와 과학공원의 녹지축을 연계한 전국 최대의 도심 속 인공수목원으로 각종 식물종의 유전자 보존과 청소년들에게 자연체험학습의 장, 시민들에게는 도심 속에서 푸르름을 만끽하며 휴식할 수 있는 공간 제공을 목적으로 조성했다.

한밭수목원의 총 조성면적 387천㎡은 4단계로 구분 연차별로 조성하였으며, 서원(시립미술관 북측)과 남문광장은 2005년 4월 28일 개원하였고, 목련원, 약용식물원, 암석원, 유실수원 등 19개의 테마별 園으로 구성된 동원(평송수련원 북측)은 2009년 5월 9일 개원하였다. 또한 2011년 10월 29일 맹그로브를 주제로 열대식물원 개원, 공립수목원 제33호 등록, 연구관리동의 확충을 계기로 수목 연구 교육 기능 등을 더욱 강화하여 수목원의 본연의 기능을 충실히 할 수 있도록 하였다.',NULL,'09:00 ~ 18:00','https://www.daejeon.go.kr','주차가능','대전광역시 서구 둔산대로 169',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','엑스포과학공원','우리나라 최초의 국제박람회기구(BIE)공인 전문 엑스포로 개최되었던 "93년 대전세계박람회"를 기념하기 위해 그 시설과 부지를 국민 과학교육의 장으로 활용하기 위하여 조성된 과학공원이다. 엑스포과학공원에는 대전세계박람회(1993)의 상징탑인 한빛탑과 대전세계박람회를 기념하기 위해 새롭게 재단장한 대전엑스포기념관이 있고, 각국에서 개최하였던 엑스포의 기념품 및 상징물이 전시되어있는 세계엑스포기념박물관에서는 200년간의 엑스포의 역사를 감상할 수 있으며, 어린이들이 교통관련 교육 및 교통의 역사를 체험할 수 있는 대전교통문화센터가 운영되고 있다. 이 외의 시뮬레이션관, 돔영상관, 전기에너지관, 첨단과학관, 에너지관, 자기부상열차, 음악분수, 꿈돌이광장 등은 대전시의 엑스포재창조사업 추진으로 현재 시설 철거 작업중이므로 관람이 불가능하다.',NULL,'09:30~17:40(입장마감 17:20)','http://www.expopark.co.kr','주차가능','대전광역시 유성구 대덕대로 480',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','유성장 (4, 9일)','대전광역시 유성구 장대동에서 5일마다 열리는 정기 재래시장이다. 매월 4일과 9일, 14일, 19일, 24일, 29일에 유성장이 열린다. 전통 5일장인 유성 5일장은 1916년 10월 15일 최초 개장된 이래 장대동 191번지 장옥을 중심으로 매 4일, 9일 성시를 이루는 전통 풍물장으로서, 지금은 공주, 연기, 논산, 금산, 옥천 등 인근 시, 군에서 생산되는 농산물 직거래장터로 각광받고 있다. 약 1,980㎢의 부지에 점포 40여 개가 있으나, 그것만으로는 모자라서 그 일대의 공터와 골목에까지 장이 들어선다. 장날이면 대전에 사는 시민들은 말할 것도 없고 인근의 대덕군이나 옥천, 공주, 조치원, 금산, 논산 등지에서 사람들이 몰려온다. 유성장에서는 장대동사무소 뒤편의 장터 입구에서 가축류가 거래되고, 그 안쪽으로 어류·채소류·의류·식기류 순으로 좌판이 벌어진다. 유성의 특산물로는 학하 고구마, 세동 상추 등이 자랑거리다. 특히 배는 전국에서도 맛이 좋기로 유명하다.',NULL,'10:00 ~ 17:00(1회 약 1시간 20분 소요)','https://www.yuseong.go.kr/?home=Y','장애인 주차장 있음(공용주차장)_무장애 편의시설','대전광역시 유성구 유성대로730번길 24',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','국가핵융합연구소','핵융합에너지는 미래 녹색에너지원으로 주목되고 있다. 특히 자원이 없는 우리나라에서는 더욱 관심을 가지고 지켜봐야 할 에너지이다. 이곳에서는 홍보영상 시청, 특강, 홍보관 견학, KSTAR 주장치실과 주제어실을 둘러 볼 수 있다.',NULL,'매주 화,목 14:00~15:00(공휴일 및 기관사정에 의한 일자 제외)','http://fusionnow.nfri.re.kr','있음','대전광역시 유성구 과학로 169-148',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','장태산자연휴양림','구역면적은 815,855㎡, 1일 수용인원은 6,000명인 자연휴양으로 1970년대부터 조성된 국내 유일의 메타세쿼이아 숲이 울창하게 형성되어 있어 이국적인 경관과 더불어 가족단위 산림욕을 즐기는 이용객이 즐겨 찾는 휴양림으로유명하다. 장태산 자연휴양림은 전국 최초로 민간인이 조성·운영하여 왔으나, 2002년 2월 대전광역시에서 인수한 후 새롭게 개축하여 2006년 4월 25일부터 개방하게 되었다.

자연 상태의 잡목 숲을 배경으로 평지에 고유 수종인 밤나무, 잣나무, 은행나무 등 유실수, 소나무, 두충 등을 계획적으로 조림했고, 미국에서 들여온 메타세쿼이아, 독일 가문비나무 등 외래 수종을 배열하여 독특하게 조성했다. 산 입구 용태울저수지를 지나면서 휴양림이 펼쳐지고 산 정상의 형제바위 위에 있는 전망대에서 낙조를 바라볼 수 있으며 장군봉, 행상바위 등 기암괴석이 보인다.

장태산의 천혜의 자연경관과 잘 어우러진 장태산 휴양림은 1991년부터 조성하기 시작해서 지금은 거의 그 기틀을 갖추었으며 현재까지도 활발한 개발을 하고 있다. 그림 같은 호수, 기암괴석 등 주변 경관이 절경이며 질서 있게 조성된 나무들이 많고 길 또한 잘 다듬어져 있어서 산책하기에 좋은 곳이다. 장태산은 대전의 서남쪽에 자리 잡고 있는데, 형제바위 위에 있는 전망대에서 바라보는 붉은 낙조는 산아래 용태울 저수지와 어우러져 가히 형용할 수 없는 장관을 이루어 보는 이들의 감탄을 자아내게 한다.',NULL,'[숙박시설] 당일 15:00~익일 12:00','https://www.jangtaesan.or.kr:454/index.asp','있음 (472면)','대전광역시 서구 장안로 461',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','뿌리공원','뿌리공원은 효를 바탕으로 모든 사람들에게 자신의 뿌리를 알게 하여 경로효친 사상을 함양시키고 한겨레의 자손임을 일깨우기 위해 세운 공원으로 대전광역시 중구 침산동 일원 3만 3천여평의 부지에 세계 최초로 성씨를 상징하는 조각품 및 각종 편의시설을 갖추고 효를 주제로 1997년 11월 1일 개장한 테마공원이다. 뿌리공원은 충효사상 및 주인정신을 함양시키는 교육공원이면서 가족 단위의 다양한 이벤트 행사가 마련된 가족친화 공원이며, 또 심신수련, 건전한 청소년 육성의 체육공원이자 천혜의 자연경관을 배경으로 한 도심 속의 자연공원으로서의 특색을 잘 나타내고 있다.

자신의 뿌리를 되찾을 수 있는 성씨별 조형물과 사신도 및 12지지를 형상화한 뿌리 깊은 샘물, 각종행사를 할 수 있는 수변무대, 잔디광장과 공원을 한눈에 바라볼 수 있는 전망대, 팔각정자 뿐만 아니라 산림욕장, 자연관찰원 등 다양한 시설이 갖추어져 있다. 주요시설로는 미니모터카 30대(2인용) 및 교통표지판, 보행자신호등이 있는 교통안전교육장과 자연관찰로, 수목원, 산림욕장, 야생초화류단지가 있는 자연관찰원이 있다. 성씨별 조각품설치 및 제막식, 도민친선대회, 어린이날행사, 경노행사, 수화노래공원, 찬양공연장, 애인은 내 친구, 음악연주회 등 다양한 문화행사도 펼쳐지며 팔각정자(자산정), 밤나무단지, 산책로, 수변무대, 분수대, 만성보(라바댐) 등 볼거리가 많은 유익한 공원이다.',NULL,'하절기(3월~10월) 06:00 ~ 22:00, 동절기(11월~2월) 07:00 ~ 21:00','http://djjunggu.go.kr','있음','대전광역시 중구 뿌리공원로 79',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','온천지구','유성온천은 대전 중심가에서 서쪽으로 약 11km 가량 떨어진 유성구의 중심을 이루고 있는 대단위 온천관광타운이다. 유성의 온천수는50∼400m로 구성된 화강암 단층 파쇄대에서 생성된 물로서, 화강암의 단층균열층을 따라 지하 200m 이하에서 분출되는 27~56℃ 정도의 고온 열천이다.약 60 여종의 각종 성분이 함유되어 있으며 중금속이 전혀 검출되지 않은 산성도(pH)7.5∼8.5의 약알카리성 단순천으로 명성을 떨치고 있다. 특히 온천이 시내에 위치해 있어 대표적인 도시형 온천으로 주변으로 대규모 숙박시설과 유흥주점들이 들어서 관광타운을 형성하고 있다. 또 유성컨트리클럽, 꿈돌이동산, 엑스포과학공원 등이 조화를 이뤄 관광과 온천욕을 겸한 단체관광객과 일반 행락객들이 끊이지 않고 이어져 도시발전에도 크게 기여하고 있다. 유성IC와 대전 월드컵경기장이 불과 1km 남짓한 거리다. 전국 어디서나 접근이 쉽고 이용이 편한 온천타운으로 발전의 소지가 더욱 높다.

* 유성온천지구의 또다른 볼거리, 5월의 눈꽃축제 *
대전은 5월이 되면 바빠진다. 이곳 유성온천거리에 5월의 눈꽃축제가 열리기 때문이다. 유성온천거리에는 눈을 닮은 하얀 꽃잎이 아름다운 이팝나무가 가로수로 많이 심어져 있고, 눈꽃거리가 조성되어 매우 아름답다.',NULL,'동절기(11월~3월) 07:00~21:00, 하절기(4월~10월) 07:00~10:00','https://www.yuseong.go.kr/tour/index.do','있음','대전광역시 유성구 봉명동 574',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','대전시립미술관','대전시립미술관은 대전, 중부권의 최초 공공미술관으로 지역미술은 물론 우리나라 현대미술의 발전에 기여하고, 시민 모두가 그 성과를 함께 누림으로써 보다 여유롭고 깊이 있는 삶을 공유하는데 도움이 되고자 설립되었다.1998년에 개관한 미술관은 5개의 전시실 및 수장고, 강당, 세미나실을 갖추고 있다. 야외 분수대와 조각공원으로 구성되어 있다. 미술관은 공공재이며 문화시설인 동시에 교육시설이다. 공교육의 연계와 연장으로서 살아있는 교육의 장으로 활용되기 위하여, 미술관이 단순히 작품을 감상하는 수동적인 미술문화에서 벗어나 보다 적극적이고 능동적인 미술문화 향유의 방법을 제시하고, 사회교육기관으로서의 역할 확대를 위하여 성인강좌 프로그램도 운영하고 있다. 2006년의 동양미술사를 시작으로 한국도자기의 역사, 서양미학사, 에칭과 북아트 , 최근의 인체크로키까지 그 강좌가 다양하다.

* 미술관의 시설 *

전시실·사진실·세미나실·자료실·강당·회의실·학예원실 등의 시설을 갖추었으며, 야외에 물조각공원과 잔디조각공원이 있다. 전시실은 모두 5개로, 현대의 문화와 사회를 반영하는 미술품 및 이와 관련된 자료만을 전문적으로 수집하여 전시하고 있다.',NULL,'10:00~19:00(매월 마지막 수요일 21:00까지)','https://www.daejeon.go.kr/dma/index.do','주차 가능 (둔산대공원 주차장이용)','대전광역시 서구 둔산대로 155',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','이응노 미술관','대전 이응노미술관은 이 지역이 낳은 세계적인 작가 고암 이응노(1904-1989) 화백의 예술 연구와 전시를 맡아 이 시대 고암 정신을 확장하고 계승할 못적으로 2007년 5월 개관하였다. 이응노의 삶과 예술활동을 재조명하고, 그의 예술세계를 연구함으로써 한국 미술의 발전에 기여하고자 하는 뜻을 내포하고 있다. 대전광역시 서구 만년동 396번지에 있으며, 지하 1층, 지상 2층 건물이다. 박물관 건축설계는 프랑스 건축가 로랑 보두앵이 맡았다. 2007년 5월 3일 개관하였고 개관 기념전으로 ‘고암, 예술의 숲을 거닐다-파리에서 대전으로’를 열었다. 그동안 잘 알려지지 않았던 고암 선생의 작품인 릴리프(종이부조), 판화, 은지화, 페인팅, 몽돌 등 이응노 작품의 매재적 다양성에 초점을 두고 개관 3주년 기획전이 벌어지고 있다. 고암의 작품세계가 동양과 서양의 만남이었던 것처럼 이응노미술관의 건축물은 한국작가 이응노와 프랑스 건축가 로랑 보드앵의 만남이 자아낸 조화라는 점도 매우 흥미로운 일이다.

* 대전 이응노미술관이 건립되기까지 *

대전 이응노미술관의 청사진이 완성된 것은 고암선생의 미망인 박인경 여사가 운영했던 서울 평창동의 이응노미술과의 폐관에 이은 2005년 9월이다. 평창동 미술관의 수장품을 인수받은 대전시는 이응노미술관의 대전시대를 선포한 것이다. 미술관은 프랑스 건출가 로랑 보드앵의 설계로 2006년 말 완공되었다.',NULL,'10:00~20:00',' http://www.leeungnomuseum.or.kr/','주차 가능','대전광역시 서구 둔산대로 157',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','솔로몬 로파크','솔로몬 왕이 재판을 통해 지혜롭게 정의를 실현했듯이 솔로몬 로파크는 법치사회의 자유, 지혜, 정의를 느끼고 체험하며 국민 누구나가 신뢰하는 법치국가를 만들어 가는데 필요한 민주시민의 자질과 소양을 쌓아가는 법교육 테마공원이다. 솔로몬 로파크는 어린이, 청소년과 국민들이 법을 쉽고 재미있게 배우고 체험할 수 있도록 법무부가 조성하고 직접 운영하는 법과 정의의 배움터이다.법체험관에서는 세계의 법역사를 이해하고 우리나라 법제도 전반을 체험할 수 있도록 입법체험실, 과학수사실, 모의법정실, 교도소체험이 마련되어 있으며 미취학 아동을 위한 법짱마을도 있으며, 솔로몬 로파크에 조성된 법체험관과 법연수관을 중심으로 다양한 법체험 및 법연수 프로그램을 국민들에게 제공하고 있다.',NULL,'법체험관 및 야외운동장 10:00 ~ 17:00','https://www.lawnorder.go.kr/solomondj/index.do','주차 가능','대전광역시 유성구 엑스포로 219-39',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','시민천문대','대전시민천문대는 2001년 5월 3일 지자체 1호 천문과학관으로 개관하여 매년 10만 명 이상 천문대를 방문하고 있다. 3층 관측실에서는 천체망원경으로 주간 태양의 홍염, 흑점 관측체험, 야간 다르 행성, 항성, 성운, 성단까지 관측 프로그램 체험과, 1층 천체투영관에서는 사계절 별자리 설명과 천문 관련 영상물 상영, 그리고 "토요 별음악회", "금요 별음악회", "별빛 속에서 시와 음악회"등 천문우주과학과 공연예술 프로그램을 진행하고 있으며, 1층 복도에서는 "아스트로 갤러리"미술 전시전이 진행된다.2017년에는 천문공원 조성, 주차장 설치, 관람객 안전을 위한 진입로 포장과 인도(데크)설치, 보조관측실에 슬로프를 설치하여 장애우도 천체관측을 할 수 있도록 시설보완하였으며, 포토존 등을 새롭게 단장하였다.',NULL,'14:00 ~ 22:00 (입장마감 21:50)','http://djstar.kr/','연구단지종합운동장 주차장 이용','대전광역시 유성구 과학로 213-48',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','으능정이 문화의거리','대전의 중심에 있는 은행동 젊음 패션 거리는 젊은이들의 거리로 대전의 명동으로 불리며 패션뿐 아니라 볼거리, 먹거리, 즐길 거리가 고루갖추어져 있으며 문화와 패션이 함께 숨쉬는 거리로 다양한 문화 행사를 개최하고 차 없는 거리를 조성하여 명실공히 젊은이들을 위한 거리로 발전하고 있으며 인근에 NC백화점, 지하상가등 패션몰이 어우러져 활기가 넘치고 웨딩업소 등이 점차 늘어나 신상권이 활성화되는 한편 철도, 버스등 대중교통 접근성도 아주 용이한 거리이다.',NULL,'10:30 ~ 22:00','http://www.culture-street.kr','주차 가능','대전광역시 중구 중앙로 164',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','공주 무령왕릉과 왕릉원[유네스코 세계유산]','공주시 금성동에 있는 웅진 백제시대 왕들의 무덤이 모여있는 곳이다. 무령왕릉을 포함한 이 일대의 고분들은 모두 7기가 전해지는데, 송산을 주산으로 뻗은 구릉 중턱의 남쪽 경사면에 위치한다. 계곡을 사이에 두고 서쪽에는 무령왕릉과 5 ·6호분이 있고 동북쪽에는 1∼4호분이 있다. 1∼6호분은 일제시대에 조사되어 고분의 구조와 형식이 밝혀졌고, 무령왕릉은 1971년 5 ·6호분의 보수공사 때 발견되었다.

고분들은 모두가 표고 약120m 정도되는 송산(宋山)을 북쪽의 주산(主山)으로 한 중턱 남쪽경사면에 자리하고 있는데, 1∼5호분은 모두 굴식 돌방무덤(횡혈식 석실분)으로, 무덤 입구에서 시신이 안치되어 있는 널방(현실)에 이르는 널길이 널방 동쪽벽에 붙어 있는 것이 특징이다. 1∼4호분은 바닥에 냇자갈을 깔아 널받침(관대)을 만들었는데, 5호분은 벽돌을 이용하였다. 이처럼 같은 양식의 무덤이면서 구조와 규모에 있어서 약간의 차이가 나는 것은 시기 차이가 반영된 것으로 보인다. 5호분은 원형으로 남아 있으나, 1∼4호분은 조사되기 전에 이미 도굴되었다. 이외에 벽돌무덤(전축분)으로 송산리벽화고분이라고도 불리는 6호분과 무령왕릉이 있다.

6호분은 활모양 천장으로 된 이중 널길과 긴 네모형의 널방으로 되어 있는데 오수전(五銖錢)이 새겨진 벽돌로 정연하게 쌓았다. 널방 벽에는 7개의 등자리와 사신도 · 일월도 등의 벽화가 그려져 있다. 무령왕릉도 6호분과 같이 연꽃무늬 벽돌로 가로쌓기와 세로쌓기를 반복하여 벽을 쌓았다. 벽에는 5개의 등자리가 있고, 무덤주인을 알 수 있게 해주는 지석 등 많은 유물이 출토되었다.',NULL,'09:00~18:00(종료 30분 전까지 입장)','http://tour.gongju.go.kr','있음','충청남도 공주시 왕릉로 37-2',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','공주 공산성 [유네스코 세계유산]','* 공산성의 북문, 공산성 공북루(충청남도 유형문화재/1976.01.08 지정) *
공북루는 공산성에 설치된 문루 중 북문으로 성문을 나서면 나루를 통하여 금강을 건너게 되어 있다. 선조 36년인 1603년에 옛 망북루의 터에 신축한 것으로 시축 후 수 차례에 걸쳐 개수가 이루어진 것으로 확인되나 현존의 것은 본래의 형상을 간직하고 있으며 조선시대 문루 건축의 대표적 예로 꼽는다. 건축의 내용은 여지도서에 기록되어 있는데, 동성의 충청도 편에 보면 1603년인 계묘년에 쌍수 산성의 수리가 이루어졌다. 더불어 공북, 진남 양문을 건립한 내용을 적고 있어 현존의 공북루 건물의 축조에 대한 기사를 남기고 있다. 본래 현존 공북루의 자리는 망북루가 자리하였던 것으로 전한다. 그러나 유지는 공북루의 동쪽 성벽상에 초석의 일부만 남아 있을 뿐, 외형은 확인하기가 어렵다. 망북루의 초석은 자연석으로 4매가 지표면에 남아 있지만 이것만으로 건물의 형상을 복원하기는 어렵다. 성문의 건축은 협축형태로 조성된 석성이 절단된 후면에 이층의 누각 형태로 이루어져 있다. 정면 5칸에 측면 3칸으로 면적은 남문인 진남루의 2배 가량이며, 고주를 사용한 이층의 다락집 형태로 고창 읍성의 공북루와 유사한 모습이다. 각 문의 크기는 등간격이며 누의 중앙 어칸에는 출입문을 달았던 흔적이 아직도 남아있어 근세까지 문비가 남아 있었을 것으로 추정된다.',NULL,'09:00 ~ 18:00 (30분 전까지 매표 가능)','http://www.gongju.go.kr/prog/tursmCn/tour/sub02_01_04/view.do?cntno=14','있음','충청남도 공주시 웅진로 280',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','산림박물관','* 자연과의 만남이 있는 곳, 산림박물관 *

창벽에 가로막혀 나룻배를 타고 드나들어야 했던 오지마을인 이 곳에 1994년 충청남도 산림환경연구소가 이전하면서 주변의 잘 보존된 울창한 숲을 금강자연휴양림으로 지정하였고 1997년 10월 산림박물관이 문을 열었다. 이곳의 볼거리로는 산림박물관, 수목원, 온실, 야생동물원, 야생화원, 연못, 팔각정 등이 있으며, 중부권 최대의 전천후 자연학습 교육장으로 손색이 없는 시설을 갖추게 되었다. 특히 산림박물관의 웅장한 건물은 백제의 전통양식으로 건립되었으며. ""자연과의 만남, 산림의 역사, 산림의 혜택과 이용, 고통받는 산림, 산림정책과 미래의 산림""을 주제로 산림에 관한 모든 것을 전시한 산림문화공간이며 금산의 은행나무, 공주의 당산나무, 안면도 소나무 등을 실제 크기와 모양으로 재현해 놓았다. 유리 돔으로 지어진 대형온실에는 열대, 아열대 식물을 전시, 재배하며 야생 동물원에는 반달곰, 멧돼지 등 10종의 수류와 원앙,공작새 등 31종의 조류를 사육하고 있고 29ha의 수목원은 일반인을 위한 산림학습교육장이다. 철쭉원, 매화원 등의 전문수목원과 창포, 톱풀, 구절초 등 야생화를 관찰할 수 있는 야생화원, 분수, 폭포, 무지개다리 등을 시설한 전통 연못이 있다.',NULL,'하절기 09:00~18:00, 동절기 09:00~17:00','http://www.gongju.go.kr/prog/tursmCn/tour/sub02_01_04/view.do?cntno=14','주차 가능','세종특별자치시 금남면 산림박물관길 110',sysdate, 0, 0);

--광주(무작위)
insert into item values(item_seq.nextval, 1, '관광지','호수생태원','* 도심 속 자연 학습의 장, 광주호수생태원 *

광주호(光州湖)의 호숫가 인근에 184,948m²의 부지에 자연관찰원, 자연학습장, 잔디휴식광장, 수변 습지 등 테마별 단지로 조성된 생태공원이다. 광주시내에서 약 30분 정도 거리에 있어, 시민들이 찾기가 좋아 2006년 3월에 개장한 후 아이들의 자연생태학습장이자 시민들의 휴식공간으로 이용된다.',NULL,'연중무휴','http://bukgu.gwangju.kr/culture/','장애인 주차장 있음(4대,장애인 표지판)_무장애 편의시설','광주광역시 북구 충효샘길 7',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','예술의 거리','* 광주의 대학로? 광주 예술의 거리 *

서울의 대학로와 인사동 거리, 부산의 Piff 거리 등 지방마다 도시의 특색을 살린 거리가 존재한다. 광주광역시를 대표하는 거리는 바로 광주 예술의 거리이다.예술의 거리는 호남문화와 예술의 중심지인 예향 광주의 전통을 계승 발전시키기 위해 조성됐다. 현재 동호인의 편의도모를 위해 서화, 도자기, 공예품 등 이 지방 예술의 상징적 작품을 집산하여 전시, 판매하고 있으며, 한국화, 서예, 남도창을 중심으로 한 남도예술의 진수를 누구나 손쉽게 접할 수 있는 명소이다.광주동부경찰서 앞에서 중앙초등학교 뒤편 사거리에 이르는 이곳을 두루 돌아보는데 구경만 하면 1시간 정도, 매장에 들어가서 감상하면 2시간 정도 소요되는데, 광주가 초행이면 꼭 들러볼 만한 곳이다.

* 예술의 거리를 제대로 보려면 토요일에 방문 *

그 이유는 매주 토요일 예술의 거리가 ‘차 없는 거리’로 지정되기 때문이다. 300m 정도 길이의 길에 차가 없이 문화행사가 펼쳐지지 더욱 활기를 띠기 마련. 또한 1달에 1차례는 남도문화예술진흥회가 주축이 된 음악회, 빛의 축제, 언더그라운드 공연, 캐릭터 문화 상품전, 빛의 축제 등이 열려 예술의 거리를 활성화시키고 있다. 또한 2015년 7월 광주에서는 광주 하계 유니버시아드가 개최된다.',NULL,'연중무휴','http://tour.gwangju.go.kr',null,'광주광역시 동구 예술길 24',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','최승효가옥','* 한말 전통가옥에 대해 알 수 있는, 최승효가옥(崔昇孝家屋) *

최승효가옥은 양림산 동남쪽 끝 부분에 위치하고 있는 전통가옥이다. 건물은 동향으로 지었으며, 정면 여덟 칸, 측면 네 칸의 매우 큰 규모로 이루어져 있다. 건물의 구조를 살펴보면 일자형 평면의 팔작(八作)집이면서도 우측의 경사진 부지를 자연 그대로 이용하여 1퇴(退) 공간의 반지하층을 구성하여 율동감을 주었다. 좌측으로도 1퇴(退)를 개방공간으로 주어 비대칭의 평면과 입면을 형성하여 단조롭지 않게 하였다. 서향인 뒤쪽은 너비 60m의 마루를 두르고 미닫이 창문을 만들어 서쪽의 빛을 일단 차단시키고 있으며, 미닫이 창문 때문에 방이 어두워지는 것을 해결하기 위해 벽면 윗부분에 띠판창을 두었다. 연등천장인 대청을 제외하고는 다락을 두었는데 이곳에 독립운동가 등을 피신시켰다고 한다. 다락 외부벽에는 완공을 두어 다락안의 채광을 돕고 있다. 기단은 우측의 반 지하 부분을 제외하고는 1cm 정도 높인 뒤 2단 원형 주초석을 써서 모양을 살렸다.

* 최승효가옥의 의의 *

이 가옥은 원래 독립운동가 최상현(崔相鉉)의 집이다. 당시 다락에 독립운동가들을 피신시켰다고 한다. 또한 이 가옥은 1920년대의 지어진 것으로 한말 전통 가옥의 이해 과정을 살펴볼 수 있는 건축사적 의의가 큰 집이다.',NULL,null,'http://www.namgu.gwangju.kr/culture','없음','광주광역시 남구 양촌길 29-4',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','광주월드컵경기장','경기장 주변의 관람객 출입구와 바닥포장 패턴의 방사형 설계 및 조경시설물의 열주배치를 통해 원형경기장에서 강렬한 빛이 발산되는 모습을 형상화함으로써 빛고을 광주의 이미지를 표현하고 있다. 경기장의 지붕과 스탠드를 지지하는 대형기둥을 Y자 형태로 설계하여 지붕과 기둥의 전체적인 모습이 광주의 전통민속놀이인 고싸움놀이에 사용되는 고의 머리모습을 나타내도록 하고 동서 양측지붕이 마주하고 있는 모습은 고싸움 놀이중에 상호 충돌하려는 고의 모습을 상징화하고 있다.
또한 4만여명을 동시에 수용할 수 있는 축구경기장으로 미디어센타, 선수대기실, 통신 및 의료시설과 최고의서비스를 가능케 하는 각종 부대시설 등 관람객과 선수를 동시에 만족시키는 최첨단시설을 갖추고 있다.',NULL,'연중무휴','http://www.gwangjusports.org','주차 가능','광주광역시 서구 금화로 240',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','풍암저수지 (풍암호수)','1956년 농업용 목적으로 축조하였으나 풍암택지 개발과 더불어 이용객이 증가함에 따라 99년부터 국토공원화 시범사업으로 전통정자와 목교등을 설치하여 물과 전통이 조화를 이루는 광주의 상징적 쉼터로 개발하여 1일 수백명의 이용객이 찾고있다.',NULL,'연중무휴','http://tour.gwangju.go.kr','주차 가능','광주광역시 서구 월드컵서로 71-3',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','전평제','1943년에 매월동, 벽진동 농경에 농업용수를 공급하고 재해방지를 위해 축조 도심근교에 방치된 저수지를 99년부터 국토공원화 시범사업으로 쉼터를 조성했다. 저수지 가운데 인공섬을 사이에 두고 목교가 설치되어 있어 수변경관 및 자연탐방과 함께 가족단위 여가선용의 장소로 적합하다.

* 면적 46,992㎡, 저수량 100천톤',NULL,null,'https://www.seogu.gwangju.kr/intro/intro_20201218.html',null,'광주광역시 서구 전평길 9',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','상무시민공원','서구 치평동 상무 신도심 아파트 단지내에 자리한 아름다운 공원이다. ’94년 11월 12일 지정되어 각종 운동시설과 아름다운 수경관 연출이 가능한 호수 및 열린광장, 조각공원 등 각종 조경, 편의시설 등을 갖춘 광주에서 최대 규모의 공원이다. 상무시민공원은 인공호수 2개, 광장(39,360㎡), 체육시설(종합운동장, 육상트랙, 테니스장 3, 농구장 1, 배구장 1), 여성발전센터, 환경조형작품(공룡나라외 15종) 등으로 이루어져 있다. 특히 운동시설로 3천470평의 국제규격 잔디축구장 및 6,000여 명을 수용할 수 있는 잔디스탠드, 맨발 조깅이 가능한 4백m 우레탄 트랙 등이 설치돼 있는 종합운동장과 소운동장이 있다.

조각공원은 상무시민공원내 호숫가를 중심으로 펼쳐져 있다. 각 작품마다 경관 조명시설을 설치해 야간에도 환상적이고 아름다운 작품을 감상할 수 있으며 누구나 만지고 체험하면서 감상할 수 있도록 함으로써 ‘보는 즐거움’과 ‘체험의 즐거움’을 동시에 안겨준다. 휴먼파크를 주제로 조각가 18명의 작품 22점이 설치되어 있다. ‘공룡나라’는 익룡21, 아기공룡, 티라노, 잃어버린 세계 등이 테마로 꾸며진 곳으로 티라노 미끄럼틀을 타며 뛰노는 어린이들의 모습이 눈부시다.',NULL,null,'https://www.seogu.gwangju.kr/culture',null,'광주광역시 서구 상무공원로 101',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','광주 역사민속박물관','지난 30여 년 간 시민들의 사랑을 받아왔던 광주 역사민속박물관은 광주역사공간에 대한 시민들의 오랜 여망을 담아 남도민속에 광주근대역사의 숨결을 더하여 지역의 역사와 문화를 종합적으로 살펴볼 수있도록 재탄생하였다.
광주와 전남 민속의 특수성을 집약하여 잊혀 가는 삶의 풍경을 진솔하게 그려내고 조선시대부터 근현대에 이르기까지 광주의 근현대 역사를 들여다 볼 수 있는 새로운 창이자, 지역의 대표 박물관이다. 주변에 국립광주박물관, 광주시립미술관, 문화예술회관, 광주비엔날레 전시장, 우치공원 등이 있다.',NULL,'09:00~18:00 ※ 관람종료 30분 전까지 입장가능','https://www.gwangju.go.kr/gjhfm','주차 가능','광주광역시 북구 서하로 48-25',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','중외공원','*공연과 전시시설이 밀집되어 있는 곳, 중외공원 문화벨트 *

중외공원은 수려한 자연 속에서 휴식을 취할 수 있는 도시 근린공원으로서 인기가 높은 곳이다. 중외공원에는 어린이대공원, 올림픽동산, 올림픽기념탑 등이 있다. 중외공원 문화벨트에는 비엔날레·박물관 지구에는 민속박물관과 교육홍보관, 비엔날레전시관이 들어서 있으며 어린이 대공원 등으로 휴일이면 나들이객들로 붐빈다. 특히 이곳에 사람들이 가장 많이 찾는 시기는 바로 가을. 그 이유는 이곳이 가을철 단풍명소로도 유명하기 때문이다. 또한, 광주의 관문에 설치된 무지개다리는 비엔날레 상징물로서 1회 광주비엔날레 때 설치된 또 다른 볼거리이다.',NULL,'24시간','http://tour.gwangju.go.kr','장애인 주차장 있음(2대)_무장애 편의시설','광주광역시 북구 하서로 52',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','광주시립미술관','* 다양한 작품을 전시하고 소개하는 광주광역시립미술관 *

1992년 8월 1일 지방 공립미술관으로는 처음 개관한 미술관이다. 1996년 기구를 확대 개편하여 광주비엔날레를 관장(管掌)해 오고 있다. 광주광역시와 전라남도 지역에 연고(緣故)를 둔 허백련과 오지호, 양수아, 임직순 등 유명 작고작가 작품으로부터 현재 활동하고 있는 작가들의 작품에 이르기까지 약 560점의 작품을 소장하고 있다.시립미술관의 주요사업으로는 상상설전시와 기획전시 등의 전시사업을 기반으로 하고 있으며, 다양한 문화프로그램을 통한 교육사업과 지역 미술의 활성화 등의 사업에도 매진하고 있다.

* 시립미술관의 시설 소개 *

광주시립미술관은 본관과 비엔날레관, 교육홍보관 등 3개관으로 구성되어 있으며, 총 18개의 전시실과 2개의 휴게시설을 갖추고 있다. 시설의 규모를 살펴보면 본관은 총 2,800㎡ 규모로 1층 4개, 2층 5개의 전시실을 갖추고 있다. 1층은 국내외 우수 작가들의 작품을 특정한 주제로 전시하는 기획 전시실이며, 2층은 미술관이 소장하고 있는 작품들을 장르별로 구분해 전시하는 상설 전시실이다. 또한, 소규모 전시실이 조성되어 있는데 이곳에서는 허백련기념관과 오지호기념관, 하정웅 기증작품전시실 등이 전시된다.비엔날레관은 약 800㎡ 규모로 3개층 5전시실로 구성되어 있으며, 교육홍보관은 1,300㎡ 규모로 1층에 3개의 전시실을 갖추고 있다. 이 밖에도 미술관계 전문도서와 잡지, 국내외 전시관련 자료를 제공하는 미술자료실과 미술전문서점이 있다. 휴게실에서는 음식과 음료를 판매한다.',NULL,'평일, 주말, 공휴일 10:00~18:00','http://artmuse.gwangju.go.kr','주차 가능','광주광역시 북구 하서로 52',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','충효동 왕버들 군','광주호 동쪽 호안(湖岸)과 충효동 마을 사이의 도로변에 위치한 왕버들나무는 버들과의 딸린 갈잎 큰키나무이다. 암수 나무가 딴 그루를 이루며, 4월에 꽃이 피고 열매는 5월에 익는다. 우리 나라 경기도 이남지역과 일부 중부 이남 지역, 중국 중부 지역에 분포하며 풍치림(風致林)과 정자목(亭子木)으로 널리 사랑을 받고 있다. 물가나 들에서 자라며, 목재는 가구와 땔감 등으로 쓰인다.

충효동의 왕버들 3그루는 모두 광주시 나무로 지정되어있는데 원래는 일송·일매·오류(一松·一梅·五柳)라 하여 마을의 상징 조경수였다고 한다. 그러나 매화와 왕버들 1그루는 말라 죽었으며, 또 1그루의 왕버들과 소나무는 마을 앞 도로를 확포장하면서 잘라 버려 지금은 왕버들 3그루만 남아 있다.

마을에서는 다시 왕버들 2그루를 식목하였으며, 소나무와 매화도 계속 식목할 계획을 가지고 있다. 충효동의 역사는 분명치 않으나 옛부터 성이 있어 성안 또는 석저촌(石低村)이라 불려왔다. 이 일대는 임진왜란 이전에 이미 양산보(梁山甫)의 소쇄원(瀟灑苑)을 비롯하여 김윤제(金允悌)의 환벽당(環璧堂), 김성원(金成遠)의 식영정(息影亭)과 누하당(樓霞堂) 등의 원림(苑林) 정각(亭閣)이 많이 있어, 주변 조경에 많은 영향을 주었던 곳이다.

* 나무의 크기
1) 높이 9m, 둘레 6.25m, 수관(樹冠)너비 11.5 ×18.9m
2) 높이 10m, 둘레 5,95m, 수관너비 14.0 ×14.0m
3) 높이 12m, 둘레 6.30m, 수관너비 16.6 ×27.0m',NULL,'00:00~24:00','http://bukgu.gwangju.kr/culture/',null,'광주광역시 북구 충효샘길 7',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','지산유원지','지산유원지는 2016년 12월경 11년만에 모노레일 운행을 다시 시작하며, 재개장하였다. 1개의 레일을 달리는 모노레일 특유의 덜컹거림은 탑승객들에게 스릴을 즐기게 한다.
모노레일을 탑승하면 광주 시내 전경과 무등산 정상의 모습을 한눈에 구경할 수 있다. 모노레일은 리프트의 종착점에서 숲길로 50ｍ 떨어진 산 중턱에서 출발해 팔각정이 있는 지산유원지 산 정상을 왕복하는 코스로 운행된다. 재개장 후 젊은세대 층을 중심으로 SNS와 입소문을 타고 광주 무등산에서 스릴을 즐길 수 있는 독특한 놀이시설로 인기몰이 중이다.',NULL,'주중 10:00~17:00 / 주말 10:00~19:00','https://blog.naver.com/jisan_park','소형 200대 / 대형 10대 주차 가능','광주광역시 동구 지호로164번길 35-1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','펭귄마을공예거리','양림동 펭귄마을공예거리는 양림동 주민 센터 뒤에 펭귄모양의 이정표를 따라 좁은 골목길을 들어가면 70,80년대 마을이 전시장으로 변모한 곳으로 무릎이 불편한 어르신이 뒤뚱뒤뚱 걷는 모습이 펭귄 같다고 하여 이름 지어진 마을이다. 마을 주민들은 과거에 화재로 타 방치되어 있던 빈집을 치우고 버려진 물건을 가져와 동네 벽에 전시하기 시작했으며, 마을 담벼락 에는''그때 그 시절 살아있음에 감사하자'' 고 새겨 놓았다. 마을 한가운데 있는 펭귄 주막은 주민들의 사랑방, 조그맣지만 필요한 물건들이 다 있다. 공예거리에는 도자공방, 가죽공방, 섬유공방, 목공방 등 다채로운 공방들이 입주해 있으며, 각 공방에서는 예쁜 공예품 판매 및 원데이 클래스와 같은 체험 활동도 하고 있다.',NULL,'화~토 10:00~18:00','http://craftst.or.kr/','장애인 주차장 있음_무장애 편의시설(양림탐방객쉼터)','광주광역시 남구 오기원길 20-13',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','전일빌딩245','전일빌딩245 Bl는 역사적 현장으로서의 건축형태와 공간을 ''245''로 상징화하여 전일빌딩의 의미를 되새기고 미래로의 스토리텔링을 담고자 하였다.''245'' 정중앙의 원은 5·18 민주화운동 당시 헬기사격의 선명한 탄흔을, 4가지 컬러 구성은 전일빌딩의 콘텐츠 공간을 형상화 하였다.',NULL,'09:00~19:00','http://tour.gwangju.go.kr/home/main.cs','없음','광주광역시 동구 금남로 245',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','무각사','조계총림 송광사 광주포교당 무각사는 광주 서구의 팔경 가운데 하나인 여의산에 자리해 있으며, 1990년대 이후 광주의 행정, 문화, 상업이 이곳 여의산이 자리한 상무지구로 옮겨지면서 무각사는 광주불교 1번지로 자리잡아가고 있다. ''일이 바라는대로 이루어진다''는 여의산에는 본래 극락암이라는 작은 암자가 자리해 있었고 1950년대 초반, 상무대(전투병과 교육사령부)가 들어서면서 장병들의 훈련공간이 되었다. 1971년 당시 송광사 방장 구산 큰스님과 지역불자의 원력으로 국민 총화 단결과 남북통일의 기원을 담아 민, 관, 군, 정신교육의 장으로 부처님 도량 무각사가 창건되었다.

1994년, 도심개발과 함께 상무대가 장성으로 옮겨지고 무각사를 포함한 여의산 일대 10만여 평이 5.18기념공원으로 명명되어 광주시민의 쉼터로 남게 되었고, 무각사도 불자와 시민들의 수행도량으로 가듭나 오늘에 이르고 있다. 2007년, 현 주지 청학스님이 부임한 직후 부터 시작한 제1차 천일기도를 원만히 회향하여 무각사를 대한불교 조계종단 소속으로 등기 이전 했으며 광주·호남 지역의 중심 사찰로 발돋움 할 수 있는 계기를 마련했다. 곧이어 2010년 5월 중창불사 원만 성취를 발원하는 기도를 입재하고 2013년 제2차 천일기도를 원만히 회향하여 근래 한국 불교계에서 찾아 볼 수 없는 깊은 감동과 신심을 불러 일으켰으며 사부대중의 수행 풍토를 일신시켰다. 2017년 2월 3차 천일기도 회향으로 무각사는 기도 수행뿐 아니라 시민과 함께 하는 도량으로 자리잡고 있다.',NULL,'연중개방','https://tour.gwangju.go.kr','있음 (소형 100여대 주차 가능)','광주광역시 서구 운천로 230',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','김대중컨벤션센터','* 지역 경제 활성화를 추구하는, 김대중컨벤션센터

김대중컨벤션센터는 최상급시설의 전시, 컨벤션센터로 천혜의 자연이 살아 숨쉬는 관광 광주에 건립되었다. 2003년 11월 광주전시컨벤션센터로 착공해 2005년 5월 김대중컨벤션센터로 이름을 바꾼 뒤, 같은 해 9월 6일 문을 열었다. 광주를 동북아 무역 중심도시로 육성하여 국가 경쟁력을 강화시키며, 관광산업 등 지역 특화산업의 발전에 견인함으로써 지역결제 활성화 도모에 힘쓰고 있다. 또한, 국제적 상품, 기술, 정보, 문화 교류의 장으로써 지역역량을 강화하고 있다. 그리고 풍부한 노하우를 갖춘 최고의 전문인력과 최고의 서비스와 다양한 편의시설을 갖추었다.

* 김대중컨벤션센터의 주요 사업

김대중컨벤션센터에서는 국내외 박람회·전시회·회의·세미나 개최, 부동산 관리·운영 및 임대, 기계장비와 용구의 관리·임대, 무역 거래 알선, 국내외 전시정보 자료 조사 및 제공, 문화·광고·이벤트 서비스 공급 등이다. 개관 이후 2005년에만 국제광산업전시회, 광주정보통신전시회, 광주국제식품산업전, 광주디자인비엔날레 등 10건의 전시회를 유치하였다.',NULL,null,'http://www.kdjcenter.or.kr','총 1,502대','광주광역시 서구 상무누리로 30',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','광주패밀리랜드 눈썰매장','호남 최대 길이의 썰매장, 광주패밀리랜드 눈썰매장 광주패밀리랜드는 호남 지방 최대의 종합 위락공원으로 991년 7월 6일 문을 열었다. 울창한 자연림과 저수지 등 자연조건이 빼어나 주변 전체가 우치공원으로 조성되어 있으며, 36만평의 대지 위에 35기종의 신나는 놀이기종, 동물원, 썰매장, 체육시설을 갖추고 있다. 또한 호남 최대길이를 자랑하는 사계절 썰매장은 봄, 여름, 가을엔 물썰매장으로 겨울엔 눈썰매장으로 더욱더 편하게 이용하시도록 에스컬레이터를 설치하고 있다.
패밀리랜드에는 다양한 놀이시설이 조성되어 있으며 코스에 따라 연인코스, 가족코스, 어린이 코스 등으로 나누어 이용할 수 있다. 우선 연인코스는 청룡열차, 카오스, 바이킹, 나는썰매, 박치기왕, 타가디스코, 나는그네 등으로 연인들이 함께 즐기면 좋을 놀이기구들이다. 가족코스는 패밀리열차, 사막의 폭풍, 타팀머신 등 가족 단위로 아이와 부모가 함께 즐기면 좋은 놀이기구이다. 이외에 어린이범퍼카, 꼬마비행기, 우주탐험대, 꼬마레이서 등 어린이 전용 놀이기구도 구비되어 있다.',NULL,'10:00 ~ 17:00','http://광주패밀리랜드.com','주차 가능','광주광역시 북구 우치로 677',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','광주패밀리랜드','* 호남 지방의 새로운 명소, 광주패밀리랜드 *

광주패밀리랜드는 광주광역시 북구 생용동에 있는 도시근린공원으로서 36만평의 부지 위에 최첨단 놀이시설 30종, 사계절 썰매장과 아이스링크, 수영장을 갖춘 호남 최대의 종합위락공원으로 1991년 7월 6일 개원하였다. 호남 최대길이를 자랑하는 사계절 썰매장은 봄, 여름, 가을엔 물썰매장으로 겨울엔 눈썰매장으로 더욱 더 편하게 이용하시도록 에스컬레이터를 설치하고 있다. 또한, 사계절 테마파크로 자리잡고자 전천후 썰매장 단지를 조성하여 봄, 여름, 가을, 겨울 사계절 언제나 고객과 즐거움을 함께 하고 있다.

* 패밀리랜드 100배 즐기기 *

패밀리랜드에는 다양한 놀이시설이 조성되어 있으며 코스에 따라 연인코스, 가족코스, 어린이 코스 등으로 나누어 이용할 수 있다. 우선 연인코스는 청룡열차, 카오스, 바이킹, 박치기왕, 타가 디스코, 날으는 그네 등으로 연인들이 함께 즐기면 좋을 놀이기구들이다. 가족코스는 패밀리열차, 사막의 폭풍 등 가족 단위로 아이와 부모가 함께 즐기면 좋은 놀이기구이다. 이외에 어린이범퍼카, 꼬마비행기, 회전목마 등 어린이 전용 놀이기구도 구비되어 있다.',NULL,'평일 :09:30 ~ 18:00, 주말 : 09:30 ~ 19:00','http://www.gjfamilyland.com/','있음(1,500대)','광주광역시 북구 우치로 677',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','오리요리의 거리','우리 나라 전통 음식 문화를 한마디로 말하라면 대개 탕 문화를 든다. 여러 가지 재료와 양념을 섞어서 만든 탕이야말로 종합적인 맛을 전달해 주고 그 재료의 진수를 모두 국물로 녹여 내기 때문이다. 특히 오리탕의 구수함과 텁텁함은 여느 탕이 따라오질 못할 정도로 독특하다. 광주역과 현대백화점 근처에는 오리탕집 간판이 즐비해 먹거리가 풍부한 곳이다. 30여 년 전부터 인기를 끌기 시작한 광주 오리탕은 유동 일대에만 20여 군데가 넘을 정도로 성업을 이루고 있다. 전국의 식도락가들은 이 맛을 보기 위해 비행기를 타고 달려오고 일본 관광객들도 유동의 ''오리탕 골목''을 지정 코스로 들른다고 한다. 그러자 아예 관할 구청에서는 오리고기를 토속음식으로 활성화하기 위해 ''건강 음식의 거리''라는 간판까지 내달았다. 오리고기는 쇠고기나 돼지고기, 닭고기 못지 않게 단백질이 풍부하며 육류로는 보기 드물게 알칼리성에 가까운 식품이다. 지방도 불포화 지방산이 대부분이기 때문에 다른 콜레스테롤을 크게 염려하지 않아도 된다. <동의보감에는 중풍·고혈압·신경통 등 성인병 예방에도 약효가 있다고 기록되어 있다.',NULL,null,'http://www.bukgu.gwangju.kr/culture',null,'광주광역시 북구 경양로 125',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','국립광주박물관','국립광주박물관은 1976년 수중발굴이 시작된 신안해저문화재를 비롯한 호남지역의 문화유산을 수집·보관하고, 지역의 역사와 문화를 소개하기 위해 1978년 12월 6일 개관하였다. 호남지역의 첫 박물관이자 광복 이후 우리 손으로 지은 최초의 지역 국립박물관이다.
국보·보물 등의 지정문화재를 포함하여 130,000여 점의 소장품을 보존·관리하며 성설전시와 특별전시를 통해 다양한 주제로 관람객들이 문화를 향유할 수 있도록 노력하고 있다. 전시뿐만 아니라 다채로운 맞춤형 교육·체험프로그램과 문화행사로 박물관이 더욱 가깝고 즐거운 문화 공간이 될 수 있도록 최선을 다하고 있다.',NULL,'10:00 ~ 18:00','http://gwangju.museum.go.kr','주차가능','광주광역시 북구 하서로 110',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','김용학가옥','김용학 가옥은 살림집과 정자가 언덕 위에 조화롭게 세워져 있는 1900년대 초의 민간원림이다. 동서를 중심축으로 하여 고단삼문, 사랑채, 안채를 둔 주거와 그리고 이웃에 병행하여 역시 동서축으로 원지, 고단삼문, 하은정, 연파정 등 선조들이 유람상춘을 즐겼던 건물들로 배치되어 있다. 특히 건물 정면 및 측면에 지당을 두어 정원의 미를 더하고 있다. 동저 서고 및 북저 남고의 대지를 잘 적응시켜 돌계단을 놓아 각 건축물에 이르도록 하였으며 기단을 높게하여 하은정을 앉혔다. 언덕 위에 있는 동파정은 기단을 낮추어 전체적인 조화를 도모하였다. 마당 및 주위는 1년생 된 벚나무 등 상당한 수령을 가진 수목들이 많다.

주거공간의 왼쪽에 연못과 하은정(荷隱亭)을, 좌측 뒤에는 연파정(蓮坡亭)을 동향으로 배치하여 자연과 조화를 이루도록 하였다. 사랑채는 정면 7칸, 측면 3칸의 팔작지붕 기와집이다. 평면형태는 중앙의 2칸 대청을 중심으로 좌우측에 온돌방을 배치하고, 후면을 손질하여 마루와 부엌을 증축하였다. 대청은 우물마루이며, 천장은 연등천장인데 연등천정에 보이는 마룻대 상량문에 정사윤이월이라 기록되어 1917년 신축된 것임을 알 수 있다. 평면은 정면 7간 측면 3간이고 처마는 흩처마 팔작집 와가이다. 구조형식은 석축기단을 90cm정도 높게하여 손질한 둥근 초석을 놓고 두리기둥을 전퇴에 둘렀으며 전퇴 기둥머리를 주두로 처리한 점이 특이하다. 왼쪽 끝에 반 칸의 마루가 있어 남쪽으로 터진 담장 사이로 연못을 볼 수 있다.',NULL,null,'http://www.bukgu.gwangju.kr/culture',null,'광주광역시 북구 하백로29번길 24',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','기아 챔피언스 필드','국내 최초 개방형 야구장인 광주-기아 챔피언스 필드는 최신, 최고의 시설로 미래를 만드는 꿈의 구장이다.',NULL,null,'http://www.tigers.co.kr/tigers/stadium_gwangju.asp','지상 56대, 지하 4대','광주광역시 북구 서림로 10',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','KBC 광주방송','* 호남지역 최초 TV 민영방송사. KBC 광주방송 *

1995년 5월 개국한 KBC광주방송은 호남 최초 TV 민영방송으로 출범해 18년 동안 지역민과 함께 호흡하며 호남지역의 대표방송으로 자리매김했다. 광주방송은 청소년을 위한 방송체험센터를 운영하고 있다. 방송국 1층에 위치한 체험센터는 방송제작현장을 간접적으로 체험해 볼 수 있는 기회를 제공한다. 방송국에 도착하면 방송이 제작되는 전반적인 과정을 영상으로 시청하고 체험관으로 이동하게 된다. 합성영상 제작을 위한 블루 스크린 앞에서 다양한 포즈로 체험을 즐길 수 있으며, 뉴스 세트의 앵커 자리에 앉아 앵커체험도 할 수 있다. 이곳에서는 음향과 화면조정을 주관하는 시설과 각종 방송장비도 직접 조작해볼 수 있다.',NULL,'9:30 / 13:30 (1일 2회)','http://www.ikbc.co.kr',null,'광주광역시 서구 무진대로 919',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','현충탑(광주)','조선시대 때 성거산이라 일컬었던 광주공원은 사직공원과 함께 광주시내에서는 가장 가까운 곳에 있는 시민의 휴식처이다.이곳에 나라를 지키기 위해 싸우다 숨진 사람들의 충성을 기리기 위하여 세운 현충탑이 있다. 1950년 한국전쟁 당시 나라를 구하기 위해 목숨을 바치신 광주, 전남지역의 전몰 호국용사 15,867명(군인 10,745명, 경찰 5,122명)을 모셨으나, 위패부는 모두 없다. 현충탑의 규모는 가로 5m, 세로 3m, 높이 22m로써 이곳에서는 매년 현충일인 6월 6일날 호국 영령들의 높으신 뜻을 기리기 위해, 추념식을 거행하고 있다. 현재 이곳은 광주광역시 공원관리사무소에서 관리하고 있다.

* 현충탑 인근의 또다른 탑, 서오층석탑 *

현충탑이 있는 광주공원 내 서오층석탑은 고려 시대 탑 전체적인 상태가 매우 양호한데, 통일신라 시대의 이중 기단 양식에서 변화된 모습을 보여준다. 탑의 오층 몸체부 중 초층을 다섯 개의 돌로 짜맞춘 것이 다른 탑에서는 흔히 볼 수 없는 독특한 특징이다. 또한 지붕돌의 추녀와 몸체부의 알맞은 비례, 상층으로 올라가면서 줄어드는 각 층의 비율이 크지 않아 전체적으로 높게 보이면서도 튼튼한 안정미와 수려함이 넘치는 뛰어난 수작이라 할 수 있다.',NULL,'24시간','http://www.ikbc.co.kr','있음','광주광역시 남구 중앙로107번길 15',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','현대자동차 울산공장','세계 최대, 자동차가 쑥쑥 탄생하는 곳

현대자동차는 세계 최대 규모의 단일 공장이다. 5개의 독립된 공장설비가 있으며 32,000여명이 하루 평균 5,800여대의 차량을 생산한다. 놀라운 것은 60만 그루의 조경수, 말 그대로 숲 속의 공장이라 할 수 있겠다. 견학 프로그램은 생산 공장과 76,000 톤 급의 선박을 접안 할 수 있는 부두 견학 등으로 이루어진다.',NULL,null,'https://www.hyundai.com','있음','울산광역시 북구 염포로 700',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','태화강 전망대','1963년 만들어졌으나 1995년 이후 가동하지 않았던 태화취수장 및 취수탑을 울산시와 한국수자원공사에서 현대적 감각에 맞게 태화강 전망대로 리모델링하였다. 2009년 2월 24일 개장하여 태화강의 수려한 경관과 자연생태 전망, 태화강의 철새관찰 그리고 시민휴식 공간으로 재 탄생하였다. 지상 4층 (높이 28m), 연면적 514㎡로 야외전망대 및 홍보관, 휴게실이 설치되어있다.',NULL,'11:00 ~ 23:00','http://tour.ulsan.go.kr/index.ulsan','있음','울산광역시 남구 남산로 223',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','태화강 국가정원','태화강은 울산의 중심을 가르며 흐르는 강으로, 화룡연을 굽이 돌아 학성을 지나면서 이 수삼산의 이름을 남기고 울산만에서 동해로 들어간다. 동서로 약 36㎢, 남북 28㎢ 의 유역은 그 대부분이 산악지대를 형성하나 강의 양쪽과 하류에는 기름진 평야가 펼쳐져 있으며, 오늘날에는 울산시민의 중요한 식수원이 되어주고 있다.
태화강의 심장부에 위치했던 태화들은 장기간동안 무관심으로 방치되어 있다가 태화강 국가정원 조성으로 다시 자연의 모습을 갖추고 시민들의 품으로 돌아왔다. 태화강 국가정원은 서울 여의도 공원 면적의 2.3배에 달하는 531천㎡로 물과 대나무, 유채ㆍ청보리를 비롯한 녹음이 함께 어우러진 전국 최대규모의 도심친수공간이다. 홍수 소통을 위하여 한때 사라질 위기에 처해졌던 십리대숲은 백만 시민의 단결된 힘으로 보전하게 되었고, 도시계획상 주거지역으로 결정되어 개발이 예정되어 있던 186천㎡의 토지를 다시 환원시켜 오늘의 태화강 국가정원을 조성하였다. 태화강 국가정원은 04년부터 10년 5월까지 총사업비 1.196억원(사유지매입 1.000 공사비 196)을 투입하여 실개천과 대나무 생태원,야외공연장,제방산책로 등 자연과 인간이 공존하는 친환경적인 생태공원으로 조성하였다.',NULL,'상시개방 (일부시설 제외)','https://www.ulsan.go.kr/garden/index','있음','울산광역시 중구 태화강국가정원길 154',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','용연서원','용연서원은 1737년(영조13)에 도(道) 유림의 공의에 의해 황용연(黃龍淵) 위에 용연사(龍淵祠)가 창건되어 충숙공(忠肅公) 이예(李藝)를 배향하였으며 1782년(정조6) 웅촌 석천리로 이건되어 사호(祠號)를 석계라 하였다. 1860년(철종11)에 서원으로 승격되었으나 1868년(고종5) 훼철되었고 1900년(광무4) 9월9일 설단하여 그 후 매년 9월 9일 향사를 봉행하여 왔으며 1915년 경수당(敬守堂)과 필동문(必東門)이 중건되었고 2002년 9월 9일 설단을 훼철하고 복원하여 매년 음력 9월 9일 향사를 봉행하여 왔으나 2001년 3월에 옛 용연사(龍淵祠) 유허지(遺墟地)에 울산 향유의 공의와 월진문회(越津門會)주도로 용연서원(龍淵書院)을 복원하여 음력 2월 23일 기일(忌日)을 기하여 향사를 봉행하고 있다.',NULL,null,'http://www.ulsannamgu.go.kr/tour',null,'울산광역시 남구 이휴정길 20',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','고래문화마을','2015년 조성된 고래문화마을에서는 예전 장생포 고래잡이 어촌의 모습을 그대로 재현하였으며, 고래광장, 장생포 옛마을, 선사시대 고래마당, 고래조각정원, 수생 식물원 등 다양한 테마와 이야기를 담은 공원을 둘러 볼 수 있다.

* 장생포 고래문화마을 주요시설 *
- 장생포 옛마을 : 고래 포경이 성업하던 1960~70년대의 장생포의 모습을 그대로 조성한 공간으로, 옛 향수를 불러 일으키는 추억의 공간이자 교육의 현장
- 고래조각공원 : 실물크기의 고래를 형상화하여 다양한 고래를 경험하고 학습할 수 있는 이색적인 체험공간
- 고래 이야기 길·고래 만나는 길 : 고래와 관련된 교감,공존 등 다양한 테마를 다루고 있는 스토리텔링 포토존
- 선사시대 고래마당 : 반구대 암각화와 고래잡이벽화 등 선사시대 고래역사문화를 체험할 수 있는 야외 학습 공간',NULL,'관람시간 : 09:00~18:00','http://www.whalecity.kr','주차 가능','울산광역시 남구 장생포고래로 271-1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','고래바다여행선','울산 남구에 위치한 장생포고래문화특구에는 국내 유일의 고래관광 인프라를 구축하고 있으며, 고래바다여행선 운항과 고래박물관 및 고래생태체험관도 갖추고 있어 테마관광으로 각광을 받고 있다. ‘고래바다 여행선’이 2009년 7월 우리나라 최초 취항한 이후 2013년 4월 새로운 크루즈급으로 교체하였으며, 한층 업그레이드된 고래관광 크루즈 시대를 열게 되었다. 2013년 5월 13일 밍크고래 1마리가 목격된 것을 시작으로 15일 참돌고래 4,500여 마리, 16일 3,000여 마리, 23일 4,000여 마리, 30일 3,500여 마리가 잇따라 출몰하는 광경이 목격되기도 했다. 야간에는 울산 공단의 화려한 야경을 볼 수 있으며, 선상에서는 공연, 뷔페 등 다양한 프로그램이 운영되고 있다. 특히, 초·중·고 수학여행, 기업단체 워크숍 및 세미나, 단체 연회, 결혼식, 비어파티 및 커플데이 등의 행사도 가능하다. ''''고래바다여행선''''에서 가족, 친구, 연인과 함께 특별한 경험과 소중한 추억을 만들 수 있다.',NULL,null,'http://www.whalecity.kr','주차 가능','울산광역시 남구 장생포고래로 244',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','귀신고래 회유해면','귀신고래는 해안가에 가깝게 사는 고래로, 암초가 많은 곳에서 귀신같이 출몰한다 하여 부르게 되었으며, 북태평양에서만 분포한다. 우리나라 동해안에 나타나는 귀신고래의 무리는 겨울에는 한반도와 일본 앞 바다에서 번식하고 여름에는 먹이를 찾아 오츠크해 북단으로 이동한다.
신고래는 몸길이가 평균적으로 수컷 13m, 암컷 14.1m이다. 새끼는 4.6m로 중간정도 크기이며, 체중은 평균 500㎏ 정도이다. 몸전체가 흑색으로 목의 주름살은 수컷은 2줄, 암컷은 3줄이 있는 것이 보통인데 드물게 4줄인 것도 있다. 등지느러미는 없으며 가슴과 꼬리지느러미만 있다. 몸에 붙는 동물이 많아서 그것이 떨어진 자리의 피부에는 크고 작은 흰무늬가 생긴다.
수온이 5℃∼10℃인 연안에 주로 서식하며, 바다새우, 물고기알, 해삼, 플랑크톤 등을 먹는다. 임신기간은 1년으로 2년마다 규칙적으로 1마리의 새끼를 낳는다. 울산 귀신고래 회유 해면은 고래 사냥으로 멸종위기에 처해 있는 귀신고래가 새끼를 낳기 위해 이동하는 경로에 속한다. 현재 울산 귀신고래 회유 해면이 속해있는 서부 북태평양과 북대서양의 귀신고래는 멸종의 위기에 처해있고, 동부 북태평양의 귀신고래는 보호와 감시에 의해 멸종의 위기를 벗어난 상태이다. 귀신고래는 멸종위기에 처한 국제적 보호 대상 동물로 이를 보호하고자 울산 부근 동해안을 중심으로 한 인근 회유 해면을 천연기념물로 지정하였다.',NULL,'00:00~24:00','http://tour.ulsan.go.kr',null,'울산광역시 남구 장생포동',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','울산대교 전망대','울산대교 전망대는 높이 63M(해발203M)로 화정산 정상에 위치해 있다. 전망대에 올라서면 2015년 5월 개통한 국내 최장이자 동양에서 3번째로 긴 단경간 현수교인 울산대교와 울산의 3대 산업인 석유화학, 자동차, 조선산업 단지 및 울산 7대 명산을 조망할 수 있다. 주간에 바라보는 울산의 전경과, 야간에 바라보는 공단과 도심의 야경은 색다른 즐거움을 제공한다. 전망대에는 동구 관광기념품 기프트샵과 카페 등을 운영하고 있어 볼거리·머물거리 모두 제공하고 있다.',NULL,'[관람시간] 09:00~21:00','http://www.donggu.ulsan.kr','주차 가능','울산광역시 동구 봉수로 155-1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','대왕암공원','대왕암 공원은 우리나라에서 울주군 간절곶과 함께 해가 가장 빨리 뜨는 대왕암이 있는 곳이다. 산책로에는 숲 그늘과 벚꽃, 동백, 개나리, 목련이 어우러져 있다. 28만평에 달하는 산뜻한 공간을 가진 이 공원 옆에는 일산해수욕장의 모래밭이 펼쳐져 있다. 우리나라 동남단에서 동해 쪽으로 가장 뾰족하게 나온 부분의 끝 지점에 해당하는 대왕암공원은 동해의 길잡이를 하는 울기항로표지소로도 유명하다. 이곳 항로 표지소는 1906년 우리나라에서 세 번째로 세워졌으며, 이곳 송죽원에서는 무료로 방을 빌려주어 아름다운 추억거리를 만들어 갈 수 있도록 민박을 제공하고 있다. 공원입구에서 등대까지 가는 길은 600m 송림이 우거진 길로, 1백여 년 아름드리 자란 키 큰 소나무 그늘이 시원함과 아늑함을 선사한다. 송림을 벗어나면 탁 트인 해안절벽으로 마치 선사시대의 공룡화석들이 푸른 바닷물에 엎드려 있는 듯한 착각을 불러일으킬 정도로 거대한 바위덩어리들의 집합소이다.',NULL,'연중무휴','https://daewangam.donggu.ulsan.kr/','주차 가능','울산광역시 동구 등대로 95',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','슬도','방어진 항으로 들어오는 거센 파도를 막아주는 바위섬으로 ''갯바람과 파도가 바위에 부딪칠 때 거문고 소리가 난다''하여 슬도(瑟島)라 불린다. 슬도는 ''바다에서 보면 모양이 시루를 엎어 놓은 것 같다'' 하여 시루섬 또는 섬 전체가 왕곰보 돌로 덮여 있어 곰보섬이라고도 한다. 슬도에 울려 퍼지는 파도소리를 일컫는 슬도명파(瑟島鳴波)는 방어진 12경중의 하나다. 1950년대 말에 세워진 무인등대가 홀로 슬도를 지키고 있으며 이곳에는 다양한 어종이 서식하고 있어 낚시객의 발길이 끊이지 않고 있다.',NULL,'00:00~24:00','http://tour.ulsan.go.kr','주차 가능','울산광역시 동구 방어동 산5-3',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','주전몽돌해변','주전몽돌해변은 울산 12경으로 울산 시민들이 즐겨 찾는 해수욕장이다. 주전은 땅이 붉다는 뜻으로 땅 색깔이 붉은색을 띠고 있다. 동해안을 따라 1.5km 해안에 직경 3~6cm의 동글동글한 까만 자갈이 해안에 길게 늘어져 있어, 절경을 이루고 있다. 노랑바위, 샛돌바위 등 많은 기암괴석이 있다. 또한, 주전몽돌해변의 파도 소리는 동구의 소리9경 중의 하나이기도 하다. 몽돌 사이로 드나드는 파도소리는 오늘의 번영을 이뤄낸 동구 사람들의 강인함이 느껴진다.',NULL,'00:00~24:00','https://tour.ulsan.go.kr/index.ulsan','주차 가능','울산광역시 동구 주전동',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','KBS 울산홀','KBS울산홀에서는 울산시민들이 다양한 문화를 접할 수 있게 자체적으로 영화상영을 하고 있으며, 울산홀에서 운영하고 있는 배드민턴은 지역 시민의 생활체육으로 뿌리내렸다 한다.또한, 콘서트, 문화예술제, 방송프로그램 제작, 박람회, 전시회, 강연회, 체육 및 일반행사와 관람인원 약 2,000명 수용의 KBS문화홀과, 편리한 주차공간, 최신 음향 시설을 갖추고 있다.',NULL,'공연에 따라 다름','http://ulsan.kbs.co.kr','주차 가능','울산광역시 남구 번영로 212',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','울산테마식물수목원','20여년을 두고 가꾸며 손질하여 온 농원을 테마화한 식물수목원에는 다양한 수목과 식물을 식재하여 자연학습과 학술연구를 병행할 수있는 곳이다. 울산테마식물원은 기존 생태림을 이용한 친환경적인 식물수목원을 조성하고 우리나라 자생식물을 토대로한 자연생태계의 회복과 기존 위락시설 위주의 유사 식물원과 차별화시켜 자연환경울 최대한 보존하고 식물의 특성, 이용객의 편의 및 토지활용 등을 고려한 통합적이고 체계적인 식물수목원을 수립하고자 한다. 또한 사라져가는 우리 식물을 번식 및 관리를 통하여 자생지외에서 보존 관리함으로써 희귀 및 멸종위기식물의 영구보존 및 복원을 추진하고있다.',NULL,'하절기(3~10월) 09:00~18:00 / 동절기(11~2월) 09:00~17:00','http://www.usarboretum.co.kr','주차 가능','울산광역시 동구 쇠평길 33-1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','울산대공원','울산대공원은 넓은 부지와 도시내부에 위치하여 시민들이 이용하기 편리하며, 풍부한 산업환경과 울산의 문화를 그대로 느낄 수 있도록 설계되었다.
울산대공원은 남녀노소 다양한 계층을 위한 체험의 장이자 문화와 휴식의 공간이며, 공원의 효율적인 관리를 통하여 생동감 넘치는 다양한 공원 프로그램을 진행함으로써 주민들에게 부담없이 지속적으로 방문할 수 있는 공간이자 자연생태에 관한 교육 및 체험공간이 되고자 한다.',NULL,'출입문개방 05:00~23:00','http://www.ulsanpark.com/main/main.php','주차 가능','울산광역시 남구 대공원로 94',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','울산종합운동장','울산광역시 종합운동장은 울산의 유일한 공공 체육시설로써 주경기장, 보조구장, 테니스장, 검도장, 사격장으로 이루어져 있다.',NULL,'출입문개방 05:00~23:00','http://www.uimc.or.kr/institution/InstitutionHome/ComplexStadium/main/main.php','장애인 전용 주차구역 있음_무장애 편의시설','울산광역시 중구 염포로 55',sysdate, 0, 0);

--세종
insert into item values(item_seq.nextval, 1, '관광지','합강공원 오토캠핑장','합강공원 오토캠핑장은 금강과 미호천이 만나는 금강살리기 세종지구의 합강공원에 위치하고 있다. 생태공원과 보존습지가 함께 어우러지고 금강과 미호천의 정취를 느낄 수 있는 자전거 도로와 산책로, 등산로 등 자연과 사람이 만나는 이야기가 있는 캠핑장이다. 또한 금강수계 중 최고의 풍경을 자랑하는 합강정과 더불어 자연의 여유와 행복을 느낄수 있는 4대강 살리기의 명소로 거듭나고 있다.',NULL,'14:00 ~ 13:00 (익일) - 오토캠핑존','http://hapgangcamp.sejong.go.kr','주차 가능','세종특별자치시 연기면 태산로 329',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','합호서원','1984년 5월 17일 충청남도문화재자료로 지정되었다. 2012년 해제되었다가 같은 해 12월 31일 문화재자료로 지정되었다. 1716년(숙종 42) 안경신·안경인·안경정 등이 고려 때의 학자 안향(安珦:1243∼1306)의 영정을 봉안하고 매년 3월 3일과 9월 9일 향사를 지내다가 고종 때 서원철폐령에 따라 훼철되었다. 그 후 후손들이 합호사(合湖祠)를 건립하여 춘추로 향사하다가, 1949년 전국 218개 향교의 동의를 얻어 합호서원을 부설하였다. 정면 3칸 측면 2칸의 맞배지붕 기와집으로 현재 연기유림회 주최로 매년 9월 12일 안향의 제삿날에 제사를 지낸다. 안향은 순흥(順興) 출신으로, 호는 회헌(晦軒), 시호는 문성공(文成公)이다. 1260년(고려 원종 원년) 문과에 급제하여 교서랑(校書郞)이 되고, 1270년 삼별초의 항쟁 때 강화에 억류되었다가 탈출한 뒤 감찰어사(監察御史)가 되었다. 1286년(충렬왕 12) 왕을 따라 원(元)나라에 가서 연경(燕京)에서 처음으로 《주자전서(朱子全書)》를 보고 필사하여 고려로 가지고 들어왔다. 이후 성리학 연구에 몰두, 고려 말기의 유학 진흥에 큰 공적을 남겼다.',NULL,null,'http://www.cha.go.kr',null,'세종특별자치시 연동면 원합강1길 262-6',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','운주산성','일명 고산산성으로 백제시대의 유물이다. 전동면 미곡리, 청송리와 전의면 동교리, 신정리 경계 지점에 운주산(459.7m)이 솟아있다. 운주산성은 바로 이 운주산을 이용한 산성이다. 산성 서쪽 아래편으로는 경부고속 철길이 놓인다. 운주산성은 성의 둘레 3,210m, 폭 2m, 높이 2~8m의 웅장한 백제산성으로, 분지형의 산세와 수려한 풍치가 일품이다.성벽은 자연 지형을 최대한 이용하면서 축성되었는데, 북벽과 동벽은 운주산 정상에서 서쪽과 남쪽으로 뻗어내린 능선을 따라 이어졌으며 남벽은 산봉우리를 에워싸면서 축조되었고, 서벽은 서쪽으로 뻗어내린 능선을 가로지르면서 축성되었다. 따라서 북쪽은 해발고도가 높고 서남쪽이 낮은 지형으로 이루어져 있다.서문, 남문, 북문에서 문지(門址)가 확인되는데 붕괴되어 자세한 형상을 알 수 없다.

성 안에는 성문과 건물터, 우물터 등이 남아 있는데, 정상부에는 기우제(祈雨祭)를 지낸 제단으로 보이는 원형 대지가 있다. 또 성 안에서는 백제 토기편과 기와편이 출토되었고, 고려시대와 조선시대의 자기편과 기와편도 발견되었다. 이 산성은 내성과 외성으로 이루어져 있어서 고대 산성 연구에 중요한 자료가 된다.운주산성은 서기 660년 백제가 멸망하고 풍왕과 복신, 도침장군을 선두로 일어났던 백제부흥 운동군의 최후의 구국항쟁지로 알려져 있다. 운주산 등산로 입구에 사찰(고산사)이 있으며 백제가 멸망한 매년 음력 9월 8일을 기해 토요일 백제 멸망기의 의자왕과 부흥기의 풍왕 그리고 백제부흥운동을 하다, 죽은 혼령을 위로하기 위해 고산제를 지내고 있다.',NULL,'00:00~24:00','https://www.sejong.go.kr/tour.don','주차 가능','세종특별자치시 전동면 청송리 산90',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','베어트리파크','세종특별자치시에 위치한 베어트리파크는 2009년 5월 개장하였다. 이재연 설립자가 50여년간 가꾸어온 식물과 동물들이 자라 숲과 군락을 이루어 현재의 베어트리파크가 되었다. 베어트리파크 33만여㎡(10만 평)의 대지에 1,000여종 40여만 점에 이르는 꽃과 나무, 비단잉어와 반달곰, 꽃사슴 등이 어우러진 곳이다. 백여마리의 비단잉어가 서식하는 오색연못을 시작으로 수백 마리의 반달곰과 불곰이 재롱을 부리는 모습을 직접 볼 수 있다. 베어트리파크를 한눈에 볼 수 있는 전망대를 시작으로 사시사철 꽃을 피우는 베어트리정원, 아기반달곰과 사슴, 공작새, 원앙 등을 관람할 수 있는 애완동물원 등이 조성되어 있다. 희귀한 소나무를 수집해 조성한 송백원, 고사목과 향나무가 조화를 이룬 하계정원, 수천 송이의 장미를 감상할 수 있는 장미원, 국내 야생화를 모아둔 산책로인 야생화 동산, 다양한 종류의 분재를 만나 볼 수 있는 분재원, 국내에서 보기 힘든 열대 식물을 한자리에 모아 놓은 열대온실원, 선인장과 과목, 나무화석 등 다양한 볼거리가 가득한 만경비원, 수령 100년 이상 된 향나무 사이로 산책로를 조성한 향나무동산, 800년 된 느티나무가 있는 우리나라 지도 모양으로 만든 유럽식 정원 송파원 등이 있다.',NULL,'3월~11월 : 09:00 ~ 일몰시 / 12월~2월 : 10:00 ~ 17:00 또는 18:00','http://www.beartreepark.com/','주차 가능','세종특별자치시 전동면 신송로 217',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','비암사(세종)','* 810년 된 느티나무가 있는 비암사 *

세종시 전의면 비암사길 137 비암사는 2,000여 년 전 삼한시대의 절이라고 하지만 정확하진 않다. 통일신라 말기 도선국사가 창건했다는 설도 있다. 삼층석탑은 고려시대의 것으로 추정되며, 조선시대 기록에 비암사라는 이름이 나온다. 1960년 삼층석탑 꼭대기에서 ‘계유명전씨아미타불비상’이 발견되어 국보로 지정됐다. 이밖에 17세기에 제작된 것으로 알려진 영산회 괘불탱화와 소조아미타여래좌상이 있다. 비암사에서 방문객을 가장 먼저 반기는 것은 810년 된 느티나무. 높이 15m, 둘레 7.5m인 이 나무는 비암사로 오르는 계단 옆에 있다. 비암사 주차장에 차를 세운 뒤 바로 절로 올라가지 말고 화장실 뒤로 난 계단을 따라 산으로 조금만 올라가면 비암사를 한눈에 담을 수 있다.',NULL,'3월~11월 : 09:00 ~ 일몰시 / 12월~2월 : 10:00 ~ 17:00 또는 18:00','http://cafe.daum.net/bas0230','주차 가능','세종특별자치시 전의면 비암사길 137',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','영평사','대한불교조계종 제6교구 마곡사 말사로서 6동의 문화재급 전통건물과 3동의 토굴을 갖춘 대한민국 전통사찰의 수행도량이다.산은 작지만 풍수적으로는 금강을 거슬러 올라가는 역룡(逆龍)이라 하여 기운이 세찬 명당이라 불린다. 장군산!(將軍山) 국토의 7할이 산인 우리나라, 산봉우리 이름이 장군봉인 산은 많다. 하지만 과문한 탓이겠지만 산의 이름이 장군인 산은 아직 듣지 못했다.

어느 등산가는 큰 나무숲도 없고 두 시간이면 다녀오는 정상을 다녀와서 하시는 말씀 “태백산에서도 느끼지 못한 거대한 기운, 어떤 두려움 같은 경외심을 느꼈어요, 굉장히 큰 산입니다, 이 명산에 안겨있는 영평사 앞으로 대한민국 국찰(國刹)이 되겠습니다.” 어찌되었든 들어오면 편안하다고들 말하는 영평사는 아직도 반딧불과 가재 다슬기가 사는 청정한 물과 공기를 간직한 조용하고 아늑하며 청정한 수행도량이다. 봄에는 매발톱꽃, 할미꽃이요 여름에는 백련이며 가을에는 구절초 꽃 등 온갖 들꽃들이 앞 다투어 반기는 꽃 대궐이기도 하다.

* 영평사의 유래 *

스승이 머물고 있는 도량으로 영원하고 궁극적인 행복을 선사하는 곳이며, 또한 도량에서 추구해야 할 일이 바로 중생의 행복과 세계의 평화라고 믿기 때문에, 이 도량에 상주하는 대중은 물론 한 번 다녀가거나 절 이름을 생각만 해도 최고의 행복을 얻으라는 원력으로 영평사(永平寺)라고 한다.',NULL,'연중무휴','http://www.youngpyungsa.co.kr','주차 가능','세종특별자치시 장군면 영평사길 124',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','고복자연공원','공원 지정면적은 1.95㎢로 오봉산의 자연림, 동굴(용굴), 사찰(신흥사), 야외조각 전시장 등이 있으며, 수변길(데크) 3.65km가 조성되어 있다. 주변 마을에는 포도, 복숭아, 배를 재배하는 과수 단지가 있다. 공원변에 광장과 이화여대 미술대 강태성 교수가 조성한 야외조각공원이 있어 방문객들에게 또 하나의 볼거리를 제공해 주고 있다. 특히, 야외수영장이 개장하는 여름방학시기에 많은 사람들이 찾아온다. 중간지점에 있는 ''민락정''에서 내려다보는 경관이 일품이며, 벚꽃 필 무렵의 고복자연공원은 아는 사람만 아는 숨겨진 명소이다. 고복자연공원 주변에는 갈비, 한방오리와 메기매운탕을 전문으로 하는 음식점 등이 산재해 있어 미식가들의 입맛을 돋워 주며, 수변 전망이 가능한 까페들이 있어 휴식공간을 제공해 준다.',NULL,'연중무휴','https://www.sejong.go.kr/tour','야외 주차장','세종특별자치시 연서면 도신고복로 586',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','금강자연휴양림(금강수목원,산림박물관)','공주시에서 대전방향으로 강변을 따라 오다가 청벽대교를 건너기 전 오른쪽으로는 유유히 흐르는 금강을 바라보면서 잠시 달리다 보면 오른쪽에 붉은 아치 모양의 불티교가 보인다. 이 불티교를 건너면 이렇게 넓은 자연휴양림이 있을까 싶을 만큼 규모도 크고 잘 정돈된 금강자연휴양림이 모습을 드러낸다. 창벽에 가로막혀 나룻배를 타고 드나들어야했던 오지마을인 이곳에 1994년 충남산림환경 연구소가 이전하면서 주변의 잘 보존된 울창한 숲을 금강자연휴양림으로 지정하였고, 1997년 10월에는 산림박물관이 문을 열었다. 금강자연휴양림은 첫인상부터 여느 휴양림과는 다른 느낌을 준다. 울창한 숲 속의 산책로를 떠올리게 하는 휴양림이라기 보다는 잘 정비된 도로위에 산림 박물관, 수목원, 온실, 연못, 야생동물원 등 다양한 볼거리들이 산재해있어 테마파크 같은 인상을 주기 때문이다.',NULL,'하절기(3~10월) 09:00∼18:00 / 동절기(11~2월) 09:00∼17:00','http://www.keumkang.go.kr','야외 주차장','세종특별자치시 금남면 산림박물관길 110',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','밀마루전망대','세종시의 중심행정타운 중앙에 조성된 밀마루전망대는 동서남북 어디서든 도시의 모습을 관람할 수 있도록 설계되었다. 이 전망대에 오르면 하루가 다르게 변화하는 세종시의 모습과 공주, 조치원 등 인근 지역을 한 눈에 볼 수 있다. 또한, 세종시 전체 조감도와 첫마을 조감도, 토지이용 조감도도 설치해 놓아 조감도를 살펴보면서 세종시 미래의 모습을 동시에 상상해 볼 수 있다.

- 설치일 : 2009년 3월 12일
- 높이 : 42m (해발 : 98m)
- 특징 : 누드 엘리베이터와 슬림형',NULL,'09:00~18:00','https://www.sejong.go.kr/tour/sub01_11.do','주차 가능','세종특별자치시 도움3로 58',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','비암사 도깨비도로','비암사 가는 산길로 약 1.3km 쯤 올라가는 중간쯤에 내려가는 길인데도 마치 올라가는 것 같은 착시현상을 일으키게 하는 이른바 ‘도깨비 도로’이다. 도깨비 도로 시작점과 끝나는 지점을 알리는 안내판이 세워져 있어 호기심 많은 관광객들은 직접 실험을 해보기도 한다.',NULL,null,'https://www.sejong.go.kr/tour/index.do',null,'세종특별자치시 전의면 다방리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','연기대첩비공원','연기대첩을 기념하기 위해 높이 10m의 연기대첩비를 고복자연 공원에 건립하고, 대첩비 주변 지역을 공원으로 조성하였다. 연기대첩은 1291년(충렬왕 17년) 고려를 침공하여 금강 연안까지 밀고 내려온 원나라의 반란군 합단적을 한희유, 인후, 김흔 등이 지금의 세종특별자치시 연서면 정좌산에서 격파한 싸움이다. 고려시대의 대표적 역사서인 고려사와 고려사절요, 동국여지승람 등에 기록되어 있는 7대 대첩 중의 하나로 꼽힌다. 공원 안에는 대첩비 외에 조각상, 놀이시설, 파고라, 잔디광장 등이 있어 가족 단위의 관광객들이 자주 찾는 곳이다.',NULL,null,'https://www.sejong.go.kr/tour/index.do','주차 가능','세종특별자치시 연서면 도신고복로 586',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','아람달 체험마을','세종시 아람달 체험마을은 활력 넘치고 살맛나는 농촌으로 발돋움하기 위해 여섯 개 마을이 의기 투합한 농촌마을 종합개발사업으로 시작되었다.아람달은 정겨운 농촌 분위기 속에서 현대적인 펜션형 숙박, 세미나실, 풋살 경기장 등 이용자를 배려한 다양한 편의 시설을 완비하고 있다. 또한 자라나는 청소년에게는 도시에서 할 수 없는 색다른 체험을, 어른들에게는 그 시절 농촌 문화의 아련한 추억을 떠올릴 수 있도록 각종 민속체험, 농촌체험, 로컬푸드 등을 제공한다.',NULL,'09:00~18:00','http://aramdal.kr/main/main.php','있음 (승용차 20대, 대형버스 2대)','세종특별자치시 전동면 운주산로 606',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','우주측지관측센터','이곳은 직경 22m, 높이 28m의 국내 최대 전파망원경을 가진 관측센터이다. 한국의 측지 VLBI의 발자취와 세계의 천체망원경을 살펴보고 천문 측량에 관한 정보도 알아 볼 수 있다. ‘우주측지’라는 생소한 용어는 백문이 불여일견, 이곳에서 궁금증을 해결한다.',NULL,'월~금 10:00~17:00 (12:00~13:00 점심시간)','http://aramdal.kr/main/main.php','있음','세종특별자치시 연기면 월산공단로 276-71',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','신광사(세종)','신광사는 세종특별자치시 조치원읍에 있는 노적산에 자리한 사찰이다. 창건연대는 약 160여년 전으로 추측되며, 1920년 이경직 주지가 복원하였다는 기록이 남아있다. 창건 당시 토골절, 수양사(修養寺) 등으로 불리었으며, 혜원스님이 1980년 신광사로 개칭하였다. 젊음의 활기가 넘쳐 흐르는 사찰. 누구나 신광사를 찾게 되면 느끼게 될 첫 인상이다. 누구나 신광사를 찾게 되면 느끼게 될 첫 인상이다. 그 이유는 쉽게 알게 된다. 사찰의 역사가 길지 않음에도 불구하고 젊은 대학생들이 살고 있는 홍익대학교가 근처에 있으며, 이들에게 적극적으로 부처님의 가르침을 전하고 있기 때문이다.

* 젊은 사찰의 면모를 볼 수 있는 신광사 *
신광사는 후덕한 상호를 지닌 주지스님의 모습만큼 부처님의 말씀을 널리 전파하기 위해 노력하고 준비하는 그런 곳이다. 신도가 절집에 가까이 다가가기 쉬운 도심 속 사찰이다. 신광사는 그렇게 참배객이 접근하기 좋은 곳에 위치해 있으면서 한편으로 그렇게 인연을 맺은 이들을 소홀히 하지 않고 품어 안으면서 불법을 전파하려고 노력하는 곳이다. 이러한 노력은 사찰 곳곳에 배치된 석물 하나하나에도 배어 나오고, 법당 안에 봉안된 불상에서도 느낄 수 있다. 이처럼 신광사는 젊은이와 함께 계속 성장할 것으로 기억되는 그런 사찰이다.',NULL,'월~금 10:00~17:00 (12:00~13:00 점심시간)','http://www.sejong.go.kr/tour/index.do','있음','세종특별자치시 조치원읍 토골고개길 24',sysdate, 0, 0);

--강원도
insert into item values(item_seq.nextval, 1, '관광지','조선민화박물관','조선민화박물관은 전문해설자의 유익하고 재미있는 설명과 함께 조선시대 진본 민화와 고가구, 현대민화 등을 함께 관람할 수 있으며 관람객이 판화로 민화찍기, 민화 그리기 등에 직접 참여 할 수 있는 민화 체험장과 독특한 민화 상품도 구입할 수 있다. 또한, 정자 등 멋진 휴식공간에서 쉬면서 250년생 목백일홀 등 수백점의 희귀 분재와 수석 등을 함께 감상할 수 있다.

* 개관일 2000년 07월 29일',NULL,'월~금 10:00~17:00 (12:00~13:00 점심시간)','http://www.minhwa.co.kr','있음','강원도 영월군 김삿갓면 김삿갓로 432-10',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','김삿갓 계곡','김삿갓 묘가 위치하여 유명해진 인근 계곡이다. 김삿갓과 관련된 유적은 강원도 남부와 충청북도 경계지대에 분산되어 있는데 남대천 (南大川)을 사이에 두고 북쪽 영월군 하동면 어둔리 선래골 (선락동)에는 집터가 있고, 근처 와석리 노루목에는 묘소가 있다. 그리고 냇물 건너 단양군 영춘면 접경에는 기념시비가 세워졌다. 최근 김삿갓에 대한 문학적, 역사적 관심이 높아지면서 이 지역을 찾는 등산객, 답사 여행객이 증가하여 대야리 - 인근 마대산(해발1,052m, 강원도,충북, 경북 3도의 접경을 이루는 산) - 김삿갓생가터 - 김삿갓묘역을 연결하는 등산로가 개발되고 있으며, 곰봉 (곰의 모양을 한 봉우리)도 탐방이 잦아지고 있다. 와석리는 10여 가구가 살고 있는 조촐한 오지 마을로서 옛 시골의 정취를 간직하고 있는 마을이다.

김삿갓 계곡은 김삿갓이 생전에 ""무릉계""라 칭했을 만큼 빼어난 경치를 지녔다. 관광지로 지정되지 않았지만 오염이 안되고 보존이 잘 되어 청정지대임을 자랑한다. 인근 내리계곡의 크낙새와 법흥사 적별보궁 오르는 길의 딱따구리, 그외 동강과 서강이 기암을 돌아 흐르는 곳에 사는 수달, 수리부엉이, 비오리, 검독수리, 작은소쩍새, 올빼미, 황조롱이, 오리떼 등은 이 지역이 과연 있는
그대로의 생태박물관임을 입증한다. 영월군은 이 계곡과 내리계곡 등 인근의 계곡을 번갈아가며 휴식년제를 취하고 있으므로 확인 후 출발해야 한다.',NULL,'월~금 10:00~17:00 (12:00~13:00 점심시간)','https://www.yw.go.kr/','있음','강원도 영월군 김삿갓면 와석리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','고씨굴 (강원고생대 국가지질공원)','고씨굴은 1969년 6월 4일에 천연기념물로 지정되어 국가로부터 보호를 받고 있는 학술적, 자연유산적 가치가 뛰어난 동굴이며, 1974년 5월 15일에 일반인들에게 공개되었다. 고씨굴은 여러 층으로 이루어진 다층 구조를 보이며 제일 아래층에는 지하수가 작은 하천처럼 흐른다. 주굴은 대부분 석회암 내에 발달한 절리면(석회암이 힘을 받아 깨진 부분)을 따라 형성되었으며, 가지굴은 층리면(퇴적암에 나타나는 편평한 면)을 따라 발달한다. 고씨굴 내에는 종유관, 종유석, 석순, 석주, 동굴산호, 유석, 커튼, 곡석 등이 다양한 동굴생성물이 자라며, 비공개 구간에서 자라는 흑색을 띄는 동굴생성물은 고씨굴만의 자랑이다.',NULL,'09:00~18:00(매표는 마감 1시간 전까지)','http://www.paleozoicgp.com/','있음(소형 100대 / 대형 10대 주차 가능)','강원도 영월군 김삿갓면 영월동로 1117',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','영월아프리카미술박물관','아프리카미술박물관은 아프리카 여러 부족의 생활, 의식, 신앙, 축제 등과 관련하여 만들어진 문화산품 즉 조각, 그림, 생활도구, 장신구 등과 현대미술 작품을 상설 전시하고 있다. 아프리카의 다양한 문화를 폭넓게 이해하기 위하여 주한아프리카대사관이 출품한 아프리카 문화전을 반 영구적으로 전시하고 있으며, 계기 또는 지역적 특성에 맞는 특별기획전 통하여 박물관 기능을 보완하고 있다. 아프리카인들의 관념 세계를 표현한 마스크와 인물상 등 조각 미술을 통하여 그들의 예술적 재능을 찾아볼 수 있고 아프리카 미술의 소재, 제작 기법, 미술적 특징 등이 현대미술에 미치는 영향과 의미를 알아볼 수 있도록 전시하고 있다.',NULL,'하절기(3~11월) 09:00~18:00 / 동절기(12~2월) 10:00~17:00','http://blog.naver.com/aamy32229','주차 가능','강원도 영월군 김삿갓면 영월동로 1107-1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','이원추추파크','강원도 삼척시 도계읍에 위치한 국내 유일의 산악철도와 영동선을 활용한 기차테마파크로 지그재그 철도를 달리는 스위치백트레인, 국내 최고 속도의 짜릿한 레일바이크, 이색 미니트레인 외 30동의 숙박시설로 이루어진 하이원추추파크이다. 남녀노소 누구나 체험하고 즐길 수 있는 국내 유일의 철도 체험형 기차 테마 리조트로 추억과 낭만을 느끼며 즐거운 기차여행을 체험할 수 있다.',NULL,'레일바이크/스위치 백트레인 회차 운영','http://www.choochoopark.com','주차 가능','강원도 삼척시 도계읍 심포남길 99',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','덕풍계곡 트레킹','자연경관이 수려하고 마을과 멀리 떨어져 있어 조용하며 경관이 뛰어난 여러개의 폭포가 산재해 있다. 병풍처럼 둘러싸인 산세가 수려하여, 등산을 겸한 가족 단위 피서지로 적합한 곳이다. 진입로인 풍곡1리까지는 416번 지방도를 이용할 수 있다. 계곡 입구에서 계곡 안까지는 약 8㎞정도 된다. 덕풍마을 앞에 흐르는 덕풍계곡의 맑은 냇물에는 물고기가 떼지어 다니고 마을 사람들의 후한 인심은 찾는이들에게 좋은 추억거리를 제공한다. 덕풍계곡과 용소골은 도전하는 젊음을 위한 트레킹 코스로서 더할 나위 없이 좋은 곳이다.
덕풍계곡과 용소골은 전국 제일의 트레킹코스로 가곡면 풍곡리에 위치해 있으며 덕풍에서 용소골 막바지까지는 약 12km이며 경북 울진군 서면과의 접경이다. 덕풍에서 용소의 제3폭포에 이르는 대자연의 미관은 실로 금강산 내금강을 방불케 한다.',NULL,null,'http://valley.invil.org',null,'강원도 삼척시 가곡면 풍곡리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','추암해변','추암해변은 기암괴석이 늘어선 해안절벽과 고운 백사장이 아름다운 해변이다. 해변의 크기는 작은 편이지만 절경을 감상하기에는 충분하다. 추암해변은 해돋이 명소로 유명한데, 그중 추암촛대바위는 사시사철 여행객의 발길이 끊이지 않는 명소 중 명소다. 애국가 방송 첫 소절의 배경화면에 등장하는 바위는 하늘을 향해 곧게 뻗은 기암 끝에 해가 걸린 모습이 촛불 같아 ‘추암촛대바위’라고 불린다. 추암촛대바위에서 200m 떨어져 있는 해상 출렁다리는 또 다른 볼거리다. 바다를 건너도록 기암 위에 설치된 72m 길이의 추암촛대바위 출렁다리는 짜릿함을 줌과 동시에 동해를 배경으로 사진을 남길 수 있는 포토존이다. 추암촛대바위에서 출렁다리로 향하는 길 중간에는 북평 해암정이라는 정자가 있다. 1361년, 삼척 심 씨의 시조인 심동로가 벼슬을 버리고 노후를 보내기 위해 지은 정자로 지금 모습은 1790년경에 중수한 것이다. 출렁다리의 끝은 추암조각공원으로 이어져 연계해 둘러보기 좋다.',NULL,'추암해변: 00:00~24:00','https://www.dh.go.kr/tour','주차가능','강원도 동해시 촛대바위길 26',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','용평리조트','강원도 평창군의 명산인 발왕산 기슭에 위치한 리조트로 ‘한국 스키의 메카’로 불린다. 1975년 한국 최초로 스키장을 개장했고, 아시아에서 두 번째로 국제스키연맹(FIS)으로부터 국제대회 개최가 가능한 수준으로 공인받았다. 리조트가 들어선 대관령면은 연평균 적설량이 250cm에 달하고 겨울이 길어 자연설이 쌓인 슬로프에서 스키를 즐길 수 있다. 스키장 외에도 호텔과 콘도, 골프장, 워터파크, 발왕산 관광케이블카 등 다채로운 시설을 갖췄다. 용평리조트가 자리한 해발 1,458m의 발왕산은 희귀목과 야생화가 살아가는 훌륭한 생태 여행지다. 발왕산의 아름다운 자연을 만끽할 수 있는 다양한 웰니스 프로그램을 운영한다. 숲해설가에게 산과 희귀 나무에 관한 이야기 듣기, 티베트의 명상 도구인 싱잉볼을 활용한 뮤직 테라피, 힐링 요가 등 발왕산의 청정한 기운 속에서 양질의 휴식을 누릴 수 있다. 발왕산 정상에 조성된 발왕산氣스카이워크는 일대 풍광을 감상할 수 있는 명소다. KTX 진부역과 용평리조트를 오가는 셔틀버스가 정기 운행한다.',NULL,'00:00~24:00(시설별 운영시간 상이)','www.yongpyong.co.kr','주차가능','강원도 평창군 대관령면 올림픽로 715',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','삼척 너와마을','너와란 소나무나 참나무를 두께 4~5cm, 가로 20~30cm, 세로 40~60cm정도로 자른 널빤지를 말하고 너와집이란 이 너와를 지붕에 얹은 집이다. 강원도에서는 느에집 또는 능에집 이라고도 한다. 신리마을에 가면 점차 사라져가는 이 너와집을 만나볼 수 있다. 황토너와집 펜션에서의 숙박, 마을 부녀회가 운영하는 식당에서의 산촌 먹을거리맛보기 등은 웰빙여행의 대표적 사례이다. 산촌칼국수, 산촌 된장찌개, 칡전병, 송이백숙 등의 별미도 맛보고 떡만들기, 순두부만들기 등도 체험해 볼 수 있다. 계절에 따라 다양한 체험이 준비되어 있는데 가을에 신리 너와마을에 가면 너와집을 지어보는 체험, 송이채취 등 가족단위 산촌체험을 즐길 수 있으며, 겨울철에 가면 눈 덮인 골짜기에서 눈발구타기, 굴피집 추억만들기, 등잔불켜고 밤보내기 등 겨울 산골마을의 정취를 한껏 느낄 수 있다.',NULL,'체험 별 상이','http://neowa.invil.org','주차가능','강원도 삼척시 도계읍 문의재로 1113',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','삼척문화예술회관','삼척문화예술회관은 1994년 6월 죽서루, 오십천 성남동에 개관하여 음악, 연극, 무용 등의 공연예술은 물론 전시, 영화의 기능까지 갖춘 대규모 다목적시설로 지역문화예술의 전당으로써 문화예술을 사랑하는 지역민과 함께 해왔다.',NULL,'체험 별 상이',null,'주차 가능(소형 250대, 대형 30대)','강원도 삼척시 엑스포로 45',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','천곡황금박쥐동굴','한국에서 유일하게 도심 한복판에 자리한 석회암 동굴이다. 강원도 동해시 시내 중심부에 위치한 동굴은 1991년 아파트 공사를 하다 우연히 발견되어 1996년부터 일반에 공개됐다. 4~5억 년 전에 생성된 것으로 추정되는 동굴에는 세계적 멸종위기종인 황금박쥐가 서식하는 것으로 알려져 있다. 진한 오렌지색을 띠는 황금박쥐는 멸종위기 야생생물 1급과 천연기념물로 지정된 희귀종이다. 1,510m 길이의 동굴은 810m만 관람 구간으로 개방하고 나머지는 보존 지역으로 보호한다. 천장에 매달린 대형 종유석, 바닥에서 솟은 석순, 종유석과 석순이 기둥으로 연결된 석주 등 기이한 동굴 생성물을 볼 수 있고, 천장에 깊은 도랑을 형성한 천장 용식구는 한국에서 가장 큰 규모를 자랑한다. 동굴 옆의 자연학습체험공원을 함께 둘러보면 더욱 유익하다. 동굴 형성 과정을 이해하기 쉽도록 785m의 돌리네(석회암이 물에 녹으면서 깔때기 모양으로 패인 웅덩이) 탐방로를 조성했고, 100여 종의 야생화가 피는 야생화 체험공원에서 쉬어갈 수 있다.',NULL,'09:00~18:00','https://blog.naver.com/cheongokcave','있음(187대)','강원도 동해시 동굴로 50',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','묵호등대','묵호등대는 강원도 동해시의 주요 항구인 묵호항 근처에 자리한 등대이자 논골담길의 종착지다. 등대의 나선형 계단을 오르면 탁 트인 동해가 펼쳐져 풍광이 시원스럽다. 등대가 있는 언덕 아래에는 동해를 마주 보는 카페와 민박집이 여럿 있다.
동해시의 관광명소인 논골담길에는 묵호항의 역사와 바닷가 주민의 삶이 깃든 담화가 벽에 새겨져 있다. 2010년, 지역 어르신과 예술가가 소통하고 합심해 그림을 그렸기에 ‘벽화’가 아니라 ‘담화’라는 표현을 쓴다. 논골마을에 형성된 논골담길은 논골1길, 논골2길, 논골3길, 등대오름길, 총 네 구역으로 나뉘고, 어느 곳으로 올라가도 묵호등대에서 만난다. 굽이진 언덕길 따라 “신랑 없이 살아도 장화 없인 못 살고”라는 글귀, 큰 보따리를 머리에 인 할머니, 오징어와 명태를 나르는 지게꾼 등 마을 사람들의 소박한 삶이 담긴 그림을 볼 수 있다. 논골1길 끝자락의 ‘바람의 언덕’은 논골담길에서 가장 아름다운 풍광을 자랑한다. 동해를 배경으로 사진을 남길 수 있는 포토존이 있고, 묵호항 일대와 알록달록한 지붕을 인 마을 풍광이 한눈에 담긴다.',NULL,'하절기(4월~10월) 06:00~20:00 / 동절기(11월~3월) 07:00~18:00','https://www.dh.go.kr/tour/','주차가능','강원도 동해시 해맞이길 300',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','묵호항','강원도 동해시 묵호항은 1937년에 개항하였으며 동해안 제1의 무역항으로 시작하여 현재는 동해안의 어업기지로 바뀌었다. 아침 일찍 어선이 입항하는 시기를 잘 맞춰 묵호항에 가면 어시장에서 금방 잡은 싱싱한 횟감을 구할 수 있으며 잡아온 생선을 경매하는 장면을 구경하는 것도 이색적이다. 또한, 건어물 등 쇼핑이 가능한 상점들이 있다. 묵호항 동문산에는 1963년 6월에 건립된 유인등대인 묵호등대가 있다. 높이 12m의 내부 구조가 2층으로 된 원형의 철근콘크리트로 지어졌으며 새하얀 등대가 푸른 바다와 어울려 맑고 깨끗한 이미지를 연출한다. 등대주변으로는 바다를 한눈에 조망할 수 있도록 작은 공원이 조성되어 있고, 소공원 입구에 들어서자마자 ‘해에게서 소년에게’의 글이 새겨진 조각이 넓게 펼쳐져 있다.',NULL,null,'https://www.dh.go.kr/tour/','주차가능','강원도 동해시 일출로 22',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','국립 청태산자연휴양림','해발 1,200m의 청태산을 주봉으로 하여 인공림과 천연림이 잘 조화된 울창한 산림을 바탕으로 한 국유림 경영 시범단지로서 숲속에는 온갖 야생 동식물이 고루 서식하고 있어 자연박물관을 찾은 기분을 느낄 수 있다. 영동고속도로 신갈기점 강릉방향 128km 지점에 위치하고 있어 여름철 동해안 피서객들이 잠시 쉬었다 가기에 편리하고, 청소년의 심신수련을 위한 숲속교실도 설치되어 있으며 울창한 잣나무 숲속의 산림욕장은 한번왔다간 사람은 누구나 매료되어 찾는 곳이기도 하다.',NULL,'[일일개장] 09:00~18:00','https://www.foresttrip.go.kr/','주차가능','강원도 횡성군 둔내면 청태산로 610',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','국립횡성숲체원','청태산 해발 680m에 위치하고 있는 국립횡성숲체원은 한국산림복지진흥원에서 운영하는 국가 제1호 산림교육센터다. 늘솔길(탐방로)의 하늘로 뻗은 잣나무 숲길을 따라 올라가다보면, 청태산 치유의숲내 산림치유센터에서 스트레스 타파 산림치유 프로그램을 즐길수 있다. 유아와 청소년의 생태감수성 발달과 신체 건강을 위한 산림교육 프로그램도 다양하게 제공한다. 또한 낙엽송과 졸참나무 사이로 떨어진 도토리와 다람쥐를 볼수 있으며, 층층나무, 자작나무를 찾아 걷다보면 계곡에 발을 담글수도 있다. 아이들과 함께 온 가족들은 숲오감체험장에서 즐거운 시간을 가질 수 있으며, 무장애 데크로드는 교통약자를 배려하여 남녀노소 누구나 숲을 만끽할 수 있다.',NULL,'09:00~17:00','http://hoengseong.fowi.or.kr','주차가능(소형 70대 / 대형 8대)','강원도 횡성군 둔내면 청태산로 777',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','허브나라농원','1996년에 문을 연 한국 최초의 허브 테마 농원이다. 농원을 일군 부부는 둘의 나이를 합쳐 100세가 되던 해에 평창의 깊은 계곡에 내려와 돌밭을 고르고 허브를 심었다. 990㎡으로 시작했던 농원은 현재 33,000㎡에 이르고, 오늘날 평창의 관광명소이자 한국 허브산업의 발상지로 자리매김했다. 허브나라농원은 허브와 꽃을 재배하는 농지와 허브를 보며 휴식할 수 있는 관광농원을 아우른다. 라벤더, 세이지, 메밀 등 150여 종 허브를 테마별로 나눈 10여 개의 테마정원은 허브에 대한 각각의 이야기를 바탕으로 한다. 색색의 허브와 꽃이 피는 팔레트 가든, 셰익스피어 작품에 언급된 허브로 꾸민 셰익스피어 가든, 꿀이 많아 벌과 나비가 좋아하는 밀원식물을 심은 나비가든 등 저마다 특색이 뚜렷하다. 레스토랑과 카페에서 허브가 들어간 음식을 맛볼 수 있고, 허브체험교실에서 천연비누·향초 등을 만들 수 있다. 한국 유명 가수들이 음악회를 여는 별빛무대, 터키 민속공예품을 전시한 터키 갤러리 같은 문화공간도 눈길을 끈다.',NULL,'09:00~17:30','http://www.herbnara.com','있음(206대)','강원도 평창군 봉평면 흥정계곡길 225',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','이효석 문학관','남안교를 건너 물레방앗간 뒷산 중턱에 자리잡고 있으며, 생가터 가는 길목이기도 하다. 오랜 기다림 끝에 2002년 9월 7일 제4회 효석문화제 기간 중 문을 연 이효석 문학관에는 선생님의 작품 일대기와 육필원고 유품 등을 한눈에 볼수 있다. 전시되는 육필원고와 유품 등은 가산문학 선양회를 중심으로 이루어졌으며 지난 5월 25일 해마다있는 선생님 추모식에는 미국에 있는 장남(이우현)가족과 차녀가 참석하여 소장하고 있던 선생님의 육필원고와 훈장증을 기증하기도 했다.',NULL,'09:00 ~ 18:30','http://www.hyoseok.net/','주차 가능','강원도 평창군 봉평면 효석문학길 73-25',sysdate, 0, 0);

--제주도
insert into item values(item_seq.nextval, 1, '관광지','제주 세계자연유산센터','제주 세계자연유산센터는 대한민국에서 유일한 유네스코 세계자연유산으로서의 가치를 널리 알리기 위해 조성되었다. 4D영상관에서 제주의 환상적인 자연을 온몸으로 느끼고, 리프트를 타고 제주도 탄생과정 체험, 직접 가 볼 수 없는 용암 동굴 체험 등 교과서에 실린 세계자연유산 제주를 직접 체험해 볼 수 있다. 제주 세계자연유산센터는 2007년 유네스코 세계자연유산 등재, 2009 환경부 선정 생태관광 20선, 2010 한국형 생태관광 10모델에 선정된 대표적인 생태관광지 유네스코 세계자연유산 거문오름에 위치해 있다.',NULL,'	09:00~18:00','http://wnhcenter.jeju.go.kr','주차 가능(약 소형 100대, 대형 25대)','제주특별자치도 제주시 조천읍 선교로 569-36',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','휘닉스 제주 섭지코지','천혜의 자연과 비일상의 즐거움이 공존하는 휘닉스 제주 섭지코지는 숙박, 휴양, 레져, 문화가 공존하는 친환경 해양 종합리조트로, 리조트 면적만 66만㎡로 바다를 향해 호리병 모양으로 뻗어 있는 섭지코지 전체를 아우르는 규모로 세계자연문화유산 성산일출봉과 마주하고 있다.
세계적인 건축거장 안도다다오가 직접 설계한 글라스하우스, 지니어스로사이 및 마리오보타의 아고라 등 현대 건축 작품들을 만날 수 있다. 콘도미니엄은 34평형 실, 54평형 실 등 총 300여 실로 구성되어 있으며 실내·외 수영장과 해양레포츠센터, 테라피센터, 로비라운지(섭지), 한식당(일출봉), 노래방(콩콩)과 가요주점(문라이트) 등의 부대시설을 비롯한 편의점(CU)와 PC방, 테디베어, 허브, 기념품샵 등의 편의시설을 갖추고 있다. 휘닉스 제주의 유원지인 ‘섭지코지’ 의 해안 절경을 만끽할 수 있음은 물론, 전동카트, 자전거, 해마열차, 꽃마차 등 레포츠 시설도 마련되어 있다.',NULL,'	09:00~18:00','http://phoenixhnr.co.kr','주차 가능','제주특별자치도 서귀포시 성산읍 섭지코지로 107',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','따라비 오름','3개의 굼부리가 있는 것이 가장 큰 특징이다. 크고 작은 여러 개의 봉우리가 매끄러운 등성이로 연결되어 한 산체를 이룬다. 말굽형으로 열린 방향의 기슭쪽에는 구좌읍 `둔지오름`에서와 같은 이류구들이 있다. 이류구가 있는 것으로 보아 비교적 최근에 분출된 신선한 화산에 속하는 것으로 판단된다고 한다. 화산체가 형성된 후에 용암류가 분출, 화구륜의 일부가 파괴되어 말굽형을 이루게 용암의 흐름과 함께 이동된 이류(泥流)가 퇴적한 것 호칭이 여러개가 있고 그 어원에 대한 해석이 구구함. 주위의 묘비에는 대개 地祖岳(지조악) 또는 地翁岳(지옹악)으로 표기돼 있고, 多羅肥(다라비)라는 것도 보이며, 한글로는 따라비라 적힌 것도 있다고 한다. 옛 지도에는 지조악이라는 것은 찾아볼 수 없다고 하며 多羅非(다라비)로 나온다고 한다.',NULL,null,'https://www.visitjeju.net/',null,'제주특별자치도 서귀포시 표선면 가시리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','조랑말체험공원','제주의 말 문화를 쉽고 재밌게 이해하고 체험할 수 있는 조랑말체험공원은 조선시대 최고의 말을 사육했던 갑마장이 있었던 가시리 마을 그 자리에 600년 목축문화의 역사를 고스란히 간직하고 있다. 농림부가 지원하는 ‘신문화공간 조성사업’의 일환으로 조성된 조랑말 박물관에 마을회의 노력으로 따라비승마장, 마음(馬音)카페, 게르 게스트하우스, 캠핑장, 아트숍, 체험장 등이 어우러진 복합 문화공간으로 확대 조성되었다. 마을에서 설립한 국내 최초의 전문 박물관이자, 마을의 역사와 문화를 주제로 한 문화공간으로 새로운 형식의 커뮤니티 비즈니스 모델로서도 큰 의미가 있다.',NULL,'10:00~18:00','http://www.jejuhorsepark.co.kr','주차 가능','제주특별자치도 서귀포시 표선면 녹산로 381-15',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','해녀박물관','해녀박물관은 1932년 제주해녀들이 인간의 존엄성과 생존권을 무참히 수탈하는 일제에 맞서 여성이 주체가 되어 투쟁했던 제주해녀항일운동의 발상지에 자리 잡고 있다. 제주해녀는 세계적인 존재로 어려운 작업 환경을 딛고 끈질긴 생명력과 강인한 개척정신으로 인해 제주여성의 상징으로 자리매김해 왔다. 불과 20여 년 전만 하더라도 우리 삶의 현장에서 가정 경제의 핵심적 역할을 했으나 30~40대 해녀가 15%도 되지 않는 현상황에서 해녀문화의 보존을 위한 전문 해녀박물관의 갖는 위상은 매우 뜻깊은 일이라고 할 수 있다.

역사 속에서 형성된 해녀들만의 독립적이고 주체적인 문화는 향토문화유산으로서 뿐만 아니라, 전 세계적으로 주목받는 중요한 관광문화자원으로 발전해 나갈 것이다. 해녀박물관은 제주만의 독특한 해녀, 어촌, 해양문화의 계승, 발전을 위하여 제주해녀항일운동기념공원 조성사업과 연계해서, 2003년 12월 23일 공사를 착공, 85,951m²(2만 6천평)의 부지에 총 124억 원을 투자하여 지상 4층에 전체면적 4,002m²의 규모로 지어졌다. 주요시설로는 4개의 전시실과 영상실, 전망대, 휴게실, 야외전시장 등으로 구성되어 있으며 2006년 6월 9일에 개관하였다.',NULL,'09:00~17:00','http://www.haenyeo.go.kr','주차 가능','제주특별자치도 제주시 구좌읍 해녀박물관길 26',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','제주돌문화공원','돌문화 공원은 돌의 고장 제주에 있는 돌문화를 종합적이고 체계적으로 보여주는 박물관이자 생태공원이다.2020년까지 전체공원이 조성되며, 제1단계로 제주돌박물관, 제주돌문화전시관, 제주의 전통초가 등의 전시관이 완공되어 공사가 시작된지 7년 만인 2006년 6월 3일 문을 열었다. 제주의 돌문화를 한곳에서 볼 수 있는 돌문화공원은 규모가 워낙 커서 여유로운 일정으로 둘러보는 것이 좋다. 돌문화 공원은 제주만의 독특한 자연유산인 오름 앞에 자리잡고 있으며, 돌을 쌓아 만들어 놓은 성곽의 형태를 따라 나지막한 오르막길을 올라가면 주변 전망이 시원한 돌문화공원 입구에 다다르게 된다.

입구를 지나 관람로를 따라가다보면 설문대할망과 그 아들인 오백장군 설화로 엮은 각종 돌조형물들을 만나게 되고,거석 사이를 통과하여 숲속오솔길을 따라가다 보면 박물관과 제주의 전통초가들을 볼 수 있는데, 특이하게도 박물관은 지상이 아닌 지하에 자리잡고 있다. 자연 환경과 주변 경관을 해치지 않기 위해서 그렇게 지어졌다고 한다. 야외 전시장에는 48기의 돌하르방, 사악한 기운과 액운을 몰아낸다는 방사탑, 도둑이 없어 대문도 없다는 제주의 상징인 정주석, 무덤 주위에 세워 망자의 한을 달래준다는 제주만의 내세관을 보여주는 동자석 등 제주의 역사와 전통 자연미를 함께 느낄수 있는 자연과 문화의 쉼터이다.',NULL,'09:00~18:00','http://www.jeju.go.kr/jejustonepark/index.htm','주차 가능','제주특별자치도 제주시 조천읍 남조로 2023',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','만장굴 (제주도 국가지질공원)','제주시 구좌읍 김녕리에 위치하는 만장굴은 전체길이 약 7,400 m, 최대 높이 약 25 m, 최대 폭 약 18 m로서 제주 세계자연유산의 한 부분인 거문오름용암동굴계(황상구 외, 2005)에 속하는 용암동굴이다. 특히 주 통로는 폭이 18m, 높이가 23m에 이르는 세계적으로도 큰 규모의 동굴이다. 전 세계에는 많은 용암동굴이 분포하지만 만장굴과 같이 수십만 년 전에 형성된 동굴로서내부의 형태와 지형이 잘 보존되어 있는 용암동굴은 드물어서 학술적, 보전적 가치가 매우 크다. 만장굴은 동굴 중간 부분의 천장이 함몰되어 3개의 입구가 형성되어 있는데, 현재 일반인이 출입할 수 있는 입구는 제2입구이며, 1㎞만 탐방이 가능하다. 만장굴 내에는 용암종류, 용암석순, 용암유석, 용암유선, 용암선반, 용암표석 등의 다양한 용암동굴생성물이 발달하며, 특히 개방구간 끝에서 볼 수 있는 약 7.6m 높이의 용암석주는 세계에서 가장 큰 규모로 알려져 있다.',NULL,'09:00~18:00','http://www.jeju.go.kr/jejustonepark/index.htm','주차 가능','제주특별자치도 제주시 구좌읍 만장굴길 182',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','제주도민속자연사박물관','제주특별자치도민속자연사박물관은 제주도 고유의 고고·민속 자료와 동물, 광·식물, 해양생물 자료들을 수집하고 조사 연구를 통해 전시하고 있는 곳이다.
지난 1984년 5월 24일 개관한 이래 실물자료와 모형·마네킹 등을 활용해 입체적으로 전시함으로써 이국적인 느낌을 주는 제주문화를 보다 쉽게 이해할 수 있도록 하고 있다. 로비에 대형어류 및 해양생물 디오라마 전시를 비롯하여 제주도 형성사, 여러가지 암석, 한라산의 식물 수직분포도, 곤충, 포유류 등 제주의 형성과정과 여러 자연생태까지도 한눈에 볼 수 있다. 그리고 제주인의 일생, 생업, 의식주 등을 통해 과거 제주인의 생활을 접할 수도 있다.',NULL,'09:00~17:00','http://museum.jeju.go.kr','주차 가능','제주특별자치도 제주시 삼성로 40',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','사라봉공원','사라봉 공원은 제주시 동문로터리에서 동쪽으로 2km 거리에 있는 143m 높이의 낮은 동산이다. 이곳에서 볼 수 있는 사봉 낙조는 영주 12경의 하나로 성산일출과 대조가 될만하다. 쪽으로는 바다를 끼고 남쪽으로는 한라산을 바라보고 있는 이곳은 제주시민은 물론 관광객도 즐겨 찾는다. 라봉입구 버스 정류장에서 공원으로 가는 길에 모충사가 있고 사라봉 동쪽에는 패러글라이딩 활공장이 있는 별도봉이 들어앉았다. 기슭에 우당도서관이 있는데 이곳에서 부터 사라봉 뒤편을 돌아 제주항을 거친 다음 탑동까지 가는 코스는 이름난 드라이브 코스이다.',NULL,'09:00~17:00','http://www.visitjeju.net','있음(25대)','제주특별자치도 제주시 사라봉동길 74',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','관덕정(제주)','제주도내에서 가장 오래된 건축물 중의 하나인 관덕정은 보물로서 조선 시대 세종 30년(1448)에 목사 신숙청이 사졸들을 훈련시키고 상무 정신을 함양할 목적으로 이 건물을 세웠다. 관덕정이란 이름은 [사이관덕]이란 문구에서 나온 것으로 활을 쏘는 것은 평화시에는 심신을 연마하고 유사시에는 나라를 지키는 까닭에 이를 보는 것은 덕행으로 태어난 곳이다. 대들보에는 십장생도, 적벽대첩도, 대수렵도 등의 격조높은 벽화가 그려져 있고, 편액은 안평대군의 친필로 전해오고 있다.',NULL,'09:00~18:00','http://www.visitjeju.net/','장애인 주차장 있음(2대,관덕정 서측 공영주차장)','제주특별자치도 제주시 관덕로 19',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','용두암','제주시내 북쪽 바닷가에 있는 용두암은 높이 10m가량의 바위로 오랜 세월에 걸쳐 파도와 바람에 씻겨 빚어진 모양이 용의 머리와 닮았다 하여 용두암이라 불린다. 전설에 의하면 용 한 마리가 한라산 신령의 옥구슬을 훔쳐 달아나자 화가 난 한라산 신령이 활을 쏘아 용을 바닷가에 떨어뜨려 몸은 바닷물에 잠기게 하고 머리는 하늘로 향하게 하여 그대로 굳게 했다고 전해진다. 또 다른 전설은 용이 되어 하늘로 올라가는 것이 소원이던 한 마리의 백마가 장수의 손에 잡힌 후, 그 자리에서 바위로 굳어졌다는 전설이 있다.이곳 주변에서는 해녀가 작업하는 모습을 볼 수 있을 뿐만 아니라, 이곳에서 해안 도로를 따라 10여 분 정도 걸어가면 카페 및 주점, 식당 등이 있다.
애월읍에서 용두암에 이르는 북제주의 해안도로는 제주 사람들이 가장 많이 찾는 데이트코스이다. 용두암 앞에는 4~5년 전부터 하나둘씩 횟집과 카페가 들어서기 시작해 이젠 자그마한 카페촌이 형성됐다.제주의 명물로 떠오른 카페촌에서 차를 한잔하고 바닷길을 따라가다 보면 이호 해수욕장과 하귀해변, 애월읍으로 이어진다. 이호해수욕장을 넘어서면 검은 현무암과 푸른 물결이 대조를 이루는 바다를 만날 수 있다. 영락없이 캘리포니아의 해안도로를 달리는 듯한 기분. 애월항에는 자그마한 횟집과 어선들이 드라이브의 맛을 더해준다. 더 가면 제주의 3대 해수욕장으로 꼽히는 협재해수욕장. 협재의 옥빛 바다는 환상적이다.',NULL,'00:00~24:00','http://www.visitjeju.net/','주차가능','제주특별자치도 제주시 용두암길',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','어영소공원','제주도 용두암에서 약 1km정도 떨어진 곳에 용담 해안도로를 따라 길게 만들어진 공원이다. 야간에 각종 조명시설로 야간공원으로 유명하다. 특히, 해 진 저녁, 맞은 편에 있는 카페, 레스토랑, 식당에서 어영소공원의 야경을 감상하기 좋아 많은 관광객이 찾고있다. 또한, 제주 올레 17코스 도중에 자리한 공원으로 올레꾼들의 발걸음 또한 끊이지 않고 있다. 일몰 이후 뿐만 아니라 낮에도 탁트인 전경과 바로 눈 앞에 펼쳐진 바다, 시원한 바닷바람으로 사람들을 붙잡는다.어영소공원에서는 시원한 풍경과 함께 운치있는 시도 즐길 수 있다.
공원에 설치된 벤치와 바다 쪽의 방호벽에 유명인들의 시가 이어져 있으며 시와 함께 잔잔한 여운을 남기는 벽화들도 그려져 있다. 또한, 방호벽 위로 60cm 크기의 어패류 조형물이 세워져 있어, 이것 또한 볼거리이다.어영소공원에서는 특이 ''로렐라이 요정상''이 눈에 띈다. 독일의 로렐라이시와 제주시가 우정의 상징으로 각각 ''로렐라이 요정상''과 ''돌하르방''을 교환하여 이곳에 세워졌다고 한다.로렐라이는 요정의 바위라는 뜻으로 19세기 시인 클레엔스 브렌타노의 설화에서 등장하기 시작하였다. 라인강을 항해하는 뱃사람들을 아름다운 노래소이로 유혹하여 배를 좌초시키는 주인공이다. 현재 어영소공원에 세워져 있는 로렐라이 요정상은 우호 협력 도시인 로렐라이시와 제주시의 21세기 공동번영을 의미하기도 한다.',NULL,'00:00~24:00','http://www.visitjeju.net/','주차가능','제주특별자치도 제주시 용담3동',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','제주테지움','테지움 사파리는 세계 최초로 야생동물과 수중동물 꽃과 새들을 모두 봉제인형으로 제작하여 전시되는 새로운 개념의 박물관이다. A동 1층의 야생동물존에는 호랑이, 코끼리, 사자 표범 등의 동물인형과 다양한 포즈의 테디베어와 함께 사진을 찍을 수 있도록 전시되어 있고 2층에는 돌고래, 상어를 비롯하여 문어, 거북이 등 수중 동물인형과 홍학, 학, 오리떼 등 다양한 인형들이 있다. B동 2층으로 넘어오게 되면 4m의 엎드린 테디베어에서 어린이들이 자유롭게 뛰어놀 수 있는 놀이터와 드라마 ''뉴하트''에 등장했던 모든 테디베어와 테지움아트갤러리에는 영화패러디, 그리스신화 테디베어, 세계의상 테디베어들이 전시되어 있다.B동 1층의 선물코너에서는 다양한 형태의 테디베어 소품들과 사랑스러운 여러가지의 테디베어를 구매할 수 있다. 특히 A동의 1층과 2층에 걸쳐 조성되어 있는 소원 들어주는 나무는 관람객들이 써넣은 소원들을 선별하여 매원 소원을 들어주는 행사로 계획하고 있다.',NULL,'00:00~24:00','http://www.teseum.net','주차가능','제주특별자치도 제주시 애월읍 평화로 2159',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','테디베어뮤지엄','흔하게 서양 어린이들이 하나씩은 갖고 있는 ''곰돌이'' 인형은 단순한 완구가 아닌 가족과 같은 느낌이 든다. 한국의 대표적 관광지 제주도 중문관광단지내에 위치한 곰인형박물관, 일명 테디베어뮤지엄(Teddybear Museum)은 지난 2001년 4월 개장, 가족단위나 연인이 함께 즐길 수 있는 테마파크로 자리 잡았다. 영국, 일본, 미국 등지에서는 이미 널리 알려진 테디베어 박물관이지만 우리로서는 다소 생소한 이색박물관으로, 곰인형에 관해서는 세계 최대규모(총면적 13,553㎡, 연건평 4,297㎡)를 과시하며 제주를 찾은 관광객들에게 색다른 여행의 묘미를 안겨준다.''테디베어''는 우리가 흔히 곰돌이 인형이라고 즐겨 부르는 곰의 모양의 봉제완구를 통칭하는 말로, 미국의 제 26대 대통령인 테어도어 루즈벨트 시절 곰사냥에서 한 마리도 잡지못한 대통령을 위해 한 보좌관이 생포해 온 새끼곰을 풀어주었다는 이야기가 당시 언론에 크게 실리면서, 한 실업가가 이를 본딴 인형을 상업적으로 만들어 팔면서 널리 알려지게 되었다.',NULL,'09:00~18:00 (17:30 입장마감)','http://www.teddybearmuseum.com','주차가능','제주특별자치도 서귀포시 중문관광로110번길 31',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','중문관광단지','중문관광단지는 제주의 독특한 자연경관과 지리적 조건을 활용하여 한국관광공사가 1978년부터 제주특별자치도 서귀포시 중문, 대포, 색달동 일원(356만㎡)에 조성한 국제적인 관광 휴양지이다.

중문관광단지에는 국내 최고의 관광 휴양지답게 신라호텔, 롯데호텔, 그랜드조선호텔, 스위트호텔, 부영호텔, 씨에스호텔, 블룸호텔, 하얏트호텔(리모델링 중), 한국콘도(리모델링 중) 등 9개의 최고급 호텔이 있으며, 퍼시픽리솜, 여미지식물원, 테디베어박물관, 그림포레스트, 박물관은살아있다, 초콜릿랜드, 제주국제평화센터, 천제연폭포, 주상절리대, 중문골프클럽 등의 관광지가 있다.
특히 서핑, 요트, 패러세일링 등 해양 레포츠를 즐길 수 있는 중문색달해수욕장과 바다 전망 카페, 산책로 등이 최근 각광을 받고 있다.',NULL,'09:00~18:00 (17:30 입장마감)','https://korean.visitkorea.or.kr','주차가능','제주특별자치도 서귀포시 중문관광로 38',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','중문·색달 해변','길이 560m, 폭 50m, 경사도 5도, 평균 수심 1.2m 정도의 백사장을 품은 중문·색달 해수욕장은 활처럼 굽은 긴 백사장과 흑, 백, 적, 회색 등의 네 가지색을 띤 "진모살"이라는 모래가 특이하다. 이 진모살과 제주도 특유의 검은 현무암이 조화를 이룬 풍광이 아름다워서 영화나 드라마의 촬영지로도 자주 이용되고 있다. 이 해수욕장 오른쪽에 병풍처럼 둘러쳐진 해안절벽에는 길이 15m 가량의 천연동굴도 하나 있다. 또한 이 해안절벽을 따라 많은 희귀식물이 자생하고 있어 생태관광을 즐길 수도 있다. 그리고 중문·색달 해수욕장은 패러세일링, 수상스키, 윈드서핑, 스쿠버다이빙, 래프팅, 요트 투어 등 해양레포츠가 활성화되어 있어 보다 역동적인 휴가를 즐기기에 제격이다.',NULL,'09:00~18:00 (17:30 입장마감)','http://www.visitjeju.net/','있음(150대)','제주특별자치도 서귀포시 중문관광로72번길',sysdate, 0, 0);


--경상북도
insert into item values(item_seq.nextval, 1, '관광지','의성 제오리 공룡발자국화석 산지','* 중생대 백악기의 공룡발자국 화석, 의성 제오리의 공룡발자국화석지 *
지금으로부터 약 1억1500만 년 전인 중생대 백악기의 공룡발자국 화석이다. 1993년 6월 1일 천연기념물로 지정되었다. 공룡은 중생대의 주라기부터 백악기에 걸쳐 번성했던 길이 5∼25m의 거대한 파충류를 통틀어 말한다. 의성 제오리의 공룡발자국화석은 군도의 확장공사를 하느라 산허리부분의 흙을 깎아내면서 발견되었다.

이곳에서 발견된 공룡발자국화석은 4종류에 모두 316개, 발굽울트라룡, 발톱고성룡, 발목코끼리룡 등 3종류의 초식공룡발자국과 육식공룡인 한국큰룡 발자국이 발견되었다. 이곳에서는 대·중·소형의 초식공룡과 육식공룡의 발자국이 동시에 발견되어 공룡의 서식지였음을 짐작케 한다. 또한 발의 크기, 보폭, 걷는 방향 등이 아주 뚜렷하게 나타나있어 당시 공룡의 모습과 생활 등을 연구하는데 귀중한 자료로 학술적 가치가 높다.',NULL,null,'http://tour.usc.go.kr',null,'경상북도 의성군 금성면 공룡로 179-18',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','경덕왕릉','* 삼한시대 부족국가 조문국의 왕릉, 경덕왕릉 *

의성읍에서 남쪽으로 4㎞ 못 미쳐 금성면 대리리에 위치하고 있는 고분군 중에 조문국 경덕왕릉이라고 추정되는 무덤이 있다. 조문국은 삼한시대의 부족국가였던 나라로 현재의 경상북도 의성군 금성면 일대를 도읍지로 하여 존속하다가 185년(신라 벌휴왕 2년)에 신라에 병합되었다고 전한다.
하지만 조문국이 실재했었다는 기록은 삼국사기에 짧게 언급되어 있을 뿐 문헌자료는 거의 남아 있지 않다.

옛 조문국 경덕왕릉은 그 형식이 전통적인 고분으로서 봉 아래 화강석 비석과 상석이 있다. 능의 둘레가 74m, 높이가 8m이며 능의 정면에는 가로 42㎝, 세로 22㎝, 높이 1.6m의 비석이 서있다. 1725년(영조 원년) 현령 이우신이 경덕왕릉을 증축하고 하마비 등을 세웠다고 하는데 그때부터 왕릉제사를 지내오다가 일제강점기에 중단되었고, 그후 경덕왕릉보존회가 구성되어 다시 제사를 지내고 있다. 소나무로 둘러싸인 묘역은 ‘조문국경덕왕릉’이라고 쓰여진 비석과 문인석·장명등·상석으로 단장되어 있다.',NULL,null,'http://www.cha.go.kr/cha/idx/Index.do?mn=NS_01','주차가능','경상북도 의성군 금성면 대리리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','의성 탑리리 오층석탑','통일신라시대 석탑으로 높이는 9.56m이고 기단 폭은 4.51m인 국보로 지정된 석탑이다. 부분적으로 전탑(塼塔) 수법을 모방하였고 한편으로는 목조건물 양식을 보인다. 화강석으로 낮은 1단의 기단 위에 5층의 탑신부를 구성한 이 석탑은 특히, 제1층 탑신에 목조 건물의 수법을 따라 배흘림이 있는 네모기둥을 세우고 남면에 감실을 두었으며 기둥 위에는 주두의 형태를 본떠 조각하였다. 각층 옥개석은 전탑의 구조를 본떠서 아래 윗면을 모두 층급형으로 단을 지어 조성하였으며, 맨 윗부분에 장식되었던 상륜부는 노반만 남아있다. 장중한 아름다움과 함께 전탑의 양식을 따르면서 일부 목조 건물의 수법을 보여주고 있다. 이 탑은 경주 분황사 석탑에 다음가는 오래된 석탑으로 한국 석탑 양식의 발전을 연구하는데 매우 귀중한 자료이다.

[문화재 정보]
지정종목 : 국보
지정번호 : 국보
지정연도 : 1962년 12월 20일
시대 : 통일신라
종류 : 화강석제 5층 석탑
크기 : 높이 9.6m, 기단 폭 4.5m',NULL,'09:00~18:00 (17:30 입장마감)','http://tour.usc.go.kr',null,'경상북도 의성군 금성면 오층석탑길 5-3',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','산운생태공원','구 산운초등학교(폐교)를 활용하여 자라나는 세대의 자연학습 및 환경에 대한 가치관 형성을 위한 공간으로 마련하였다. 이곳은 자연생태관찰과 전통문화를 체험하는 산교육장으로 의성의 명산인 금성산과 신라시대 의상조사가 창건한 수정사로 가는 길목에 위치하고 있다. 보유수종은 관목류 및 초화류 53종이며, 주요시설로는 생태관 1동, 연못 2개소, 분수, 목교, 관찰데크, 솟대, 쉼터, 산책로 등이 있다. 넓은 마당에는 50여 종에 이르는 나무와 풀·꽃들이 자라며, 연못·분수·나무다리·관찰데크·솟대·장승·쉼터·산책로 등을 조성하였다.',NULL,'09:00~18:00','http://sanun.usc.go.kr','장애인 전용 주차구역 있음(2대)_무장애 편의시설','경상북도 의성군 금성면 수정사길 19',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','빙계계곡','* 신비함과 아름다움을 갖추고 있는 곳, 빙계계곡(氷溪溪谷) *

빙계계곡은 경북 8승의 하나로 1987년 9월 25일 군립공원으로 지정되었다. 얼음구멍과 바람구멍이 있어 빙산이라 하며, 그 산을 감돌아 흐르는 내를 빙계라 하고, 동네를 빙계리라 부른다. 빙계계곡은 빙계(氷溪) 3리 서원(書院) 마을에 위치하고 있다. 삼복 때 시원한 바람이 나오며 얼음이 얼고, 엄동설한엔 더운 김이 무럭무럭 솟아나는 신비의 계곡이다. 계곡 안쪽에 자리한 보물 오층 석탑은 높이 8.15m의 대형 탑이며, 화강석으로 조성된 고려 초의 석탑이 있다. 마을 건너편에 수십 미터 높이의 깎아지른 듯한 절벽이 병풍처럼 둘러져 있고, 그 아래 맑은 시냇물 가운데 우뚝 솟은 크고 작은 무수한 바위는 1933년 10월 4일 경북도내 경북 8승의 하나로 뽑혔을 정도로 아름다운 장관을 보여준다. 계곡 가운데 돋보이는 높이 10m, 둘레가 20m 정도의 유난히도 큰 바위에 빙계동(氷溪洞) 이란 커다란 글씨가 새겨진 건 임진왜난 때 여기 들른 명장 이여송(李如松)의 필적이란 얘기도 있다. 그 옆에 단 하나의 큰 바위 위에는 경북 팔승지일이라고 새긴 아담한 돌비(石碑)가 자리잡고 있다.',NULL,null,'http://tour.usc.go.kr',null,'경상북도 의성군 춘산면',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','대게원조 차유어촌체험마을','어촌부락으로 죽도산이 보이는 이 곳 앞바다에서 잡은 게의 다리 모양이 대나무와 비슷하다고 하여 대게로 불리워왔다. 마을 내력을 따라 영덕대게원조마을로 명명되었으며 기념표식을 세웠다.『경정리 동명의 유래는 긴 모래불이 있으므로 뱃불 또는 경정이라 하였다. 경정 2리인 수구너미 마을은 11세기 중기(1060년경)에 영해 부사(寧海府使)가 마을을 순시하던 중 말을 타고 재를 넘으면서 이 마을의 형국을 보고 우마차(牛馬車) 길마 같이 생겼다고 하여 우차의 차(車)와 넘을 유(踰)자를 따서 차유(車踰)라 명명하였다 하며, 마을의 형성은 어느 때 누구에 의해서 되었는지 미상이다.

조선시대에는 영해부(寧海府) 남면(南面) 지역이었는데 갑오개혁(甲午改革) 뒤인 1895년(高宗 32년) 5월 26일 칙령(勅令) 제98호로 지방 관제 개정을 할 때 영해부가 영해군(寧海郡)이 되었는데, 이때 경정리는 영해군에 속했으며, 1914년 3월 1일 일제(日帝)는 부령(府令) 제111로 행정구역을 자의로 폐합할 때 오매동·차유동의 일부 지역을 병합하여 경정동이라 하고 영덕군 축산면에 편입되었으며, 그 뒤 1988년 5월 1일 군조례(郡條例) 제972호로 동(洞)을 리(里)로 개칭할 때 경정동은 경정리가 되어 오늘에 이르며, 현재 행정구역상 경정 1,2,3리로 분동되어 있다.』',NULL,null,'https://tour.yd.go.kr/','주차 가능','경상북도 영덕군 축산면',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','고래불해수욕장','영덕에서 북방으로 24km를 중심으로 영해면 대진해수욕장과 이웃한 해수욕장이다. 울창한 송림에 에워싸여 있으며, 금빛 모래는 굵고 몸에 붙지 않아 예로부터 여기에서 찜질을 하면 심장 및 순환기 계통 질환에 효험이 있다는 이야기가 전해져 내려온다. 해변 길이가 8km에 이르는 긴 백사장 덕분에 대진해수욕장과 함께 동해의 명사 20리로 불리며 길고 긴 백사장, 얕은 수심, 깨끗한 에메랄드빛 바닷물, 울창한 송림이 만들어주는 시원한 그늘로 가족 피서지로 적합하다. 또 해수욕장내에 샤워장, 화장실, 급수대, 매점, 주차장 등의 편의시설이 잘 갖추어져 있어 이용하는데 불편함이 없다.

주변에 위정약수터와 고려후기 명승 나옹선사가 창건한 장육사가 있으며, 영해면 괴시리에는 고건축물이 산재해 있고, 해안도로를 따라 200년된 고가옥이 30여 동이나 있는 전통마을이 있다. 맑고 깨끗한 청정바다로 해안도로의 해맞이공원과 인근방파제 어느 곳이던 낚시를 드리우면 우럭, 학공치, 고등어, 돔 등이 심심찮게 낚인다. 강구에서 고래불까지의 해안도로는 그 경치가 절경으로 해안 드라이브코스로서 제격이며, 영덕의 특산물인 대게와 맑고 깨끗한 청정해역에서 잡힌 신선한 생선회는 식도락가들의 입맛을 돋운다. 해안도로를 따라 즐기는 해안절경과 고래불 해수욕장에서 7번국도를 타고 북쪽으로 쭈욱 달리면 동해안의 유명한 관광지는 거의 다 돌아볼 수 있는 하나의 드라이브 코스가 된다.',NULL,null,'http://goraebul.or.kr','있음(1,500대)','경상북도 영덕군 병곡면 고래불로 394',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','인량전통테마마을','350년~400년 된 8성씨 12종가 한 농촌마을에 옹기종기 모여 살고 있는 전형적인 농촌한옥마을이다. ''어질인 仁'' ''어질량 良''자로 어진이들이 많이 배출되었다 하여 불리우고 있는 "인량리"는 다른 농촌마을에서는 잘 볼수 없는 자연과 한옥들이 잘 어우려진 마을이다. 또한 마을을 둘러싸고 있는 뒷산 형국이 한마리의 학이 날개를 펼쳐 감싸안고 있는 형상을 하고 있다 하여 비개동, 나래골, 익동으로 불리우다 현재는 나라골로 불리우고 있다. 인량리는 서고동저의 형태를 보이고 있고, 마을 앞으로 반변천이 흐르고 있어 동쪽으로 넓게 소규모의 평야를 형성하고 있다.특히 토질은 점토인 사질토의 양질이 대부분을 차지하고 있어 품질이 우수한 농작물이 생산된다. 또한, 풍수 지리적으로 인량리는 마을의 터가 명당으로 알려졌으며, 현재 여러 종가의 종택이 보전되어 내려오고 있다.',NULL,'09:00~18:00','https://inryang.modoo.at/?link=nqme3v5q','주차 가능','경상북도 영덕군 창수면 인량길 178',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','영덕해맞이공원','전국 제일의 청정해역과 울창한 해송림으로 둘러쌓여 있던 창포리 동해안 일대가 1997년 2월 대형 산불로 페허가 되어 방치되다 4년간의 노력으로 수려한 해안절경과 무인등대를 활용한 인공공원을 조성하였다. 산불피해목으로 침목계단을 만들어 산책로를 조성하였으며, 사진촬영과 시원한 조망을 위한 전망데크와 휴식공간을 위해 파고라를 만들었고, 어류조각품 18종을 실시간 방송되는 음악과 어우러지도록 조성하였으며, 야생화와 향토수종으로 자연학습장을 조성하였는데, 수선화·해국·벌개미취 등 야생화 15종 30만본을 식재하였고, 해당화·동백·모감주나무 등 향토수종 8종 7만 본을 식재하였다.


64km 청정해역이 펼쳐지는 강축도로변에 위치하고 있어 교통이 편리하며 전면의 푸른 바다와 뒷면 넓은 초 지, 해송조림지로 열린 공간이 형성되어 있다.
해맞이공원 전면에는 야생꽃 2만 3천여 포기와 향토수종 꽃나무 900여 그루가 심어져 아름다움을 더하고 1천 500여개의 나무계단이 파고라와 파고라를, 해안도로와 바다까지를 얼기 설기 엮어 멋진 산책로를 이루고 있다.
산책로를 따라 걷는 도중에는 전망테크가 두군데 설치돼 동해바다를 한눈에 관망하면서 사진을 촬영하기에 최적의 장소이며, 자연경관과 조화롭게 랜드마크적인 등대 - 창포말 조형등대가 1개소 있고, 특히 가장 선명 하고 멋진 일출 광경을 볼 수 있다는 매력 때문에 새해에는 물론 평일에도 일출의 장관을 보려는 사람들과 여유로운 휴식을 취하기 위해 찾아드는 사람들의 발길이 계속이어지고 있다.',NULL,'09:00~18:00','http://tour.yd.go.kr','있음(3개소)','경상북도 영덕군 영덕읍 영덕대게로 968',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','경주국립공원','경주국립공원은 설악산국립공원, 한려해상국립공원처럼 산이나 바다 등 자연경관이 아닌, 세계적으로도 놀라운 문화유산으로 이루어진 국립공원이다. 신라 천 년의 찬란한 문화를 꽃피운 경주는 우리 조상이 남긴 찬란한 민족문화의 발자취와 삼국통일의 웅장한 기상이 서려 있고 가는 곳마다 명승고적과 전설, 고유민속 등의 수많은 문화유산을 보존하고 있는 한국 관광의 대표적인 곳이다. 훌륭한 사적과 문화적, 역사적 유물이 놀라울 만큼 한 고장에 집중적으로 보존돼 있고 국보급 또는 세계적으로 가치있는 고고품이 쏟아져 나왔으며, 또 찬란했던 불교문화와 그 예술을 확인할 수 있는 경주는 한마디로 도시 전체가 벽없는 박물관이다. 특히, 경주시가 관광특구로 지정된 후 민관이 함께 관광기반시설과 환경개선에 힘을 기울이고 있어 과거 어느 때보다도 훌륭한 관광 지역으로 변모하고 있으며, 해마다 5백만명 이상이 경주를 찾고 있다.',NULL,'연중무휴','http://gyeongju.knps.or.kr','있음(석굴암주차장, 기림사주차장)','경상북도 경주시 천북남로 12',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','경주 계림','이 숲은 첨성대(瞻星臺)와 월성(月城) 사이에 위치해 있으며, 경주 김씨의 시조 알지(閼智)가 태어났다는 전설이 있는 유서 깊은 곳이다. (사적)신라 탈해왕(脫解王) 때 호공(瓠公)이 이 숲에서 닭이 우는 소리를 들었는데, 가까이 가보니, 나뭇가지에 금궤(金櫃)가 빛을 내며 걸려 있었다. 이 사실을 임금께 아뢰어 왕이 몸소 숲에 가서 금궤를 내렸다. 뚜껑을 열자 궤 속에서 사내아이가 나왔다하여 성(姓)을 김(金), 이름을 알지라 하고, 본래 시림(始林), 구림(鳩林)이라 하던 이 숲을 계림(鷄林)으로 부르게 되었다.

계림은 신라의 國號(국호)로도 쓰이게도 되었다. 펑퍼짐한 숲에는 느티나무 등의 옛나무들이 울창하게 우거지고 북쪽에서 서쪽으로 작은 실개천이 돌아흐른다. 왕은 알지를 태자로 삼았으나 후에 박씨 왕족인 파사왕에게 왕위가 계승되어 왕이 되지 못했고, 후대 내물왕대부터 신라 김씨가 왕족이 되었다. 경내의 비는 조선 순조(純祖) 3년(1803)에 세워진 것으로 김알지 탄생에 관한 기록이 새겨져 있다. 신라 왕성 가까이 있는 신성한 숲으로 신라 김씨 왕족 탄생지로 신성시되고 있으며 지금도 계림에는 왕버들과 느티나무가 하늘을 가릴 듯하다. 대릉원-계림-반월성으로 이어지는 산책로옆에는 봄이면 노란 유채꽃이 유적지의 운치를 더 깊게 해준다.',NULL,'연중무휴','https://www.gyeongju.go.kr/tour','있음','경상북도 경주시 교동',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','첨성대','‘동양 최고(最古)의 천문대’ 첨성대. 신라 제27대 선덕여왕 때 건립된 것으로 추정되며 경주를 상징하는 랜드마크 중 하나이다. 받침대 역할을 하는 기단부(基壇部)위에 술병 모양의 원통부(圓筒部)를 올리고 맨 위에 정(井)자형의 정상부(頂上部)를 얹은 모습으로 높이는 약9m이다. 원통부는 부채꼴 모양의 돌로 27단을 쌓아 올렸다. 남동쪽으로 난 창을 중심으로 아래쪽은 막돌로 채워져 있고 위쪽은 정상까지 뚫려서 속이 비어 있다. 동쪽 절반이 판돌로 막혀있는 정상부는 정(井)자 모양으로 맞물린 길다란 석재의 끝이 바깥까지 뚫고 나와있다. 이런 모습은 19∼20단, 25∼26단에서도 발견되는데 내부에서 사다리를 걸치기에 적당했던 것으로 보인다.
옛 기록에 의하면, “사람이 가운데로 해서 올라가게 되어있다”라고 하였는데, 바깥쪽에 사다리를 놓고 창을 통해 안으로 들어간 후 사다리를 이용해 꼭대기까지 올라가 하늘을 관찰했던 것으로 보인다.

첨성대를 이루는 돌들은 저마다의 의미를 가진다. 위는 둥글고 아래는 네모진 첨성대의 모양은 하늘과 땅을 형상화했다. 첨성대를 만든 365개 내외의 돌은 1년의 날수를 상징하고, 27단의 돌단은 첨성대를 지은 27대 선덕여왕을, 꼭대기 정자석까지 합치면 29단과 30단이 되는 것은 음력 한 달의 날수를 상징한다.
관측자가 드나들었을 것으로 추측되는 가운데 창문을 기준으로 위쪽 12단과 아래쪽 12단은 1년 12달, 24절기를 표시한다. 하늘의 움직임을 계산해 농사 시기를 정하고, 나라의 길흉을 점치는 용도로도 첨성대가 활용되었음을 짐작할 수 있는 대목이다.',NULL,'09:00 ~ 22:00 (동절기 21:00까지)','http://www.gyeongju.go.kr/tour','있음','경상북도 경주시 첨성로 140-25',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','천마총(대릉원)','1973년에 발굴된 고분 천마총은 신라 특유의 적석목곽분이다. 높이 12.7m, 지름 50m의 능으로 봉토 내에는 냇가의 돌로 쌓은 적석층이 있고, 적석층 안에는 길이 6.5m, 너비 4.2m, 높이2.1m의 나무로 된 방이 있어, 그 중앙에 목관을 놓고 시신을 안치했다. 출토된 유물이 11,526점으로, 그 중 천마도는 우리나라 고분에서 처음 출토된 귀중한 그림이다.

대릉원의 고분군 중 유일하게 공개하고 있는 고분 천마총은, 옆에 위치한 황남대총을 발굴하기 위해 시범적으로 발굴한 곳인데, 당시 기술로는 황남대총 같이 거대한 규모의 무덤을 발굴하기가 힘들었기 때문이다.
1973년 발굴 과정에서 부장품 가운데 자작나무 껍질에 하늘을 나는 말이 그려진 말다래(말을 탄 사람의 옷에 흙이 튀지 않도록 가죽 같은 것을 말의 안장 양쪽에 늘어뜨려 놓은 기구)가 출토되어 ‘천마총(天馬塚)’이 되었는데, 최근 이 천마가‘말’을 그린 것이 아니라 ‘기린’을 그린 것이라는 주장도 설득력을 얻고 있다.
천마총은 5세기 말에서 6세기 초에 축조된 고분으로 추정되는데 금관, 금모자, 새날개 모양 관식, 금 허리띠, 금동으로 된 신발 등이 피장자가 착용한 그대로 출토되었다.
특히 천마총 금관은 지금까지 출토된 금관 중 가장 크고 화려한 것이다. 실제 유물들은 경주국립박물관에 전시되어 있으니 꼭 한번 들려 보길 권한다.',NULL,'09:00 ~ 22:00 (동절기 21:00까지)','http://www.gyeongju.go.kr/tour','주차가능','경상북도 경주시 계림로 9',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','다덕약수탕','봉화의 청정 탄산약수 중에 하나이다. 옛날 스무나무 아래 약수가 있어 이를 마시고 많은 사람이 덕을 보았다 하여 다덕(多德)약수라 불리워지는 이곳은, 탄산과 철분 등이 함유되어 있어 톡 쏘는 맛이 그만이다. 예로부터 피부병과 위장병에 많은 사람들이 효험을 보았다 하고, 지금도 전국에서 많은 사람들이 찾고 있다.
울진.태백 방향의 국도변에 위치하고 있어서 지나는 길에 들러보아도 좋다. 봉화 농특산물직판장이 있어 이용할 수 있다. 약수탕 주변 음식점은 봉화지정 토속음식단지로 약수로 고아 만든 약수닭백숙, 오리한방백숙을 비롯해서 봉화산송이돌솥밥, 봉화한약우구이 등 토속음식을 맛볼 수 있다.',NULL,null, 'https://www.bonghwa.go.kr','주차가능','경상북도 봉화군 봉성면 진의실길 6',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','봉화 금강소나무림','남부지방산림청(청장 배영돈)은 인위적인 벌채와 환경적인 여건 변화로 쇠퇴되어가고 있는 금강소나무를 조선 말엽의 울창했던 금강소나무 숲으로 복원하고 아울러 국민들이 건강한 숲을 직접 체험할 수 있도록「에코투어가 이끄는 금강소나무 생태경영림」을 울진 소광리, 영양 본신리, 봉화 고선·대현리 등 3개소에 조성하였다.
금강소나무 생태경영림에는 100년 후 현재 숲을 대체할 금강소나무 후계림 606㏊를 조성하고, 물이 있는 계곡을 중심으로 한 먹이사슬 복원을 위하여 새들의 먹이나무인 마가목·찔레 등 열매나무 3천본을 심고, 야생 토끼·노루 등이 좋아하는 클로버·벌개미취 등 먹이식물 3.5㏊, 9천본을 심고, 계곡에는 물고기 댐과 소규모의 “물막이보”를 만들어 향토어종인 피라미·누치·버들치 등 3만 여 마리를 방사하여 계곡을 생명이 숨쉬는 공간으로 복원하였다. 또한 최근 참살이(웰빙)가 각광을 받고 있어 금강소나무에서 뿜어져 나오는 피톤치드를 국민들이 만끽하며 건강한 몸과 맑은 정신을 체험할 수 있도록 생태탐방로를 1시간 코스·2시간 코스·4시간 코스 등 다양하게 만들어 놓았다.',NULL,'09:00 ~ 22:00 (동절기 21:00까지)','http://south.forest.go.kr','주차가능','경상북도 봉화군 소천면 청옥로',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','구마계곡(고선계곡)','태백산(1,567m)에서 발원한 계류가 20km에 걸쳐 흐른다. 발원하는 계곡 중 가장 길어 물줄기가 장장 100리나 되는 원시림 계곡으로, 수량이 풍부하고 각종 민물고기도 많이 서식하고 있어 가족과 함께 물놀이를 즐기기에 좋다. 또, 주변에는 기암괴석과 절벽, 숲 등이 천혜의 자연 그대로 보존되어 있고, 계곡물은 거울처럼 맑아 주위의 수려한 산세가 물에 비치면서 한번 더 생생히 살아날 정도이다. 고선계곡은 이처럼 태고의 신비를 간직하고 있어 공해에 찌든 현대인들에게 여름철 피서지로 그만이다. 그래서 한번 다녀간 많은 사람들이 매년 이 곳을 찾고 있다.

구마계곡으로 더 잘 알려진 이 곳은, 풍수지리설에 의하면 9필의 말이 한 기둥에 매여 있는 구마일주의 명당이 있다고 하는데 아직 이 명당을 찾은 이는 아무도 없다고 한다. 구마계곡이라는 이름도 거기에서 유래되었으며, 마방, 죽통골, 굴레골과 같이 말과 관련된 지명들이 곳곳에 남아 전해지기도 한다. 계곡 내에 민박이 가능한 곳이 5~6개소 되며, 텐트를 칠 수 있는 야영지도 여러 곳이다. 바쁜 일상을 잠시 접어두고 맑은 물과 좋은 산세, 푸른 자연과 벗하며 무더운 여름을 보낼 수 있는 조용한 피서 휴가지로 백리장천(百里長川) 깊은 계곡, 이만한 곳이 없을 듯하다.',NULL,'09:00 ~ 22:00 (동절기 21:00까지)','http://www.bonghwa.go.kr/open.content/tour/','주차가능','경상북도 봉화군 소천면 고선리',sysdate, 0, 0);

--경상남도
insert into item values(item_seq.nextval, 1, '관광지','가지산도립공원(밀양)','경상남도 밀양시, 울산시 울주군과 경상북도 청도군의 경계에 있는 가지산(높이 1,240m)은 서남쪽으로 1,189m의 천황산과 이웃해서 태백산맥과 나란히 남단으로 매듭져 있다. 특히, 쌀바위에서 산 위를 잇는 능선 일대가 바위벽과 바위 봉우리로 이루어져 있으며, 온갖 형태의 바위, 석남사, 얼음골, 폭포들이 어울려 영남에서 으뜸가는 산으로 꼽히고 있다. 가지산에는 곳곳에 바위봉과 억새밭이 어우러져 운문산으로 이어지는 산줄기로 능선을 따라 갈 수 있다. 가을이면 석남고개에서 정상에 이르는 억새밭이 장관을 이루고, 기암괴석과 쌀바위는 등산객의 눈길을 이끈다.',NULL,null,'http://www.bonghwa.go.kr/open.content/tour/',null,'경상남도 밀양시 산내면',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','밀양 얼음골','재약산(천황산) 북쪽 중턱의 높이 600~750m쯤 되는 곳의 골짜기 약 29,752m²(9천여평)을 얼음골이라고 한다. 봄부터 얼음이 얼었다가 처서가 지나야 녹는 곳이며, 반대로 겨울철에는 계곡물이 얼지 않고 오히려 더운 김이 오른다는 신비한 곳이다. 더위가 심할수록 바위 틈새에 얼음이 더 많이 얼고, 겨울에는 반팔을 입을 정도로 더운 김이 나 ""밀양의 신비""라 불리며 천연기념물로 지정, 보호하고 있다.

얼음이 어는 시기는 4월부터 8월까지로, 비가 온 뒤에는 녹아서 얼음이 보이지 않으며 어는 경우도 예전만큼 많지는 않다고 하는데 그래도 계곡입구에 들어서면 냉장고 속에 들어간 듯 쏴아한 얼음바람을 맛볼 수가 있다.얼음골의 여름 평균기온은 섭씨 0.2도, 계곡물은 5℃ 정도. 물이 차서 10초 이상 발을 담그고 있기 어렵다. 얼음골의 정식이름은 시례빙곡(詩禮氷谷)이다. 우리나라에서 얼음골로 알려진 곳은 이 곳 밀양의 천황산 얼음골, 의성군 빙혈(氷穴), 전라북도 진안군의 풍혈(風穴), 냉천(冷泉), 울릉도 나리분지의 에어컨굴 등 네 곳이다.',NULL,'09:00 ~ 22:00 (동절기 21:00까지)','https://www.miryang.go.kr/tur/index.do','주차가능','경상남도 밀양시 산내면 산내로 1647',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','표충사(밀양)','대한불교조계종 15교구 사명대사 호국성지 표충사는 경상남도 밀양시 단장면 재약산(載藥山) 기슭에 있는 절로 임진왜란 때 승병을 일으켜 나라에 큰 공을 세운 사명대사(四溟大師)의 충훈을 추모하기 위하여 세운 절이다. 재약산(천황산)의 남서쪽 기슭에 위치한 표충사는 천 년 역사를 가진 고찰이다. 신라 무열왕 원년(654)에 원효대사가 가람을 창건하고 이름을 죽림사(竹林寺)라 한 것을 흥덕왕 4년(829)에 황면선사가 부처님 진신사리 3과를 모시고 와서 삼층석탑을 세워 봉안하고 가람을 크게 중건하여 절 이름을 영정사라고 개칭했다.

그 후 889년(진성여왕 3) 보우국사가 승려 500명을 모아 선풍을 크게 일으켜 동방 제2선찰이 되었고, 고려 충렬왕 12년(1286)년에 삼국유사의 저자인 일연국사가 1,000여명의 대중을 맞아 불법을 중흥하여 동방 제1선찰이 되었으며, 1290년(충렬왕 16) 천희국사가 선풍을 관장하여 일국의 명찰이라 일컫게 되었다. 1839년에는 월파선사가 그의 팔세조사인 사명당 송운대사의 임진란 구국충의를 받들기 위하여 지금의 밀양시 무안면 삼강동 있던 표충사당을 이곳으로 이건 한 후 사명을 표충사라 개칭하였다. 1958년 9월 17일 국가지정 국보인 청동함은향완, 보물인 3층 석탑 그리고 사명대사 유물 200여점의 문화재도 보관하고 있다. 또한 절 주변에는 층층폭포, 금강폭포, 얼음골이 있고 산마루에는 사자평 초원이 있으며, 남한에서 가장 규모가 큰 고산습지인 산들늪이 있다.',NULL,'09:00 ~ 22:00 (동절기 21:00까지)','http://www.pyochungsa.or.kr','주차가능','경상남도 밀양시 단장면 표충로 1338',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','밀양 평리산대추정보화 마을','* 대추가 들어간 영양 간식 만드는 밀양 평리산대추정보화 마을 *

평리마을은 밀양댐 아래에 위치한 마을로 대추 농가가 많아 산대추 마을로도 불린다. 수량이 풍부한 하천이 흐르고 메밀묵 만들기 등 먹거리도 풍부해 여름휴가철에도 인기가 많다. 대추 수확 등 농사가 거의 마무리 되어가는 늦가을부터는 수확한 대추를 가지고 다양한 먹거리를 만들어 보는 체험을 운영한다. 달콤한 대추가 씹히는 대추 찰떡과 대추의 풍미를 느낄 수 있는 대추 엿 만들기 체험이 대표적이다.

* 먹거리 : 흑염소 불고기, 손두부, 평리정식, 평리비빔밥 등
* 인근볼거리 : 밀양댐, 백마산, 얼음골 등',NULL,'09:00~18:00','http://sandaechu.invil.org/index.html','주차가능','경상남도 밀양시 단장면 고례4길 7-3',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','오례사','백촌 김문기(1399∼1456) 선생의 학문과 덕행을 추모하고 이를 계승하고자 세운 곳이다. 김문기 선생은 세종 8년(1426) 과거에 급제하여 여러 관직을 두루 거쳤으나 사육신과 함께 단종복위를 꾀한 사건으로 희생당하였다. 그 뒤 영조 7년(1731) 복관되고, 영조 33년(1757) 충의(忠毅)란 시호가 내려졌다. 오례사는 선생의 후손이 1870년에 세웠으며, 1994년에 크게 보수하여 오늘에 이른다. 현재 남아있는 건물은 외삼문, 추원재, 내삼문, 사당이 있다. 사당은 앞면 3칸·옆면 2칸 규모이며, 지붕은 옆면에서 볼 때 사람 인(人)자 모양인 맞배지붕이다. 추원재는 앞면 4칸·옆면 2칸이며, 지붕은 옆면에서 볼 때 여덟 팔(八)자 모양인 팔작지붕으로 꾸몄다.',NULL,null,'http://www.geochang.go.kr/tour/index.do',null,'경상남도 거창군 신원면 오례길 127-3',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','설천 남해해안도로','‘한 점 신선의 섬’으로 불리는 남해는 해안 드라이브 코스로 유명하며 봄철에 더욱 아름답다. 특히, 설천면 노량에서 삼동면 지족을 잇는 남해해안도로는 약 35km 구간으로 봄철 벚꽃과 유채꽃을 만끽할 수 있는 아름다운 드라이브코스이다. 농촌의 여유로운 풍경과 더불어 천혜의 자연이 절경을 자아내는 곳으로 자전거 라이딩 코스로도 인기를 끌고 있다. 수려한 한려수도의 남해 비경을 여유롭게 감상할 수 있는 이곳은 남해의 새로운 관광자원으로 주목받고 있다.',NULL,null,'http://tour.gyeongnam.go.kr/index.gyeong#close',null,'경상남도 남해군 설천면',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','청곡리지석묘','‘한 점 신선의 섬’으로 불리는 남해는 해안 드라이브 코스로 유명하며 봄철에 더욱 아름답다. 특히, 설천면 노량에서 삼동면 지족을 잇는 남해해안도로는 약 35km 구간으로 봄철 벚꽃과 유채꽃을 만끽할 수 있는 아름다운 드라이브코스이다. 농촌의 여유로운 풍경과 더불어 천혜의 자연이 절경을 자아내는 곳으로 자전거 라이딩 코스로도 인기를 끌고 있다. 수려한 한려수도의 남해 비경을 여유롭게 감상할 수 있는 이곳은 남해의 새로운 관광자원으로 주목받고 있다.',NULL,null,'http://tour.geoje.go.kr',null,'경상남도 거제시 사등면 청곡리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','거제향교','조선 초기에 현유(賢儒)의 위패를 봉안, 배향하고 지방의 중등교육과 지방민의 교화를 위해서 창건되었으며, 창건연대는 미상이다. 1592년 임진왜란으로 고현성이 함락되었을 때 성밖에 있던 이 향교도 소실되었으며, 1664년에 현령 이동구가 고현에서 계룡산 기슭의 서정리로 이건하였다. 1715년에는 다시 거제현 동쪽의 도촌동으로 이전하였다가 1854년에 지금의 위치로 옮겼다. 현존하는 건물로는 대성전·동무(東廡)·서무(西廡)·일주문(一柱門)·명륜당·풍화루(風化樓) 등이 있으며, 대성전 안에는 5성(五聖)·송조2현(宋朝二賢), 그리고 신라 2현(薛聰·崔致遠)·고려 2현(安珦·鄭夢周) 등의 우리나라 14현(十四賢)의 위패가 봉안되어 있다. 조선시대에는 국가로부터 전답과 노비·전적 등을 지급받아 교관이 교생을 가르쳤으나, 현재는 교육적 기능은 없어지고 봄·가을에 석전(釋奠)을 봉행하고 초하루·보름에 분향을 올리고 있으며, 전교(典校) 1명과 장의(掌議) 수명이 운영을 담당하고 있다.',NULL,null,'http://tour.geoje.go.kr',null,'경상남도 거제시 거제면 기성로7길 10',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','포충사','표충서원(表忠書院)은 본래 표충사(表忠祠)라고 불렀는데, 임진왜란때 의승장(義僧將)으로서 구국(救國)의 대공(大功)을 세운 서산(西山), 송운(松雲), 기허(騎虛) 등 3대사(大師)를 향사(享祀)하는 곳으로서 본래는 1610년(광해군 2)에 창건하였다. 1669년(현종 10)에는 조정에서 사액하였다. 무안면 중산리 웅동(熊洞 : 현, 대법사(大法寺)자리)에 있던 것을 1839년(헌종 5) 정월에 송운대사(松雲大師)의 8세(世) 법손(法孫)인 월파당(月坡堂) 천유(天有)가 당시 영정사(靈井寺 : 현재 표충사) 주지(住持)로 있을 때 밀양부사(密陽府使) 심의복(沈宜復)과 그의 아들인 순상(巡相) 심경택(沈敬澤)의 힘을 빌리고 예조(禮曹)의 승인을 얻어, 현 위치인 단장면 구천리 영정사(靈井寺) 경내로 옮기고 편액을 표충서원(表忠書院)이라 고쳐 걸고, 절의 이름도 표충사(表忠寺)로 고쳐 부르게 되었다. 본래 서원(書院)은 유교(儒敎)의 사학(私學) 시설인데, 불교(佛敎) 사찰(寺刹) 안에 고승(高僧)의 영정(影幀)과 위패(位牌)를 봉안(奉安)한 사당(祠堂)을 두고 있는 것 자체가 일반적 관례(慣例)와는 매우 이질적이라 볼 수 있겠고, 춘추(春秋) 2회에 걸쳐 매년 실시하는 향사(享祀)도 승려가 아닌 관리(官吏 : 대개 市長)가 주재하여 올리고 있는 것이 특징이다. 1871년(고종 8년)에 흥선대원군(興宣大院君)에 의한 서원철폐령(書院撤廢令)에 따라 이 서원도 훼철(毁撤) 되었다가 1883년(고종 20년) 사림(士林)의 요청으로 복원(復院) 되었으며 근년에 현재의 자리로 옮겨지었다.',NULL,null,'http://www.geochang.go.kr/tour/index.do',null,'경상남도 거창군 웅양면 원촌3길 29',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','반구헌','반구헌은 조선 헌종, 철종 시대에 영양 현감을 지낸 야옹 정기필 선생이 기거하던 주택이다. 야옹 선생은 목민관 재임 시 청렴한 인품과 덕행으로 명망이 높았으며 관직을 사직하고 고향으로 돌아왔으나 재산과 거처가 없자 당시 안의 현감의 도움으로 이 반구헌을 건립하였다고 한다.반구헌이란 이름은 스스로 자신을 뒤돌아보고 반성한다는 뜻을 갖고 있다. 반구헌은 현재 대문채와 사랑채만 남아 있는데 사랑채에 상량문이 남아 있어 현재의 건물은 1870년대에 건립, 또는 중건된 것으로 추정된다.반구헌이라 불리는 사랑채는 팔작기와지붕에 정면 5칸, 측면 5칸 규모로 이루어진 비교적 큰 규모의 건물이다. 이 건물의 가장 큰 특징은 대청이 중앙에 있지 않고, 규모가 1칸인 반면에 방이 3칸이라는 점이다. 또한, 측면 1칸에 난간을 두룬 누마루를 가지고 있다. 따라서 건물 후면 중앙에 아궁이를 설치하여 방 2개를 한 곳에서 난방하도록 평면을 구성하였다. 구조는 민도리집으로 단순 소박하지만, 전체적으로 사대부가의 품격을 풍기는 중요한 건축물이다.',NULL,null,'http://www.geochang.go.kr/tour/index.do',null,'경상남도 거창군 위천면 강동1길 17',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','곤양향교','창건연대는 미상이나, 현유(賢儒)의 위패를 봉안, 배향하고 지방의 중등교육과 지방민의 교화를 위하여 당시 교동(校洞)에 창건되었다. 1807년에 위치가 좁고 나쁘다 하여, 곤양군수 신오(申晤)가 향유(鄕儒)들과 함께 현 위치로 이건하였다. 1822년 대성전을 중수하였고, 1947년 화재로 소실된 풍화루(風化樓)를 재건하였으며, 1975년 내삼문(內三門)과 명륜당을 보수하였다. 현존하는 건물은 5칸의 대성전과 7칸의 명륜당, 전직사(殿直舍)·동재(東齋)·풍화루·내삼문(內三門)·외삼문(外三門) 등이 있다. 대성전에는 5성(五聖)·송조2현(宋朝二賢), 우리나라 18현(十八賢)의 위패가 봉안되어 있다. 조선시대는 국가로부터 토지와 노비 등을 지급받아 교관이 교생을 가르쳤으나, 현재는 교육적 기능은 없어지고, 봄·가을의 석전제(釋奠祭)와 초하루·보름의 삭망제(朔望祭)만 실시되고 있으며, 전교(典校) 1명과 장의(掌議) 18명이 운영을 담당하고 있다. 이 향교는 현재 경상남도 유형문화재로 지정되어 있으며, 소장 전적 가운데 『조선청금록(朝鮮靑衿錄)』·『동성승람(東城勝覽)』·『향교급각단응행절목(鄕校及各壇應行節目)』 등은 이 지방 향토사연구에 귀중한 자료가 된다.',NULL,null,'https://www.cha.go.kr/main.html',null,'경상남도 사천시 곤양면 향교길 43-31',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','송호서원','이 서원은 고려중기의 인물 충숙공 문극겸(忠肅公 文克謙)을 배향하는 곳이다. 원래 1777년(정조 1) 삼가현 역평(三嘉縣繹坪)에 세워졌던 본 서원은 대원군의 서원철폐령으로 폐지되고, 이후 사우(祠宇) 등이 1957년에 복원되었다. 그것을 1985년 다시 합천댐 공사로 인한 수몰을 피해 장소를 옮겨 복원한 것이 지금 전하고 있는 것이다. 서원에서는 매년 3월 20일에 향사를 지내고 있다.',NULL,null,'http://www.cha.go.kr',null,'경상남도 합천군 대병면 신성동2길 22-3',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','월봉서원','유학자 월헌 이보림 선생의 학덕을 기리고 그 유업을 계승하기 위해 선생의 사후 12년 뒤인 1984년에 유림의 공의로 월봉서당 오른편에 명휘사를 건립하여 그 위폐를 모셨다. 장유면 관동리 덕정마을에 위치한 이 서원은 매년 음력 3월 20일을 영정하여 향례를 올리고 있다. 김해지역 유림의 정신적 중추 구실을 하고 있는 이 서원은 지금도 제향의과 전통적 서당교육이 이루어지고 있다. 전통적 서원의 규모 갖추고 있으면서 동시에 그 역할을 담당하고 있는 우리나라에 몇 안 되는 서원중에 한 곳이라 할 수 있다. 화재 선생은 율곡 이이, 우암 송시열, 간재 전우, 석농 오진영으로 이어지는 영남 기호학맥의 후예로, 평생 고향에서 월봉서원을 지키면서 한학을 가르쳤다. 또한 2005년 5월에는 성리학 관련 글과 한시, 금석문 등을 정리한 ''화재문집(華齋文集·전27권)''을 출간하는 등 40여권의 방대한 저술을 남겼고, 막내아들인 준규(38·부산대 한문학과 교수)씨를 통해 월봉서당을 6대째 운영하며 많은 후학을 양성했다. 화재 선생의 이 같은 업적과 정신을 기려 유족과 월봉서원, 유림 등은 지난해 화재 선생의 장례를 학문과 덕망이 높은 유학자가 타계했을 때 행해지는 유림장 형태의 유월장(踰月葬)으로 거행했으며 3년상을 치렀다.',NULL,null,'http://www.cha.go.kr',null,'경상남도 김해시 덕정로77번길 11-12',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','원천정','원천정은 1587년(선조20)에 원천 전팔고 선생이 후배들을 기르기 위해 건립한 것으로, 임진왜란 때는 의병의 비밀 모의장소로 이용하기도 했다. 전팔고는 본관이 죽산으로, 남명 조식의 문인이다. 전팔고 선생은 11세 때 논어 중용을 독파하고, 노진, 김우옹, 정구, 오장 등 석학들과 학문을 익혔다. 임진왜란 때는 거창의 의병을 도왔고, 명군이 가조면에 머무를 때 적극적으로 도운 공으로 명 황제가 첨지 벼슬을, 선조가 대사헌을 내렸지만 사양하였다. 원천정은 임란 시 의병장들의 모의장소 및 학문과 도의를 연마하여 오던 장소로서 건물은 정면 4칸, 측면 1칸의 일자형 평면 맞배지붕이다. 왼쪽으로 마루 2칸, 오른쪽으로 방 2칸을 들였고, 방 앞에 난간을 설치하였다.1684년 후손들이 중창한 이후 여러 번 중수하였다. 뜰에는 신도비가 있으며, 정자 안에는 정자 건립에 관한 기문과 상량문이 걸려 있다. 서숙이 인조 14년(1636)에 지은 ‘원천정사기’와 숙종 10년(1684)에 임동익이 지은 ‘원천 정사 중창 상량문’, 정온, 조경, 오장 세 사람이 지은 시가 걸려 있다.',NULL,null,'http://www.cha.go.kr',null,'경상남도 거창군 가조면 원천1길 80',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','함양문화원','함양문화원은 향토문화 발굴사업, 교육사업 및 향토 예술 활동을 하며 체험프로그램을 운영하고 있다.',NULL,'09:00~18:00','hamyang.kccf.or.kr','주차가능','경상남도 함양군 함양읍 함양여중길 10',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','구연서원','1694년(숙종 20)에 지방 유림이 신권(愼權)의 학문과 덕행을 추모하기 위하여 신권이 제자를 가르치던 구주서당(龜州書堂) 자리에 서원을 창건하여 위패를 모셨다. 그 뒤 성팽년(成彭年)과 1808년 신수이(愼守彛)를 추가 배향하여 선현 배향과 지방 교육의 일익을 담당하였다. 대원군의 서원철폐령으로 1868년에 훼철되었다. 이곳에는 신권의 사적비와 신권을 위한 산고수장비(山高水長碑), 열녀, 효자비가 많고, 관수루가 사원의 문처럼 서 있다',NULL,'09:00~18:00','http://www.geochang.go.kr/tour/index.do','주차가능','경상남도 거창군 위천면 은하리길 100',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','몽고정','고려 말 충렬왕 7년(1281) 원나라 세조가 일본 원정을 준비하기 위하여 정동행성(征東行省)을 두었으나, 일본 정벌이 2차에 걸쳐 실패로 돌아간 그 해 10월에 연해방비를 위해 이곳 환주산(環珠山)(현, 자산동 무학초등학교 뒤쪽 마산시립박물관 일대)에 둔진(屯鎭)을 설치하였다. 이 몽고정은 이곳의 둔진군(屯鎭軍)이 용수(用水)를 쓰기 위해 만들었던 우물로 추정되고 있다. ‘몽고정 맷돌’이라고 불리는 직격 1.4m 가량의 원방형(圓方形)의 돌이 몽고정 근처에서 발견되었는데 이를 차륜(車輪)이라는 설도 있으나 맷돌로 쓰였던 것으로 보인다. 우물 곁의 석비에 몽고정(蒙古井)이라 써서 세워둔 것은 1932년 마산 고적보존회(일본인 고적단체)가 멸시적 감정에서 명명한 것으로 그 이전에는 고려정이라 불렸을 것이다.

* 규모 - 1개소
* 재료 - 화강암
* 시대 - 고려시대',NULL,'24시간','http://www.geochang.go.kr/tour/index.do','없음','경상남도 창원시 마산합포구 자산동',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','영빈서원','영빈서원은 1744년(영조 20)에 창건하여 정구(鄭矩)등 6위를 제향하던 곳으로 이 지역 학문의 중심 역할을 담당한 영천사(瀯川祠)에 그 뿌리를 두고 있다. 1868년(고종 5) 서원철폐령으로 훼철되었다가 일제강점기에 국난극복을 도모하고자 사림과 후손들이 1919년 중건하여 민족정신을 집결하는 공간으로 자리매김하였고, 민족자존과 지역교화에 중심적인 역할을 하였다.',NULL,'24시간','http://www.geochang.go.kr/tour/index.do','없음','경상남도 거창군 남하면 무릉2길 34',sysdate, 0, 0);

--전라남도
insert into item values(item_seq.nextval, 1, '관광지','향일암(여수)','향일암은 전국 4대 관음 기도처 중의 한 곳으로 644년 백제 의자왕 4년 신라의 원효대사가 창건하여 원통암이라 불렀다. 고려 광종 9년(958)에 윤필거사가 금오암으로, 조선 숙종 41년 (1715년)에 인묵대사가 향일암이라 개칭했다. 이 곳은 원통보전, 삼성각, 관음전, 용왕전, 종각, 해수관음상을 복원, 신축하여 사찰로서의 면모를 갖추었는데 2009년 12월 20일 화재로 소실된 대웅전(원통보전), 종무소(영구암), 종각을 2012년 5월 6일 복원하여 낙성식을 가졌다. 마을에서 향일암을 오르는 산길은 제법 가파른 편인데, 중간쯤에매표소를 지나 계단길과 평길을 돌아오르는 길이있다. 암자근처에 이르면 집채 만한 거대한 바위 두개 사이로 난 석문을 통과해야 하는데 이곳이 다른 사찰의 불이문에 속하는 곳이다. 또한 임포마을 입구에는 수령이 5백년이나 된 동백나무가 있고 향일암 뒤 금오산에는 왕관바위,경전바위,학사모바위,부처바위가 있다.

남해 수평선의 일출 광경이 장관을 이루어 향일암이라 하였으며, 또한 주위의 바위모양이 거북의 등처럼 되어 있어 영구암이라 부르기도 한다.12월 31일에서 1월 1일까지 향일암 일출제가 열리고 있어 이곳 일출 광경을 보기위해 찾는 관광객들로 북새통을 이룬다. 나오는 길엔 방죽포 등 해수욕장이 많고, 돌산공원, 무술목전적지, 고니 도래지, 흥국사 등이 가까이 있다. 향일암에는 7개의 바위동굴 혹은 바위틈이 있는데 그 곳을 모두 통과하면 소원 한가지는 반드시 이뤄진다는 전설이 있다. 소원을 빌기 위해 대웅전과 용왕전 사이에 약수터 옆 바위와 관음전 뒷편 큰 바위에 동전을 붙이거나 조그만 거북 모양 조각의 등이나 머리에 동전을 올려놓기도 한다.',NULL,'24시간','http://tour.yeosu.go.kr','주차가능','전라남도 여수시 돌산읍 향일암로 60',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','전라남도해양수산과학관','1998년 5월에 개관한 전라남도 수산종합관은 임진왜란 전승지로 이순신 장군이 무술년에 왜적을 섬멸한 무술목 유원지에 위치하고 있으며 자연경관이 수려한 한려수도와 함께 남해안의 유명관광지로 연결되어 있다. 규모는 부지 2,802평, 건물 1,680평이며, 주요시설로는 수족관전시실, 해양수산전시실, 해양과학전시실 및 종묘배양장, 시청각실을 갖추고 있다. 또한, 3D 입체영상관과 해양생물자연사관이 신설되어 관람객들에게 선보이고 있다. 정문 로비에 전라남도를 상징하는 도어인 참돔의 조형물이 관람객을 맞이하며 타원형 수조의 바다거북과 참돔을 관람 후 유영하는 고기떼의 흐름안내를 따라 수족관전시실로 입장한다.',NULL,'09:00~18:0','http://www.해양수산과학관.kr','주차가능','전라남도 여수시 돌산읍 돌산로 2876',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','돌산도','1984년 12월 15일에 준공된 돌산대교를 통해 여수반도와 이어져 있다. 길이 450m, 폭 11.7m의 사장교인 돌산대교는 주변의 아름다운 해상풍경과 멋진 조화를 이뤄 그 자체가 관광명소가 되었다.

돌산도에는 돌산공원, 무술목전적지, 전라남도수산종합관, 방죽포 해수욕장, 향일암, 은적암 등의 명승지와 유적지가 있으며, 섬 전체를 둘러볼 수 있는 해안 일주도로가 잘 포장되어 있다. 특히 근래에는 관광식당, 민박집 등의 편의시설이 늘어남에 따라 이곳을 찾는 여행객들도 증가하는 추세이다. 돌산도는 자동차를 타고 천천히 한 바퀴 돌아보는 것만으로도 기분이 상쾌해지는 여행지이다. 해안도로를 타고 일주하는 거리는 대략 60㎞ 정도로 1~2시간 소요된다.

돌산대교 아래에는 임진왜란 당시에 활약한 거북선의 실물 모형이 웅장한 자태를 뽐내고 있으며, 인근에는 갖가지의 싱싱한 생선회를 즐길 수 있는 식당이 해안을 따라 즐비하게 늘어서 있다. 돌산공원(대교공원)에서 내려다보는 여수시의 전경도 빼놓을 수 없는 구경거리다.',NULL,'09:00~18:0','http://www.해양수산과학관.kr','주차가능','전라남도 여수시 돌산읍',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','돌산공원','돌산공원은 돌산대교와 마주보는 자리에 위치하고 하고 있으며 87,000여평의 부지에 1987년 조성되었다. 공원에는 2004년 sbs아침드라마 “선택” 세트 촬영장이 설치되어 많은 관광객들이 관람하고 있으며, 세트장의 일부를 전통찻집으로 개조하여 돌산대교를 바라보며 차를 마시는 풍경이 일품이다. 공원의 뷰포인트에서 바라보는 돌산대교 머리위로 지는 해넘이와 돌산대교 야경, 그리고 여수시 중앙동과 종화동을 아우르는 해양공원의 야경, 장군도 야경 등을 바라보는 경치 또한 장관이다. 중앙부지에는 1994년 삼여통합과 관련된 각종 자료가 타임캡슐 안에 보관되어 100년 후에 공개할 예정이다.',NULL,'상시 가능','http://tour.yeosu.go.kr/tour','주차가능','전라남도 여수시 돌산읍 우두리 산 1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','한려해상국립공원 (오동도)','여수하면 오동도, 오동도하면 동백꽃이 연상될 정도로 동백꽃이 유명한 섬이다. 또한, 한려해상국립공원의 기점이자 종점이기도 하다. 여수 중심가에서 승용차로 10여 분만 가면 닿는 오동도 입구의 주차장에 차를 세워두고 다시 768m 길이의 방파제 길을 15여분 걸으면 오동도에 도착한다.
면적 125,620.4m²(38,000평)의 섬 내에는 동백나무, 시누대 등 200여 종의 가종 상록수가 하늘을 가릴 정도로 울창하다. 또한, 16,529m²(5,000여 평)의 잔디광장 안에는 70여 종의 야생화가 심어진 화단과 기념식수동산 등이 있어 어린이들의 자연학습장으로도 유용하다. 섬 전체를 덮고 있는 3,000여 그루 동백나무는 이르면 10월부터 한두 송이씩 꽃이 피기 시작하기 때문에 한겨울에도 붉은 꽃을 볼 수 있다. 그리고 2월 중순경에는 약 30% 정도 개화되다가 3월 중순경에 절정을 이룬다. 섬 전체에 거미줄처럼 뻗어있는 탐방로는 연인들의 데이트 코스로 인기가 높고, 종합상가 횟집에서는 인근 남해 바다에서 갓잡아 올린 싱싱한 생선을 맛볼 수 있다.
오동도 입구에서 섬 안으로 들어가는 교통 수단으로는 동백열차를 비롯해 유람선, 모터보트 등도 있다. 유람선과 모터보트는 오동도입구 선착장에서 출발해 오동 일대 해안의 아름다운 풍광과 병풍바위, 용굴, 지붕바위 등을 감상할 수 있다.',NULL,'상시 가능','http://www.yeosu.go.kr/tour','주차가능','전라남도 여수시 오동도로 222',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','진도대교','진도군 군내면 녹진과 해남군 문내면 학동사이에 놓여진 길이 484m, 폭 11.7m의 국도 18호선인 전국에서 유일한 쌍둥이 사장교로 1984년10월18일 준공되어 관광명소로 각광받고 있으며, 2005년 12월15일 제 2진도대교가 개통되고 특히 낙조와 야경이 아름답고 다리 아래의 울돌목 물살은 장관을 이룬다.울돌목은 이충무공의 3대 해전중의 하나인 명량대첩지로 잘 알려진 서해의 길목으로 해남과 진도간의 좁은 해협을 이루며 바다의 폭은 한강 너비 정도의 294m 내외이다. 1984년 진도대교의 개통으로 인해 한반도의 최남단 지역이된 진도는 연간 외국인을 포함하여 약 260만여 명이 찾는 국제적 관광 명소가 되었다. 아름다운 경관과 수많은 특산물 문화예술이 살아 숨쉬는 고장 진도로 오는 첫번째 관문이다.',NULL,null,null,null,'전라남도 진도군 고군면 녹진리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','망금산 강강술래터','망금산은 13척의 배로 3백여척의 왜선을 물리친 명량해전지 (울돌목)에 연접하여 울돌목이 바로 내려다보이는 해발 115m의 나지막한 산이다.명량해전 당시 이순신 장군은 적으로 하여금 우리 군사가 많이 보이게 하기 위하여 이 망금산에 토성을 쌓고 부근의 부녀자들을 모아 남장을 시켜 산봉우리를 원을 그리며 반복하여 돌게 하였다고 한다. 주로 추석날 밤, 곡식의 풍년을 기원하며 추던 부녀자들의 민속놀이를 의병술로 사용한 것이다.지금도 망금산 산봉에는 망터가 있고, 그 밑으로 강강술래터가 뚜렷하게 남아 있다. 또한 충무공 이순신 장군의 전술을 존경하는 마음이 담긴 강강술래에 관한 많은 전설이 전해져오고 있다.',NULL,null,null,null,'전라남도 진도군 군내면 명량대첩로 101',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','진도 의신사천마을 [농촌체험휴양마을]','진도는 과거 유배문화에 의해 시・서・화와 더불어 진도아리랑, 남도들노래, 다시래기, 진도북춤 등 소리 문화가 발달하였다. 사천마을에서는 다시래기(무형문화재. 부모상을 당한 상주와 유족들의 슬픔을 덜어주고 위로하기 위하여 벌이는 상여놀이)・북놀이 등을 무형문화재 이수자에게 직접 배울 수 있는 곳이다. 마을 주변에 진도에서 가장 높은 첨찰산 아래 운림산방, 쌍계사(진도 최고 목조건물), 진도역사관 등 다양한 문화, 역사 자원이 많아 진도여행에서 빼놓기 아쉬운 곳이다.',NULL,'null','https://www.welchon.com/web/index.do','있음','전라남도 진도군 의신면 의신사천길 26',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','운림산방','서화 예술이 발달한 진도에서도 대표적인 서화 예술가로 꼽히는 분은 조선후기 남화의 대가로 불리는 소치 허련(小痴 許鍊)이다. 그는 당나라 남송화와 수묵 산수화의 효시인 왕유의 이름을 따 허유로 알려져 있기도 하다.운림산방은 허련이 말년에 서울 생활을 그만두고 고향인 이 곳에 돌아와 거처하며 그림을 그리던 화실의 당호다. 진도읍에서 바로 남쪽으로 내려오다 보면 첨찰산 서쪽, 쌍계사와 가까운 곳에 위치해 있으며, ""ㄷ""자 기와집인 운림산방과 그 뒤편의 초가로 된 살림채, 새로 지어진 기념관들로 이루어져 있다. 운림산 방 앞 오각으로 만들어진 연못에는 흰 수련이 피고 연못 가운데 직경 6m 크기의 원형으로 된 섬에는 배롱나무가 있다. 소치 허련선생은 1809년 진도읍 쌍정리에서 태어나 어려서부터 그림에 재주를 보이다. 28세부터 해남 대둔사 일지암에서 기거하던 초의선사에게서 가르침을 받고, 30대 초반 그의 소개로 서울로 가서 추사 김정희에게서 본격적인 서화수업을 받아 남화의 대가로 성장했다. 왕실의 그림을 그리고 여러 관직을 맡기도 했으나, 김정희가 죽자 서울 생활을 청산하고 고향인 진도에 내려와 운림산방을 마련하고 그림에 몰두했다.
',NULL,'	09:00~17:00','http://tour.jindo.go.kr','있음','전라남도 진도군 의신면 운림산방로 315',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','세방낙조 전망대','한국에서 가장 아름다운 일몰을 볼 수 있는 곳
진도 해안도로 중에서 가장 아름답다는『세방낙조 전망대』에서 내려다 보는 다도해의 경관은 압권이다. 이 곳에서 보는 낙조는 환상적이다. 해질 무렵 섬과 섬 사이로 빨려 들어가는 일몰의 장관은 주위의 파란 하늘을 단풍보다 더 붉은 빛으로 물들인다. 중앙기상대가 한반도 최남단『제일의 낙조 전망지』로 선정했을 정도이다. 이 해안도로는 다도해의 아름다운 섬들을 한눈에 볼 수 있는 우리나라 최고의 다도해 드라이브 코스다. 많은 숲들과 청정 해역에서 뿜어내는 맑은 공기를 마시면서 드라이브를 즐길수 있다.',NULL,'00:00~24:00','https://www.jindo.go.kr/tour/main.cs','주차가능','전라남도 진도군 지산면 가학리 산27-3',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','이충무공 벽파진 전첩비','제주도, 거제도에 이어 우리나라에서 세 번째로 큰 섬인 진도를 찾아가는 길은 예전에 광주, 나주, 영암, 해남을 거쳐 돌아가야 했으나, 지금은 목포에서 해남읍내를 거치지 않고 영암방조제와 금호방조제를 가로질러 진도에 갈 수 있게끔 길이 단축되었다. 유인도 45개와 무인도 185개로 이뤄진 진도의 호국 전적지로는 섬 동북쪽에 들어선 벽파진의 이충무공전첩비와 용장산성, 그리고 남쪽의 남도석성이 있다. 진도대교를 건너 읍내로 가다보면 군내면 세등리를 지나 용장산성 안내판이 나타난다. 이를 따라 좌회전,1.7km를 가면 용장산성 입구인데, 벽파진은 이 곳에서 계속 바다를 향해 3.5km 가량 간다.',NULL,null,'https://www.jindo.go.kr/tour/main.cs',null,'전라남도 진도군 고군면 벽파길 90',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','명량다원','보성 녹차밭을 지나 회천면 쪽으로 조금만 가면 고갯길이 나오고 그 도로 오른쪽에 명량다원이 보인다. 판매장은 주차장에 들어서는 순간 쉽게 눈에 띈다. 한눈에 들어오는 커다란 2층 한옥 누각이 바로 그곳이기 때문이다. 언뜻 보면 마치 서울에서나 봄직한 조선시대 왕이 기거하던 궁궐처럼 생겼다. 그래서 차밭을 찾은 관광객들의 사진 배경으로도 인기가 높다. 산등성이에 세운 건물과 그 뒤로 펼쳐진 차밭이 나름의 멋을 지니고 있다.
판매장은 보성지역 여느 다원처럼 시음장을 겸하는데 한옥형 테라스에 나가 제공되는 녹차 한 잔을 마시며 바라보는 풍경은 가히 절경이다. 지난 2000년부터 판매업을 시작한 임흥준 사장은 농업경영혁신 분야에서 대통령상을 받은 차 재배 농업인이다. 봇재다원은 잎녹차를 주로 판매하지만 티백, 가루, 과자류 등 녹차 가공품과 위탁판매 중인 다기류 등 다양한 제품을 판매하고 있다. 잎녹차는 판매장에 붙어 있는 차밭에서 자체 생산한 수제 녹차다. 명량다원은 맛과 관광을 동시에 즐길 수 있는 곳이다.',NULL,null,'http://www.boseong.go.kr/tou','주차가능','전라남도 보성군 회천면 녹차로 745-8',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','백록다원','백록다원은 보성차밭 고갯길을 넘어 밤고개 삼거리에서 장흥 방면으로 우회전 후 직진하다 빨간집펜션 이정표가 확인한 다음 마을로 들어서면 만날 수 있다. 지난 2003년부터 7년째 판매장을 운영 중인 백록다원은 다원 밀집 지역와 다소 떨어진 지리적 약점에도 연평균 3000여 명의 체험객이 찾는 인기 명소다. 체험객들에게 차 문화의 모든 것을 하나하나 세세히 가르쳐주는 주인장의 세심함을 장점으로 손꼽지만 백록다원의 더 큰 매력은 7년째 영업을 하며 많은 체험객을 상대하는 백종우, 정혜영 부부에게서 느껴지는 때 묻지 않은 순박함이 아닌가 싶다. 보성군에서 가장 큰 규모인 14만 평에 달하는 차밭을 자랑하는 백록다원은 ''보성녹차 홍보대사'' 역할을 자임하고 있다. 그렇기에 다양한 상품을 판매하는 여느 판매장과 달리 오로지 자체적으로 생산개발한 수제차류와 녹차방향제만 판매하고 있다. 눈에 띄는 것은 체험객이 잎녹차, 방향제 등을 직접 만들 수 있다는 점이다. 백록다원은 차 문화 하면 떠오르는 특유의 정(靜)적 이미지에 걸맞은 정숙하고 정갈한 분위기가 여타 다원에 비해 더욱 무르익은 듯하다. 그래서인지 KOTRA(대한무역투자진흥공사) 추천으로 신라호텔과 연계해 미국 CEO 초청행사도 추진 중이다. 주변 관광 인프라도 뛰어나다. 마을 뒷산인 일림산은 철쭉 군락지로 전국적 명소이고, 5분 거리에 녹차해수탕, 15분 거리에 율포해수욕장, 보성다빈치 휴양·레저시설 등이 자리한다. 장흥 천관산과도 지근거리여서 질 좋은 전통수제차도 구입하고 질적으로나 양적으로 마음을 채우는 관광도 즐길 수 있다.',NULL,'08:00 ~ 22:00','http://www.baekrok.com',null,'전라남도 보성군 회천면 봉서동길 81-7',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','제암산자연휴양림','제암산의 사계는 봄에는 철쭉으로, 여름에는 풍부한 수량으로 가을에는 억새가, 겨울에는 설화가 아름다운 산이다. 하지만 산의 명칭이 말하듯 모든 산을 압도하는 황제의 산이기도 하다. 인근에는 용추계곡이 있어 휴가철에는 연인원 10만여명의 인파가 몰리는 영산이다. 또한, 제암산에서 승용차로 한 고개만 넘으면 파란바다의 절경이 눈앞에 펼쳐지는 율포해수욕장 관광지가 있어서 제암산 자연휴양림을 둘러 본 후, 율포해수욕장도 함께 많이 찾는 곳이기도 하다.',NULL,'09:00~18:00','http://www.foresttrip.go.kr/','주차가능','전라남도 보성군 웅치면 대산길 330',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','태백산맥문학관','태백산맥문학관은 태백산맥이 관통하는 시대정신인 통일을 염원하는 마음을 담아 북향으로 지어졌으며, 1, 2층 전시실과 5층 전망대를 갖춘 모던 양식으로 작업에는 건축가 김원 씨가 참여했다. 또한 1층 전시실에서 마주 보게 될 높이 8m, 폭 81m에 이르는 ‘원형상-백두대간의 염원’ 벽화는 이종상 교수에 의해 시각화됐으며, 세계 최대, 최초의 야외건식 ‘옹석벽화’로 이미 세간의 관심을 끌고 있다. 문학관에는 1983년 집필을 시작으로 6년 만에 완결하고 이적성 시비로 몸살을 앓았으며, 그 유형무형의 고통을 겪고 분단문학의 최고봉에 올랐던 작가 조정래의 소설『태백산맥』에 대한 자료가 전시되어 있다. ‘소설을 위한 준비와 집필’, ‘소설 『태백산맥』의 탈고’, ‘소설 『태백산맥』 출간 이후’, ‘작가의 삶과 문학 소설 『태백산맥』’이란 장으로 구성되고, 1만 6천여 매 분량의 태백산맥 육필원고를 비롯한 623점의 증여 작품이 전시되어 있다. 부대시설로는 누구나 책을 볼 수 있는 “북 카페”와 작가가 직접 머무르면서 집필활동을 하게 될 “작가의 방”이 있어 타 문학관과 차별을 두고 있다.',NULL,'09:00~18:00','http://www.boseong.go.kr/tbsm','주차가능','전라남도 보성군 벌교읍 홍암로 89-19',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','강진 고려청자 요지','강진군 대구면 일대는 우리 나라 중세미술을 대표하는 고려청자의 생산지다. 1963년 사적으로 지정된 강진 고려청자 요지는 9세기부터 14세기까지 5백여 년간 집단적으로 청자를 생산했던 곳으로 9개 마을에 180여 개소의 가마터가 분포되어 있으며, 약 18만여 평을 문화재 보호구역으로 지정 관리하고 있다. 고려시대 집단적으로 청자를 생산했던 곳으로 이곳 강진과 부안 등을 들 수 있으나, 전국적으로 지금까지 발견된 400여 기의 옛 가마터 중 대부분이 이곳 강진에 분포되어 있다. 그 중에서도 사당리는 제작기술이 최절정을 이룬 시기에 청자를 생산하였던 지역으로, 우리나라의 국보나 보물로 지정된 청자의 80% 이상이 이곳에서 생산되었을 정도로 그 기법의 천재성과 예술적 가치를 세계적으로 인정받아 왔으며, 프랑스 루부르 박물관에도 보관되어 있다. 또한, 강진은 다른 지방에 비해 태토, 연료, 해운, 기후 등 여건이 적합하여 우리나라 청자 문화를 주도해 왔으나, 고려말기에 청자 기법이 쇠퇴한 후 600여 년 동안 전승되지 못한채 단절되어 오던것을 1977년부터 재현사업을 하여 재현에 성공하였다.',NULL,'09:00~18:00','http://www.celadon.go.kr/','주차가능','전라남도 강진군 대구면 사당리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','강진영랑생가','영랑 김윤식 선생은 1903년 1월 16일 이곳에서 김종호의 2남 3녀중 장남으로 태어났다. 어릴 때에는 채준으로 불렀으나 윤식으로 개명하였으며 영랑은 아호인데 문단활동시에는 주로 이 아호를 사용했다. 영랑 선생은 1950년 9월 29일 작고하기까지 주옥같은 시 80여편을 발표하였는데 그중 60여편이 광복전 창씨개명과 신사참배를 거부하며 이곳에서 생활하던 시기에 쓴 작품이다. 영랑생가는 1948년 영랑이 서울로 이거한 후 몇 차례 전매 되었으나 1985년 강진군에서 매입하여 관리해 오고 있는데 안채는 일부 변형 되었던 것을 1992년에 원형으로 보수하였고, 문간채는 철거 되었던 것을 영랑 가족들의 고증을 얻어 1993년에 복원하였다. 생가에는 시의 소재가 되었던 샘, 동백나무, 장독대, 감나무 등이 남아 있으며 모란이 많이 심어져 있다.',NULL,'09:00~18:00','http://www.gangjin.go.kr','주차가능','전라남도 강진군 강진읍 영랑생가길 15',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','주작산자연휴양림','주작산은 강진군 신전면에 위치하고 있는 해발 475m의 낮은 산이지만 날카롭고 웅장한 암봉과 말 잔등처럼 매끈한 초원 능선이 어우러져 있으며, 등산로와 다도해의 일출이 유명하다. 주작산자연휴양림은 2007년 7월 1일 개장했다.',NULL,'09:00~18:00','https://foresttrip.go.kr/indvz/main.do?hmpgId=ID02030060','주차가능','전라남도 강진군 신전면 주작산길 398',sysdate, 0, 0);

--전라북도
insert into item values(item_seq.nextval, 1, '관광지','익산 미륵사지 [유네스코 세계유산]','백제 최대의 가람인 미륵사 창건에 대해서는 삼국유사에 기록되어 있다. 신라 선화공주와 혼인한 후 왕이 된 마동 즉, 무왕(백제 30대왕 600-641)이 선화공주와 함께 용화산(현재의 미륵산) 사자사의 지명법사를 찾아가던 중이었다. 그 때 갑자기 연못 속에서 미륵삼존이 출현하여, 이를 계기로 미륵사를 창건하게 되었다. 삼존을 위하여 전(금당), 탑, 낭무(화랑)을 세웠다고 한다. 이와 달리 미륵사의 창건에는 무왕과 선화공주의 신앙만이 아니라 정치적 목적이 있었을 것이라는 견해도 있다. 즉 백제의 국력을 확장하기 위해 마한 세력의 중심이었던 이곳 금마에 미륵사를 세웠을 거라는 추측이다. 백제 최대의 가람인 미륵사를 세우는 데에는 당시 백제의 건축·공예 등 각종 문화 수준이 최고도로 발휘됐을 것으로 짐작할 뿐만 아니라, 신라 진평왕이 백공을 보내 도와주었다는 삼국유사의 기록에서 알 수 있는 바와 같이 당시 삼국의 기술이 집결되었을 것이다. 미륵사가 백제불교에서 미륵신앙의 구심점이었음은 분명하며, 신라최대의 가람인 황룡사가 화엄사상의 구심점이었던 것과 대비된다. 황룡사가 1탑 3금당식인 것과 달리 미륵사는 3탑 3금당식 가람배치이다.황룡사는 왕을 정점으로 하는 화엄사상, 미륵사는 미륵사상을 가람에 구현하고 있다. 미륵사는 일반평민 대중까지 용화세상으로 인도하겠다는 미륵신앙이 바탕을 이루고 있다.
',NULL,'00:00~24:00','http://www.iksan.go.kr/tour/index.iksan','주차가능','전라북도 익산시 금마면 미륵사지로 362',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','서동공원','금마저수지를 끼고 있는 시원한 조각공원인 서동공원은 한여름을 가로지르는 자전거하이킹과 산책을 즐길 수 있으며, 선화공주와 서동왕자의 조각상과 ""서동요"" 조각을 비롯한 98점의 조각들을 만날 볼 수 있다. 중앙광장에는 무왕 동상이 위치하고 있으며, 십이지신상 조각을 보며 그 의미 또한 새기며 사진을 찍어 볼 수 있어 한층 재미가 있다. 봄에는 철쭉이 환영하며, 여름에는 금마저수지가 물결이 푸르다. 가족소풍이나 단체 소풍 코스로도 좋다. 서동공원내에 있는 궁남지 연못은 신라 선화공주(善花公主)와 결혼한 무왕(武王)의 서동요(薯童謠) 전설이 깃든 곳이다.

삼국사기(三國史記)에「백제 무왕 35년(634) 궁의 남쪽에 못을 파고 이십여 리 밖에서 물을 끌어다가 채우고, 주위에 버드나무를 심었으며, 못 가운데 섬을 만들었는데 방장선산(方丈仙山)을 상징한 것」 이라는 기록이 있다.이로 보아 이 연못은 백제 무왕 때 만든 궁의 정원이었음을 알 수 있다. 못 가운데 섬을 만들어 신선사상(神仙思想)을 표현한 궁남자는 우리나라 정원 중에서 가장 이른 시기의 것이다. 백제가 삼국 중에서도 정원을 꾸미는 기술이 뛰어났었음을 알 수 있다.또한 삼한시대 마한의 역사와 생활상을 한눈에 살펴볼 수 있도록 꾸며진 마한관이 개관되었다. 전시실은 생활,무덤 공감으로 구분했으며 국립전주박물관 원광대박물관에서 빌려 온 삼한시대 관련 유물 30여점 일반인으로부터 기증받은 70여점 등 110여점이 전시되어 있다.',NULL,'00:00~24:00','http://www.iksan.go.kr/tour','주차가능','전라북도 익산시 금마면 고도9길 41-14',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','익산 쌍릉','* 백제말기 굴식 돌방무덤, 익산 쌍릉(사적) *
익산 쌍릉은 백제말기 굴식 돌방무덤으로 1963년 1월 21일 사적으로 지정되었다. 봉분이 동서로 약 200m의 사이를 두고 자리하고 있으며, 동쪽의 능은 ''대왕뫼''라 불리며, 서쪽의 능은 ''소왕뫼''라 불린다. 내부는 모두 부여 능산리 고분 돌방과 같은 형식으로, 백제 말기인 7세기 전반의 형식이며 부근의 미륵사지가 백제 무왕때 창건되었음을 감안하면 이 능은 무왕과 왕비의 능묘일 가능성이 많다고 한다. 마한(馬韓)의 무강왕(武康王)과 그 왕비의 능이라고도 하며, 백제 무왕(武王)과 선화비(善花妃)의 능이라고 전하기도 한다. 고려 충숙왕(忠肅王) 때 도굴된 기사가 있고, 1917년에 학술적인 발굴 조사가 이루어졌다. 발굴 결과 그 구조는 원분(圓墳)으로 부여 능산리(陵山里)에 있는 백제 왕릉과 동일 형식에 속하는 판석제 굴식돌방으로 밝혀졌다. 이미 도굴되어 부장품은 거의 남아 있지 않았으나, 당시의 돌방 안에서 비교적 완전한 나무널〔木棺〕이 출토되어 국립박물관에 보존되어 있었는데, 6·25전쟁 중 파손되었다.',NULL,null,'http://www.iksan.go.kr/tour',null,'전라북도 익산시 석왕동',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','왕궁리 오층석탑','* 고려 전기의 석탑, 왕궁리 5층석탑(국보) *

1997년 1월 1일 국보로 지정된 석탑이다. 마한시대 도읍지로 알려진 전라북도 익산시 왕궁면에서 남쪽으로 2㎞쯤 떨어진 곳에 있는 석탑이다. 1기단 위로 5층의 탑신(塔身)을 올린 모습으로, 기단부가 파묻혀 있던 것을 1965년 해체·수리하여 원래의 모습으로 복원했다. 1965년 해체·수리하면서 탑의 1층 지붕돌 가운데와 탑의 중심기둥을 받치는 주춧돌에서 사리장치가 발견되었다. 이때 발견된 고려시대 유물은 국보로 지정되어 국립중앙박물관에 보관하고 있다. 석탑의 정확한 유래는 전해지지 않지만 탑주변에서 ""왕궁사"" ""대관"" 등의 명문기와가 수습되어 궁성과 관련된 사찰이 건립되는 과정에서 축조된 것으로 보는 견해가 있다. 또, 탑 해체 복원시 제1층 옥개석 중앙과 기단부에서 금제 금판경과 사리함, 청동불상 등이 수습되어 국보로 지정되었는데, 이들 유물이 ""관세음 음험기""에 나오는 제석사지 칠층목탑 내의 유물과 같은 종류이어서 제석사지 목탑과 관련되어 건립된 것으로 보는 견해도 있다. 특징으로는 백제 석탑양식을 충실히 따른 통일신라 말 또는 고려 초기의 석탑이며, 석탑 하부에서 백제시대 판축이 확인되어 백제 시대 목탑 또는 건물지가 있던 것으로 판단된다.',NULL,null,'http://www.iksan.go.kr/tour','주차가능','전라북도 익산시 왕궁면 왕궁리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','익산 왕궁리유적 [유네스코 세계유산]','* 왕궁리성지라 불리우는, 왕궁리유적 *
1998년 9월 17일 사적으로 지정된 유적으로 면적은 21만 6,862㎡에 이른다. ‘왕궁리성지’라고도 부르며 마한·도읍지설, 백제 무왕의 천도설이나 별도설, 안승의 보덕국설, 후백제 견훤의 도읍설이 전해지는 유적이다. 발굴조사한 결과, 이 유적은 적어도 세 시기(백제 후기∼통일신라 후기)를 지나면서 만들어진 것으로 생각하고 있다. 석탑 동쪽으로 30m 지점에서 통일신라시대 것으로 보이는 기와 가마 2기를 발견했다. 특히, 탑을 에워싼 주변의 구릉지를 중심으로 직사각형 모양의 평지성으로 생각되는 성곽 유물을 찾았다.성곽의 모습은 현재 발굴을 통해 점점 드러나고 있다. 또한 성곽 안팎으로 폭이 약 1m 정도로 평평한 돌을 깔아 만든 시설이 발견되어 성곽 연구에 좋은 자료가 되고 있다.이 지역 안에 있는 왕궁리 5층석탑(국보)과 절터의 배치를 알 수 있게 하는 유물, 바깥쪽을 둘러싸고 있는 직사각형의 성이 발견되어, 백제 후기의 익산 천도설이나 별도설을 뒷받침하는 중요한 유적으로 떠오르고 있다.',NULL,'09:00~18:00','http://www.iksan.go.kr/tour','주차가능','전라북도 익산시 왕궁면 궁성로 666',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','익산 구 익옥수리조합 사무실 및 창고','* 익산 구 익옥수리조합 사무실 및 창고 *

익산 구 익옥수리조합 사무실 및 창고는 2005년에 등록문화재로 지정되었다. 1930년에 익옥수리조합 사무소 건물로 지어져 1996년까지 전북농지개량조합의 청사로 사용된 건물이다. 정면 중앙의 출입구와 그 위쪽 창호 부분은 테두리에 꽃잎 무늬 형상의 인조석으로 치장하여 붉은 벽돌과 대비를 이룬다. 외벽의 독특한 장식적 조적수법 및 맨사드 지붕의 목조트러스 가구법에서 수준 높은 건축기법을 보여주고 있어 건축의장 및 기술사적으로 매우 가치가 있는 건물이다. 바닥 콘크리트에 대한 공사기록이 ‘조선과 건축’지(1922-45)에까지 실렸다고 전하며 외관의 원형도 잘 남아 있다. 철근콘크리트조에 목조트러스의 구조로 되어 있다.

이 건물은 일본인 농장 지주들이 쌀 생산량을 늘리고자 창설한 익옥수리조합의 사무소이다. 토지 개량과 수리 사업을 명분으로 설립되어, 과다한 공사비와 수세(水稅)를 부담시켜 지역 농민을 몰락시키는 등 일제에 의한 우리나라 근대 농업 수탈의 역사를 증언하고 있다. 농업 수탈의 아픈 역사를 간직한 익옥수리조합 사무실 및 창고 외벽은 붉은 벽돌로 되어 있으며, 창문과 창문 사이에 벽돌로 치장쌓기를 한 것이라든지, 테두리보의 벽면도 붉은 벽돌로 쌓은 것 등은 현재 건축기법과 다른 것을 알 수 있다. 지붕에는 환기통이 있고, 빗물이 들어가지 못하도록 나무로 경사진 그레이팅을 만들어 놓았다. 테두리보를 장식한 원형의 꽃받침 무늬는 정교하면서도 일정하게 되어 보는 이를 감탄하게 한다.',NULL,'09:00~18:00','http://www.iksan.go.kr/tour','주차가능','전라북도 익산시 평동로1길 28-4',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','춘포역사','* 등록문화재 익산 춘포역사 *

익산 춘포역사는 전라북도 익산시 춘포면 덕실리에 있는 역사 건물이다. 이곳은 2005년 11월 11일에 등록문화재로 지정되었다. 한국철도공사 소유이다. 익산 춘포역사는 1914년에 지은 한국에서 가장 오래된 역사로 슬레이트를 얹은 박공지붕의 목조 구조 건물이다. 춘포역은 처음에는 대장역(大場驛)이라는 이름으로 익산(당시 이리)과 전주를 연결하는 전라선의 보통역으로 시작하였다. 당시 이 근처에 일본인 농장이 설립되면서 형성된 ‘대장촌’이라는 일본인 이민촌이 있었기 때문에 일본인들이 많이 이용했던 역사 가운데 하나이다. 대장이란 말이 생겨난 것은 일제강점기로, 일본사람들이 들이 넓다고 큰 대(大), 마당 장(場)자를 써서 대장촌이라고 했다. 이후 1996년에 춘포역으로 이름을 바꾸고 1997년에 역원배치 간이역으로 격하되어 지금까지 삼례역에서 관리하고 있다.

광장 쪽 출입구 위에는 캐노피, 철로변에는 직교형 박공지붕이 돌출되는 등 군산 임피역사와 함께 일제강점기 당시 전형적인 소규모 철도 역사의 모습을 잘 보여주는 건물로 평가받고 있으며 건축적, 철도사적 가치가 있다.철로 위의 추억을 간직하며 역사의 뒤안길로 사라진 춘포역사 전라선에 있는 한적한 마을의 춘포역사. 역사의 뒤안길로 사라져 철도의 기능이 사라져버렸지만, 지금은 문화재로서의 가치를 인정받은 철도역사이다. 춘포역사는 일제강점기의 아픈 역사를 온몸으로 보여주는 것으로 이곳에서 생산된 쌀을 군산으로 실어 나르고, 농사를 짓기 위한 물자가 역을 통해 들어 왔다. 화려했던 과거였지만 지금은 역의 기능이 사라져 버렸다.',NULL,'09:00~18:00','http://www.iksan.go.kr/tour','주차가능','전라북도 익산시 춘포면 춘포1길 17-1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','변산해수욕장','서해안의 대표적인 해수욕장이다. 하얀 모래와 푸른 솔숲이 어우러졌다 하여 ''백사청송''해수욕장으로도 불린다. 또한 우리나라에서 가장 오래된 해수욕장의 하나로 1933년에 개장되었다. 곱디 고운 모래해변이 끝없이 펼쳐져 있으며 서해안의 해수욕장치고는 물빛도 맑은 편이다. 더욱이 평균수심이 1m밖에 되지 않고 수온이 따뜻해서 해수욕장 조건이 아주 좋다.',NULL,'00:00~24:00','http://www.buan.go.kr/tour/index.buan','주차가능','전라북도 부안군 변산면 변산로 2076',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','고사포해수욕장','부안군 변산면 운산리에 있는 해수욕장으로 약 2km에 이르는 백사장과 방풍림으로 심어 놓은 송림이 장관을 이룬다. 일대의 해수욕장 중에서 가장 맑고 깨끗하며 모래도 곱고 부드럽다. 해수욕장 앞에는 웅크리고 있는 새우모습을 닮은 하섬(蝦島)이 있는데 매월 음력 보름과 그믐쯤에는 모세의 기적처럼 2km의 바닷길이 열리는 체험도 즐길 수 있다.',NULL,'연중무휴','http://www.buan.go.kr/tour','주차가능','전라북도 부안군 변산면 노루목길 8-8',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','채석강 (전북 서해안 국가지질공원)','약 7,000천만 년 전 중생대 백악기부터 바닷물의 침식을 받으면서 쌓인 이 퇴적암은 격포리층으로 역암 위에 역암과 사암, 사암과 이암의 교대층, 셰일, 화산회로 이루어졌다. 이런 퇴적 환경은 과거 이곳이 깊은 호수였고, 호수 밑바닥에 화산분출물이 퇴적되었다는 것을 짐작해 볼 수 있다. 또 이 절벽에서 단층과 습곡, 관입구조, 파식대 등도 쉽게 관찰할 수 있어 지형과 지질학습에 좋다. 파도의 침식작용으로 만들어진 해식애, 평평한 파식대, 해식동굴도 발달했다. 채석강 바닥에는 지각과 파도의 합작품인 돌개구멍이 발달했는데, 밀물 때 들어온 바닷물이 고여서 생긴 조수웅덩이도 곳곳에 있다.',NULL,'연중무휴','http://www.jwcgeopark.kr','주차가능','전라북도 부안군 변산면 변산해변로 1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','상록해수욕장','상록해수욕장은 격포항 남쪽의 변산면 도청리 두포부락 앞에 위치한다. 1988년 7월에 개장한 이 해수욕장은, 공무원복지증진을 위하여 공무원연금관리공단에서 휴양장소로 선정 개발운영하고 있다.이곳은 주변경관이 좋고 수심이 앝으며 물이 깨끗하고 해송 및 모래사장이 좋아 해수욕장으로서의 천혜의 조건을 갖추었다. 이곳을 상록해수욕장이라 명명한 것은 선정(善政)공무원의 표상이 상록수이기 때문이다.',NULL,'연중무휴','https://www.buan.go.kr/tour/index.buan','주차가능','전라북도 부안군 변산면 변산로 3210-16',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','곰소항','곰소항은 부안에서 24km지점에 위치한 진서면 진서리 일대에 위치하고 있다. 이 항구는 왜정말엽 우리 한민족에게서 착취한 농산물과 군수물자를 반출하기 위하여 항만을 구축하고자 도로, 제방을 축조하여 현재의 곰소가 육지가 되면서 만들어진 항구이다.(작도와 웅도를 막아서 내륙이 된 곳)

이 항구는 1986년 3월 1일 제2종 어항으로 지정되어 물량장 및 부대시설을 갖추어 150척의 배를 수용할 수 있는 규모로 하루에 130여척의 어선들이 드나드는 항구로 주변에 소규모 상가와 마을을 끼고 있으며 더 나아가 염전을 두고 있는 등 항구로서의 면모를 갖추고 있다.

곰소항은 줄포항이 토사로 인해 수심이 점점 낮아지자 그 대안으로 일제가 제방을 축조하여 만들었다. 목적은 이 지역에서 수탈한 각종 농산물과 군수물자 등을 일본으로 반출하기 위해서였다. 진서에는 항구 북쪽에 8ha에 달하는 드넓은 염전이 있어 소금 생산지로도 유명하지만, 근해에서 나는 싱싱한 어패류를 재료로 각종 젓갈을 생산하는 대규모 젓갈 단지가 조성돼 있어 주말이면 젓갈 쇼핑을 겸한 관광객들로 붐비는 곳이다.',NULL,'연중무휴','https://www.buan.go.kr/tour','주차가능','전라북도 부안군 진서면 곰소리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','우화정(내장산)','정자에 날개가 돋아 승천하였다하는 전설이 있어 우화정이라 부르며 거울같이 맑은 호수에 붉게 물들은 단풍이 비치는 경관은 한폭의 수채화 같다. 호수주변에는 당단풍, 수양버들, 두릅나무, 산벚, 개나리, 산수유 등이 둘러싸여 장관을 이루고 있다.',NULL,'연중무휴','http://naejang.knps.or.kr','주차가능','전라북도 정읍시 내장산로 936',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','내장산 단풍생태공원','내장산국립공원과 정읍시가 공동으로 조성한 공원시설로 내장호 인근에 위치해 있으며 넓이는 69,000여㎡로 내장호 체험학습관과 조류관찰대, 멸종위기 식물원, 생태습지, 세계단풍원, 단풍분재원, 단풍전통차길, 체육시설등이 조성되어 있다. 정읍시민과 탐방객은 누구가 이용할 수 있고 잔디광장 경관이 좋고 편리한 공간은 야외 결혼식장이나 각종 문화행사장으로 활용되고 있다.',NULL,'연중무휴','http://naejang.knps.or.kr','주차가능','전북 정읍시 내장동 560',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','전설의 쌍화차 거리','정읍 도심에 자리잡은 쌍화차 거리는 정읍경찰서에서 정읍세무서까지 이어지는 새암로에 있다. 이 거리에 특화된 쌍화탕은 넉넉한 한약재에 밤, 대추, 견과류를 넣어 만든 제대로 된 전통 한방탕이다. 쌍화차 거리에는 30년을 훌쩍 넘긴 쌍화탕 찻집이 아직도 건재하고, 크고 작은 쌍화탕 찻집이 10여 곳이나 성업 중이다. 소박하고 편안한 분위기가 그대로 남아 있는 골목길에 옹기종기 자리한 찻집들을 기웃거리다 보면 특유의 쌍화탕 향기가 발길을 잡는 곳이다.',NULL,'각 찻집마다 다름',null,null,'전라북도 정읍시 중앙1길 147',sysdate, 0, 0);

--충청남도
insert into item values(item_seq.nextval, 1, '관광지','당진항만관광공사 (삽교호 함상공원)','대양을 호령하던 우리의 자랑스런 군함이 명예로운 퇴역과 함께 삽교호 함상공원에 해군과 해병의 역사와 문화를 체험 할 수 있는 이색적인 공간이 조성되었다. 해군·해병의 주제별 전시관, 함정 내·외부, 항공기 등이 전시되어 자라나는 어린이들에게 바다에 대한 동경과 해군·해병의 친밀감을 느끼게 하고 있으며, 3D 영상관, 게임센터, 카니발프라자, 실내위락시설 등은 잠시나마 모든 것을 잊고 재미있는 동심의 세계로 빠져들어 즐거움을 만끽할 수 있다. 또한 삽교호 함상공원만의 색다른 휴식공간인 함상카페는 삶에 즐거움과 풍요로움을 주고 있다.',NULL,'09:00~19:00','http://www.dpto.or.kr','주차가능','충청남도 당진시 신평면 삽교천3길 79',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','아그로랜드 태신목장','푸른 초원에서 느낄 수 있는 목가적인 풍경과 소와 함께하는 체험의 장을 제공한다. 체험실에서 소젖을 직접 짜 볼 수 있고, 푸른 초원에 나가 직접 소에게 풀과 사료를 먹이고, 우유를 이용하여 아이스크림, 팥빙수 등을 만들어 보는 등 다양한 낙농 체험을 할 수 있다.',NULL,'10:00~18:00','http://www.agroland.co.kr/','주차가능','충청남도 예산군 고덕면 상몽2길 231',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','푸레기마을','* 약쑥의 향기에 취하다, 푸레기마을 *

충남 당진시 석문면 초락1로에 위치한 푸레기마을은 몸에 좋은 약쑥을 테마로 다양한 체험을 할 수 있는 마을이다. 원래는 섬이었으나 석문방조제와 대호방조제가 만들어지면서 육지와 연결되어 바다와 들녘을 골고루 즐길 수 있다. 마을에서 재배하는 약쑥을 직접 베고, 쑥환을 만들어보는 독특한 체험도 가능하다. 쑥이 나지 않는 계절에는 바지락캐기, 굴따기, 미역따기 등 갯벌체험을 할 수 있다. 감자캐기, 고구마캐기 등 농사체험과 두부만들기 등 전통음식 만들기도 진행한다. 마을에서 직접 운영하는 황토약쑥찜질방도 인기다.',NULL,'10:00~18:00','http://www.041-353-5008.ezbuilder.co.kr/','주차가능','충청남도 당진시 석문면 초락1로 147',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','슬로시티','충남 예산군 대흥면 중리길 49에는 충남의 보물 같은 마을이 자리했다. 슬로시티답게 자연과 역사, 문화와 전통을 고루 갖춘 동네다. 봉수산 정상에서 예당호까지 이어지는 낱낱의 풍경은 그 증거처럼 존재한다. 보고 느끼고 누릴 수 있는 요소도 많다. 달팽이체험학교는 누구나 참여할 수 있는 느린 체험 프로그램이다. 백제 부흥군도 되어보고, 숲의 정취에도 젖어보고, 슬로시티 대흥마을의 가치도 확인할 수 있다.
그 사이사이로 난 느린 꼬부랑길은 프로그램에 구애받지 않고 편히 즐길 수 있는 마을 산책로다. 3개의 코스로 나뉘는데 5.1km의 옛이야기길은 90분, 4.6km의 느림길은 60분, 3.3km의 사랑길은 50분이 걸린다. 무엇보다 곳곳에 의좋은 형제 이야기가 살아 숨쉰다. 서로의 곳간으로 밤새 볏단을 날랐다는 이성만과 이순 형제 이야기는 전설이 아닌 대흥마을에 전해오는 실화다. 대흥마을만이 전할 수 있는 감동이 서렸다.',NULL,null,'http://www.slowcitydh.com',null,'충청남도 예산군 대흥면 중리길 49',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','봉수산 자연휴양림','충청남도 예산군 대흥면 상중리 산11-1번지외3필지 예산군청 예산 대흥 봉수산 자연휴양림은 2007년에 개장해 다양한 산림휴양시설을 갖추고 있으며, 천연림과 인공림이 조화를 이룬 절경에 각종 야생조수가 서식하고 있는 곳으로 알려져 있고, 예당저수지(330만평)와 어울어진 사시사철 경관이 가히 내방객의 눈과 마음을 사로잡는데 부족함이 없다. 또한 휴양림내 등산코스는 1시간부터 3시간 코스까지 다양하고, 등산로는 비교적 완만하여 가족 및 동호회 단위의 등산객이 증가하고 있으며, 휴양림내 산림욕은 상쾌한 솔내음을 온몸으로 만끽할 수 있고, 아름다운 숲사이에 숲속의 집과 광장, 산책로, 숲체험장등 각종 편의ㆍ휴식시설이 잘 갖춰져 자연이 숨쉬는 숲의 공간으로 가족과 단체등의 휴식처가 되고 있다. 아울러, 휴양림 인근에는 전국제일의 낚시터인 예당저수지와 의좋은 형제공원, 대흥동헌, 대련사, 임존성 및 덕산온천, 천년고찰 수덕사, 충의사, 추사고택, 고건축박물관등 교육ㆍ문화탐방과 휴양을 동시에 체험하실 수 있는 유일한 자연휴양림이다.',NULL,'당일 15:00~익일 12:00','https://www.foresttrip.go.kr/indvz/main.do?hmpgId=ID02030028','주차가능','충청남도 예산군 대흥면 임존성길 153',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','광시 한우거리','* 한우 맛의 진수, 광시한우거리 *

충남 예산군 광시면 광시소길에 들어서면 한우 고깃집들이 즐비하다. 300m 도로변에 약 30개의 고깃집이 있는데 대부분 식당과 정육점을 겸한다. 바로 대흥슬로시티마을에서 남쪽으로 7km 떨어진 광시한우거리다. 30여 년 전부터 고깃집이 하나둘 생겨났는데 이제는 전국 각지에서 찾아든다. 직접 도축을 하거나 인근에서 한우 암소를 가져오기 때문에 육질이 좋고 신선해 믿을 만하다. 생등심에서 특수부위, 육회, 소고기버섯전골 등을 맛볼 수 있다.',NULL,null,'http://www.yesan.go.kr/tour/','주차가능','충청남도 예산군 광시면',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','한국고건축박물관','전국에 산재된 국,보물급 고건축문화재를 1/10, 1/5로 축소 전시하여 한국건축 발달사를 한자리에서 견학, 연구, 계승 발전시키는데 목적이 있으면 선조들의 정신문화를 고취시키고 후학들에게 우리 건축문화교육의 장으로 활용하기 위해 설립되었다.',NULL,'09:00~18:00','https://www.yesan.go.kr/tour.do','주차가능','충청남도 예산군 덕산면 홍덕서로 543',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','충의사 (매헌 윤봉길 의사 유적)','예산에서 북서쪽 23km 지점에 위치한 충의사는 일제강점기 독립 투사인 윤봉길의사가 태어나 망명길에 오르기까지 농촌계몽과 애국정신을 고취한 곳으로, 윤의사의 의거와 애국 충정을 기리기 위하여 1968년에 건립되었다. 매년 4월 29일에는 윤의사의 애국충정을 기념하는 매헌 문화제가 열리며 윤의사의 귀중한 유품은 기념관에 전시되어 보물로 보호되고 있다.',NULL,'09:00~18:00','http://www.yesan.go.kr/tour/','주차가능','충청남도 예산군 덕산면 덕산온천로 183-5',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','예당저수지(예당관광지)','조선 후기의 실학자 이중환은 택리지에서 내포 땅이 충청도에서 가장 살기 좋은 곳이라고 썼다. 내포 땅이 바로 지금의 예산이다. 예당관광지는 현재 국민관광지 지정 면적 5만 6천 평 중 1만 3천 평이 조성되었다. 주요 시설은 식당, 여관, 각종 편의시설 등 대중이 이용할 수 있는 것들이며 현재까지 등산로와 주차장 시설 등 6개 시설은 조성 완료, 테마를 간직한 관광지로 변모해가고 있다. 특히 예당 저수지 주변의 산책로와 팔각정은 부산 태종대 같은 운치를 느낄 수 있도록 조성하였으며 가족단위 산책과 친구, 연인과 함께 찾아가기에 좋다.하절기에는 인근 지역 주민과 사시사철 낚시객의 명소로 활용되고 있으며 찾는 이로 하여금 호평과 함께 관광명소로 거듭나고 있다.

예당관광지는 예산군 응봉면 등촌리, 후사리 일원의 4만3천평 규모에 1986년부터 조성하기 시작되었다. 현재 공공편익시설인 주차장, 야영장, 잔디광장, 산책로등 부대시설이 다양하게 조성되어 있으며 전국 제일의 저수지인 예당저수지와 접해있어 친환경적인 관광지로 개발되고있다.

* 낚시 - 1962년에 만들어진 우리나라에서 가장 큰 저수지인 예당 저수지는 예산군과 당진시의 농경지에 물을 공급한다 하여 예산군과 당진시의 앞머리를 따서 이름을 지었다. 지난 40여 년 동안 중부권 최고의 낚시터로 알려져 있다. 겨울철 얼음낚시 외에 초봄부터 늦가을까지 계속 낚시할 수 있다. 주로 붕어, 잉어를 비롯해 뱀장어, 가물치, 동자개, 미꾸라지 등 민물에 사는 물고기 대부분이 있다.',NULL,'09:00~18:00','www.yesan.go.kr/tour/index.do','주차가능','충청남도 예산군 광시면 장전리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','청라 은행마을 (보령)','청라 은행마을에는 약 3천 여 그루의 토종 은행나무가 식재 되어 있어 가을이 되면 온 마을이 황금색으로 물드는 국내 최대의 은행나무 군락지이다. 청라 은행마을에는 이 은행나무들에 대한 전설이 전해지고 있는데 옛날 장현리 뒷산에는 까마귀가 많이 살아 오서산이라 불렸던 산이 있으며, 산 아래 작은 못 옆에는 누런 구렁이 한 마리가 살았다고 한다. 이 누런 구렁이는 천년 동안 매일 용이 되게 해달라고 기도 하여 마침내 황룡이 되어 여의주를 물고 승천 하였다. 이를 본 까마귀들이 노란색 은행을 보고 황룡의 여의주라 생각 하여 마을로 물고와 키우면서 마을에 수많은 은행나무가 자라게 되었다고 한다. 매해 10월 말에서 11월 초에는 청라 은행마을 축제가 열리며 이 기간 동안에는 은행마을, 돌아보기, 은행털기 등 다채로운 체험을 즐길 수 있다. 축제 기간이 아니더라도 사계절 별로 체험할 수 있는 녹색농촌체험이 준비 되어 있고, 마을에는 오토캠핑장이 마련 되어 있다.',NULL,null,'https://ginkgotown.modoo.at/',null,'충청남도 보령시 청라면 오서산길 150-65',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','신경섭 전통가옥','조선후기(朝鮮後期) 한식가옥(韓式家屋)이며 큰 부재(部材)를 사용 하여 당시 부호(富戶)의 사랑채로 전한다. 사랑채 회첨부(會첨部) 중간(中間)에 마루를 두어 대청(大廳)으로 사용하였고, 전면 벽체에 화방벽(花枋壁)을 설치(設置) 하였고, 목재(木材)의 결(結)과 고색단청(古色丹靑)이 지금까지 변함이 없는 것을 보아 보존이 잘되고 있다. 대문채는 우진각지붕으로, 신석붕의 효자문(孝子門)을 세워 특징적이다. 1998년 국고보조, 사랑채 산자이상 번와보수 하였다. 신경섭가옥은 팔작(八作)지붕으로 ㄱ자형의 가옥이다. 중간에 대칭을 설치하였으며, 앞에는 툇마루를 놓았다. 좌측끝에는 부엌을 두고, 부엌 위에 다락을 만들었다. 조선시대후기의 목조기와 형태의 가옥으로 문간채에 문중의 효자 신석붕 정려문이 있다.',NULL,null,'http://www.brcn.go.kr/tour.do',null,'충청남도 보령시 청라면 장밭길 62',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','오서산','충남 제 3의 고봉인 오서산(790.7m)은 천수만 일대를 항해하는 배들에게 나침반 혹은 등대 구실을 하기에 예로부터 ''서해의 등대산''으로 불려왔다. 정상을 중심으로 약 2km의 주능선은 온통 억새밭으로 이루어져 억새산행지의 명소이기도 하다.
또, 오서산은 장항선 광천역에서 불과 4km의 거리에 위치, 열차를 이용한 산행 대상지로도 인기가 높다. 오서산은 까마귀와 까치들이 많이 서식해 산이름도 ""까마귀 보금자리""로 불리어 왔으며 차령산맥이 서쪽으로 달려간 금북정맥의 최고봉. 그 안에 명찰인 정암사가 자리하고 있어 참배객이 끊이지 않는다.
한편 산 아래로는 질펀한 해안평야와 푸른 서해바다가 한 눈에 들어와 언제나 한적하고 조용한 분위기를 느낄 수 있다. 특히, 오서산 등산의 최고 백미는 7부 능선안부터 서해바다를 조망하는 상쾌함과 후련함이다. 정암사에서 정상까지 구간은 가파르면서 군데군데 바윗길이 자리해 약 1시간동안 산행 기분을 제대로 만끽할 수 있어 동호인들이나 가족등반객들에게 인기가 높다. 산 정상에서는 수채화처럼 펼쳐진 서해의 망망대해 수평선과 섬자락들을 관망할 수 있다. 정암사는 고려때 대운대사가 창건한 고찰로 주변은 온통 수백년생 느티나무가 숲을 이루고 있다.',NULL,'00:00~24:00','http://www.brcn.go.kr','주차가능','충청남도 보령시 청소면 성연리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','백사장해수욕장','안면도 연육교를 지나 4km쯤 남서쪽으로 내려가면 백사장포구에 이르는데 이 포구의 인근에 흰 모래밭의 백사장해변이 있다. 해변은 은빛 모래로 끝없이 길게 뻗어있어 썰물 때면 수평선으로 변하며, 간만의 차가 심하나 안전하고 수온이 알맞아 늦은 여름까지 해수욕을 즐길 수 있다. 해변 길이는 1.2km, 폭은 300m 정도이며 고운 규사모래로 되어 있다. 예전엔 이 곳 위쪽의 판목나루터와 아래쪽 백사장 나루터를 연결하는 나룻배가 있었으나, 1970년 안면도를 잇는 연육교가 생기면서 자연적으로 자취를 감추고 말았다. 삼봉해변과 한 모퉁이 사이로 자연산 대하(왕새우)가 아주 유명하여 가을이면 전국에서 대하를 먹고자 하는 사람들로 북적인다. 가을 대하철이면 대하축제가 열릴 만큼 많은 대하가 나오며, 갓 잡아 올린 싱싱한 대하를 먹을 수 있는 곳이다.',NULL,'00:00~24:00','http://taean.go.kr/tour.do','주차가능','충청남도 태안군 안면읍 창기리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','삼봉해수욕장','태안군 남면과 안면읍을 연결하는 연육교 남쪽 3km 거리에 있으며 백사장의 길이는 3.8km, 폭 300m, 경사도 6도, 평균수심 1.5m, 수온은 섭씨 22도이다. 세 개의 튀어나온 삼봉괴암과 해당화가 유명하고, 울창한 솔숲이 특히 인상적이다. 또한 비교적 교통이 편리하여 여름철에는 많은 사람들이 찾고 있다.',NULL,'00:00~24:00','http://taean.go.kr/tour.do','주차가능','충청남도 태안군 안면읍',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','기지포해수욕장','기지포해변은 태안반도에 있는 크고 작은 다른 해수욕장과 같이 여름 한낮의 폭염을 피할 수 있는 울창한 송림과 경사가 완만한 깨끗한 백사장이 일품이며, 가족단위 여행객들의 하계휴양지로 좋은 지역이다. 인근 마을에서 운영하고 있는 10여개의 민박집에선 고향의 정을 물씬 느낄 수 있으며, 소나무숲 사이는 텐트를 치기에 적합하다. 수질이 깨끗하고 청결하며 해수욕장 길이는 0.8km, 폭은 200m 정도이며 규사모래로 되어있다. 해질 무렵에 바라보는 풍경은 망망대해 위에 내파수도, 나치도, 토끼섬 등 알알이 박힌 수 많은 섬들과 낙조가 어울어져 한 폭의 그림을 연상케 한다.',NULL,'00:00~24:00','http://taean.go.kr/tour.do','주차가능','충청남도 태안군 안면읍 해안관광로 745-19',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','안면해수욕장','태안반도 남부권에 위치한 섬 아닌 섬 안면도의 연육교를 지나 10여분 더 달리다보면 안면해변의 안내판과 마주하게 된다. 여기서 5분 정도 소나무숲 사이를 자동차로 달리면 넓은 백사장의 안면해변에 다다르게 되는데, 도착하기까지는 주변이 산과 논으로 이루어져 이 곳이 바닷가라는 말을 의심케 하나 일단 도착하고 나면 바로 눈앞에 펼쳐진 넓은 백사장과 바다, 바다 위의 섬들이 일대 장관을 이룬다. 주변에 갯바위낚시를 즐길 만한 장소가 충분하며, 바닷물이 많이 빠지는 사리때가 되면 해변에서 잡을거리가 풍성해진다.',NULL,'00:00~24:00','http://taean.go.kr/tour.do','주차가능','충청남도 태안군 안면읍 정당리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','두여해수욕장','지리적 형상이 좋고 나무가 우거져 도인들이 도를 닦던 마을이라 하여 도여라 불렀으며 현재는 두여라 불려지고 있다. 울창한 송림 앞에는 충청남도로부터 민박마을 제30호로 지정될 만큼 수많은 민박업소가 즐비하며, 넓고 고운 백사장과 왼쪽엔 종주려라는 바위섬이 있어 천혜의 해변이다. 특히 경사가 완만하여 수영하기에 안전하고 수온이 높아 늦은 여름까지 해수욕이 가능하다.',NULL,'00:00~24:00','http://taean.go.kr/tour.do','주차가능','충청남도 태안군 안면읍 정당리 1313-1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','밧개해수욕장','안면도 연육교에서 자동차로 10여 분 정도 달리다 보면 아름다운 서해의 해변 중 하나인 밧개해변이 나타난다. 잘 알려지지 않은 해변치고는 큰 편이며 수질이 매우 양호하고 해변이 완만하여 해수욕을 즐기기에 적합하다. 해수욕장 길이는 3.4km, 폭은 250m 해변 형태는 규사모래로 되어 있다.해변 주위에 모래언덕이 궁형을 이루고 있어 어패류 및 해초 등이 서식하여 어린이들의 바다학습 체험장으로 제격이다. 진입로 주변에는 민박집들이 즐비하고 민박업소와 해변 사이로 소나무숲이 이루어져 있어 해변을 마주 보며, 안전하고 시원한 야영을 즐길 수 있다. 주변에 다양한 해변들이 있어 이곳 저곳을 병행하며 해수욕을 즐길 수 있다.',NULL,'00:00~24:00','http://taean.go.kr/tour.do','주차가능','충청남도 태안군 안면읍 승언리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','방포해수욕장','태안읍에서 남쪽으로 36km 정도 떨어진 해수욕장으로 모래밭 길이 700m, 폭 250m, 면적 14ha, 경사도 3도, 평균수심 1.2m, 수온 섭씨 22도로 모래질이 좋고 야영하기에 좋다. 조용한 가족휴양지로 최적이며, 또한 해수욕장 양쪽에 할미바위와 할아비바위 등 전설이 담긴 기봉이 있으며, 천연기념물로 지정된 ''모감주나무'' 군락지가 있는 지역이다. 또한 서남쪽으로는 천연적인 방파제가 있는 ''내파수도''와 ''외파수도''가 있다.

방포포구에는 가오리, 붕장어, 우럭, 고등어 등의 생선들이 많이 잡혀 싱싱한 회로 유명하며 이웃에는 꽃지, 삼봉 등의 여러 해수욕장들이 있다. 또한 인근에는 안면도자연휴양림이 있어 중부해안지역의 자연수종 등 208종을 소유하고 있는 수목원과 산림전시관, 체력단련장, 전망대 및 산책로 등이 있어 가족휴양 및 심신단련 장소로 적합하다.',NULL,'00:00~24:00','http://taean.go.kr/tour.do','주차가능','충청남도 태안군 안면읍 방포1길 29-1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','꽃지해수욕장','충남 태안군 안면읍 광지길에 자리한 꽃지해변은 5km에 이르는 백사장과 할배바위, 할매바위가 어우러져 그림 같은 풍광을 보여준다. 2개의 바위 너머로 붉게 물드는 낙조는 태안을 상징하는 아름다운 풍광 중 으뜸으로 꼽힌다. 예부터 백사장을 따라 해당화가 지천으로 피어나 ‘꽃지’라는 어여쁜 이름을 얻었다. 긴 백사장을 따라 걷거나 밀려오는 파도를 바라보며 데이트를 즐기는 연인과 가족의 모습도 꽃지해변의 풍경이 된다.꽃지해변을 상징하는 두 바위에는 슬픈 전설이 깃들어 있다. 신라시대 해상왕 장보고가 안면도에 기지를 두었는데, 기지사령관이었던 승언과 아내 미도의 금슬이 좋았다. 그러나 출정 나간 승언은 돌아오지 않았고, 바다만 바라보며 남편을 기다리던 미도는 죽어서 할매바위가 되었다. 할매바위보다 조금 더 바다 쪽으로 나간 곳에 있는 큰 바위는 자연스레 할배바위가 되었다는 이야기다. 바다로 나간 남편을 맞이하듯 마주선 두 바위가 애틋해 보인다. 썰물 때면 두 바위가 마치 한 몸인 듯 모래톱으로 연결되는 모습을 볼 수 있다. 한여름뿐 아니라 사계절 여행자들의 발길이 끊이지 않는 것은 바위와 어우러진 낙조 때문이다. 해질 무렵이면 할매바위, 할배바위 너머로 아름답게 물드는 일몰 풍경을 카메라에 담으려고 많은 사람들이 모여들어 진풍경을 펼친다.',NULL,'00:00~24:00','http://taean.go.kr/tour.do','주차가능','충청남도 태안군 안면읍 승언리',sysdate, 0, 0);

--충청북도
insert into item values(item_seq.nextval, 1, '관광지','미륵대원지','미륵사지는 충북과 경북을 연결하고 있는 하늘재 사이의 분지에 남죽향으로 펼쳐져 있다. 미륵리 사지(彌勒里寺址)는 신라의 마지막 왕자인 마의태자가 금강산으로 가던 중 꿈에 관세음보살로부터 석불을 세우라는 계시를 받고 하늘재를 넘자마자 지세를 확인하고는 지금의 미륵리에 석불을 세워 절을 만들었다고 한다. 충주 미륵사지는 청주대학에서 1977년에서 1978년의 제2차 발굴조사를 통해 절의 명칭이 미륵대원사이었음이 밝혔고, 1980년에 이화여대에서 3차 발굴을 통해 여기에 일찍이 석굴사원이 경영되다가 소실되어 현재의 석조물만 남았다는 것을 밝혔다. 삼국사기, 신라본기, 아달라이사금 3년(156) 기록에 의하면 “4월에 계립령 길을 열었다”라고 되어 있다. 이를 통해 신라가 백제, 고구려와 교류하게 되었으며, 장기적으로는 한강을 통해 삼국통일의 대업을 달성하게 된다.

* 미륵사지의 다양한 유물과 의의 *

미륵사지는 14,000평 정도의 직사각형 절터에 일탑일금당이 배치되었음이 밝혀졌다. 또한 미륵리사지 내에는 5층 석탑(보물)과 석불입상(보물)이 있고 지방 유형문화재인 석등과 3층석탑이 있다. 중원 미륵리 사지는 석조(石造)와 목구조(木構造)를 합성시킨 석굴사원(石窟寺院) 터로 석굴을 금당으로 삼은 북향의 특이한 형식을 취한 유일한 유적이다. 또한 미륵사지의 석불은 국내 유일의 북향 불상이며 석불이 있는 석굴 방형의 주실은 가로 9.8m, 세로 10.75m의 넓이이며 높이 6m의 석축을 큰 무사석으로 쌓아 올렸고 그 가운데 불상을 봉안하였다. 석축 위에는 지금은 없어진 목조 건물이 있었으며 전당은 목조로 된 반축조석굴이다.',NULL,null,'http://taean.go.kr/tour.do','주차가능','충청북도 충주시 수안보면 미륵리사지길 150',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','하늘재','* 하늘과 맞닿아 있는 곳, 하늘재 *
월악산 미륵리 3층석탑을 조금 지난 왼쪽으로 작은 오솔길이 하나 있다. 멀리 황장목(적송)과 떡갈나무, 해송 등의 운치있는 풍경을 마주하며, 청량한 하늘 아래 시원한 바람길이 열리는 이 길은 일명 하늘재, 길 왼편 아래로 나 있는 도랑은 가뭄탓에 때때로 말라버린 모습을 보이기도 하지만 주변의 기암절벽 산봉우리와 길가의 진분홍 물봉선, 짙은 자주빛의 수리취, 노란짚 신나물 등의 들꽃들이 여행객들을 반긴다.
얼핏보면 하늘과 맞닿아 있다고 해서 이름지어진 하늘재(해발 525m)는 이름처럼 높지는 않다. 충북 충주시 수안보면 미륵리와 경북 문경시 문경읍 관음리를 잇고 있는 도 경계로서 미륵리에서 30∼40분(2㎞) 정도 걸어 오르면 곧바로 문경 관음리로 연결된다. 울퉁불퉁한 비포장 길은 하늘재 고갯마루에 이르러 쭉 뻗은 아스팔트 길로 이어지는데 서쪽으로 문경 대미산(해발 1,115m) 정상이 아스라히 시야에 들어온다.
또한 하늘재 아래의 중원미륵리사는 신라 말∼고려 초에 창건된 것으로 보이는 옛절터로, 당간지주와 회랑 등의 흔적만으로도 그 규모가 매우 컸음을 짐작할 수 있다. 우리나라 사찰로는 유일하게 북쪽을 향하고 있으며 지릅재와 하늘재 사이의 분지인 미륵리에 터를 잡고 있다. 중원미륵리사의 목조건물은 13세기 몽고군의 침입으로 모두 소실되었고 현재는 5층 석탑(보물), 석불입상(보물)을 비롯해 석등(지방유형문화재), 3층석탑(지방문화재) 등이 남아있다. 중원미륵리사는 지난 1977년과 1979년 두 차례에 걸쳐 청주대학교 박물관의 발굴작업을 통해 일연스님이 거처했던 미륵대원으로 밝혀졌다.',NULL,'00:00~24:00','http://worak.knps.or.kr','주차가능','충청북도 충주시 수안보면 미륵송계로 614',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','수안보온천 관광특구','수안보온천 관광특구는 전통의 온천 휴양지다. 우리나라 최초의 자연 용출 온천수로서 3만 년 전부터 있었다고 전해지며 그 효능 역시 잘 알려져 있다. 지하 250m에서 용출되는 온천의 수온은 53℃로 약알칼리성이다. 충주시가 직접 관리하는 온천수에는 인체에 유익한 원적외선뿐 아니라 각종 광물질이 포함되어 있다. 그래서인지 예부터 수안보온천은 질병을 치료하고 휴양할 목적으로 많은 사람들이 찾아들었다. 수안보온천의 중심지에 물탕공원이 자리하고 있다.

공원에는 온천수가 흐르는 나지막한 물길이 있다. 온천 입욕을 즐기기 어렵다면 이곳에서 족욕을 즐겨보자. 날이 쌀쌀해지는 가을부터 봄까지 특히 인기다. 수안보온천을 이용하는 여행자들은 대부분 수안보온천 지역 내에 있는 호텔과 모텔 등의 숙박 시설을 이용하면서 온천욕을 즐긴다. 이 지역의 먹을거리로는 꿩 요리가 유명하다. 꿩 요리 전문점은 온천 지구 어디서나 쉽게 찾을 수 있다.수안보온천 관광특구는 충주시의 중심 시가지에서 문경으로 이어지는 국도 변에 위치한다. 한반도의 중심부에 있어 서울은 물론 기타 지방 도시에서도 접근이 쉽다. 인근에 월악산, 충주호, 송계계곡 등 둘러볼 만한 자연 자원이 많다. 등산 후 온천욕을 즐기기에도 그만이다.

* 수안보온천 관광특구 현황
1) 범위 : 충청북도 충주시 수안보면 온천리, 안보리 일원
2) 면적 : 9,216,210㎡
3) 관광특구 지정일 : 1997년 1월 18일',NULL,null,'http://www.suanbo.or.kr','각 호텔이나 모텔 주차장 이외에도 2~3개의 공용 주차장 이용 가능','충청북도 충주시 수안보면 주정산로 12',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','미동산수목원','미동산수목원은 충청북도 청주시에 있는 도립 수목원으로 선진 임업기술의 연구개발 및 보급, 생태교육 환경조성 등의 목적으로 2001년 5월 4일 개원하였으며 총면적은 94만 2000평이다. 다양한 유전자원을 수집 보전하여 식물유전자의 가치를 지속시키고 연구, 관리 전시함으로써 식물과 관련된 지식을 널리 알리고 건전한 산림환경 문화를 선도해 나가는 시설이다. 94만 1천평의 부지에 1996년부터 6년간 국고지원사업으로 60억 원을 투자 조성하여 우리지역의 정이품송 후계목 등 우수한 유전자원을 비롯하여 참나무원, 단풍나무원 등 11개원의 전문 수목원에 873종 652천 본의 식물이 식재되어 있다.',NULL,'09:00~18:00','http://www.cbforest.net','있음','충청북도 청주시 상당구 미원면 수목원길 51',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','문의문화재단지','문의문화재단지는 인류문명의 발달과 급속한 산업화에 따라 사라져 가고 있는 우리의 고유 전통문화를 재현하여, 조상들의 삶과 얼을 되살리고 배우기 위해 설립되었다. 4만여평의 규모의 부지 위에 지방유형문화재 제 49호인 문산관이 이전 복원되었으며 낭성면 광정리와 문의면 노현리, 부강면 부강리에서 민가가 이전되었으며 서길덕 효자각, 김선복 충신각 및 문의지역에 있던 옛 비석도 이전되어 있다. 문의문화재단지에 있는 2004년 준공된 대청호미술관에서는 대청호반 위에 있어 좋은 경치와 함께 그림이나 작품을 감상할 수 있다.',NULL,'09:00~20:00','https://www.cheongju.go.kr/ktour/index.do','주차가능','충청북도 청주시 상당구 문의면 대청호반로 721',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','청남대','대청호반에 자리 잡고 있는 청남대는 "따뜻한 남쪽의 청와대"라는 뜻으로 1983년부터 대한민국 대통령의 공식 별장으로 이용되던 곳이다. 총면적은 182만 5천ｍ²로, 주요시설로는 본관을 중심으로 골프장, 그늘집, 헬기장, 양어장, 오각정, 초가정 등이 있고 여섯분의 대통령이 89회 472일 이용 또는 방문하였으며, 2003년 4월 18일 일반인에게 개방되었다. 사계(四季)에 따라 제 모습을 바꾸는 조경수 124종 11만 6천여 그루와 야생화 143종 35만여 본은 청남대의 또 다른 자랑거리 중 하나이다. 자연생태계도 잘 보존되어 천연기념물 수달, 날다람쥐와 멧돼지, 고라니, 삵, 너구리, 꿩 등이 서식하고 있으며 각종 철새의 도래지이기도 하다.',NULL,'09:00~18:00','http://chnam.chungbuk.go.kr','주차가능','충청북도 청주시 상당구 문의면 청남대길 646',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','수암골 벽화마을','* 청주 감성여행 1번지, 수암골 벽화마을 *

충북 청주시 상당구 수암로 일대에 자리한 수암골은 청주를 찾는 여행자들이 꼭 들르는 최고의 명소가 됐다. 한국전쟁 후 피난민들이 정착하면서 형성된 달동네로 한때 초라하고 적막한 모습이었으나 2007년에 진행된 공공미술 프로젝트와 함께 달라지기 시작했다. 곳곳에 앙증맞고 화사한 벽화가 그려지면서 동네는 활기를 되찾았다. 이후 <카인과 아벨>, <제빵왕 김탁구> 등 드라마 촬영지로 알려지면서 수암골을 찾아드는 여행자들이 점점 늘었다. 우암산 자락에 위치해 청주 시내를 한눈에 내다볼 수 있다는 점도 매력적이다. 저녁노을이 질 무렵 내려다보는 풍광이 아름답다. 드라마 세트장을 활용한 음식점과 전망 좋은 카페도 여럿 있다.',NULL,'상시','http://www.cheongju.go.kr','주차가능','충청북도 청주시 상당구 수암로 58',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','수암골전망대','수암골은 한국전쟁 이후 피란민들이 정착하며 생겨난 곳이다. 마을 위편 도로에는 수암골 전망대가 있다. 청주 시내가 한눈에 보이는 전망 좋은 곳이다. 또한 전망대 아래쪽에는 카페거리도 있다.',NULL,null,null,'없음','충청북도 청주시 상당구 수동로5번길 2',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','운보의 집','* 1만 원권의 세종대왕을 그린 운보 선생을 만나자, 운보의 집 (운보미술관, 운보공방) *

물 맑고 공기 좋은 산자락 3만여 평에 문화예술 광장을 조성하여 지역사회의명소로 알려진 ""운보의 집""에는 우리 전통 양식의 한옥을 중심으로 운보미술관과 운보공방, 분재 난 전시장, 야외 도자기, 수석공원, 3개의 연못 및 분수대 등이 자리하고 있다.특히,''운보미술관''은 故 운보 김기창 화백, 故 우향 박래현 화백의 작품을 중심으로 전시하고 있으며 각종 세미나 및 운보 문화체험 여름캠프, 전국 어린이 사생대회 등을 정기적으로 실시하여 지방문화 발전에 기여하고 있다.',NULL,'09:30~17:30','http://woonbo.kr','주차 가능','충청북도 청주시 청원구 내수읍 형동2길 92-41',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','정지용 생가','1996년에 원형대로 복원되어 관리되고 있는 정지용 생가는 구읍사거리에서 수북방향으로 청석교 건너에 위치한다. 구읍사거리에서 수북방면으로 길을 잡아 청석교를 건너면 ‘향수''를 새겨 놓은 시비와 생가 안내판이 있는 곳에 이르게 된다. 이곳이 정지용 생가이며, 생가 앞 청석교 아래는 여전히 ‘향수''의 서두를 장식하는 실개천이 흐르고 있으며 그 모습은 변한지 오래이지만 흐르는 물은 예전과 같아 맑기만 하다. 정지용 생가는 방문을 항상 열어두어 찾는 이에게 그의 아버지가 한약방을 하였음을 가구(家具)로 알리고 있으며, 시선가는 곳 어디마다 정지용의 시를 걸어놓아 시를 음미할 수 있도록 배려해 놓았다.',NULL,'09:00~18:00','http://www.oc.go.kr/jiyong/index.do','주차 가능','충청북도 옥천군 옥천읍 향수길 56',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','정지용 문학관','충북 옥천군 옥천읍 하계리는 우리에게 ''향수''로 잘 알려진 시인 정지용이 나고 자란 고향이다. 정지용 생가 옆에는 정지용의 삶과 문학을 이해하고 대표적인 작품을 다양한 방법으로 감상하며 체험할 수 있는 공간인 정지용문학관이 이웃해 있다. 문학전시실은 테마별로 정지용의 문학을 접할 수 있도록 지용연보, 지용의 삶과 문학, 지용문학지도, 시·산문집 초간본 전시 등 다양한 공간을 마련하고 있다. 정지용 문학관을 들어서면 안내데스크가 정면에 있고 우측으로 정지용의 밀랍인형이 벤취에 앉아 있는데 양옆에 빈자리가 마련되어 있어서 방문객이 인형과 함께 기념촬영을 할 수 있도록 마련된 소품이다.

문학전시실은 테마별로 정지용의 문학을 접할 수 있도록 지용연보, 지용의 삶과 문학, 지용문학지도, 시ㆍ산문집 초간본 전시 등 다양한 공간을 마련하고 있다. 다음으로 흥미성과 오락성을 갖춘 문학체험 공간이 마련되어 있는데 다양한 멀티미디어 기법을 활용하여 관람객이 즉석에서 문학을 체험 할 수 있다. 그 외에 정지용 시인의 삶과 문학, 인간미 등을 서정적으로 회화적으로 그린 다큐멘타리 형식의 영상이 상영되는 ''영상실''과 강좌, 시 토론, 세미나, 문학 동아리 활동 공간이며 단체관람객을 위한 오리엔테이션을 진행 할 수 있는 열린 문학공간인 ''문학교실''이 마련되어 있다',NULL,'09:00~18:00','http://jiyong.or.kr','주차 가능','충청북도 옥천군 옥천읍 향수길 56',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','교동저수지(교동생태습지)','교동저수지는 농업용수를 공급할 뿐만 아니라 지역 주민과 관광객에게 산책과 명상을 함께 할 수 있도록 조성한 휴식공간이다.
<설치년도 1962년, 유효저수량 359천 제곱미터, 유역면적 240헥타아르, 제당 133m/높이 15.2m>',NULL,'09:00~18:00','http://jiyong.or.kr','주차 가능','충청북도 옥천군 옥천읍 교동리 155-7번지',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','교동민화마을','주민 고령화로 정체되어가는 제천교동마을에 생기를 불어넣고, 민화의 아름다움을 널리 알리고자 제천의 다양한 예술가들이 모였다. 제천시의 지원을 받아 마을 골목골목에 민화 벽화를 그려넣어 ''교동민화마을'' 이라는 이름과 함께 제천시내권의 유일한 관광지로 주목받았다. 그러나 여행자들이 애써 찾아간 마을에 민화 벽화 말고는 이렇다 할 즐길거리가 부족했고, 이를 해결하기 위해 작가들은 서로 자금을 모아 폐가를 구입했다. 그리고 교동마을 곳곳에 공방을 차려 공방 골목을 만들었다. 2014년부터 본격적으로 활동을 시작하여 현재는 판매장과 전시체험장을 갖춘 "교동골목공방" 으로 관광객들을 위한 다양한 체험프로그램을 상시 운영하고, 정기적으로는 야외오픈마켓, 향교 내에서만 진행되던 전통혼례 등 다양한 즐길거리를 운영 중이다.',NULL,'10:00~ 18:00','https://jecheonfolk.modoo.at/','없음','충청북도 제천시 용두천로20길 18',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','공전자연학교','작문화예술협동조합은 폐교인 공전학교와 폐역인 공전역을 새롭게 단장하여 효소를 중심으로 한 공전자연학교와 힐링 편백나무로 조각을 체험하는 우드트레인을 운영하고 있다. 오미자 오가피 과일 매실, 각종약초 등 갖가지 효소체험과 효소로 반찬으로 한 효소자연밥상으로 유명하다. 효소는 수년간 효소를 연구한 안영숙 교장선생님이 직접 효소를 담그고 보관하는 방법을 강의해 준다.',NULL,null,null,'주차 가능','충청북도 제천시 봉양읍 의암로 345',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','우드트레인','공전 간이역에는 김광기선생이 운영하는 우드트레인이 있다. 측백나무, 편백나무 등 힐링나무을 이용하여 모형의 우드 체험을 할 수 있다. 간이역의 운치와 기차소리를 들으며 제작하는 목공체험은 참으로 색다른 맛이다.',NULL,'10:00~ 18:00','http://cafe.daum.net/wood1','주차 가능','충청북도 제천시 봉양읍 의암로 698',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','제천 자양영당','공전마을에는 구한말 의병의 창의지 자양영당이 자리하고 있다. 조선시대 말, 1906년(고종 43) 유림에서 창건한 서당이다. 처음에는 주자와 송시열, 이화서, 유중교의 영정을 봉안했다. 뒤에 의병장인 유인석, 이직신의 영정을 추가로 봉안하여 춘추로 제향을 올리고 있다. 원래 이곳은 조선 후기의 성리학자 유중교가 1889년(고종 26)에 세운 창주정사가 있던 자리이다. 유중교는 본관은 고흥, 자는 치정, 호는 성재이다. 의암 유인석장군의 “8도에 고함“ 창의지이기도 하지만 구한말 모든 의병창의 기폭제였던 명실공이 의병의 성지로서 많은 자료를 보관하고 있어 학생들의 교육장소이기도 하다.',NULL,'10:00~ 18:00','http://tour.jecheon.go.kr','주차 가능','충청북도 제천시 봉양읍 의암로 566-7',sysdate, 0, 0);

--경기도
insert into item values(item_seq.nextval, 1, '관광지','신탄리역','경원선의 대광리역과 백마고지역의 중간 역이다. 1913년 7월 10일 영업을 시작하였다. 1945년 8·15 광복과 동시에 북한에 귀속되었다가 1951년 수복되었다. 1971년 철도중단점 표지판을 설치하였다. 통근열차가 운행되며 여객, 승차권발매 등의 업무를 담당한다. 남한측 최북단 종착역이었다가, 2012년 11월 20일 백마고지역이 연장 개통되면서 대광리역과 백마고지역의 중간역이 되었다. 코레일(Korail) 수도권동부본부 소속으로 경기도 연천군 신서면 고대산길4(대광리 169-2)에 있다. 인근에 고대산이 있다.',NULL,'06:00~24:00','https://www.letskorail.com/','주차 가능','경기도 연천군 신서면 고대산길 4',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','고대산','금강산 가는 길목, 경원선 철도가 끊겨 있는 철도중 단점인 연천군 신탄리역에 인접한 고대산(832.1m)은 천혜의 자연경관을 간직하고 있으며 생태계가 잘 보존된 곳이고 등산으로 북녘땅을 바라볼 수 있는 국내 유일한 곳으로 등산여행에는 안성맞춤이다. 고대산(高臺山)의 유래는 ""큰고래"" 라고 부르고 있으나, 이것은 신탄(薪炭)지명에서 연루된 것으로 보이며 ""방고래""(땔나무를 사용하는 온돌방 구들장 밑으로 불길과 연기가 통하여 나가는 고랑을 고래하고 함)를 이르는 것으로 고대산은 골이 깊고 높아 고대산(高臺山)이라고 한다.

지형도에는 ""높은 별자리와 같다"" 는 뜻과 의미가 담긴 곳이라 하여 고태(高台)라고도 표기하였다. 고대산은 옛부터 광범한 산록과 울창한 산림으로 말미암아 임산자원이 풍부할 뿐만 아니라, 목재와 숯을 만드는데도 적합한 곳으로 부락으로 형성된 주막집들이 있다하여 신탄막(薪炭幕)이라는 지명으로 불리웠으며, 실질적으로 한국전쟁 이전에는 참숯이 유명했던 고장으로 널리 알려진 곳이다. 또한, 1907년 11월 4일 의병진 150명과 임진강에서 의병들을 토벌하러 파견된 일본군 보병 제20연대 8중대와 연천에서 격전한 후 신탄막에서 흩어지고 의병진 60명이 고대산에서 다시 일본 군대와 치열하게 교전한 곳으로서, 우리 선열들의 용맹스러운 민족정기가 서려있는 곳이기도 하다.',NULL,null,'https://www.yeoncheon.go.kr/tour/index.do',null,'경기도 연천군 신서면',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','당포성 (한탄강 국가지질공원)','당포성은 지형을 최대한 활용하여 수직단애를 이루지 않는 평지로 연결된 동쪽에만 돌로 쌓아 성벽을 축조했습니다. 동측 성벽은 길이 50m, 잔존높이 6m정도이며 동벽에서 성의 서쪽 끝까지의 길이는 약 200m에 달하고 전체둘레는 450m 정도입니다. 성 축조에 이용한 돌은 대부분 주변에서 흔히 구할 수 있는 현무암을 가공하여 쌓았는데 이는 고구려 성의 큰 특징 중에 하나입니다. 당포성의 배후에는 개성으로 가는 길목에 해당하는 마전현이 자리하고 있어 양주분지 일대에서 최단거리로 북상하는 적을 방어하기에 당포성은 필수적이라 할 수 있습니다. 반면에 남하하는 적을 방어하는데도 매우 중요한 위치이므로 신라의 점령기에도 꾸준히 이용되었던 것으로 보입니다.',NULL,null,'http://www.hantangeopark.kr/',null,'경기도 연천군 미산면 동이리 778',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','연천 호로고루','호로고루는 개성과 서울을 연결하는 중요한 길목에 위치하고 있으며, 원당리에서 임진강으로 유입되는 지류가 흐르면서 형성된 현무암 단애 위에 조성되었다. 호로고루의 어원에 대해서는 ''이 부근의 지형이 표주박, 조롱박과 같이 생겼다."하여 호로고루라고 불린다는 설과 "고을"을 뜻하는 ''홀(호로)''와 ''성''을 뜻하는''구루''가 합쳐져 ''호로고루''가 되었다는 설이 있다. 경기도 지역에서 조사된 고구려 관방유적 중 당포성, 은대리성과 함께 3대 평지성 중 하나이다. 호로고루 동쪽벽은 현무암대지의 동쪽 부분을 막아 조성한 것으로 가장 높은 부분이10m로 성벽 위에서는 주변지역은 물론 임진강의 절경을 바라볼 수 있다.호로고루에 대한 1차 발굴조사는 2000년 11월부터 2002년 5월까지 이루어져 성벽의 축성방식과 구조에 대한 확인이 이루어졌다. 호로고루 성벽 전체 둘레는 401m로 남벽 161.9m, 북벽146m, 동벽 93.1m로 내부 면적은 606㎡이며 약 28m 높이의 현무암 절벽에 위치하고 있다. 동쪽벽은 여러 번에 걸쳐 흙을 다져 쌓은 위에 돌로 성벽을 높이 쌓아 올려 석성과 토성의장점을 적절하게 결합한 축성술을 보여주고 있다.',NULL,'06:00~24:00','https://tour.yeoncheon.go.kr','주차 가능','경기도 연천군 장남면 원당리',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','재인폭포 (한탄강 국가지질공원)','재인폭포는 한탄강에서 가장 아름답고 멋진 경관을 자랑하고 있는 곳으로 오래 전부터 명승지로서 널리 알려져 있다. 재인폭포는 북쪽에 있는 지장봉에서 흘러 내려온 작은 하천이 높이 약 18m에 달하는 현무암 주상절리 절벽으로 쏟아지는 것이 그야말로 장관을 이룬다. 또한, 재인폭포 주변에는 천연기념물 어름치와 멸종위기종인 분홍장구채 등의 서식지로도 알려져 있으며 폭포의 이름과 관련된 아름다운 사랑이야기도 전해오고 있다.
재인폭포에서는 다양한 현무암의 특징들을 관찰할 수 있는데, 대표적으로 주상절리를 비롯하여 하식동굴과 포트홀, 가스튜브 등을 볼 수 있다. 높이 약 18m에 달하는 폭포는 계속해서 폭포 아래를 침식시켜서 수심 5m에 달하는 포트홀을 만들었다. 포트홀이란 하천에서 암석의 오목한 곳이나 깨진 곳에 와류(물이 회오리 치는 현상)가 발생하여 깊은 구멍이 생겨난 것을 말한다.',NULL,'10:00~17:30','http://www.hantangeopark.kr/','주차 가능','경기도 연천군 연천읍 부곡리 192',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','동막골유원지','서울에서 두시간 거리에 있는 동막계곡은 수도권 주민들에게 널리 알려지지 않아 당일치기로 호젓한 피서를 즐기기에 좋은 곳이다. 어른 허리 깊이의 소가 군데군데 있어 가족끼리 물놀이를 즐기기에도 알맞고 계곡 주변에 기암괴석과 자연림이 아우러져 자연의 신비함을 더해준다. 또한 동막리 남쪽에 깊이 16m 높이 2.2m의 천연동굴이 있다. 여름철에는 얼음이 녹지 않을 정도로 찬공기가 흘러나와 추운 겨울을 연상케하고 반대로 겨울철에는 얼음이 얼지 않고 따뜻한 김이 모락모락 솟아오르는 기현상을 보이고 있는 곳이다. MBC TV 드라마 왕초에서 김춘삼이 움막식구인 거지들과 함께 인민군과 치열한 전투를 벌인 촬영 장소이기도 하다. (면적 약 571,211㎡, 길이 7km)',NULL,'10:00~17:30','http://www.hantangeopark.kr/','주차 가능','경기도 연천군 연천읍 동막리 동막계곡',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','열두개울','열두개울은 기암절벽과 맑은 계곡이 손잡고 선경을 빚는다. 선녀바위, 무장소, 보안소,만장바위, 평바위, 도라소, 돌묵소, 봉바위, 쌍무소, 용수골소 등의 명소가 10리에 걸쳐 펼쳐진다.옛날, 다리가 없던 시절에 법수동에서 덕둔리로 가려면 열두차례나 개울(산내천)을 건너야 했다고 한다. 지금은 5개의 다리가 놓이고 길이 뚫려 교통이 편리해졌지만 ''열두개울'' 이라는 이름은 여전히 남아 있다. 인근에는 1992년 12월에 온천지구로 지정받은 포천시 소재 신북온천이 있다.',NULL,'10:00~17:30','https://www.yeoncheon.go.kr/tour/index.do','주차 가능','경기도 연천군 청산면 청신로 345',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','한탄강관광지 오토캠핑장','국민들의 여가활동 및 자동차를 이용한 레저활동 증가 등 국민의 관광형태 변화추세에 대응할 수 있는 자연친화적이며 특색있는 다목적캠핑장(오토캠핑장)이다.

* 자동차야영장 - 한탄강이 내려다 보이는 천혜의 위치에 자리잡은 자동차캠프장은 86개의 사이트를 운영하고 있다. 분전함 및 공동취사시설 등의 편의시설을 갖추었다.',NULL,null,'https://yccs.or.kr/sisul/sisul_01_2/','주차 가능','경기도 연천군 전곡읍 선사로 76',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','경기미래교육 파주캠퍼스','모든 시설과 교육프로그램이 수강생의 적극적인 참여를 유도하고 있어 생활 속에서 자연스러운 영어 체험학습이 가능하다. 영어권 국가의 마을과 유사한 환경에서 세계의 다양한 문화를 체험하면서 세계시민의식을 배우고, 영어가 목적이 아닌 의사소통을 위한 수단이라는 것을 느끼게 하며, 친절하고 자세한 원어민 선생님의 지도로 영어에 대한 흥미와 외국인과의 대화에 대한 자신감을 심어 주어 수강생 스스로가 퇴소 후 즐겁게 학습에 임할 수 있도록 한다. 특히, 파주캠프는 모든 시설을 영어권 국가 마을의 모습으로 인테리어하여 이국적이고 새로운 환경 속에서 문화적 체험을 통해 자연스럽게 영어를 습득하도록 만들고 있다. 시청, 박물관, 도서관, 경찰서, 공연장 등의 공공시설과, 카페, 레스토랑, 전문숍 등의 상업시설, 각종체험시설, 야외공연장, 체육관 등의 놀이 및 특화시설 등 영어마을 내의 모든 시설은 실제 주거공간이자 체험공간이다.이처럼 파주캠프에서는 교육(Education),체험(Experience),놀이(Entertainment)의 3E가 결합된 시설과 교육프로그램을 체험할 수 있다.',NULL,'09:00~21:00','http://www.gcampus.or.kr','주차 가능','경기도 파주시 탄현면 얼음실로 40',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','파주 카트랜드','카트는 자동차원리를 축소시킨 미니자동차로 조작원리가 간단하여 남녀노소 누구나 운전면허 없이도 간단한 교육이수로 쉽게 체험할 수가 있으며 본인의 운전기술의 습득, 자신감, 집중력, 판단력을 향상시켜 주어 스트레스해소 등으로 현존하는 레포츠 중 청소년 및 어린이 선호도 인기 1위 레포츠이다. 파주 카트랜드는 국내 최초의 카트전용 서킷으로서 연간 수용인원이 약 100,000 명에 달하고 있으며 국내 공인 카트경기 및 국제 카트대회 유치를 연 10회이상 진행중이다. 25,000 평의 넓은 주차장 부지위에 아스팔트로 포장된 주로 길이가 약 600m에 달하는 카트 경기장으로서 일반인의 카트 체험 및 레이싱 스쿨, 어린이 교통 안전교육 등 많은 프로그램을 운영하고 있으며 파주 주변 관광지와의 연계 프로그램으로 월7000명 이상의 초,중,고교생의 교통안전운전 교육과 파주관광 프로그램을 운영하고 있다.',NULL,'09:30 ~ 17:30','http://kartland.modoo.at/','주차 가능','경기도 파주시 탄현면 필승로 398-30',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','오두산 통일전망대','경기도 파주시 탄현면에 위치하고 있는 오두산 통일전망대는 이산가족의 망향의 한을 달래주고 통일교육의 체험 도장으로 활용하기 위해 1992년 지상5층, 지하1층 건물로 건립되었다.서울의 젖줄인 한강과 북에서 흘러내리는 임진강이 합류하는 서부전선 최북단 휴전선에 위치하고 있는 오두산 통일전망대는 북으로는 개성 송악산, 남으로는 서울의 63빌딩까지 한 눈에 볼 수 있으며, 시원하게 뚫린 자유로를 따라 동북방향으로는 임진각, 제3땅굴, 판문점과 연계되는 통일안보관광지이다.개관이래 지금까지 약 1천 9백만 명이 방문하여 분단현실을 체감함으로써 명실상부한 대한민국 최고의 국민통일교육장으로 자리매김하고 있다.',NULL,'09:00~17:00','http://jmd.co.kr','주차 가능','경기도 파주시 탄현면 필승로 369',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','심학산 산림공원','경기도 파주시의 교하읍 서남단의 한강변에 있는 산으로『신증동국여지승람』에는 심악산(深岳山)으로 기록되어 있다. 심학산은 다른 산에 비해 높지 않기 때문에 가볍게 산책하기 좋으며, 2009년 가을에 심학산 둘레길이 조성되었다. 심학산 기슭에 약천사가 있으며, 정상에 올라 보는 전망과 일출을 보러 많은 이들이 찾고 있다.',NULL,null,'https://tour.paju.go.kr',null,'경기도 파주시 동패동 산284-1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','파주 출판도시','지혜가 자라는 모두의 쉼터

이곳에는 출판사, 인쇄소, 제본소 등 출판 관련 업체들이 모여 있다. 출판사에 따라 도서관, 헌책방, 테마 도서관을 운영하는 곳이 많아 아이 뿐 아니라 어른에게도 좋다. 일회성 투어가 아니어서 주기적인 방문자가 많으며 출판사가 진행하는 문화 행사나 강연, 콘서트 등도 유익하여 훌륭한 문화의 장이 되고 있다.',NULL,'각 시설별 시간 다양(사이트 참고)','http://www.pajubookcity.org','주차 가능','경기도 파주시 회동길 145',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','우농타조농장','파주시 교하읍 동패리에 위치한 ''우농타조마을''은 아름답고 아담한 동물농장에서 동물과 농촌체험을 테마로 자연을 배우고 동시에 즐길 수 있는 자연 학습공간이다.타조 및 양, 오리, 토끼, 거위 등 동물친구들에게 먹이주기 및 관찰 학습을 할 수 있으며, 타조 알 껍질 조각에 직접 그림을 그려 넣어 나만의 목걸이를 만들고 아토피 진정, 피부 보습에 좋은 타조오일과 천연 재료를 쓴 수제 비누를 직접 제작해 볼 수 있다. 또, 일일 농부가 되어 고구마 수확 체험도 해볼 수 있다.',NULL,'10:00~18:00 / 1,2월 10:00~17:00','http://www.pajubookcity.org','주차 가능','기도 파주시 교하로 595-41',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','화성 공룡알 화석지','2000년 3월 21일 국가지정문화재인 천연기념물로 지정되었다. 1999년 4월 25일 화성시 송산면 고정리일대에서 시화호 간척지의 육지화에 따른 생태계와 지질 변화에 관한 기초조사를 벌이던 중 시화호 남쪽 간척지에서 발견되었다.바닷물이 막히기 전에는 사람이 살지 않는 섬이었던 이 지역은 중생대 백악기(1억년전으로 추정됨)에 형성된 퇴적층으로 공룡알은 시화호의 해수(海水)가 빠져 나가면서 육상에 노출된 섬의 표면이 풍화와 침식에 의해 깎여 나간 표면에 주로 노출되어 있었다.지금까지 조사된 12개 지점에서 둥지 30여개에서 200여개에 달하는 공룡알이 발견되었고, 현재 뻘로 덮여있는 부분에 대한 정밀조사가 이루어지면 더 많은 화석이 발견될 것으로 기대되고 있다. 대부분의 공룡알 모양은 구형이며 검붉은 색을 띠고 있다. 공룡알 껍질의 표면을 보면 미세한 구멍이 있는데 이를 통해 태아는 이산화탄소, 산소, 수분을 교환한다. 공룡알에는 다른 알들에 비해 이러한 숨구멍이 훨씬 많은 것을 알 수 있는데, 그것은 공룡이 살았던 중생대는 현재보다 연평균 기온이 높았고 극지방에도 빙하가 없을 정도로 온난다습했기 때문에 산소를 많이 호흡하기 위해 알껍질에 많은 숨구멍을 발달시킨 결과이다.그러나 숨구멍이 많으면 호흡작용에는 크게 유리하지만 수분을 잃는 단점도 생긴다.이를 방지하기 위해 공룡들은 땅속에 구덩이를 파고 알을 낳은 후 모래로 덮어 알의 수분 손실을 막았다.',NULL,'09:00~17:00','http://dinopia.hscity.go.kr','주차 가능','경기도 화성시 송산면 공룡로 659',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','시화호','간사지 11,200ha 시화방조제 12.7km, 총저수량 3억 2천 2백만톤, 배수갑문 2개소(방아머리, 탄도)를 가지고 있는 인공 호수로 안산시, 시흥시, 화성시에 접하고 있다. 특히 조력발전소를 설치할 예정에 있어 새로운 관광명소로 자리잡게 될 것이다. 시화호 주변에는 세계적 희귀조인 장다리물떼새를 비롯하여 천연기념물인 큰고니, 희귀텃새인 천연기념물 보호조류인 검은머리물떼새 등이 서식하고 있어 새로운 생태환경지로 각광받고 있으며 주변 갯벌에는 대형무척추 동물, 갯지렁이류, 갑각류, 연체동물 등 총 214종이 서식하고 있는 생태계의 보고이다. 또 최근 천연기념물 저어새가 시화상류에서 지난 2002년에 9마리 2003년에 30마리가 발견된 이후 금년도에는 7월 28일에 처음으로 3마리가 발견되고 지난 8월 6일 28마리가 시화호를 찾아 먹이 활동을 하고 있다.',NULL,null,'http://www.shihwaho.kr',null,'경기도 안산시 단원구 대부황금로 1927',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','대부도','안산의 하와이로 불리는 대부도는 시화방조제로 연결이 되어 육지가 된 섬이지만 아직도 섬이 가진 낭만과 서정이 곳곳에 남아있는 곳이다. 무엇보다도 대부도 가는 길목은 섬과 섬을 잇는 색다른 드라이브를 즐길 수 있으며 특히 돌이 검다는 탄도, 부처가 나왔다는 불도, 신선이 노닐었다는 선감도를 비롯하여 섬 여섯개가 마치 형제처럼 어깨를 맞대고 서해에 있다해서 불리는 육도, 겨울이 되면 굴과 바지락을 채취하기 위해 인근 도리도로 이주했다가 이듬해 설이 되기전에 돌아오는 독특한 생활방식의 ''풍도'' 등은 독특한 멋을 간직한 곳이다.
대부도는 갯벌에서 맛조개, 동죽 등을 직접 잡을 수 있고, 그 외에도 고동, 조개 등을 손쉽게 잡을 수 있으며, 망둥이, 넙치, 우럭, 놀래미, 등을 바다낚시로 즐길 수 있다. 대부도 지역은 다양한 특산물로 유명한데 육도는 바지락과 굴이, 풍도는 소라젓과 천연 둥글레차가, 대부도는 특히 ''바지락칼국수''가 시원함을 자랑한다.',NULL,null,'http://tourinfo.iansan.net',null,'경기도 안산시 단원구 대부황금로 1531',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지','유리섬박물관','Glass Art를 소개하고 유리예술문화 공유를 목적으로 유리공예품의 전시와 체험의 테마 여행지이다. 자연을 유리로 재현한 테마전시관과 현대 유리 작가들의 기획전시전이 열리며, 유리공예 시연장에서는 하루 3차례 유리조형 작가들의 유리공예품 제작 시연을 관람할 수 있다.
한국의 무라노, 대부도 유리섬은 43,000㎡의 드넓은 공간에 최고의 유리조형작가들의 예술혼이 녹아 숨쉬는 환상적인 유리조형 작품과 아름다운 일몰과 서해갯벌이 장관으로 어우러진 문화체험 공간이다. 현역작가들로 구성된 맥아트글라스는 자체 디자인 상품을 개발, 생산하여 독창적이고 예술적인 유리조형제품을 건축과 도시문화공간 그리고 다양한 예술장르에 접목시키고자 노력하고있다.',NULL,'4월~9월(하절기) : 화~일 09:30~18:30 / 토요일 09:30~21:00','http://www.glassisland.co.kr','주차 가능','경기도 안산시 단원구 부흥로 254',sysdate, 0, 0);

insert into item values(item_seq.nextval, 1, '관광지', '경찰혼','우리 사회의 안정과 치안을 위해 순국ㆍ순직한 영등포경찰서 출신 경찰들의 숭고한 희생정신을 추모하고 그 분들의 고귀한 업적을 후세에 널리알리기 위하여 건립된 추모비이다.6ㆍ25전쟁 직후 전몰ㆍ순직한 경찰 62위 및 국내에서 발생한 각종 시위 진압과정에서 순직한 경찰 16위 등 총 78위의 경찰들을 기리고 있으며 서울영등포경찰서 내에 위치해 있다.', '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://mfis.mpva.go.kr', '공원앞 주차가능', '서울특별시 영등포구 국회대로 608', sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지', '국회의사당', '여의도 면적 80만 평 가운데 의사당 대지 10만 평에 건물면적 2만 4,636평을 차지하는 지하 2층 지상 8층의 석조건물이다. 단일 의사당 건물로는 동양에서 제일 크며, 장차 남북통일이 되고 의회제도가 양원제로 채택 되더라도 불편없이 사용할 수 있도록 배려되었다.6년의 공사 끝에 1975년 8월에 준공되었으며, 현대식 건물에 한국의 전통미를 가미하였다. 의사당을 둘러싸고 있는 24개의 기둥은 국민의 다양한 의견을 뜻하며, ||'||'돔'||'|| 지붕은 국민의 의견들이 찬반토론을 거쳐 하나의 결론을 내린다는 의회 민주정치의 본질을 상징한다.', '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://www.assembly.go.kr', '공원앞 주차가능', '서울특별시 영등포구 의사당대로 1', sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지', '대림동 차이나타운', '2015년 기준, 관내 중국인이 6만 6000여명에 달하며 대림 중앙시장 내 상점의 40%가 중국인 소유일 정도로 전국에서 가장 규모가 큰 차이나타운이다. 서울시는 이곳을 단순 외국인 밀집거주지역이 아닌 문화관광교류명소로 조성한다는 계획이다. 지하철 2,7호선 대림역 12번 출구 앞 골목 안쪽에는 대림중앙시장이 있다. 이곳의 풍경은 우리나라 여느 재래시장과는 다르게 생소한 중국식 재료와 중국 향기가 물씬 풍기는 길거리 음식들을 판매하고 있다.대림동 차이나타운에는 마라탕이나 훠궈 등 전통식부터 퓨전식까지 다양한 종류의 중국 음식을 판매하는 유명한 중국음식점들이 많다. 많은 식당들이 한국어 메뉴를 갖추고 있지만, 한국어가 전혀 통하지않는 곳도 있다.', null, '08:00~20:30(점포마다 상이함)', 'https://www.daerimmarket.co.kr', null, '서울특별시 영등포구 디지털로37나길 21', sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지', '맥아더 사령관 한강방어선 시찰지', '맥아더 사령관이 1950. 6. 29. 도쿄에서 날아 와 수원비행장에서 내려 이승만 대통령과 채병덕 육군참모총장이 참석한 가운데 전쟁상황에 관한 브리핑을 실시하였다. 맥아더는 직접 전선을 시찰하기로 하고 시흥지구전투사령부 김종갑 작전처장과 동행하여 한강전선이 보이는 신길동 근처에서 전황을 관측하였다. 이때 맥아더 사령관이 한강 남쪽을 지키고 있던 한 병사에게 "너는 이곳을 얼마 동안 지킬 수 있다고 생각하는가?"라고 질문하자, 병사가 "상관이 철수명령을 내릴 때까지 지키겠다"고 답변하여 그럴 감동시켰다. 맥아더장군의 현지 전선 방문은 후퇴를 거듭하던 한국군의 사기를 크게 고무시켰다. 이와 더불어 인천상륙작전의 아이디어를 얻는데도 큰 도움이 되기도 하였다. 그는 1951년 4월 해임되기 전까지 한국전선을 10회 이상 방문하였다. 당시 시찰지는 영등포공원 앞 도로로 추정되며 영등포공원 내 분수대 인근에 현충시설 안내판이 설치되어 있다.', null, '09:00부터 ~ 22:00까지', 'http://mfis.mpva.go.kr', '공원앞 주차가능', '서울특별시 영등포구 신길로 275', sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지', '문래예술공장', '서울특별시 창작공간 문래예술공장은 자생적 예술 마을인 문래창작촌을 포함하여 국내외 다양한 예술가들을 위한 창작지원센터로 2010년1월28일에 개관했다. 문래동 철공소 거리의 옛 철재 상가 자리에 전문창작공간으로 새롭게 건립되었으며, 공동작업실, 다목적발표장을 비롯해 녹음실, 세미나실 등 창작 및 발표 활동을 위한 다양한 지원시설을 갖추고 있다.', null, '09:00부터 ~ 22:00까지', 'http://www.sfac.or.kr/', '공원앞 주차가능', '서울특별시 영등포구 경인로88길 5-4', sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지', '반공순국용사 위령탑', '1945년 8월 15일 조국광복 이후 좌우의 충돌에 의한 혈전과 1950년 6월 25일 북한의 기습남침으로 조국의 운명이 누란의 위기에 처했을 때 영등포구 관내 대동청년단, 대한청년단, 대한노총, 반공연맹, 민보단 서북청년회 등 애국우익 단체소속 동지들과 경찰관, 소방관, 학생을 비롯한 많은 애국동지들이 구국의 일념으로 멸공전선에서 싸우다가 순국 산화한 이재호 등 134위의 호국용사들을 추모하기 위해 건립하였다.신길역 옆의 여의도 샛강을 지나는 노들길변에 위치해 있으며, 매년 6월 순국용사들의 숭고한 뜻과 희생을 기리는 위령제를 지내고 있다.', null, '09:00부터 ~ 22:00까지', 'http://mfis.mpva.go.kr', '공원앞 주차가능', '서울특별시 영등포구 신길1동 20-4', sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지', '서울색공원', '서울 색공원은 마포대교 교각과 둔치 사이의 하부공간에 색을 주제로 조성된 시민공원(약 9,000㎡)이다. 서울시 색채환경 개선 및 고유한 도시이미지 형성을 위하여 개발한 서울색을 공공공간에 적용하여 서울 색공원(Seoul Color Park)을 조성하여 한강을 찾는 시민들에게 휴식 공간과 동시에 일상적 디자인 체험의 기회도 제공하고 있다.서울 색공원은 한강의 물결을 형상화한 서울색 조형물, 서울 대표색10을 활용한 서울색 바코드 그래픽 및 벤치 등이 설치되어 있다. 공공시설물은 거리에 통합되어 쾌적해 보이도록 기와진회색과 돌담회색 등을 적용하고, 가로에서 눈에 잘 보여야 하는 것에는 단청빨간색, 꽃담황토색, 남산초록색 등과 그 계열색들을 적용하여 가로경관의 이미지를 체계적으로 개선해가고 있다. 또한, 서울시립미술관과 서울역사박물관에도 서울색을 활용한 조형물 및 작품이 설치되어 있다.서울지하철 5호선 여의나루역. 마포대교 남단을 10여 분 걸어가면 서울 색공원을 만날 수 있다.', null, '09:00부터 ~ 22:00까지', 'http://hangang.seoul.go.kr', '공원앞 주차가능', '서울특별시 영등포구 여의동로 330', sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지', '선유도공원0', '과거 정수장 건축구조물을 재활용하여 조성한 국내 최초의 물공원이다. 수질정화원, 수생식물원, 생태숲 등 자연을 즐기기 좋고 한강전시관과 시간의 정원 등 볼거리와 휴식공간도 잘 가꾸어져 있다. 볏짚 공예품 만들기, 꽃과 나무를 주제로 한 영어와 한자 배우기, 나뭇잎과 꽃잎을 이용한 장식품 만들기 등 체험 프로그램도 흥미롭다.', null, '09:00부터 ~ 22:00까지', 'http://parks.seoul.go.kr/template/sub/seonyudo.do', '있음(장애인 차량은 선유도공원 내 주차 가능/일반 승용차는 양화 한강공원 주차장 이용)', '서울특별시 영등포구 선유로 343', sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '관광지', '양화한강공원', '양화한강공원은 여의도 샛강 하구에서 강서구 가양대교까지로 한강남단에 위치하고 있다. 둔치에 넓게 조성된 잔디밭에서 바라보는 탁 트인 전망을 자랑하고 있다. 여의도 샛강 하구에서 가양대교까지 연결된 자전거도로가 있으며, 선유교 아래의 무성하게 우거진 가량의 물 억새길을 만날 수 있다. 뿐만 아니라 자전거도로변에는 매년 5월이면 초록 잔디밭을 붉게 물들이며 꽃피우는 아름다운 장미꽃이 유명하여 친구, 연인이나 가족과 함께 사진 찍기에 좋은 곳이다.', null, '09:00부터 ~ 22:00까지', 'http://hangang.seoul.go.kr', '있음(5개소, 501대 주차 가능)', '서울특별시 영등포구 노들로 221', sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','진짜 축제가 시작된다. 문경찻사발축제','꽃잎 떨어지고 꽃 축제 끝났다고 몽땅 망한 것처럼 아쉬워할 필요 없다. 진짜 축제가 다가온다. 문경새재 오픈세트장에서 오는 28일부터 펼쳐지는 문경찻사발축제다. 찻사발에 흐르는 곱디고운 선이며 은은한 향기까지 찻사발의 치명적인 매력에 빠지는 시간이다. 전통과 재미가 어우러진 고품격 축제장에서 놓쳐서는 안 될 프로그램을 미리 체크해두자. 대한민국의 멋과 흥에 풍덩 빠지려면 준비 운동이 필수다.전통에 재미까지 더한 대한민국 대표 축제""누가 나에게 내가 만든 도자기와 똑같은 도자기를 만들어달라고 하면 만들어줄 수 있습니다. 하지만 문경 찻사발과 똑같은 도자기를 만들어달라고 하면 만들 수 없습니다. 문경도자기는 Only One입니다."" 일본 15대 심수관인 심일휘 씨가 문경도자기를 극찬하며 남긴 말이다.문경은 지금도 발물레로 도자기를 빚고 장작 가마에서 구워낸다. 전국에서 가장 오래된 전통 장작 가마가 남아 있고, 국가무형문화재 김정옥 사기장과 두 명의 도예명장을 비롯해 40여 개의 요장이 전통을 이어가고 있는 도예의 메카다.','2021년4월 28일 ~ 2021년5월 7일','09:30~18:30','http://www.mghotel.com/','주차 가능','경상북도 문경시 문경읍 새재2길 36 문경새재 일원 오픈세트장',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','세계인과 함께하는 보령머드축제','제24회 보령머드축제는 생산적 온라인콘텐츠와 가능한 범위내에서 안전을 최우선으로 하는 오프라인콘텐츠를 연결한 새로운 시도를 통해 기존 온라인축제와의 차별성과 함께 지역경제활성화를 도모할 수 있는 축제로 개최','2021. 7. 23.(금) ~ 8. 1.(일)','09:30~18:30','https://www.mudfestival.or.kr/festival/view','주차 가능','충청남도 보령시 대해로 897-15',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','푸른 제주도에서의 불멍 - 제주들불축제','“정말로 그대가 외롭다고 느껴진다면, 떠나요 제주도 푸른 밤 하늘 아래로 / 최성원 ‘제주도의 푸른 밤’ 中”‘불멍’ 이라는 신조어가 생겼다. 적막한 어둠 속에서 장작 타는 소리와 함께 포근한 느낌을 주는 불이 주는 어떤 감성이 있기 때문이다. 푸른 하늘과 바다가 떠오르는 우리의 대표적 최애 휴양지인 제주도에서 이런 불멍 감성까지 느낄 수 있는 시간이 있다면 어떨까?제주는 1970년대까지만 하더라도 농가마다 보통 2~3마리의 소를 기르며 주 노동력인 소를 이용하여 밭을 경작했다고 한다. 농한기에는 마을마다 양축 농가들이 윤번제로 서로 돌아가며 방목 관리하던 풍습이 있었다. 이때 해묵은 풀을 없애고, 해충을 구제하기 위해 마을별로 늦겨울에서 경칩에 이르는 기간에 목야지에 불을 놓아 양질의 새 풀이 돋아나도록 불놓기를 했다. 이러한 제주 선인들의 옛 목축문화를 현대적 감각에 맞게 승화 발전시킨 축제가 ‘제주들불축제’ 이다. ','2021.11.19 ~ 2022.01.23','09:30~18:30','https://www.mudfestival.or.kr/festival/view','주차 가능','제주특별자치도 서귀포시 태평로 436',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','등불이 주는 포근함 - 진주남강유등축제','“불을 밝히니 촛불이 두 개가 되고, 그 불빛으로 다른 초를 또 찾고, 세 개가 되고, 네 개가 되고 어둠은 사라져가고 / god ‘촛불하나’ 中 ""   등(燈)이 주는 감성을 굳이 언급해서 무엇할까? 가수 god 의 ‘촛불하나’ 라는 노래를 듣고 있으면, 세상 부정적인 걱정들이 가득한 내 삶을 위로받는 것만 같다. 대만의 지우펀, 베트남의 호이안처럼 야경의 등불이 유명한 도시에 열광하는 이유도 여기에서 왔을 것이다. 어둠을 따뜻하게 밝혀주는 모습에 넋을 잃고 감성에 젖기도 하고, 예쁜 사진을 담기 위해 부단히 뛰어다니는 연인들의 모습을 보고 있으면 천국이 이런느낌일까? 라는 행복한 상상에 빠지기도 한다. 어둠 속의 등불이 주는 따뜻한 감성을 느낄 수 있는 영화 같은 공간이 있다면 소중한 사람과 꼭 가보고 싶을 것이다. 바로 진주남강유등축제이다.10월 청량한 가을 밤, 이러한 등불의 형형색색 감성을 느낄 수 있는 축제가 경남 진주에서 펼쳐진다. 진주 남강에서 이루어지는 이 축제는 역사적으로도 큰 의미를 가지고 있다. 임진왜란 중, 임진년(1592) 10월, 어둠을틈타 남강을 건너려는 2만여명의 왜군을 저지하기 위한 군사 전술 및 군사 신호로써 유등을 사용했다고 한다. 이후 순국선열을 기리기 위해 남강에 유등을 띄우기 시작했고, 이 전통이 이어지면서 대한민국을 대표하는 축제 ‘진주남강유등축제’ 로 자리잡았다. ','2021.12.04 ~ 2021.12.31','09:30~18:30','http://www.yudeung.com','주차 가능','경상남도 진주시 남강로 626',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','밤바다의 로망 - 포항국제불빛축제','올해 포항국제불빛축제는 “포항에서 희망의 빛을 띄우다!”라는 주제로 유튜브와 메타버스를 활용하여 뉴노멀 시대에 맞게 진행된다.이번 축제는 기존처럼 크게 국제적인 불꽃쇼를 개최하지는 않지만, 위로와 희망 그리고 비전의 메시지를 담아 300여대의 드론과 불꽃이 결합되어 새로운 퍼포먼스를 선보이는 “드론불꽃쇼”와 희망의 메시지를 담은 불꽃 퍼포먼스인 “희망의 불꽃, 치유의 불꽃, 다시 일상으로!” 프로그램이 진행된다.올해의 포항국제불빛축제는 유튜브 “포항국제불빛축제” 채널과 메타버스 포항을 활용하여 온라인으로 감상할 수 있다.','2021.11.20 ~ 2021.11.21','18:30~21:30','https://festival.phcf.or.kr','주차 가능','경북 포항시 북구 두호동 681',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','급이 있는 영화제','2021년 11월 25일(목)-26일(금) 제3회 <급이 있는 영화제>를 개최한다.올해 영화제는 영화와 등급에 관한 이야기를 온오프라인의 방식으로 심도있고 흥미롭게 나눠보려 한다.더 많은 분들과 함께 하기 위해 유튜브 라이브로도 진행할 예정이오니 많은 관심과 참여 부탁드립니다.*유튜브 라이브 방송에 참여해주시는 분들에게는 추첨을 통해 소정의 경품을 문자 발송해드립니다.','2021.11.25 ~ 2021.11.26','18:30~21:30','http://www.kmrb.or.kr','주차 가능','부산광역시 해운대구 수영강변대로 120',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','2021 코엑스 푸드위크 (제16회 서울국제식품산업전)','2021 코엑스 푸드위크(제16회 서울국제식품산업전)는 올해로 16회째 개최되는 하반기 최대규모 식품 전시회이다.2020년에 유일하게 온오프라인 하이브리드로 진행한 이력이 있으며, 2021년에도 마찬가지로 온오프라인 동시 진행될 예정이다.동시개최되는 한국베이커리쇼는 20회를 맞이하는 서울국제빵과자페스티벌(SIBA)의 새로운 이름으로, 국내 유일 제과제빵 전문 전시회이다.동시개최되는 푸드테크산업전은 전시회와 컨퍼런스로 구성된 B2B 플랫폼으로 식품기술, 가공 및 기기, 서비스, 포장, 3D 프린팅 등 관련 분야의 최신 트렌드를 선보인다.원데이 클래스, 경연대회, 현장 이벤트 등 다양한 현장 체험 행사들을 즐길 수 있다.','2021.11.24 ~ 2021.11.27','09:30~21:30','www.foodweek.co.kr','주차 가능','서울특별시 강남구 영동대로 513',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','제15회 전북청소년영화제','11월 25일(목) 19:00 개막식(전주디지털독립영화관)11월 26일(금) 섹션1 11:00, 섹션2 13:30, 섹션3 16:0011월 27일(토) 섹션4 11:00, 비경쟁부문 13:30, 폐막식 및 시상식 16:00-경쟁부문 33편, 비경쟁부문 14편, 총47편 상영개막식과 폐막식을 청소년들이 직접 사회를 보고 전체 진행한다.','2021.11.25 ~ 2021.11.27','09:30~21:30','http://www.jyff.or.kr','주차 가능','전라북도 전주시 완산구 전주객사3길 22',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','인천국제디자인페어','“인천국제디자인페어” 는 인간과 자연이 공존하는 지속가능한 미래 환경도시 인천에서 도시의 녹생 생태계 회복을 위한콘텐츠를 디자인 기술의 융,복합을 통한 녹색산업 혁신으로 환경, 공간, 시각, 서비스 디자인 등의 기여와 협업을 통해인천 시민이 도심 속 자연과 공존하여 삶의 질을 향상시키는데 기여하고자 한다.또한 도시의 녹색 생태계 회복을 위한 사업으로 기후, 환경위기 속에서 지속가능한 환경도시를 구현하는 것을 목표로하고 있으며, 시민의 인식확대를 위한 재활용 및 새활용 확대를 위한 행동학적, 경험적 서비스 디자인 구축을 목표한다.','2021.11.25 ~ 2021.11.28','09:30~21:30','http://www.indew.kr','주차 가능','인천광역시 연수구 센트럴로 123',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','[문화관광축제]제13회 강릉커피축제','강릉에서 매년 10월, 향긋한 커피향과 함께하는 강릉커피축제를 개죄하고 있다.강릉을 비롯한 전국 유명 커피 업체들이 참석해 커피 무료 시음행사를 열고, 커피 명인들에게 직접 커피에 관한 전문적인 노하우를 얻는 세미나도 열린다. 올해는 가족단위형 프로그램 및 커피 관련 체험 등 다양한 문화행사도 동시에 열린다. 아름다운 강릉에서 바다를 바라보며 커피 한잔의 여유를 즐길 수 있다.','2021.11.25 ~ 2021.11.28',null,'http://www.coffeefestival.net','주차 가능','강원도 강릉시 경강로2021번길 9-1',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','캐릭터 라이선싱 페어 2021','캐릭터 라이선싱 페어는 라이선싱 관련 국내외 제조사, 에이전트, 유통 구매 담당자, 마케터, 홍보담당자를 초청, 실질적인 바이어와 매칭 프로그램을 운영하여, 참가사에 효율적인 비즈니스 환경을 제공한다. 또한 다양한 퍼블릭 이벤트 진행을 통하여 일반 참관객의 이목을 집중시키고, 고객의 반응을 현장에서 바로 테스트할 수 있는 최적의 장소가 될 것이다.','2021.11.25 ~ 2021.11.28',null,'http://www.characterfair.kr','주차 가능','서울특별시 강남구 영동대로 513 코엑스 C, D홀',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','서울모빌리티쇼','2021년 제15회 서울모터쇼는 11월 25일부터 12월 05일까지 경기도 일산 킨텍스에서 펼쳐질 예정이다.','2021.11.25 ~ 2021.12.05',null,'www.motorshow','주차 가능','경기도 고양시 일산서구 킨텍스로 217-60',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','관악별빛조명축제','다가오는 겨울, 특색 있는 야경을 즐길 수 있는 명소 ‘별빛내린천’에서 펼쳐지는 ‘관악별빛조명축제’, ‘별빛내린천으로 마실나온 토끼와 사랑과 축복의 루미나리에가 펼쳐지고, 강감찬 장군이 탄생할 때 떨어진 별빛도 이곳 ‘별빛내린천’에 깃들어 있다.별빛내린천을 따라 펼쳐지는 별빛과 신원시장, 관악종합시장, 서원동 상점들은 신사리만의 특색 있는 다양한 음식들로 축제의 하이라이트를 더한다.코로나19로 지친 시민들의 마음을 위로하고, 아름다운 이야기가 있는 ‘별빛의 동행’으로 여러분을 초대합니다.','2021.11.23 ~ 2021.12.14',null,null,'주차 가능','서울특별시 관악구 신림동 1642-7',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','제주해비치아트페스티벌','제주해비치아트페스티벌은 전국 문예회관 관계자, 국내외 예술단체 및 공연기획사, 문화예술 관련 기관, 공연장 관련 장비업체 등 문화예술 산업 종사자 간 정보제공·교류·홍보를 위한 유통의 핵심 플랫폼 구축을 통해 기획 역량 및 유통 활성화에 기여하고, 다양한 형태의 공연예술프로그램 실연을 통해 문화 향유 기회를 제공하는 대한민국을 대표하는 아트마켓형 페스티벌이다.2021. 11. 22.(월) ~ 11. 25. (목) / * 11. 19.(금) 부터 프린지 공연 개최','2021.11.22 ~ 2021.11.25',null,'http://www.jhaf.or.kr','주차 가능','제주특별자치도 서귀포시 표선면 민속해안로 537',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','파주장단콩축제','""웰빙명품 파주 장단콩""이라는 주제로 개최되는 파주장단콩 축제가 2021.11.26.~28까지 임진각 광장에서 장단콩 등을 판매할 예정이오니 시민여러분의 많은 성원 바랍니다.파주장단콩의 유래옛날부터 콩의 주산지로 알려진 장단군은 본래 고구려의 장천현으로 통일신라 때 장단으로 고쳐불렀으며 1972년 12월 군내면, 장단면,진동면,전서면 등이 파주시에 속하게 되었다.장단지역에서 생산되는 콩은 古來로부터 그 명성이 높았다. 1913년 우리나라 최초의 콩 장려 품종으로 결정된 품종인 ""장단백목""도 바로 이 지역 토종 콩으로 장단지역 콩을 수집, 순계, 분리하여 선발되었다. 1969년 우리나라 최초로 작물시험장에서 인공교배를 통하여 육성보급된 장려품종인 광교(光敎)도""장단백목""과 일본으로부터 도입종인 ""육우3호""와의 교배 육성종이다.','2021.11.26 ~ 2021.11.28',null,'https://tour.paju.go.kr','주차 가능','경기도 파주시 문산읍 임진각로 164',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','2021 서울빛초롱축제','지난 13년간 청계천에서 치러진 서울빛초롱축제는 한지 등(燈)을 주축으로 다양한 빛 조형물을 전시한 서울시 대표 축제이다.2021년에는 코로나로 지친 시민에게 힐링을 전하고자 「빛으로 물든 서울 힐링의 숲」 을 주제로 개최되며, 코로나 사회적 거리두기 상황을 고려한 온·오프라인 병행형 축제로 진행된다.','2021.11.26 ~ 2021.12.05',null,'www.stolantern.com','주차 가능','서울특별시 종로구 청계천로 85',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','마노르블랑 동백꽃축제 2021','""마노르블랑은 서귀포시에 위치한 가든 카페이다.마노르블랑에서는 매년 동백꽃축제가 열리고 있지만 올해 또한 특별한 동백꽃 축제가 열린다.작년에 개장된 동백스케치가 더욱 더 풍성해졌다. 엄청난 규모의 동백꽃들이 기다리고 있다.또한, 마노르블랑은 우리나라 최남단에 위치하고 있어 다양한 식물들이 식재되어있기에 제주도를 찾는 수많은 관광객들은 물론이며 제주도민까지도 찾는 명소로 손꼽힌다.4000여 평 정원 속에 다양한 동백꽃 산책로가 있으며 산방산과 송악산 사이로 형제섬과 사계 앞바다가 보이는 환상적인 조망 또한 마노르블랑의 자랑거리이다.환상적인 조망과 함께 동백꽃 인생샷을 남길 수 있는 다양한 포토존이 준비되어 있고 야외 잔디정원에서는 피아노 연주 버스킹을 즐길 수 있다. 또한 동백스케치에는 특별한 그네가 준비되어 있으며 감귤체험(별도) 또한 즐길수있다.이곳 마노르블랑은 지금 동백꽃 축제의 향연이 펼쳐지고 있다.""','2021.11.26 ~ 2022.01.31',null,'www.instagram.com','주차 가능','제주특별자치도 서귀포시 안덕면 일주서로2100번길 46',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','제6회 부천전국버스킹대회(통합결선)','​제6회 부천전국버스킹대회부천전국버스킹대회는 길에서 만나는 다양한 음악인들의 재능을 발굴하고 격려하고자 시작된 문화특별시 부천이 마련한 축제이다. 노래, 연주를 포함한 다양한 음악적인 재능을 부천전국버스킹대회를 통해 자랑하고 함께 즐기는 기회로 마련된 행사이다. 코로나19로 인해 사회적 거리두기와 방역지침에 의거하여 제5회, 제6회는 온라인으로 진행된다.','2021.11.27 ~ 2021.11.27',null,'http://marubusking.com','주차 가능','경기도 부천시 소사본동 호현로489번길 52',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','청소년 콘텐츠 축제 z-페스티벌','z세대 및 청소년을 위한 콘텐츠 축제. 전도유망한 사업인 로봇분야의 전문가 한재권 박사와 인기 개그맨이자 인플루언서인 김원효의 토크콘서트로 청소년들에게 다양한 이야기를 제공하는 소통과 공감의 장을 마련했다. 인기 힙합가수인 매드클라운의 축하공연과 다양한 콘텐츠 전시체험관을 함께 준비하여 다양한 볼거리와 즐길거리 함께 선사할 예정이다. 그리고 세계 최초 로봇 융복합문화공간인 경남 마산로봇랜드 컨벤션센터에서 개최하여 z-페스티벌 축제와 함께 인접해 있는 테마파크, 로봇랜드까지 함께이용하여 보다 더 재밌는 축제를 즐길 수 있다.','2021.11.27 ~ 2021.11.27',null,'https://zfestival.modoo.at/','주차 가능','경상남도 창원시 마산합포구 구산면 로봇랜드로 70',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','제8회 해운대 빛축제','-축제기간 : 2021. 11. 27.(토) ~ 2022. 2. 2.(수) 68일간 점등식 : 2021. 11. 27.(토) 18시, 해운대해수욕장-점등시간 : 18:00 ~ 24:00-장 소 : 해운대해수욕장, 해운대광장, 해운대시장, 온천길 일원-행사주체 : “해운대 전설, 빛으로 담다”-주요내용 : 점등식, 빛 시설물 전시, 시민 참여 프로그램 등','2021.11.27 ~ 2021.11.27',null,'http://www.haeundae.go.kr','주차 가능','부산 해운대구 중동 1411-23',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','제15회 울산과학기술제전','과학 원리를 이해할 수 있는 온라인 과학체험 프로그램을 제공하여 과학과 과학기술에 대한 관심과 흥미 고취로 과학기술인을 육성하기 위한 과학 축제이다. 첨단과학에 대한 안내 및 체험 기회 제공으로 과학기술에 대한 이해를 통해 과학문화 확산 및 저변을 확대하고자 한다. 과학 원리 체험, 과학 특별 강연, 전국 과학 교사 교류회, 메이커 코딩 교육, 뚝딱뚝딱 자동차 만들기, 언택트 사이언스 버스킹(USB), 나도 과학 유튜버, 드론 축구 대회 등 다채로운 이벤트가 준비되어 있으며, 특히 누리집을 통해 학생들이 직접 제작한 다양한 과학 영상들이 업로드될 것이다.','2021.11.20 ~ 2021.12.05',null,'http://www.ulsansf.kr','주차 가능','울산광역시 남구 남부순환도로 111',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','네이처파크 미라클크리스마스','네이처파크에 또다시 돌아온 미라클크리스마스에 당신을 초대한다.네이처파크에서 진행되는 미라클크리스마스는 작년보다 더 다양해진 이벤트로 돌아왔다.네이처파크를 찾아온 산타가 두고 간 럭키박스에는 작년보다 더 많은 과자와 선물들이!어떤 선물이 들어있을까? 기대하며 언박싱.','2021.11.20 ~ 2022.01.02',null,'http://www.spavalley.co.kr/naturepark','주차 가능','대구광역시 달성군 가창면 가창로 891',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','고니골빛축제','제7회 고니골 빛축제, 양잠테마단지고니골은 양잠농가로 어려움속에서도 비수기인 겨울동안 자연과 빛의 만남이라는 주제를 가지고 LED불빛등을 이용 농가소득 증대를 활성화할뿐만 아니라 원주시민들과 주변 사람들에게도 좋은 추억거리와 힐링이 되고 양잠농가인 원주시 고니골을 알리는데 뜻을 두고 빛축제를 하게 되었으며, 더불어 눈썰매장을 운영 아이들에게도 좋은 추억거리를 제공하게 되었다.','2021.11.20 ~ 2022.02.06',null,null,'주차 가능','강원도 원주시 호저면 호저로 1277-43',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','이월드 미라클 윈터 나이트 2021','<제 9회 이월드 별빛축제 : 미라클 윈터 나이트>올해로 9회째 이어지는 이월드 별빛축제는 2021년을 맞이하여 <미라클 윈터 나이트>라는 타이틀 아래 겨울 이월드에서만 볼 수 있는 별빛의 화려하고 로맨틱한 모습을 선보일 예정이다.밤이 되면 본격적으로 시작되는 별빛축제에는 이월드 대표 캐릭터인 비비가 맞이해주는 초대형 크리스마스 트리광장을 시작으로, 산타가 된 초대형 비비에게 소원을 빌 수 있는 <자이언트 산타비비>, 1만송이 장미가 빛을 밝히는 <로맨틱 빛장미 언덕>이 새롭게 선보일 예정이며, 메가문, 천국의계단등 이월드 13만평에 펼쳐진 100여개의 인기 야간 포토존이 준비되어 있다. 아름다운 <이월드 별빛축제: 미라클 윈터 나이트>에서 겨울에만 만나는 로맨틱 별빛 추억과 사진을 남길 수 있다.이월드 자유이용권 구매 시, 이월드 별빛축제는 물론 30여종의 놀이기구와 대구의 랜드마크인 83타워를 함께 즐길 수 있다. 83타워 전망대에서 바라보는 대구야경과 13만평 전체가 별빛으로 물들여진 이월드의 광경 또한 별빛축제에서 반드시 즐겨야 하는 필수코스다.※ 자세한 행사내용은 이월드 인스타그램 @eworld.official 또는 이월드 유튜브, 이월드 페이스북 페이지를 참조.※ 일부 행사는 현장상황에 따라 변경 및 취소될 수 있다.','2021.11.20 ~ 2022.02.28',null,'http://www.eworld.kr','주차 가능','대구광역시 달서구 두류공원로 200',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','우리 학교, 추억의 그때 그 놀이','전통문화 테마파크 한국민속촌이 학창시절 동심으로 떠나는 시간여행 축제를 준비했다. ‘우리학교, 추억의 그때 그 놀이’ 겨울 시즌축제를 2021년 11월 20일부터 2022년 3월 20일까지 진행한다고 밝혔다.올해 10년째를 맞이한 한국민속촌의 레트로 축제는 과거 감성을 느낄 수 있는 다양한 놀이와 체험으로 많은 사랑을 받아 왔다.','2021.11.20 ~ 2022.03.20',null,'http://www.koreanfolk.co.kr','주차 가능','경기도 용인시 기흥구 민속촌로 90',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','청도 프로방스 크리스마스 산타마을 빛축제','청도프로방스 크리스마스 산타마을 빛축제 레트로 빛축제와 산타을 포토존으로 행복한 추억이 쌓이는 겨울 축제로 환영합니다.','2021.11.19 ~ 2022.01.23',null,'http://www.cheongdo-provence.co.kr','주차 가능','경상북도 청도군 화양읍 이슬미로 272-23',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','2021 동대문구 문화재야행 <월하홍릉>','올 해 처음 개최하는 ‘동대문구 문화재야행-월하홍릉’은 ‘집으로 찾아온 동대문구 문화유산’ 이라는 주제로 서울 영휘원과 숭인원, 홍릉숲, 청량리 홍릉주택 등 일반인에게 잘 알려지지 않은 동대문구 근·현대 문화유산을 배경으로 한다.행사에서는 야경(夜景), 야로(夜路), 야사(夜史), 야식(夜食)을 주제로 총 7개의 프로그램이 펼쳐진다.','2021.11.18 ~ 2021.11.30',null,'www.ddmnight.or.kr','주차 가능','서울특별시 동대문구 무학로44길 38',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','부산국제아트페어 2021','문화 도시 부산을 중심으로 열린 미술 시장을 성공적으로 개최 해온 부산국제아트페어가 오는 12월 2일부터 12월 6일까지 5일간 더욱 발전된 모습으로 여러분을 찾아간다. 올해로 20회를 맞이하는 부산국제아트페어는 국내외 유명작가 250여 명이 3천여 점의 작품이 출품되는 아시아의 유일한 열린 미술장터로 온라인과 오프라인 양채널을 통해 전시된다.. 2021 BIAF에서는 고유물을 비롯하여 한국, 인도, 중국, 러시아 등 국내외 작가의 작품과 더불어 신진작가 공모를 통해 신선하면서도 개성과 실력을 갖춘 신진작가들을 선발하여 그룹전을 기획하여 미술의 과거와 오늘, 그리고 미래를 만나고 소장 할 수 있는 기회를 제공한다.','2021.12.02 ~ 2021.12.06',null,'http://www.biaf.co.kr','주차 가능','부산광역시 해운대구 APEC로 55 벡스코 제2전시장',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','궁디팡팡 캣페스타','국내 최초, 최대 규모의 고양이 박람회 궁디팡팡 캣페스타는 2014년 신촌의 작은 카페에서 10여 개의 고양이 관련 업체 및 작가와 함께 시작, 현재 매 회 300여개의 고양이 관련 브랜드 및 아트 작가가 참여하는 박람회이자 연 100,000명의 애묘인이 방문하는 축제의 장으로 성장하였다.','2021.12.03 ~ 2021.12.05',null,'https://gdppcat.com','주차 가능','서울특별시 강남구 남부순환로 3104',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','제주국제관악제','제주의 관악은 6․25 한국전쟁을 전후한 어려웠던 시절부터 시작된다. 금빛 나팔소리로 제주사람들의 애환을 달래며, 천진스런 동경과 꿈을 심어주었다. 제주국제관악제는 제주토박이 관악인들에 의해 1995년에 격년제로 시작되었다. 1997년 제2회 대회까지의 개최를 발판으로 1998년에는 전문앙상블, 관악독주 등 소규모의 앙상블축제를 마련했다. 관악의 대중적 호응도와 축제성이 강한 홀수 해의 밴드축제와 병행하여 전문성에 초점을 맞춘 짝수 해의 축제였다. 이후 홀수해의 축제와 짝수해의 축제가 하나로 결합되어 현재까지 이어져오고 있다.제주국제관악제는 야외연주가 용이한 관악의 특성과 함께 제주가 갖고 있는 평화스런 이미지와 여름철 낭만이 조화를 이룬 관악축제이다. 이 축제는 관악만으로 특화된 공연과 콩쿠르의 융화를 통해서 관악의 예술성과 대중성, 전문성 등을 고루 추구하는 한국의 대표적인 음악축제 중의 하나이며 세계적으로 주목받는 전문 관악축제이다.','2021.12.03 ~ 2021.12.07',null,'http://www.jiwef.org','주차 가능','제주특별자치도 제주시 동광로 90',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','청도 프로방스 크리스마스 산타마을 빛축제','청도프로방스 크리스마스 산타마을 빛축제 레트로 빛축제와 산타마을 포토존으로 행복한 추억이 쌓이는 겨울 축제로 환영합니다.','2021.11.19 ~ 2022.01.23','09:00~18:00','http://www.cheongdo-provence.co.kr','주차가능','	경상북도 청도군 화양읍 이슬미로 272-23',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','의성세계하늘축제','코로나로 인해 2021년 12월 11일(토)부터 12일(일)까지 의성군 공식 유튜브 의성TV 및 네이버 메일신문TV를 통해 의성의 대표 연사 일대기를 비롯한 과거를 돌아보는 프로그램, 해외 카이트 영상 콘테스트 등 세계의 연을 만날 수 있는 프로그램 뿐만 아니라 다양한 온라인 참여ㆍ체험 프로그램을 통해 많은 사람들에게 의성과 연의 매력을 알리는 축제가 되길 기대해 본다.','2021.12.11 ~ 2021.12.12','14:00 ~ 18:00','http://www.worldskyfesta.com','주차가능','	경상북도 의성군 의성읍 중앙길 44',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','신라소리축제 에밀레전','통일 신라시대 때 조성된 성덕대왕신종(일명 에밀레종)을 주제로 한 신라 소리축제 에밀레전이 천년고도 경주에서 개최된다.','2021.11.12 ~ 2021.11.14','09:00~18:00','http://emille.or.kr','주차가능','경북 경주시 교동 274',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','고령 대가야 문화재 야행','대가야의 도읍지 고령에서 대가야의 역사를 여행하고 대가야의 문화를 체험하는 고령 대가야 문화재 야행(夜行)은 지역의 문화재를 조성시기와 역사적 특성에 따라 테마별, 인물별 서사구조를 창작하여 관광객에게 참여하는 재미와 감동을 이끌어 내는 야간 문화재 관람 및 다양한 체험프로그램이다. 고령군 지산동 일대에서 진행하는 이 행사의 20개 이상 프로그램들은 8夜(야경, 야로, 야사, 야화, 야설, 야시, 야식, 야시)로 나뉘어져있어 다양한 볼거리, 체험거리를 제공한다. 또한, 유튜브를 통해 비대면으로 실시간 라이브로도 즐길 수 있다.','2021.11.12 ~ 2021.11.13','09:00~18:00','http://yahaeng.or.kr/','주차가능','경상북도 고령군 대가야읍 대가야로 1216',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','포항스틸아트페스티벌','10주년을 맞은 포항스틸아트페스티벌은 "함께 열(十)다. 다시, 새롭게"라는 주제로 포항 오천 냉천, 연오랑세오녀테마공원 귀비고에서 진행된다.','2021.10.16 ~ 2021.10.30','09:00~18:00','	http://steel.phcf.or.kr/','주차가능','경상북도 포항시 북구 두호동 1015-6',sysdate, 0, 0);
insert into item values(item_seq.nextval, 1, '축제','신라소리축제 에밀레전1','통일 신라시대 때 조성된 성덕대왕신종(일명 에밀레종)을 주제로 한 신라 소리축제 에밀레전이 천년고도 경주에서 개최된다.','2021.11.12 ~ 2021.11.14','09:00~18:00','http://emille.or.kr','주차가능','경북 경주시 교동 274',sysdate, 0, 0);
-- 저장 (item)
COMMIT;

-- 테이블 데이터 보기 (item)
SELECT * FROM item;



-- ★★★★★★★★★★ item_reply ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (item_reply)

-- 테이블/시퀀스 새로 정의 (item_reply)
CREATE SEQUENCE item_reply_seq;
CREATE TABLE    item_reply(
  item_reply_idx     NUMBER                                NOT NULL CONSTRAINT item_reply_PK PRIMARY KEY,
  users_idx          REFERENCES users (users_idx)         ON DELETE CASCADE NOT NULL,
  item_idx           REFERENCES item(item_idx)             ON DELETE CASCADE NOT NULL,
  item_reply_detail  VARCHAR2(2000)                        NOT NULL,
  item_reply_date    DATE                                  DEFAULT SYSDATE NOT NULL,
  item_reply_superno REFERENCES item_reply(item_reply_idx) ON DELETE SET NULL,
  item_reply_groupno NUMBER                                DEFAULT 0 NOT NULL,
  item_reply_depth   NUMBER                                DEFAULT 0 NOT NULL
);

-- 저장 (item_reply)
COMMIT;

-- 테이블 데이터 보기 (item_reply)
SELECT * FROM item_reply;




-- ★★★★★★★★★★ item_file ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (item_file)

-- 테이블/시퀀스 새로 정의 (item_file)
CREATE SEQUENCE item_file_seq;
CREATE TABLE item_file(
item_file_idx        NUMBER                    NOT NULL            CONSTRAINT item_file_PK                PRIMARY KEY,
item_idx             REFERENCES item(item_idx) ON DELETE CASCADE,
item_file_uploadname VARCHAR2(256)             NOT NULL            CONSTRAINT item_file_uploadname_unique UNIQUE     ,
item_file_savename   VARCHAR2(256)             NOT NULL            CONSTRAINT item_file_savename_unique   UNIQUE     ,
item_file_size       NUMBER,
item_file_type       VARCHAR2(256)
);

-- 저장 (item_file)
COMMIT;

-- 테이블 데이터 보기 (item_file)
SELECT * FROM item_file;



-- ★★★★★★★★★★ course ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (course)

-- 테이블/시퀀스 새로 정의 (course)
CREATE SEQUENCE course_seq;
CREATE TABLE course(
  course_idx         NUMBER(20)                                   CONSTRAINT course_PK                   PRIMARY KEY,
  users_idx          REFERENCES users (users_idx) ON DELETE CASCADE,
  course_name        VARCHAR2(100)                                CONSTRAINT course_name_not_null        NOT NULL,
  course_detail      VARCHAR2(2000)                               CONSTRAINT course_detail_not_null      NOT NULL,
  course_date        DATE                         DEFAULT SYSDATE CONSTRAINT course_date_not_null        NOT NULL,
  course_count_view  NUMBER(20)                   DEFAULT 0       CONSTRAINT course_count_view_not_null  NOT NULL,
  course_count_reply NUMBER(20)                   DEFAULT 0       CONSTRAINT course_count_reply_not_null NOT NULL
);

-- 저장 (course)
COMMIT;

-- 테이블 데이터 보기 (course)
SELECT * FROM course;




-- ★★★★★★★★★★ course_item ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (course_item)

-- 테이블/시퀀스 새로 정의 (course_item)
CREATE SEQUENCE course_item_seq;
CREATE TABLE course_item(
  course_item_idx NUMBER(20)                  CONSTRAINT course_item_PK      PRIMARY KEY,
  item_idx        REFERENCES item(item_idx) ON DELETE SET NULL,
  course_idx      NUMBER(20)                  CONSTRAINT course_idx_not_null NOT NULL
                                              CONSTRAINT course_idx_check    CHECK(course_idx > 0)
);

-- 데이터 생성 (course_item 와 course를 동시에 해야 된다.)
--2~17 부산
INSERT INTO course_item values(course_item_seq.nextval,2,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,3,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,4,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'부산 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,2,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,3,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,4,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'부산 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,4,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,5,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,6,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'부산 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,7,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,8,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,9,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'부산 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,13,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,14,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,15,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'부산 테스트5','테스트',sysdate,0,0);

--18~37 인천
INSERT INTO course_item values(course_item_seq.nextval,18,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,19,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,20,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'인천 테스트0','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,20,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,21,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,22,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'인천 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,23,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,24,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,25,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'인천 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,26,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,27,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,28,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'인천 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,29,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,30,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,31,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'인천 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,32,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,33,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,34,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'인천 테스트5','테스트',sysdate,0,0);

--38번부터 60번 대구
INSERT INTO course_item values(course_item_seq.nextval,38,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,39,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,40,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'대구 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,41,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,42,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,43,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'대구 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,44,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,45,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,46,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'대구 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,47,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,48,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,49,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'대구 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,50,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,51,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,52,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'대구 테스트5','테스트',sysdate,0,0);
--61번부터 75 대전
INSERT INTO course_item values(course_item_seq.nextval,61,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,62,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,63,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'대전 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,61,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,62,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,63,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'대전 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,65,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,66,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,67,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'대전 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,68,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,69,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,70,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'대전 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,71,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,72,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,73,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'대전 테스트5','테스트',sysdate,0,0);
-- 79부터 102 광주
INSERT INTO course_item values(course_item_seq.nextval,81,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,82,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,83,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'광주 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,84,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,85,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,86,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'광주 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,87,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,88,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,89,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'광주 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,91,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,92,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,93,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'광주 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,96,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,97,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,99,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'광주 테스트5','테스트',sysdate,0,0);
--103부터 117 울산
INSERT INTO course_item values(course_item_seq.nextval,103,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,104,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,105,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'울산 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,106,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,107,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,108,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'울산 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,108,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,104,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,107,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'울산 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,111,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,112,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,113,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'울산 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,115,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,116,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,117,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'울산 테스트5','테스트',sysdate,0,0);
--118부터 131 세종
INSERT INTO course_item values(course_item_seq.nextval,118,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,119,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,120,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'세종 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,121,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,122,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,123,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'세종 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,124,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,125,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,126,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'세종 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,121,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,127,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,128,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'세종 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,129,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,128,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,130,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'세종 테스트5','테스트',sysdate,0,0);

--132부터 148 강원도
INSERT INTO course_item values(course_item_seq.nextval,134,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,132,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,133,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'강원 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,135,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,136,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,133,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'강원 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,137,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,138,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,133,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'강원 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,134,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,135,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,138,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'강원 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,139,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,138,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,136,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'강원 테스트5','테스트',sysdate,0,0);
--149부터 164 제주
INSERT INTO course_item values(course_item_seq.nextval,149,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,150,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,151,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'제주 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,152,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,153,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,154,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'제주 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,155,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,156,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,157,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'제주 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,159,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,158,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,157,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'제주 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,161,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,162,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,163,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'제주 테스트5','테스트',sysdate,0,0);

--165부터 180 경북
INSERT INTO course_item values(course_item_seq.nextval,165,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,166,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,167,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경북 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,167,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,168,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,169,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경북 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,170,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,171,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,172,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경북 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,175,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,173,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,174,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경북 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,178,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,179,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,180,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경북 테스트5','테스트',sysdate,0,0);

--181~198 경남
INSERT INTO course_item values(course_item_seq.nextval,181,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,182,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,183,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경남 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,184,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,185,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,186,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경남 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,187,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,188,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,189,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경남 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,190,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,191,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,192,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경남 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,193,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,194,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,195,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경남 테스트5','테스트',sysdate,0,0);

--199~216 전남
INSERT INTO course_item values(course_item_seq.nextval,200,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,201,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,202,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'전남 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,203,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,204,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,205,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'전남 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,206,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,207,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,208,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'전남 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,209,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,210,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,211,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'전남 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,212,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,213,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,214,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'전남 테스트5','테스트',sysdate,0,0);

--217~229 전북
INSERT INTO course_item values(course_item_seq.nextval,217,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,218,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,219,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'전북 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,220,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,221,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,222,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'전북 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,224,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,225,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,226,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'전북 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,223,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,222,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,226,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'전북 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,226,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,227,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,228,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'전북 테스트5','테스트',sysdate,0,0);
--232~251 충남
INSERT INTO course_item values(course_item_seq.nextval,232,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,233,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,234,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'충남 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,235,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,236,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,237,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'충남 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,238,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,237,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,239,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'충남 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,240,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,241,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,242,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'충남 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,243,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,244,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,245,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'충남 테스트5','테스트',sysdate,0,0);
--252~267 충북
INSERT INTO course_item values(course_item_seq.nextval,252,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,253,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,254,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'충북 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,255,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,256,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,257,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'충북 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,258,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,259,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,256,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'충북 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,260,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,261,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,262,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'충북 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,263,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,264,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,265,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'충북 테스트5','테스트',sysdate,0,0);
--269~280 282~285 경기
INSERT INTO course_item values(course_item_seq.nextval,270,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,271,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,272,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경기 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,274,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,275,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,276,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경기 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,277,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,278,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,279,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경기 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,280,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,271,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,272,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경기 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,282,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,283,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,272,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경기 테스트5','테스트',sysdate,0,0);
--286~294 서울
INSERT INTO course_item values(course_item_seq.nextval,286,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,287,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,288,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'서울 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,289,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,290,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,291,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'서울 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,292,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,293,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,294,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'서울 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,287,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,288,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,289,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'서울 테스트4','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,294,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,293,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,290,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'서울 테스트5','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,304,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,317,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,132,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'강원도 축제 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,141,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,317,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,132,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'강원도 축제 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,304,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,317,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,147,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'강원도 축제 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,306,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,312,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,319,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경기도 축제 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,309,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,312,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,319,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경기도 축제 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,319,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,309,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,312,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경기도 축제 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,314,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,322,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,300,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'부산 축제 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,300,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,322,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,314,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'부산 축제 테스트2','테스트',sysdate,0,0);


INSERT INTO course_item values(course_item_seq.nextval,323,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,301,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,305,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'서울 축제 테스트1','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,321,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,307,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,310,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'서울 축제 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,305,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,323,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,301,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'서울 축제 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,295,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,328,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,320,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경북 축제 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,328,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,329,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,295,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'경북 축제 테스트3','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,311,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,297,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,308,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'제주 축제 테스트2','테스트',sysdate,0,0);

INSERT INTO course_item values(course_item_seq.nextval,324,course_seq.nextval);
INSERT INTO course_item values(course_item_seq.nextval,311,course_seq.currval);
INSERT INTO course_item values(course_item_seq.nextval,308,course_seq.currval);
INSERT INTO course VALUES(course_seq.currval,1,'제주 축제 테스트3','테스트',sysdate,0,0);
-- 저장 (course_item 와 course)
COMMIT;

-- 테이블 데이터 보기 (course_item)
SELECT * FROM course_item;




-- ★★★★★★★★★★ course_reply ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (course_reply)

-- 테이블/시퀀스 새로 정의 (course_reply)
CREATE SEQUENCE course_reply_seq;
CREATE TABLE    course_reply(
  course_reply_idx     NUMBER
                       CONSTRAINT course_reply_PK                PRIMARY KEY,
  users_idx            REFERENCES users (users_idx)              ON DELETE CASCADE
                       CONSTRAINT users_idx_not_null_2           NOT NULL,
  course_idx           REFERENCES course(course_idx)             ON DELETE CASCADE
                       CONSTRAINT course_idx_not_null_2          NOT NULL,
  course_reply_detail  VARCHAR2(2000)
                       CONSTRAINT course_reply_deatil_not_null   NOT NULL,
  course_reply_date    DATE DEFAULT SYSDATE
                       CONSTRAINT course_reply_date_not_null     NOT NULL,
  course_reply_superno REFERENCES course_reply(course_reply_idx) ON DELETE SET NULL,
  course_reply_groupno NUMBER
                       DEFAULT 0
                       CONSTRAINT course_reply_groupno_not_null  NOT NULL,
  course_reply_depth   NUMBER DEFAULT 0
                       CONSTRAINT course_reply_depth_not_null    NOT NULL
);

-- 데이터 생성 (course_reply)

-- 저장 (course_reply)
COMMIT;

-- 테이블 데이터 보기 (course_reply)
SELECT * FROM course_reply;

-- ★★★★★★★★★★ course_like ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (course_like)

-- 테이블/시퀀스 새로 정의 (course_like)
create table course_like(
users_idx REFERENCES users (users_idx) ON DELETE CASCADE not null,
course_idx REFERENCES course (course_idx) ON DELETE CASCADE not null
);

-- 데이터 생성 (course_reply)

-- 저장 (course_like)
COMMIT;

-- 테이블 데이터 보기 (course_like)
SELECT * FROM course_like;


-- ★★★★★★★★★★ event ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (event)

-- 테이블/시퀀스 새로 정의 (event)
CREATE SEQUENCE event_seq;
CREATE TABLE event(
  event_idx         NUMBER(20)                   NOT NULL CONSTRAINT event_PK PRIMARY KEY,
  users_idx         REFERENCES users(users_idx)  ON DELETE SET NULL,
  event_name        VARCHAR2(100)                CONSTRAINT event_name_not_null   NOT NULL,
  event_detail      VARCHAR2(2000)               CONSTRAINT event_detail_not_null NOT NULL,
  event_date        DATE                         DEFAULT SYSDATE CONSTRAINT event_date_not_null   NOT NULL,
  event_count_view  NUMBER(20)                   DEFAULT 0 CONSTRAINT event_count_view_not_null  NOT NULL,
  event_count_reply NUMBER(20)                   DEFAULT 0 CONSTRAINT event_count_reply_not_null NOT NULL
);

-- 데이터 생성 (event)
INSERT INTO event VALUES(event_seq.NEXTVAL, 1, '노가리 투어 서포터즈', '관광코스 개발 및 월별 테마에 맞는 관광홍보미션 수행'                                      , TO_DATE('2021-11-01', 'YYYY-MM-DD'), 0, 0);
INSERT INTO event VALUES(event_seq.NEXTVAL, 3, '충북 청년 축제'      , '충북지역 청년들이 기획부터 운영까지 참여한 2021 충북 청년축제'                            , TO_DATE('2021-09-17', 'YYYY-MM-DD'), 0, 0);
INSERT INTO event VALUES(event_seq.NEXTVAL, 4, '강경 젓갈 축제'      , '강경젓갈시장에는 야간 경관을 조성해 강경을 찾는 관람객들에 아름다운 추억을 선사할 예정이다.', TO_DATE('2021-10-13', 'YYYY-MM-DD'), 0, 0);
INSERT INTO event VALUES(event_seq.NEXTVAL, 4, '괴산 고추 축제'      , '유기농의 메카, 괴산 방방곳곳 온-오프 투어'                                              , TO_DATE('2021-08-26', 'YYYY-MM-DD'), 0, 0);
INSERT INTO event VALUES(event_seq.NEXTVAL, 2, '영주 사과 축제'      , '가을이 익어가는 계절, ‘영주사과’를 온라인으로 만난다'                                    , TO_DATE('2021-10-13', 'YYYY-MM-DD'), 0, 0);

-- 저장 (event)
COMMIT;

-- 테이블 데이터 보기 (event)
SELECT * FROM event;




-- ★★★★★★★★★★ event_file ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (event_file)

-- 테이블/시퀀스 새로 정의 (event_file)
CREATE SEQUENCE event_file_seq;
CREATE TABLE event_file (
event_file_idx         NUMBER                    CONSTRAINT event_file_PK                   PRIMARY KEY
                                                 CONSTRAINT event_file_idx_not_null         NOT NULL,
event_idx              REFERENCES event(event_idx) ON DELETE CASCADE,
event_file_upload_name VARCHAR2(256)             CONSTRAINT event_file_upname_not_null      NOT NULL,
event_file_save_name   VARCHAR2(256)             CONSTRAINT event_file_savename_unique      UNIQUE
                                                 CONSTRAINT event_file_savename_not_null    NOT NULL,
event_file_size        NUMBER                    CONSTRAINT event_file_size_not_null        NOT NULL,
event_file_type        VARCHAR2(256)             CONSTRAINT event_file_type_not_null        NOT NULL
);

-- 저장 (event_file)
COMMIT;

-- 테이블 데이터 보기 (event_file)
SELECT * FROM event_file;

-- ★★★★★★★★★★ event_reply ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (event_reply)

-- 테이블/시퀀스 새로 정의 (event_reply)
CREATE SEQUENCE event_reply_seq;
CREATE TABLE    event_reply(
  event_reply_idx     NUMBER
                       CONSTRAINT event_reply_PK1                PRIMARY KEY,
  users_idx            REFERENCES users (users_idx)              ON DELETE CASCADE
                       CONSTRAINT users_idx_not_null_3           NOT NULL,
  event_idx           REFERENCES event(event_idx)             ON DELETE CASCADE
                       CONSTRAINT event_idx_not_null_3          NOT NULL,
  event_reply_detail  VARCHAR2(2000)
                       CONSTRAINT event_reply_deatil_not_null3   NOT NULL,
  event_reply_date    DATE DEFAULT SYSDATE
                       CONSTRAINT event_reply_date_not_null3     NOT NULL,
  event_reply_superno REFERENCES event_reply(event_reply_idx) ON DELETE SET NULL,
  event_reply_groupno NUMBER
                       DEFAULT 0
                       CONSTRAINT event_reply_groupno_not_null3  NOT NULL,
  event_reply_depth   NUMBER DEFAULT 0
                       CONSTRAINT event_reply_depth_not_null3    NOT NULL
);

-- 데이터 생성 (event_reply)

-- 저장 (event_reply)
COMMIT;

-- 테이블 데이터 보기 (event_reply)
SELECT * FROM event_reply;
