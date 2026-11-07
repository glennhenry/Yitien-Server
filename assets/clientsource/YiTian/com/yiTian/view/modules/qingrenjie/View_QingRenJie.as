package com.yiTian.view.modules.qingrenjie
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.FruitShopHandler;
   import com.yiTian.net.message.cg.LFlowerCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.activityGuide.View_ActivityGuidePanel;
   import com.yiTian.view.modules.chunjiehuodong.View_ZiBiao;
   import com.yiTian.view.modules.lFlower.View_LFlower;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_QingRenJie extends Panel123
   {
      
      private static var _instance:View_QingRenJie;
      
      private var btn_vec:Vector.<Sprite>;
      
      private var isTimeTic:Boolean;
      
      public function View_QingRenJie()
      {
         super();
         regResource("lang/ch/QYHD.swf","QYHDdm");
      }
      
      public static function get instance() : View_QingRenJie
      {
         if(!_instance)
         {
            _instance = new View_QingRenJie();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var text:MyTextField;
         var s:Sprite = null;
         var s2:Sprite = null;
         var s1:Sprite = null;
         var s3:Sprite = null;
         this.btn_vec = new Vector.<Sprite>();
         ComponentUtil.getBitmap("Back_QYHD",this,{
            "x":0,
            "y":0
         },Global.QYHDdm);
         ComponentUtil.getBitmap("Text_QYHD",this,{
            "x":124,
            "y":22
         },Global.QYHDdm);
         ComponentUtil.getBitmap("Text_JRDL",this,{
            "x":139,
            "y":96
         },Global.QYHDdm);
         ComponentUtil.getBitmap("RenWu",this,{
            "x":75,
            "y":169
         },Global.QYHDdm);
         move = new Rectangle(0,0,650,550);
         s = new Sprite();
         ComponentUtil.getBitmap("Back_CDM",s,{
            "x":364,
            "y":168
         },Global.QYHDdm);
         ComponentUtil.getBitmap("Icon_QYCDM",s,{
            "x":473,
            "y":180
         },Global.QYHDdm);
         this.addChild(s);
         s2 = new Sprite();
         ComponentUtil.getBitmap("Back_JHDJ",s2,{
            "x":319,
            "y":348
         },Global.QYHDdm);
         ComponentUtil.getBitmap("Icon_JHDJ",s2,{
            "x":428,
            "y":360
         },Global.QYHDdm);
         this.addChild(s2);
         s1 = new Sprite();
         ComponentUtil.getBitmap("Back_AQZH",s1,{
            "x":340,
            "y":258
         },Global.QYHDdm);
         ComponentUtil.getBitmap("Icon_AQZH",s1,{
            "x":449,
            "y":270
         },Global.QYHDdm);
         this.addChild(s1);
         s3 = new Sprite();
         ComponentUtil.getBitmap("Back_SDJZ",s3,{
            "x":340,
            "y":438
         },Global.QYHDdm);
         ComponentUtil.getBitmap("Icon_SDYB",s3,{
            "x":449,
            "y":450
         },Global.QYHDdm);
         this.addChild(s3);
         s.buttonMode = s1.buttonMode = s2.buttonMode = s3.buttonMode = true;
         this.btn_vec.push(s,s1,s2,s3);
         TipManager.bind(s,LangConfig.getWord("80232",8));
         TipManager.bind(s1,LangConfig.getWord("80233",8));
         TipManager.bind(s2,LangConfig.getWord("80234",8));
         TipManager.bind(s3,LangConfig.getWord("80235",8));
         text = ComponentUtil.getTextField("",this,{
            "x":440,
            "y":515,
            "color":16184781,
            "size":12,
            "leading":0
         });
         text.htmlText = "活动时间：<font color=\'#04ff00\'>2月14号 10：00--2月17号23:59</font>";
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":685,
            "y":70,
            "textColor":16771436
         },Global.QYHDdm);
         CloseButton.callBack = function():void
         {
            visible = false;
         };
         this.serTime();
         Global.control.registerCallBack(Enum_mainUIBtn_hide.NOW_TIME,this.serTime);
      }
      
      private function serTime() : void
      {
         var a:uint = FruitShopHandler.dateNum;
         var date:Date = new Date(a * 1000);
         var day:int = date.date;
         var mon:int = date.month + 1;
         this.isTimeTic = day > 13;
      }
      
      private function clickHandler(e:MouseEvent) : void
      {
         var id:Number = NaN;
         switch(e.target)
         {
            case this.btn_vec[0]:
               Global.delegate.dosomething(Alert_CaiDengMi.instance,Alert_CaiDengMi.instance.show);
               break;
            case this.btn_vec[1]:
               id = GameUnitManager.hero.marriageID;
               if(id > 0)
               {
                  Global.delegate.dosomething(View_LFlower.instance,function():void
                  {
                     LFlowerCGMessage.CG_IFLOWER_OPEN();
                     View_LFlower.instance.visible = !View_LFlower.instance.visible;
                  });
                  break;
               }
               UIManager.centerBroadcast.addMsg("赶紧去结婚吧，才能种植爱情之花，可获得情人节属性丹哦",1);
               break;
            case this.btn_vec[2]:
               if(this.isTimeTic)
               {
                  View_ActivityGuidePanel.instance.selectedBTN("结婚打折");
                  break;
               }
               UIManager.centerBroadcast.addMsg("活动尚未开始，敬请期待！");
               break;
            case this.btn_vec[3]:
               if(this.isTimeTic)
               {
                  Global.delegate.dosomething(View_ZiBiao.instance,function():void
                  {
                     View_ZiBiao.instance.visible = true;
                  });
                  break;
               }
               UIManager.centerBroadcast.addMsg("活动尚未开始，敬请期待！");
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.addEventListener(MouseEvent.CLICK,this.clickHandler);
         }
         else
         {
            this.removeEventListener(MouseEvent.CLICK,this.clickHandler);
         }
      }
   }
}

