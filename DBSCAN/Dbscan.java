import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

public class Dbscan {

	private ArrayList<Point> data = new ArrayList<Point>();

	private final Integer UNCLASSIFIED 	= -1;
	private final Integer NOISE 		= 0;

	public Dbscan(String path) {
		readData(path);
	}

	@SuppressWarnings("unchecked")
	public int dbscan(Double eps, Integer minPoints) {
		Integer clusterId = 1;
		ArrayList<Point> points = new ArrayList<Point>();
		points = (ArrayList<Point>) data.clone();

		for(int i = 0 ; i < points.size() ; i++) {
			Point point = points.get(i);

			if(point.clusterId == UNCLASSIFIED) {
				if(expandCluster(points, point, clusterId, eps, minPoints)) {
					clusterId = clusterId + 1;
				}
			}
		}
		
		plot(points, eps, minPoints, clusterId - 1);
		
		return clusterId - 1;
	}

	private boolean expandCluster(ArrayList<Point> points, Point point,
			Integer id, Double eps, Integer minPoints) {
		ArrayList<Point> seeds = regionQuery(points, point, eps);

		if(seeds.size() < minPoints) {
			point.clusterId = NOISE;
			return false;
		} else {
			/* Delete the current point */
			putSeedsInCluster(seeds, point, id);

			while(seeds.size() > 0) {
				Point current = seeds.get(0);

				ArrayList<Point> result = regionQuery(points, current, eps);
				if(result.size() > minPoints) {
					for(int i = 0 ; i < result.size() ; i++) {
						Point aux = result.get(i);
						if(aux.clusterId == UNCLASSIFIED || aux.clusterId == NOISE) {
							if(aux.clusterId == UNCLASSIFIED) {
								seeds.add(aux);
							}
							aux.clusterId = id;
						}
					}
				}

				seeds.remove(0);
			}

			return true;
		}
	}

	private void putSeedsInCluster(ArrayList<Point> seeds,
			Point point, Integer id) {
		int indexToRemove = -1;
		
		for(int i = 0 ; i < seeds.size(); i++) {
			Point curr = seeds.get(i);
			curr.clusterId = id;
			if(curr.equals(point)) {
				indexToRemove = i;
			}
		}
		
		seeds.remove(indexToRemove);
	}

	private ArrayList<Point> regionQuery(ArrayList<Point> points, Point point, Double eps) {
		ArrayList<Point> result = new ArrayList<Point>();
		
		for(int i = 0 ; i < points.size() ; i++) {
			Point candidate = points.get(i);
			if(point.distance(candidate) <= eps) {
				result.add(candidate);
			}
		}
		
		return result;
	}
	
	private String plot(ArrayList<Point> points, Double eps, Integer pts, Integer clusterId) {
		String plot = "";
		
		for(int i = 0 ; i < points.size() ; i++) {
			Point point = points.get(i);
			plot += point.clusterId + "\t";
		}
		
		System.out.println(plot);
		
		String file = "C:\\Git\\DataMiningProject\\DBSCAN\\output" + points.get(0).coordinates.length + "_IDS_" + eps + "_" + pts + ".txt";
		
		write(file, plot);
		
		return plot;
	}
	
	public void write(String path, String content) {
		try {
			BufferedWriter bw = new BufferedWriter(new FileWriter(new File(path)));
			bw.write(content);
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void seeDistances(Integer n) {
		Double[][] distances = new Double[n][n];
		String print = "";
		for(int i = 0 ; i < n ; i++) {
			Point a = data.get(i);
			for(int j = 0 ; j < n ; j++) {
				Point b = data.get(j);
				distances[i][j] = new Double(a.distance(b));
				print += distances[i][j] + " ";
			}
			print += "\n";
		}
		System.out.println(print);
	}

	private void readData(String path) {
		try {
			BufferedReader br = new BufferedReader(new FileReader(new File(path)));
			String line = "";
			
			while( (line = br.readLine()) != null ) {
				String[] aux = line.split("\t");
                Double[] coord = new Double[aux.length];
                for(int i = 0 ; i < aux.length ; i++) {
                        coord[i] = new Double(aux[i]);
                }
                data.add(new Point(coord));
			}
			
			br.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		Dbscan db = new Dbscan("C:\\Git\\DataMiningProject\\DBSCAN\\conjunto_agrupamento.data.txt");
		long start = System.currentTimeMillis();
		int clusters = db.dbscan( 7.0, 4);
		long end = (System.currentTimeMillis() - start) / 1000;
		System.out.println("TOOK: " + end + "s CLUSTERS=" + clusters);
	}
	
}