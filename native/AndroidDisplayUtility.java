package com.monkey2.lib;
 
import android.util.DisplayMetrics;
import android.view.WindowManager;
 
public class AndroidDisplayUtility {
    private static final String TAG = "AndroidDisplayUtility";
    
    static public float getDPI( boolean vertical ) {
	    DisplayMetrics metrics = new DisplayMetrics();
        Monkey2Activity.mSingleton.getWindowManager().getDefaultDisplay().getMetrics(metrics);
        
        if( vertical ){
            return metrics.ydpi;
        } else {
            return metrics.xdpi;
        }
    }
    
}