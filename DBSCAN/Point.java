/**
 * 
 * This class represents a Point from the database.
 * 
 */
public class Point {
	
	public Integer clusterId;
	public Double[] coordinates;
	
	/**
	 * Calculates the euclidian distance between two points.
	 */
	public double distance(Point point) {
		double distance = 0.0;
		
		for(int i = 0 ; i < coordinates.length ; i++) {
			distance += ((coordinates[i] - point.coordinates[i]) 
					* (coordinates[i] - point.coordinates[i]));
		}
		
		return Math.sqrt(distance);
	}
	
	public Point(Double[] coordinates) {
		this.coordinates = coordinates;
		clusterId = -1;
	}
	
	public String getCoordinates() {
		String ret = "";
		for(int i = 0 ; i < coordinates.length ; i++) {
			ret += coordinates[i] + " ";
		}
		return ret;
	}
	
	/**
	 * 
	 * @param point
	 * @return
	 */
	public boolean isEqual(Point point) {
		for(int i = 0 ; i < coordinates.length ; i++) {
			if(coordinates[i] != point.coordinates[i])
				return false;
		}
		return true;
	}
}