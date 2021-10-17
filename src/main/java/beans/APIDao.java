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

	public List<APIDto> getTourList(int region,int section,int rowNum,int number) throws Exception{
		List<APIDto> listDto = new ArrayList<>();
		String buffer_url = getTourListString(region,section,rowNum,number);
		Document document = APIUtils.getDomCon(buffer_url);
		Element root = document.getDocumentElement();
		NodeList list = root.getElementsByTagName("item");
		
		
		for(int i=0 ; i<list.getLength() ; i++) {
				Node node = list.item(i);
				NodeList item_childList = node.getChildNodes();
				APIDto aPIDto = new APIDto();
				
				for(int k = 0 ; k<item_childList.getLength() ; k++) {
					Node item_child = item_childList.item(k);
					
					if(item_child.getNodeName().equals("addr1"))
						aPIDto.setAddress(item_child.getTextContent());
					if(item_child.getNodeName().equals("title"))
						aPIDto.setTitle(item_child.getTextContent());
					if(item_child.getNodeName().equals("mapy"))
						aPIDto.setMapy(item_child.getTextContent());
					if(item_child.getNodeName().equals("mapx"))
						aPIDto.setMapx(item_child.getTextContent());
					if(item_child.getNodeName().equals("contenttypeid"))
						aPIDto.setContenttypeid(item_child.getTextContent());
					if(item_child.getNodeName().equals("firstimage"))
						aPIDto.setImg(item_child.getTextContent());
					if(item_child.getNodeName().equals("contentid"))
						aPIDto.setContentid(item_child.getTextContent());
					
					}
				listDto.add(aPIDto);
		}
		return listDto;
	}
	
	
	public APIDto getTourObject(APIDto aPIDto,String contentid) throws Exception{
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
					aPIDto.setHomepage(item_child.getTextContent());
				if(item_child.getNodeName().equals("overview"))
					aPIDto.setOverview(item_child.getTextContent());
				}
	}
		
		return aPIDto;
	}
	
	public APIDto getTourSegmentObject(String contentid) throws Exception{
		String buffer_url = getTourDetailExaminationString(contentid);
		APIDto aPIDto = new APIDto();
		
		Document document = APIUtils.getDomCon(buffer_url);
		Element root = document.getDocumentElement();
		NodeList list = root.getElementsByTagName("item");
		
		for(int i=0 ; i<list.getLength() ; i++) {
			
			Node node = list.item(i);
			NodeList item_childList = node.getChildNodes();	
			
			for(int k = 0 ; k<item_childList.getLength() ; k++) {
				Node item_child = item_childList.item(k);
				
				if(item_child.getNodeName().equals("homepage"))
					aPIDto.setHomepage(item_child.getTextContent());
				if(item_child.getNodeName().equals("overview"))
					aPIDto.setOverview(item_child.getTextContent());
				}
	}
		
		return aPIDto;
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
	
	public APIDto getEtcInfo(String contentid) throws Exception{
		String buffer_url = getEtcString(contentid);
		APIDto aPIDto = new APIDto();
		
		Document document = APIUtils.getDomCon(buffer_url);
		Element root = document.getDocumentElement();
		NodeList list = root.getElementsByTagName("item");
		
		for(int i=0 ; i<list.getLength() ; i++) {
			
			Node node = list.item(i);
			NodeList item_childList = node.getChildNodes();	
			
			for(int k = 0 ; k<item_childList.getLength() ; k++) {
				Node item_child = item_childList.item(k);
				
				if(item_child.getNodeName().equals("infocenter"))
					aPIDto.setInfocenter(item_child.getTextContent());
				if(item_child.getNodeName().equals("parking"))
					aPIDto.setParking(item_child.getTextContent());
				if(item_child.getNodeName().equals("usetime"))
					aPIDto.setUsetime(item_child.getTextContent());

				}
	}
		
		return aPIDto;
	}
	
}
