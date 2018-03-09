package com.monkey2.lib;
 
import android.util.DisplayMetrics;
import android.view.WindowManager;
 
public class AndroidDisplayUtility {
    private static final String TAG = "AndroidDisplayUtility";
    
    static public DisplayMetrics getMetrics(){
	    DisplayMetrics metrics = new DisplayMetrics();
        Monkey2Activity.mSingleton.getWindowManager().getDefaultDisplay().getMetrics(metrics);
        
        return metrics;
    }
    
}