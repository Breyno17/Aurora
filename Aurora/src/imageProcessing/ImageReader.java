package imageProcessing;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
/**
 * 
 * @author Bret Reynolds and Jake Hackim
 *
 */
public class ImageReader {
    public static void main(String [] args) {
    	
    	String fileName = "samples/MARBLES";
    	
    	try 
    	{
    		//create file streams
    		FileInputStream fis = new FileInputStream(fileName + ".bmp");
    		FileOutputStream fos = new FileOutputStream(fileName + ".txt");
    		Writer w = new OutputStreamWriter(fos, "UTF8");
    		
    		int i;
    		int count = 1;
    		//read each byte to an integer
    		while((i = fis.read()) != -1){
    			//System.out.println(count + " " + i);
    			
    			//w.append(count++ + ": " + i + " -> " + intToHex(i) + "; ");
    			w.append(i + " -> " + intToHex(i) + ";      ");
    			count++;
    			if(count % 8 == 0)
    				w.append("\r\n");
    		}
			w.close();
			fos.close();
			fis.close();
		} 
    	catch (IOException e) 
    	{
			System.out.println("broken");
		}
    }
    
    /**
     * turs an integer into hexidecimal
     * @param i
     * @return
     */
    private static String intToHex(int i){
    	String rtn = "";
    	
    	int next = i / 16;
    	
    	if(next > 0)
    		rtn += intToHex(next);
    	
    	i %= 16;
    	if(i < 10)
    		return rtn += i;
    	switch (i) 
    	{
    	case 10:
    		return rtn += "A";
    	case 11:
    		return rtn += "B";
    	case 12:
    		return rtn += "C";
    	case 13:
    		return rtn += "D";
    	case 14:
    		return rtn += "E";
    	case 15:
    		return rtn += "F";
    	}
    	return rtn;
    }
       
}