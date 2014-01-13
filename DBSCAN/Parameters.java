import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;

public class Parameters {
	
	private ArrayList<Point> data = new ArrayList<Point>();
	
	public Parameters(String path) {
		readData(path);
	}
	
	public String plot(Integer n) {
		String plot = "[";
		
		Double[] kdist = kdistance(n);
		ArrayList<Double> plotter = new ArrayList<Double>(); 
		
		for(int i = 0 ; i < kdist.length ; i++) {
			plotter.add(kdist[i]);
		}
		
		Collections.sort(plotter);
		
		for(int i = 0 ; i < kdist.length ; i++) {
			plot += plotter.get(i) + " ";
		}
		
		plot = plot.substring(0, plot.length() - 1) + "]";
		
		System.out.println(plot);
		
		return plot;
	}
	
	@SuppressWarnings("unchecked")
	public Double[] kdistance(Integer n) {
		ArrayList<Point> points = (ArrayList<Point>) data.clone();
		Double[][] dists = distances(points);
		Double[] kdist = new Double[dists.length];
		
		for(int i = 0 ; i < kdist.length ; i++) {
			kdist[i] = kdist(dists[i], n);
		}
		
		return kdist;
	}
	
	private Double kdist(Double[] vector, Integer n) {
		ArrayList<Double> temp = new ArrayList<Double>();
		for(int i = 0 ; i < vector.length ; i++) {
			temp.add(vector[i]);
		}
		
		Collections.sort(temp);
		
		return temp.get(n);
	}

	private Double[][] distances(ArrayList<Point> points) {
		Double[][] dists = new Double[points.size()][points.size()];
		
		for(int a = 0 ; a < dists.length ; a++) {
			Point one = points.get(a);
			for(int b = 0 ; b < dists[0].length ; b++) {
				Point two = points.get(b);
				dists[a][b] = new Double(two.distance(one));
			}
		}
		
		return dists;
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
		Parameters param = new Parameters("C:\\Git\\DataMiningProject\\DBSCAN\\conjunto_agrupamento.data.txt");
		param.plot(4);
	}
	
}
