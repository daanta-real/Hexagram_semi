package beans;

import java.util.ArrayList;
import java.util.List;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class APIDao {
	
	public String getEtcString(String contentid) {
		StringBuffer buffer= new StringBuffer();
		buffer.append("http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailIntro");
		buffer.append("?ServiceKey=8449nJCdkPtXHEe5cmeJbx9PwaXdOWgXRrm%2BL7ooFLzFw%2FQHA8kMJA57Q%2FvGXRb59Ih7utDWjQqkYPBFKungEQ%3D%3D");
		buffer.append("&contentId=").append(contentid).append("&contentTypeId=12&MobileOS=ETC&MobileApp=TourAPI3.0_Guide");
		
		return buffer.toString();
	}
	
	public String getRegionString() {
		StringBuffer buffer= new StringBuffer();
		buffer.append("http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode");
		buffer.append("?ServiceKey=8449nJCdkPtXHEe5cmeJbx9PwaXdOWgXRrm%2BL7ooFLzFw%2FQHA8kMJA57Q%2FvGXRb59Ih7utDWjQqkYPBFKungEQ%3D%3D");
		buffer.append("&MobileOS=ETC&MobileApp=AppTest&numOfRows=17");

		return buffer.toString();
	}
	
	public String getSigunguString(int region) {
		StringBuffer buffer= new StringBuffer();
		buffer.append("http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode");
		buffer.append("?ServiceKey=8449nJCdkPtXHEe5cmeJbx9PwaXdOWgXRrm%2BL7ooFLzFw%2FQHA8kMJA57Q%2FvGXRb59Ih7utDWjQqkYPBFKungEQ%3D%3D");
		buffer.append("&areaCode=").append(region);
		buffer.append("&numOfRows=25&pageNo=1&MobileOS=ETC&MobileApp=AppTest");

		return buffer.toString();
	}
	
	public String getTourListString(int region,int section,int rowNum,int number) {
		StringBuffer buffer= new StringBuffer();
		buffer.append("http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList");
		buffer.append("?ServiceKey=8449nJCdkPtXHEe5cmeJbx9PwaXdOWgXRrm%2BL7ooFLzFw%2FQHA8kMJA57Q%2FvGXRb59Ih7utDWjQqkYPBFKungEQ%3D%3D");
		buffer.append("&contentTypeId=12&areaCode=").append(region);
		buffer.append("&sigunguCode=").append(section);
		buffer.append("&cat1=&cat2=&cat3=&listYN=Y&MobileOS=ETC&MobileApp=TourAPI3.0_Guide&arrange=A&numOfRows=");
		buffer.append(rowNum).append("&pageNo=").append(number);
		
		return buffer.toString();
	}
	

	public String getTourDetailExaminationString(String contentid) {
		StringBuffer buffer= new StringBuffer();
		buffer.append("http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon");
		buffer.append("?ServiceKey=8449nJCdkPtXHEe5cmeJbx9PwaXdOWgXRrm%2BL7ooFLzFw%2FQHA8kMJA57Q%2FvGXRb59Ih7utDWjQqkYPBFKungEQ%3D%3D");
		buffer.append("&contentId=").append(contentid);
		buffer.append("&defaultYN=Y&addrinfoYN=Y&overviewYN=Y&MobileOS=ETC&MobileApp=AppTest");
		
		return buffer.toString();
	}
	
	public String getTourAroundString(String mapX , String mapY) {
		StringBuffer buffer= new StringBuffer();
		buffer.append("http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList");
		buffer.append("?ServiceKey=8449nJCdkPtXHEe5cmeJbx9PwaXdOWgXRrm%2BL7ooFLzFw%2FQHA8kMJA57Q%2FvGXRb59Ih7utDWjQqkYPBFKungEQ%3D%3D");
		buffer.append("&mapX=").append(mapX).append("&mapY=").append(mapY);
		buffer.append("&radius=1000&listYN=Y&arrange=A&MobileOS=ETC&MobileApp=AppTest");
		
		return buffer.toString();
	}

	public List<TestDto> getTourList(int region,int section,int rowNum,int number) throws Exception{
		List<TestDto> listDto = new ArrayList<>();
		String buffer_url = getTourListString(region,section,rowNum,number);
		Document document = APIUtils.getDomCon(buffer_url);
		Element root = document.getDocumentElement();
		NodeList list = root.getElementsByTagName("item");
		
		
		for(int i=0 ; i<list.getLength() ; i++) {
				Node node = list.item(i);
				NodeList item_childList = node.getChildNodes();
				TestDto testDto = new TestDto();
				
				for(int k = 0 ; k<item_childList.getLength() ; k++) {
					Node item_child = item_childList.item(k);
					
					if(item_child.getNodeName().equals("addr1"))
						testDto.setAddress(item_child.getTextContent());
					if(item_child.getNodeName().equals("title"))
						testDto.setTitle(item_child.getTextContent());
					if(item_child.getNodeName().equals("mapy"))
						testDto.setMapy(item_child.getTextContent());
					if(item_child.getNodeName().equals("mapx"))
						testDto.setMapx(item_child.getTextContent());
					if(item_child.getNodeName().equals("contenttypeid"))
						testDto.setContenttypeid(item_child.getTextContent());
					if(item_child.getNodeName().equals("firstimage"))
						testDto.setImg(item_child.getTextContent());
					if(item_child.getNodeName().equals("contentid"))
						testDto.setContentid(item_child.getTextContent());
					
					}
				listDto.add(testDto);
		}
		return listDto;
	}
	
	
	public TestDto getTourObject(TestDto testDto,String contentid) throws Exception{
		String buffer_url = getTourDetailExaminationString(contentid);
		
		Document document = APIUtils.getDomCon(buffer_url);
		Element root = document.getDocumentElement();
		NodeList list = root.getElementsByTagName("item");
		
		for(int i=0 ; i<list.getLength() ; i++) {
			
			Node node = list.item(i);
			NodeList item_childList = node.getChildNodes();	
			
			for(int k = 0 ; k<item_childList.getLength() ; k++) {
				Node item_child = item_childList.item(k);
				
				if(item_child.getNodeName().equals("homepage"))
					testDto.setHomepage(item_child.getTextContent());
				if(item_child.getNodeName().equals("overview"))
					testDto.setOverview(item_child.getTextContent());
				}
	}
		
		return testDto;
	}
	
	public TestDto getTourSegmentObject(String contentid) throws Exception{
		String buffer_url = getTourDetailExaminationString(contentid);
		TestDto testDto = new TestDto();
		
		Document document = APIUtils.getDomCon(buffer_url);
		Element root = document.getDocumentElement();
		NodeList list = root.getElementsByTagName("item");
		
		for(int i=0 ; i<list.getLength() ; i++) {
			
			Node node = list.item(i);
			NodeList item_childList = node.getChildNodes();	
			
			for(int k = 0 ; k<item_childList.getLength() ; k++) {
				Node item_child = item_childList.item(k);
				
				if(item_child.getNodeName().equals("homepage"))
					testDto.setHomepage(item_child.getTextContent());
				if(item_child.getNodeName().equals("overview"))
					testDto.setOverview(item_child.getTextContent());
				}
	}
		
		return testDto;
	}
	
	public List<String> getReionName() throws Exception{
		String buffer_url = getRegionString();
		
		Document document = APIUtils.getDomCon(buffer_url);
		Element root = document.getDocumentElement();
		NodeList list = root.getElementsByTagName("item");
		List<String> strList = new ArrayList<>();
		
		for(int i=0 ; i<list.getLength() ; i++) {
			
			Node node = list.item(i);
			NodeList item_childList = node.getChildNodes();	
			
			for(int k = 0 ; k<item_childList.getLength() ; k++) {
				Node item_child = item_childList.item(k);
				
				if(item_child.getNodeName().equals("name"))
					strList.add(item_child.getTextContent());

				}
	}
		
		return strList;
	}
	
	public List<String> getSigunguName(int region) throws Exception{
		String buffer_url = getSigunguString(region);
		
		Document document = APIUtils.getDomCon(buffer_url);
		Element root = document.getDocumentElement();
		NodeList list = root.getElementsByTagName("item");
		List<String> strList = new ArrayList<>();
		
		for(int i=0 ; i<list.getLength() ; i++) {
			
			Node node = list.item(i);
			NodeList item_childList = node.getChildNodes();	
			
			for(int k = 0 ; k<item_childList.getLength() ; k++) {
				Node item_child = item_childList.item(k);
				
				if(item_child.getNodeName().equals("name"))
					strList.add(item_child.getTextContent());

				}
	}
		
		return strList;
	}
	
	public TestDto getEtcInfo(String contentid) throws Exception{
		String buffer_url = getEtcString(contentid);
		TestDto testDto = new TestDto();
		
		Document document = APIUtils.getDomCon(buffer_url);
		Element root = document.getDocumentElement();
		NodeList list = root.getElementsByTagName("item");
		
		for(int i=0 ; i<list.getLength() ; i++) {
			
			Node node = list.item(i);
			NodeList item_childList = node.getChildNodes();	
			
			for(int k = 0 ; k<item_childList.getLength() ; k++) {
				Node item_child = item_childList.item(k);
				
				if(item_child.getNodeName().equals("infocenter"))
					testDto.setInfocenter(item_child.getTextContent());
				if(item_child.getNodeName().equals("parking"))
					testDto.setParking(item_child.getTextContent());
				if(item_child.getNodeName().equals("usetime"))
					testDto.setUsetime(item_child.getTextContent());

				}
	}
		
		return testDto;
	}
	
}
