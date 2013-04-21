package org.eobservatory.util;

import java.util.List;

public class DataTable {
	private List aaData;
	
	public DataTable()
	{
		
	}
	
	public DataTable(List aaData)
	{
		this.aaData = aaData;
	}

	public List getAaData() {
		return aaData;
	}

	public void setAaData(List aaData) {
		this.aaData = aaData;
	}

}
