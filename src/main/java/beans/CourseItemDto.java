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



	public CourseItemDto() {
		super();
	}

}
