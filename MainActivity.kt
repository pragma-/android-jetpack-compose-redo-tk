package ski.kramkow.paste

import android.app.Activity
import android.os.Bundle
//import java.net.HttpURLConnection;
//import java.net.URL;
//import java.io.OutputStream;

class MainActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        //URL url = new URL("http://192.168.1.32:8000");
        //HttpURLConnection con = (HttpURLConnection)url.openConnection();
        //con.setRequestMethod("POST");
        //con.setRequestProperty("Content-Type", "text/plain");
        //con.setDoOutput(true);
        //String data = "This is a test\n";
        //try(OutputStream os = con.getOutputStream()) {
            //byte[] block = data.getBytes("utf-8");
            //os.write(block, 0, block.length);
            //}
    }
}
