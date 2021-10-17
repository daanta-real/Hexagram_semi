package beans;

import java.io.BufferedInputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;


public class APIUtils {
	
	public static Document getDomCon(String strUrl) throws Exception {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		
		URL url = new URL(strUrl);
		BufferedInputStream xmldata = new BufferedInputStream(url.openStream());
		Document document = builder.parse(xmldata);
		
		xmldata.close();
		return document;
	}
	
}
