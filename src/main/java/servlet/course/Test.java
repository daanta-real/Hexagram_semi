package servlet.course;

import java.util.List;

import beans.ItemDao;
import beans.ItemDto;

public class Test {
	public static void main(String[] args) throws Exception {
		ItemDao itemDao = new ItemDao();
		List<ItemDto> list = itemDao.getCityList("서울");
		if(list != null)
		System.out.println(list.size());
	}
}
