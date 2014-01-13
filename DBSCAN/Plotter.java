import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class Plotter {

    public static void write(String path, String content) {
        try {
            BufferedWriter bw = new BufferedWriter(new FileWriter(new File(path)));
            bw.write(content);
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        /* FIRST RUN IN THE 16DIM FILE */
		String runs = "";
        for(Double eps = 3.0 ; eps < 5.0 ; eps = eps + 0.5) {
            for(Integer pts = 2 ; pts < 6 ; pts++) {
                Dbscan db = new Dbscan("C:\\Git\\DataMiningProject\\DBSCAN\\conjunto_agrupamento.data.txt");
                runs += "EPS-" + eps + "PTS-" + pts + "CLUSTERS-" + db.dbscan(eps, pts) + "\n";
            }
        }
		
		write("C:\\Git\\DataMiningProject\\DBSCAN\\16DIM-results.txt", runs);
		runs = "";

        /* SECOND RUN IN THE 10DIM FILE */
        for(Double eps = 1.0 ; eps < 5.0 ; eps = eps + 0.5) {
            for(Integer pts = 2 ; pts < 6 ; pts++) {
                Dbscan db2 = new Dbscan("C:\\Git\\DataMiningProject\\DBSCAN\\conjunto_agrupamento_10.txt");
                runs += "EPS-" + eps + "PTS-" + pts + "CLUSTERS-" + db2.dbscan(eps, pts) + "\n";
            }
        }
		
		write("C:\\Git\\DataMiningProject\\DBSCAN\\10DIM-results.txt", runs);
    }

}
