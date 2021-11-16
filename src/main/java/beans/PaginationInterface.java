package beans;

import java.util.List;

public interface PaginationInterface<DTO> {

	public List<DTO> list(int begin, int end)
		throws Exception;

	public List<DTO> search(String column, String keyword, int begin, int end)
		throws Exception;

	public Integer count()
		throws Exception;

	public Integer count(String column, String keyword)
		throws Exception;

}