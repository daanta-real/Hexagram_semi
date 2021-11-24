package beans;

import java.util.Objects;

public class CourseItemDto {
	private int courseItemIdx;
	private int itemIdx; 
	private int courseIdx;
	
	
	
	public int getCourseItemIdx() {
		return courseItemIdx;
	}



	public void setCourseItemIdx(int courseItemIdx) {
		this.courseItemIdx = courseItemIdx;
	}



	public int getItemIdx() {
		return itemIdx;
	}



	public void setItemIdx(int itemIdx) {
		this.itemIdx = itemIdx;
	}



	public int getCourseIdx() {
		return courseIdx;
	}



	public void setCourseIdx(int courseIdx) {
		this.courseIdx = courseIdx;
	}



	@Override
	public int hashCode() {
		return Objects.hash(itemIdx);
	}



	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CourseItemDto other = (CourseItemDto) obj;
		return itemIdx == other.itemIdx;
	}
//위의 동등비교는 CourseAjaxItemAddServlet와 CourseAjaxItemAddForUpdateServlet에서 
	//courseItemList의 CourseItemDto의 item_idx만을 꺼내어서 현재 리스트에 담겨있는지 확인하기 위해서임(비교를 item_idx = 관광지 번호가 있냐?)로 비교함)


	public CourseItemDto() {
		super();
	}

}
