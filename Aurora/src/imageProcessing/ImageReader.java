package imageProcessing;

import java.awt.image.*;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
/**
 * 
 * @author Bret Reynolds and Jake Hackim
 *
 */
public class ImageReader {
    public static void main(String [] args) {
    	
    	String fileName = "samples/test";
    	
    	try 
    	{
    		//create file streams
    		FileInputStream fis = new FileInputStream(fileName + ".bmp");
    		//use for file writing
    		//FileOutputStream fos = new FileOutputStream(fileName + ".txt");
    		//Writer w = new OutputStreamWriter(fos, "UTF8");
    		
    		int i;
    		int count = 0;
    		ArrayList<Integer> bitmap = new ArrayList<Integer>();
    		//read each byte to an integer
    		
    		while((i = fis.read()) != -1)
    		{
    			bitmap.add(i);
    			count++;
    			 //use if a txt file needs to be created
    			/*
    			w.append(i + " -> " + intToHex(i) + ";      ");
    			count++;
    			if((count + 2) % 4 == 0)
    				w.append("\r\n");
    			*/			
    		}
    		int idx = bitmap.get(10);
    		int[] graymap = grayscale(bitmap, idx);
    		
    		//use for file writing
			//w.close();
			//fos.close();
			fis.close();
		} 
    	catch (IOException e) 
    	{
			System.out.println("broken");
		}
    }
    
    /**
     * turns an integer into hexadecimal
     * @param i 
     * @return
     */
    private static String intToHex(int i)
    {
    	String rtn = "";
    	//recursive call if current value is greater than 16
    	if(i >= 16)
    		rtn += intToHex(i / 16);
    	//printing remainder value to rtn string
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
       
    private static int[] grayscale(ArrayList<Integer> bitmap, int idx)
    {
    	int graysize = (bitmap.size() - idx - 1) / 4;
    	
    	int[] graymap = new int[graysize];
    	
    	for( int i = 0; i < graysize; ++i)
    	{
    		graymap[i] = (int)(0.07 * bitmap.get(idx + i * 3) + 0.72 * bitmap.get(idx + i * 3 + 1) + 0.21 * bitmap.get(idx + i * 3 + 2));
    		
    		System.out.println(i + ": " + bitmap.get(idx + i * 3 + 2) + " " + bitmap.get(idx + i * 3 + 1) + " " + bitmap.get(idx + i * 3) + ": " + graymap[i]);
    		++idx;
    	}
    			
    	return graymap;
    }
}