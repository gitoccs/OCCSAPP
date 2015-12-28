package com.occs.ldsoft.occs;

import android.support.v4.app.Fragment;

/**
 * Created by yeliu on 15/10/9.
 */
public class ActivityActivity extends SingleFragmentActivity {
    ActivityFragment myFragment;

    @Override
    protected Fragment createFragment() {
        myFragment = new ActivityFragment();
        return myFragment;
    }

    @Override
    public void onBackPressed() {
        if (myFragment.curPage > 1){
            myFragment.curPage--;
            String functionStr = "javascript:setpage" + myFragment.curPage + "()";
            myFragment.webView.loadUrl(functionStr);
        }else {
            super.onBackPressed();
        }
    }
}
