package lib;

/**
 * Created by Chanj on 17/02/2018.
 */

public class MyLog {
	public static void d(final String TAG){
		System.out.println(TAG);
	}
	public static void d(final String TAG, String msg){
		System.out.println(TAG + ", "+msg);
	}
}
