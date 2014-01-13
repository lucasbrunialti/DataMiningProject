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
        for(Double eps = 3.0 ; eps < 20.0 ; eps++) {
            for(Integer pts = 2 ; pts < 10 ; pts++) {
                Dbscan db = new Dbscan("/Users/arthur/Git/DataMiningProject/DBSCAN/conjunto_agrupamento.data.txt");
                db.dbscan(eps, pts);
            }
        }

        /* SECOND RUN IN THE 10DIM FILE */
        for(Double eps = 3.0 ; eps < 20.0 ; eps++) {
            for(Integer pts = 2 ; pts < 10 ; pts++) {
                Dbscan db2 = new Dbscan("/Users/arthur/Git/DataMiningProject/DBSCAN/conjunto_agrupamento_10.txt");
                db2.dbscan(eps, pts);
            }
        }
    }

}
