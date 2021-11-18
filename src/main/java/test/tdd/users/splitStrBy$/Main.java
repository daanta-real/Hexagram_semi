package test.tdd.users.splitStrBy$;

import java.util.Arrays;

public class Main {

	public static void main(String[] args) {
		// String을 $로 찢을 때에는 역슬래시를 필히 붙이도록 한다.
		String s = "SHA-256$b6cc7d491f1c41274eba95daf5c6a2c3f28d3d61b5c8f870eba33db832c90ce7$d6b4cecc10e0254bc63f19e311a196fae42c4499167b8fe1efe81bf794907ff4";
		String[] d = s.split("\\$");
		System.out.println("배열 크기: " + d.length);
		System.out.println("배열 정보: " + Arrays.toString(d));
	}

}
