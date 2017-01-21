package com.sca.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.sca.bean.InputData;
import com.sca.bean.ParseData;
import com.sca.bean.ParseDataRollUp;
import com.sca.bean.Location;


@Controller
public class VisualizeController {
	private @Autowired ServletContext servletContext;
	StringBuilder sb;
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView getCrimeAndYear() {
		ModelAndView model = new ModelAndView("Visualize");

		InputStream inputStream = null;
		try {
			inputStream = servletContext.getResourceAsStream("/resources/jsonfile/rakesh.json");
            BufferedReader br = new BufferedReader(new InputStreamReader(inputStream));
			String line = null;
			sb = new StringBuilder();
			
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			br.close();
			
			
			System.out.println(sb);
		} catch (FileNotFoundException fnfe) {
			fnfe.printStackTrace();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/submitForm", method = RequestMethod.POST)
	public ModelAndView createJsonDataYearCrime(@ModelAttribute("inputData") InputData inputData) {

		String displayContent = null;
		String crimeType = inputData.getCrimeType();
		String year = inputData.getYear();
		ModelAndView model = new ModelAndView("Visualize");
		JSONArray jsonArrayVisualize = null;
		JSONArray jsonArrayMaps = null;
		String trendTitle = crimeType + " in " + year;
		List<ParseData> list = null;

		System.out.println(inputData.getCrimeType() + " " + inputData.getYear());
		System.out.println(sb.toString());
		if (crimeType.equals("please_select") || year.equals("please_select")) {
			displayContent = "Please select both the fields!";
			model.addObject("displayContent", displayContent);
			return model;
		}
		else 
		{
			try 
			{
				JSONArray jsonArray = new JSONArray(sb.toString());
				JSONObject jsonObject;
				list = new ArrayList<ParseData>();
				
				if (crimeType.equals("ALL CRIMES") && year.equals("All Years"))
				{
					for (int i = 0; i < jsonArray.length(); i++) 
					{
						jsonObject = jsonArray.getJSONObject(i);
						list.add(new ParseData(jsonObject.getString("Event Clearance Description"),
								String.valueOf(jsonObject.getInt("Event Year")),
								new Location(jsonObject.getDouble("Longitude"), jsonObject.getDouble("Latitude"))));
					}		
				}
				else if (crimeType.equals("ALL CRIMES"))
				{
					for (int i = 0; i < jsonArray.length(); i++) 
					{
						jsonObject = jsonArray.getJSONObject(i);
						if ((jsonObject.getInt("Event Year") == Integer.parseInt(year))) 
						{
							list.add(new ParseData(jsonObject.getString("Event Clearance Description"),
									jsonObject.getString("Event Date"),
									new Location(jsonObject.getDouble("Longitude"), jsonObject.getDouble("Latitude"))));
						}
					}
				}
				else if (year.equals("All Years"))
				{
					for (int i = 0; i < jsonArray.length(); i++) 
					{
						jsonObject = jsonArray.getJSONObject(i);
						if ((jsonObject.getString("Event Clearance Description").equals(crimeType))) 
						{
							list.add(new ParseData(jsonObject.getString("Event Clearance Description"),
									String.valueOf(jsonObject.getInt("Event Year")),
									new Location(jsonObject.getDouble("Longitude"), jsonObject.getDouble("Latitude"))));
						}
					}
				}
				else
				{
					for (int i = 0; i < jsonArray.length(); i++) 
					{
						jsonObject = jsonArray.getJSONObject(i);
						if ((jsonObject.getString("Event Clearance Description").equals(crimeType))
								&& (jsonObject.getInt("Event Year") == Integer.parseInt(year))) 
						{
							list.add(new ParseData(jsonObject.getString("Event Clearance Description"),
									jsonObject.getString("Event Date"), 
									new Location(jsonObject.getDouble("Longitude"), jsonObject.getDouble("Latitude"))));
						}
					}
				}
				
				
				
				ArrayList<ParseDataRollUp> listRollUp = new ArrayList<ParseDataRollUp>();
				boolean boolExist;
				for (ParseData parseData : list) 
				{
					boolExist = false;
					Iterator itr = listRollUp.iterator();
					while (itr.hasNext()) {
						ParseDataRollUp p = (ParseDataRollUp) itr.next();
						if ((p.getCrimeType().equals(parseData.getStringA()))
								&& (p.getTimeLine().equals(parseData.getStringB()))) 
						{
							p.setNumberOfCrimes((p.getNumberOfCrimes()) + 1);
							boolExist = true;
							break;
						}
					}
					if (!boolExist) 
					{
						listRollUp.add(new ParseDataRollUp(parseData.getStringA(), parseData.getStringB(), 1));
					}
				}

				jsonArrayVisualize = new JSONArray();
				JSONObject jsonObjectVisualize;
				for (ParseDataRollUp p : listRollUp) 
				{
					jsonObjectVisualize = new JSONObject();
					jsonObjectVisualize.put("timeline", p.getTimeLine());
					jsonObjectVisualize.put("crimetype", p.getCrimeType());
					jsonObjectVisualize.put("numberofcrimes", p.getNumberOfCrimes());
					jsonArrayVisualize.put(jsonObjectVisualize);
				}
				//System.out.println("jsonArrayVisualize: " + jsonArrayVisualize);
				
				jsonArrayMaps = new JSONArray();
				JSONObject jsonObjectMaps;
				JSONObject jsonObjectLocation;
				for(ParseData parseData: list)
				{
					jsonObjectMaps = new JSONObject();
					jsonObjectMaps.put("timeline", parseData.getStringB());
					jsonObjectMaps.put("crimetype", parseData.getStringA());
					
					jsonObjectLocation = new JSONObject();
					jsonObjectLocation.put("longitude", parseData.getLocation().getLongitude());
					jsonObjectLocation.put("latitude", parseData.getLocation().getLatitude());
					jsonObjectMaps.put("jsonObjectLocation", jsonObjectLocation);
					
					jsonArrayMaps.put(jsonObjectMaps);
				}
				
				//System.out.println(jsonArrayMaps);
				
			} catch (JSONException e) {
				e.printStackTrace();
			}
			System.out.println(jsonArrayVisualize);
			System.out.println(jsonArrayMaps);
			model.addObject("mapJson", jsonArrayMaps);
			model.addObject("trendTitle", trendTitle);
			model.addObject("jsonTrend", jsonArrayVisualize);
			return model;
		}
		
		
	}

}
