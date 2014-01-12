import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class Dbscan {

	public Point[] point;
	public double eps;
	public int minPoints;

	public Dbscan(double eps, int minPts) throws IOException {
		this.eps = eps;
		this.minPoints = minPts;
		readDataFile();
	}

	public void readDataFile() throws IOException {
		BufferedReader br = new BufferedReader(new FileReader(new File("conjunto_agrupamento.data.txt")));
		String line = "";
		ArrayList<Double[]> data = new ArrayList<Double[]>();
		while( (line = br.readLine()) != null ) {
			String[] aux = line.split("\t");
			Double[] coord = new Double[aux.length];
			for(int i = 0 ; i < aux.length ; i++) {
				coord[i] = new Double(aux[i]);
			}
			data.add(coord);
		}
		br.close();
		point = new Point[data.size()];
		for(int i = 0 ; i < data.size() ; i++) {
			point[i] = new Point(data.get(i));
		}
		print();
	}

	public void dbscan() {

	}

	public void dbscan(double eps, int minPts) {

	}
	
	public static void main(String[] args) {
		try {
			Dbscan db = new Dbscan(2.0, 10);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void print() {
		for(int i = 0 ; i < point.length ;i++) {
			System.out.println(point[i].getCoordinates() + point[i].clusterId);
		}
	}
}