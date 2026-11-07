package com.yiTian.view.modules.chunjiehuodong
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.fishing.View_FishTipBtn;
   import flash.geom.Rectangle;
   
   public class View_DYNG extends Panel123
   {
      
      private static var _instance:View_DYNG;
      
      private var goto_btn:Button;
      
      public function View_DYNG()
      {
         super();
         regResource("lang/ch/DYNG.swf","DYNGdm");
      }
      
      public static function get instance() : View_DYNG
      {
         if(!_instance)
         {
            _instance = new View_DYNG();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
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
         },Global.DYNGdm);
         ComponentUtil.getBitmap("Back_NSHS",this,{
            "x":39,
            "y":55
         },Global.DYNGdm);
         this.goto_btn = ComponentUtil.getButton("","Button_TwoBule91",this,{
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
         move = new Rectangle(0,0,420,36);
         this.goto_btn.callBack = function():void
         {
            visible = false;
            if(GameUnitManager.hero.level < 30)
            {
               UIManager.centerBroadcast.addMsg("开启等级30级");
               return;
            }
            View_FishTipBtn.instance.clickHandle();
            Global.delegate.dosomething(View_YearACEntrance.instance,function():void
            {
               View_YearACEntrance.instance.visible = false;
            });
            visible = false;
         };
      }
   }
}

