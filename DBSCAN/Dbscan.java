import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class Dbscan {

	public ArrayList<Point> points;
	public double eps;
	public int minPoints;
	public int clusterId = 1;
	
	public final Integer UNCLASSIFIED 	= -1;
	public final Integer NOISE 			= 0;

	public Dbscan(double eps, int minPts) throws IOException {
		this.eps = eps;
		this.minPoints = minPts;
		readDataFile();
	}

	public void readDataFile() throws IOException {
		BufferedReader br = new BufferedReader(new FileReader(new File("conjunto_agrupamento.data.txt")));
		String line = "";
		while( (line = br.readLine()) != null ) {
			String[] aux = line.split("\t");
			Double[] coord = new Double[aux.length];
			for(int i = 0 ; i < aux.length ; i++) {
				coord[i] = new Double(aux[i]);
			}
			points.add(new Point(coord));
		}
		br.close();
		print();
	}

	public void dbscan() {
		for(int i = 0 ; i < points.size() ; i++) {
			Point point = points.get(i);
			// If the point is not in a cluster yet
			if(point.clusterId == UNCLASSIFIED) {
				if(expandCluster(points, point, clusterId, eps, minPoints)) {
					clusterId = getNextId();
				}
			}
		}
	}

	public void dbscan(double eps, int minPts) {
		
	}
	
	private boolean expandCluster(ArrayList<Point> points, Point point, int id,
			Double eps, Integer minPoints) {
		ArrayList<Point> seeds = regionQuery(points, point, eps);
		
		if(seeds.size() < minPoints) {
			point.clusterId = NOISE;
			return false;
		}
		
		changeIdsOfReachablePoints(seeds, point, id);
		
		while(seeds.size() > 0) {
			Point current = seeds.get(0);
			
			
			
			seeds.remove(0);
		}
		
		return true;
	}
	
	/**
	 * Changes the labels of the points and remove the 
	 * inicial point of the seeds.
	 * 
	 * @param seeds
	 * @param point
	 * @param id
	 */
	private void changeIdsOfReachablePoints(ArrayList<Point> seeds, Point point, int id) {
		for(int i = 0 ; i < seeds.size() ; i++) {
			seeds.get(i).clusterId = id;
			if(point.equals(seeds.get(i))) {
				seeds.remove(i);
			}
		}
	}

	private ArrayList<Point> regionQuery(ArrayList<Point> points, Point point, Double eps) {
		ArrayList<Point> seeds = new ArrayList<Point>();
		for(int i = 0 ; i < points.size() ; i++) {
			if(point.distance(points.get(i)) <= eps) {
				seeds.add(points.get(i));
			}
		}
		return seeds;
	}
	
	public int getNextId() {
		clusterId++;
		return clusterId;
	}
	
	public static void main(String[] args) {
		try {
			Dbscan db = new Dbscan(2.0, 10);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void print() {
		for(int i = 0 ; i < points.size() ;i++) {
			System.out.println("Cluster: " + points.get(i).clusterId + " Coords: " + points.get(i).getCoordinates());
		}
	}
}