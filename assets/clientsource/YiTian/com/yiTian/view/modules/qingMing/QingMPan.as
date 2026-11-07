package com.yiTian.view.modules.qingMing
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.NewYearCGMessage;
   import com.yiTian.view.Panel123;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class QingMPan extends Panel123
   {
      
      public function QingMPan()
      {
         super();
         regResource("lang/ch/QingMing_Imgs.swf","QingMing_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var langArr:Array = null;
         var i:int = 0;
         var sp:Sprite = null;
         var prop:Object = null;
         var url:String = null;
         var tipsDescrip:String = null;
         ComponentUtil.getBitmap("Back_Imgs",this,{
            "x":0,
            "y":0
         },Global.QingMing_Imgsdm);
         move = new Rectangle(150,0,585,38);
         ComponentUtil.getBitmap("List_01",this,{
            "x":319,
            "y":72
         },Global.QingMing_Imgsdm);
         ComponentUtil.getBitmap("List_02",this,{
            "x":299,
            "y":140
         },Global.QingMing_Imgsdm);
         ComponentUtil.getBitmap("List_03",this,{
            "x":299,
            "y":269
         },Global.QingMing_Imgsdm);
         ComponentUtil.getBitmap("List_04",this,{
            "x":279,
            "y":338
         },Global.QingMing_Imgsdm);
         ComponentUtil.getBitmap("List_05",this,{
            "x":259,
            "y":407
         },Global.QingMing_Imgsdm);
         langArr = [70022,70023,70021,70024,70025];
         i = 0;
         while(i < 5)
         {
            sp = new Sprite();
            addChild(sp);
            prop = QingMingMter.propertyArr[i];
            url = QingMingMter.urlStrArr[i];
            ComponentUtil.setPropertie(sp,prop);
            ComponentUtil.getBitmap(url,sp,{
               "x":0,
               "y":0
            },Global.QingMing_Imgsdm);
            sp.mouseEnabled = true;
            sp.buttonMode = true;
            sp.tabIndex = i + 1;
            tipsDescrip = LangConfig.getWord(langArr[i].toString(),7);
            TipManager.bind(sp,tipsDescrip);
            sp.addEventListener(MouseEvent.CLICK,this.cliHd);
            sp.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void
            {
               e.target.filters = Util.glowFFff00;
            });
            sp.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
            {
               e.target.filters = [];
            });
            i++;
         }
         ComponentUtil.getButton("","Button_XSClose",this,{
            "x":665,
            "y":11,
            "textColor":16184781,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         var _data:Date = null;
         switch(e.target.tabIndex)
         {
            case 1:
               _data = new Date();
               if(_data.month == 3)
               {
                  if(_data.date >= 1 || _data.date <= 3)
                  {
                     UIManager.amPanel.cliActionTpe(1);
                     break;
                  }
                  UIManager.centerBroadcast.addMsg("不在活动时间内");
                  break;
               }
               UIManager.centerBroadcast.addMsg("不在活动时间内");
               break;
            case 2:
               navigateToURL(new URLRequest("http://yi.qq.com/act/a20130319yrj/index.htm"),"_blank");
               break;
            case 3:
               NewYearCGMessage.CG_NIANSHOUDATA();
               break;
            case 4:
               UIManager.jindanBtn.GoldEggBtnClick();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            pop();
         }
      }
   }
}

