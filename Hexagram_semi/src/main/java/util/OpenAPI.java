package util;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class OpenAPI {


	public static void main(String[] args) {


		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		List<String[]> strList = new ArrayList<>();
		try {
			DocumentBuilder builder = factory.newDocumentBuilder();
			int total = 0;
			int pageNo = 1;

			@SuppressWarnings("unused")
			String urlString = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList"
					+ "?ServiceKey=8449nJCdkPtXHEe5cmeJbx9PwaXdOWgXRrm%2BL7ooFLzFw%2FQHA8kMJA57Q%2FvGXRb59Ih7utDWjQqkYPBFKungEQ%3D%3D"
					+ "&contentTypeId=12&areaCode=1&sigunguCode=&cat1=&cat2=&cat3=&listYN=Y"
					+ "&MobileOS=ETC&MobileApp=TourAPI3.0_Guide&arrange=A&numOfRows=12&pageNo="+pageNo+"";

			String input = "대구";
			String type = "UTF-8";
			while(true) {
			String keyword = URLEncoder.encode(input,type);

			StringBuffer buffer_url= new StringBuffer();
			buffer_url.append("http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword");
			buffer_url.append("?ServiceKey=8449nJCdkPtXHEe5cmeJbx9PwaXdOWgXRrm%2BL7ooFLzFw%2FQHA8kMJA57Q%2FvGXRb59Ih7utDWjQqkYPBFKungEQ%3D%3D");
			buffer_url.append("&keyword=");
			buffer_url.append(keyword);
			buffer_url.append("&MobileOS=ETC&MobileApp=TourAPI3.0_Guide&arrange=A&numOfRows=12&pageNo=");
			buffer_url.append(pageNo);
					pageNo++;

			URL url = new URL(buffer_url.toString());
			System.out.println(url.openStream());

			BufferedInputStream xmldata = new BufferedInputStream(url.openStream());

			Document document = builder.parse(xmldata);

			Element root = document.getDocumentElement();

			NodeList list = root.getElementsByTagName("item");

			total += list.getLength();
			if(list.getLength() == 0) break;

			for(int i=0 ; i<list.getLength() ; i++) {
					Node node = list.item(i);
					NodeList item_childList = node.getChildNodes();
					String strArray[] = new String[3];

					for(int k = 0 ; k<item_childList.getLength() ; k++) {
						Node item_child = item_childList.item(k);

						if(k==0) {
							if(!item_child.getTextContent().contains(input)) {
								total--;
								strArray = null;
							break;
							}
						}

						strArray[0] = item_childList.item(0).getTextContent();

						if(item_child.getNodeName().equals("mapy"))
							strArray[1] = item_child.getTextContent();

						if(item_child.getNodeName().equals("mapx"))
							strArray[2] = item_child.getTextContent();


						System.out.println(item_child.getNodeName()+":"+item_child.getTextContent());
						}

					if(strArray != null) {
					strList.add(strArray);
					}
					System.out.println();
			}
			}
			System.out.println("관광지역 : " + input);
			System.out.println("총 관광지 수 : "+total);
			System.out.println("마지막 페이지 수 : "+pageNo);
			for(int i = 0 ; i<strList.size() ; i++) {
				System.out.println(Arrays.toString(strList.get(i)));
			}
			System.out.println(strList.size());


		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
