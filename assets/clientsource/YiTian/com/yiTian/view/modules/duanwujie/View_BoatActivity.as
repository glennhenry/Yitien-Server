package com.yiTian.view.modules.duanwujie
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.boatChall.P_enterGamePanel;
   
   public class View_BoatActivity extends Panel123
   {
      
      private static var _instance:View_BoatActivity;
      
      public static var OPEN_ACTS:Boolean = false;
      
      public function View_BoatActivity()
      {
         super();
         regResource("lang/ch/NSHS.swf","NSHSdm");
      }
      
      public static function get instance() : View_BoatActivity
      {
         if(!_instance)
         {
            _instance = new View_BoatActivity();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var btn:Button;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":458,
            "height":308
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":410,
            "height":259
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":149,
            "y":5
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":423,
            "y":6,
            "textColor":16771436,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":34,
            "y":50,
            "width":390,
            "height":211
         },Global.NSHSdm);
         ComponentUtil.getBitmap("Back_LZFW",this,{
            "x":39,
            "y":55
         },Global.NSHSdm);
         btn = ComponentUtil.getButton("","Button_TwoBule91",this,{
            "x":184,
            "y":265,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getTextField("确定",this,{
            "x":216,
            "y":268,
            "color":16184781,
            "size":12,
            "leading":0
         });
         btn.callBack = function():void
         {
            if(View_BoatActivity.OPEN_ACTS)
            {
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(P_enterGamePanel.instance,P_enterGamePanel.instance.show);
               visible = false;
            }
            else
            {
               UIManager.centerBroadcast.addMsg("活动开启时间为21:30-22:00",1);
            }
         };
      }
   }
}

