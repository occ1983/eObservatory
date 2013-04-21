package org.eobservatory.dao;

import java.util.List;

import org.eobservatory.model.NearEarthObject;
import org.eobservatory.util.NearEarthObjectFilter;

public interface NearEarthObjectDAO {
	List<NearEarthObject> list(NearEarthObjectFilter filter);
	NearEarthObject findOne(String id);
	void save(NearEarthObject nearEarthObject);
}
