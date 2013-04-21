package org.eobservatory.service;

import java.util.List;

import org.eobservatory.model.CommentDataObject;
import org.eobservatory.model.NearEarthObject;
import org.eobservatory.util.NearEarthObjectFilter;

public interface NearEarthObjectService {
	List<NearEarthObject> listNearEarthObjects(NearEarthObjectFilter filter);
	NearEarthObject findNearEarthObject(String id);
	void save(NearEarthObject nearEarthObject);
	void addComment(CommentDataObject commentDataObject);
}
