package com.sososeen09.flutter_practise;

import android.content.Context;
import android.view.View;
import android.widget.Button;

/**
 * @author yunlong
 * @date 2019-12-12
 */
public class ViewManager {

  private static final ViewManager ourInstance = new ViewManager();
  private View mView;

  public static ViewManager getInstance() {
    return ourInstance;
  }

  private ViewManager() {
  }

  public void setView(View view) {
    this.mView = view;
  }

  public View getView() {
    return mView;
  }

  public View generateView(Context context) {
    Button button = new Button(context);

    button.setText("generate");
    return button;
  }
}
