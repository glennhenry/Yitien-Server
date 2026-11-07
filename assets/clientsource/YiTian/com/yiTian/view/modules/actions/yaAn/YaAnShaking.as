package com.yiTian.view.modules.actions.yaAn
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.christmas.ViewChristMas;
   import com.yiTian.view.modules.yellowDiamond.BaoshiQYTips;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class YaAnShaking extends Panel123
   {
      
      private var pro:Array = [{
         "x":331,
         "y":167
      },{
         "x":364,
         "y":258
      },{
         "x":376,
         "y":349
      }];
      
      private var pro2:Array = [{
         "x":474,
         "y":175
      },{
         "x":509,
         "y":266
      },{
         "x":522,
         "y":357
      }];
      
      private var tipArr:Array = ["活动期间，系统会在8:00-22:00整点时刷新祈福蜡烛，玩家可以采集在活动界面捐献蜡烛将获得积分，使用积分可以兑换积分商城中丰厚的奖励","玩家在活动期间，使用4级或者4级以上的宝石进行合成，将会邮件返还随机任意一种同级宝石给玩家","玩家在活动期间，于每天的21:00-22:00时段可免费运送紫镖，并且附赠免费的保险"];
      
      public function YaAnShaking()
      {
         super();
         regResource("lang/ch/yaAn.swf","YaAndm");
      }
      
      override protected function initUI2() : void
      {
         var bckImg:Bitmap;
         var i:int = 0;
         var p:Object = null;
         var pp:Object = null;
         var sp:Sprite = null;
         var _num:int = 0;
         var ss:String = null;
         var sss:String = null;
         var tips:String = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":828 - 77,
            "height":470
         },Global.Img_Cdm);
         move = new Rectangle(0,0,749,38);
         bckImg = ComponentUtil.getBitmap("Back_Img",this,{
            "x":24,
            "y":40
         },Global.YaAndm);
         bckImg.width = 780 - 77;
         i = 0;
         while(i < 3)
         {
            p = this.pro[i];
            pp = this.pro2[i];
            sp = new Sprite();
            addChild(sp);
            sp.buttonMode = true;
            ComponentUtil.setPropertie(sp,p);
            _num = i + 1;
            ss = "List0" + _num;
            sss = "lazu" + _num;
            sp.tabIndex = i;
            ComponentUtil.getBitmap(ss,sp,null,Global.YaAndm);
            ComponentUtil.getBitmap(sss,this,pp,Global.YaAndm);
            tips = this.tipArr[i];
            TipManager.bind(sp,tips);
            sp.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void
            {
               (e.target as DisplayObject).transform.colorTransform = Util.colorGlow;
            });
            sp.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
            {
               (e.target as DisplayObject).transform.colorTransform = Util.colorNomal;
            });
            sp.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
            {
               var tip:BaoshiQYTips = null;
               switch(e.target.tabIndex)
               {
                  case 0:
                     if(!UIManager.christmasView)
                     {
                        UIManager.christmasView = new ViewChristMas();
                        UIManager.christmasView.init();
                     }
                     UIManager.christmasView.visible = !UIManager.christmasView.visible;
                     break;
                  case 1:
                     tip = Singleton.getInstance(BaoshiQYTips) as BaoshiQYTips;
                     tip.visible = true;
                     break;
                  case 2:
                     UIManager.paoBiaoPanel.zhiBiaoHandler();
               }
            });
            i++;
         }
         ComponentUtil.getTextField("活动时间：4月24日-4月27日",this,{
            "x":332,
            "y":115,
            "color":52224,
            "size":12,
            "leading":0
         });
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":794 - 77,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         initDynamicView();
         ComponentUtil.getBitmap("Title_YaAn",this,{
            "x":334 - 37,
            "y":5
         },Global.YaAndm);
      }
   }
}

