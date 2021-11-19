
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
                             REGEXP_LIKE(users_id, '.*?[a-z]+')
                               AND
                             (REGEXP_COUNT(users_id, '[a-z0-9_]') between 4 and 20)
                           ),
  users_pw    VARCHAR2(150) CONSTRAINT users_pw_not_null    NOT NULL
                            CONSTRAINT users_pw_check       CHECK(REGEXP_LIKE(users_pw, '.*?[a-zA-Z0-9-\$]+')),
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


INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email, users_grade) VALUES(users_seq.NEXTVAL, 'admin1', 'SHA-256$b6cc7d491f1c41274eba95daf5c6a2c3f28d3d61b5c8f870eba33db832c90ce7$d6b4cecc10e0254bc63f19e311a196fae42c4499167b8fe1efe81bf794907ff4', '관리자1', 'adm@a.com', '관리자');
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
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email) VALUES(users_seq.NEXTVAL, 'recommendation412@', 'SHA-256$6c91f74231f096cb2df9623264952ad222141fbc05f81e1deeee63ed5f8cdfd5$7436cad85f4635cb98257bfb955a3c90a4b71737bed6b680a3a2cf94fd6f5369', '닉네임47', 'kdawson@msn.com');
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
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름1' , '관광지내용 관광지내용1' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름1'   , '축제내용 축제내용1'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름2' , '관광지내용 관광지내용2' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름2'   , '축제내용 축제내용2'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름3' , '관광지내용 관광지내용3' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름3'   , '축제내용 축제내용3'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름4' , '관광지내용 관광지내용4' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름4'   , '축제내용 축제내용4'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름5' , '관광지내용 관광지내용5' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름5'   , '축제내용 축제내용5'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름6' , '관광지내용 관광지내용6' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름6'   , '축제내용 축제내용6'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름7' , '관광지내용 관광지내용7' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름7'   , '축제내용 축제내용7'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름8' , '관광지내용 관광지내용8' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름8'   , '축제내용 축제내용8'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름9' , '관광지내용 관광지내용9' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름9'   , '축제내용 축제내용9'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름10', '관광지내용 관광지내용10', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름10'  , '축제내용 축제내용10'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름11', '관광지내용 관광지내용11', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름11'  , '축제내용 축제내용11'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름12', '관광지내용 관광지내용12', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름12'  , '축제내용 축제내용12'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름13', '관광지내용 관광지내용13', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름13'  , '축제내용 축제내용13'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름14', '관광지내용 관광지내용14', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름14'  , '축제내용 축제내용14'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름15', '관광지내용 관광지내용15', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름15'  , '축제내용 축제내용15'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);

INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름16', '관광지내용 관광지내용16', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름16'  , '축제내용 축제내용16'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이17'  , '관광지내용 관광지내용17', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름17'  , '축제내용 축제내용17'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름18', '관광지내용 관광지내용18', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름18'  , '축제내용 축제내용18'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름19', '관광지내용 관광지내용19', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름19'  , '축제내용 축제내용19'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름20', '관광지내용 관광지내용20', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름20'  , '축제내용 축제내용20'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름21', '관광지내용 관광지내용21', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름21'  , '축제내용 축제내용21'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름22', '관광지내용 관광지내용22', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름22'  , '축제내용 축제내용22'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름23', '관광지내용 관광지내용23', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름23'  , '축제내용 축제내용23'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름24', '관광지내용 관광지내용24', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름24'  , '축제내용 축제내용24'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름25', '관광지내용 관광지내용25', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름25'  , '축제내용 축제내용25'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름26', '관광지내용 관광지내용26', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름26'  , '축제내용 축제내용26'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름27', '관광지내용 관광지내용27', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름27'  , '축제내용 축제내용27'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름28', '관광지내용 관광지내용28', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름28'  , '축제내용 축제내용13'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름29', '관광지내용 관광지내용29', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름29'  , '축제내용 축제내용29'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름30', '관광지내용 관광지내용30', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름30'  , '축제내용 축제내용30'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);

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

-- 데이터 생성 (course)
INSERT INTO course VALUES(1, 1, '코스제목1', '코스내용1', SYSDATE, 0, 0);
INSERT INTO course VALUES(2, 1, '코스제목2', '코스내용2', SYSDATE, 0, 0);
INSERT INTO course VALUES(3, 3, '코스제목3', '코스내용3', SYSDATE, 0, 0);

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
  item_idx        REFERENCES users(users_idx) ON DELETE SET NULL,
  course_idx      NUMBER(20)                  CONSTRAINT course_idx_not_null NOT NULL
                                              CONSTRAINT course_idx_check    CHECK(course_idx > 0)
);

-- 데이터 생성 (course_item)
INSERT INTO course_item VALUES(course_item_seq.NEXTVAL, 1, 1);
INSERT INTO course_item VALUES(course_item_seq.NEXTVAL, 2, 1);
INSERT INTO course_item VALUES(course_item_seq.NEXTVAL, 3, 1);

INSERT INTO course_item VALUES(course_item_seq.NEXTVAL, 4, 2);
INSERT INTO course_item VALUES(course_item_seq.NEXTVAL, 5, 2);
INSERT INTO course_item VALUES(course_item_seq.NEXTVAL, 6, 2);

INSERT INTO course_item VALUES(course_item_seq.NEXTVAL, 7, 3);
INSERT INTO course_item VALUES(course_item_seq.NEXTVAL, 8, 3);
INSERT INTO course_item VALUES(course_item_seq.NEXTVAL, 9, 3);

-- 저장 (course_item)
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




-- ★★★★★★★★★★ board_event ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (board_event)

-- 테이블/시퀀스 새로 정의 (board_event)
CREATE SEQUENCE board_event_seq;
CREATE TABLE board_event(
  event_idx         NUMBER(20)                   NOT NULL CONSTRAINT event_PK PRIMARY KEY,
  users_idx         REFERENCES users(users_idx) ON DELETE SET NULL,
  event_name        VARCHAR2(100)                NOT NULL,
  event_detail      VARCHAR2(2000)               NOT NULL,
  event_date        DATE                         NOT NULL,
  event_count_view  NUMBER(20)                   DEFAULT 0 NOT NULL,
  event_count_reply NUMBER(20)                   DEFAULT 0 NOT NULL
);

-- 데이터 생성 (board_event)
INSERT INTO board_event VALUES(board_event_seq.NEXTVAL, 1, '노가리 투어 서포터즈'  , '관광코스 개발 및 월별 테마에 맞는 관광홍보미션 수행'                                        , TO_DATE('2021-11-01', 'YYYY-MM-DD'), 0, 0);
INSERT INTO board_event VALUES(board_event_seq.NEXTVAL, 3, '충북 청년 축제'      , '충북지역 청년들이 기획부터 운영까지 참여한 2021 충북 청년축제'                              , TO_DATE('2021-09-17', 'YYYY-MM-DD'), 0, 0);
INSERT INTO board_event VALUES(board_event_seq.NEXTVAL, 5, '강경 젓갈 축제'      , '강경젓갈시장에는 야간 경관을 조성해 강경을 찾는 관람객들에 아름다운 추억을 선사할 예정이다.', TO_DATE('2021-10-13', 'YYYY-MM-DD'), 0, 0);
INSERT INTO board_event VALUES(board_event_seq.NEXTVAL, 7, '괴산 고추 축제'      , '유기농의 메카, 괴산 방방곳곳 온-오프 투어'                                                  , TO_DATE('2021-08-26', 'YYYY-MM-DD'), 0, 0);
INSERT INTO board_event VALUES(board_event_seq.NEXTVAL, 9, '영주 사과 축제'      , '가을이 익어가는 계절, ‘영주사과’를 온라인으로 만난다'                                     , TO_DATE('2021-10-13', 'YYYY-MM-DD'), 0, 0);

-- 저장 (board_event)
COMMIT;

-- 테이블 데이터 보기 (board_event)
SELECT * FROM board_event;