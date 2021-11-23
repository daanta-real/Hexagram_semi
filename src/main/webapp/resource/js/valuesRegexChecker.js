
// 각 DB 컬럼 내 들어갈 값으로 적합한지 검사해주는 자바스크립트 파일.

const valuesChecker = {
	val: { regex: {}, status: {} },
	chk: { verify: {}, checker: {} }
};

// 정규표현식 모음
valuesChecker.val.regex = {
	usersId: /^(?=[a-z].*)[a-z_0-9]{4,20}$/,
	usersPw: /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[-_~!@#$%^&*=+/,.;’”?])[a-zA-Z0-9-_~!@#$%^&*=+/,.;’”?]{4,20}$/,
	usersNick: /^[a-zA-Zㄱ-ㅎ가-힣0-9]{2,10}$/,
	usersPhone: /^(01[016-9])[0-9]{4}[0-9]{4}$/,
	usersEmail: /^[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\.([a-zA-Z])+$/
};

// 상태메세지 모음
valuesChecker.val.status = {
    usersPw:    { empty: "비밀번호를 입력해 주세요", regexFail: "비밀번호는 영문, 숫자, 특수문자 _-~!@#$%^&*=+/,.;’”? 하나씩 포함되야 합니다" }, 
    usersId:    { empty: "아이디를 입력해 주세요",   regexFail: "영문 소문자, 숫자, 특수문자_ 4~20자 이내로 입력해주세요", USED:"아이디가 이미 사용중입니다", CANUSE:"아이디 사용 가능" },   
    usersNick:  { empty: "닉네임을 입력해 주세요",   regexFail: "영문, 한글, 숫자 2~10글자로 작성해주세요", USED:"닉네임이 이미 사용중입니다", CANUSE:"닉네임 사용 가능" },
    usersPhone: { empty: "전화번호를 입력해 주세요", regexFail: "특수문자를 제외하고 01000000000 총 11자리로 입력해 주세요" },
    usersEmail: { empty: "이메일을 입력해 주세요",   regexFail: "이메일 형식에 맞지 않습니다", USED:"이메일이 이미 사용중입니다", CANUSE:"이메일 사용 가능" } 
};

// 브라우저단 유효성 검사
valuesChecker.chk.verify = {
	usersPw:    (val) => (val !== undefined || val.length == 0) ? "empty" : !valuesChecker.regex.usersPw.test(val)    ? "regexFail" : "pass",
	usersId:    (val) => (val !== undefined || val.length == 0) ? "empty" : !valuesChecker.regex.usersId.test(val)    ? "regexFail" : "pass",
	usersNick:  (val) => (val !== undefined || val.length == 0) ? "empty" : !valuesChecker.regex.usersNick.test(val)  ? "regexFail" : "pass",
	usersPhone: (val) => (val !== undefined || val.length == 0) ? "empty" : !valuesChecker.regex.usersPhone.test(val) ? "regexFail" : "pass",
	usersEmail: (val) => (val !== undefined || val.length == 0) ? "empty" : !valuesChecker.regex.usersEmail.test(val) ? "regexFail" : "pass"
};

// AJAX 중복 검사
valuesChecker.chk.checker = {
	usersPw: (val, callback, target) => {
		var params = {
			type:'get',
			url:sysurl +"/users/register_id_check.nogari",
			data: { usersPw:val },
			success: (resp) => { callback(valuesChecker.val.status.CANUSE)
			}
		};
		
	} /*
	usersId:    
	usersNick:  
	usersPhone: 
	usersEmail: */
}