package util;

import java.io.BufferedInputStream;
import java.net.URL;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;


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
