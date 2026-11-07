package com.yiTian.view.modules.moneyTree
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_MoneyTree;
   import com.yiTian.data.vo.Vo_DynamicTip;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_MoneyTree extends Panel123
   {
      
      private static var _instance:View_MoneyTree;
      
      private var vec:Vector.<Item_MoneyTree>;
      
      private var bmp:Bitmap;
      
      private var tipsLayer:Sprite;
      
      private var isPlay:Boolean;
      
      private var tips:Button;
      
      public function View_MoneyTree()
      {
         super();
         regResource("lang/ch/YQS.swf","YQSdm");
      }
      
      public static function get instance() : View_MoneyTree
      {
         if(!_instance)
         {
            _instance = new View_MoneyTree();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var tt:MyTextField;
         var str:String;
         var vo:Vo_DynamicTip;
         var i1:Item_MoneyTree = null;
         var i2:Item_MoneyTree = null;
         var i3:Item_MoneyTree = null;
         ComponentUtil.getBitmap("Back_YQS",this,{
            "x":0,
            "y":0
         },Global.YQSdm);
         ComponentUtil.getBitmap("Text_YQS",this,{
            "x":318,
            "y":19
         },Global.YQSdm);
         CloseButton = ComponentUtil.getButton("","BT_SGC",this,{
            "x":661,
            "y":33,
            "textColor":16771436
         },Global.YQSdm);
         this.tips = ComponentUtil.getButton("","Button_HDTips",this,{
            "x":633,
            "y":31,
            "textColor":16771436
         },Global.Img_Cdm);
         i1 = new Item_MoneyTree();
         i1.x = 89;
         i1.index = 1;
         i1.y = 71;
         addChild(i1);
         i2 = new Item_MoneyTree();
         i2.x = 279;
         i2.y = 71;
         i2.index = 2;
         addChild(i2);
         i3 = new Item_MoneyTree();
         i3.x = 468;
         i3.y = 71;
         i3.index = 3;
         addChild(i3);
         ComponentUtil.getBitmap("Back_FHZZJ",this,{
            "x":205,
            "y":44
         },Global.YQSdm);
         ComponentUtil.getBitmap("Back_FHZZJS",this,{
            "x":395,
            "y":44
         },Global.YQSdm);
         ComponentUtil.getBitmap("Back_FHZZJO",this,{
            "x":584,
            "y":44
         },Global.YQSdm);
         this.vec = new Vector.<Item_MoneyTree>();
         this.vec.push(i1,i2,i3);
         ComponentUtil.getTextField("注：青铜摇钱树、白银摇钱树、黄金摇钱树只能种植一次，看准了下手！",this,{
            "x":145,
            "y":479,
            "color":16777215,
            "size":14,
            "leading":0,
            "bold":true
         });
         move = new Rectangle(0,0,590,43);
         CloseButton.callBack = function():void
         {
            visible = false;
         };
         this.tipsLayer = new Sprite();
         ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this.tipsLayer,{
            "x":142,
            "y":180,
            "width":456,
            "height":150
         },Global.Img_Cdm);
         this.addChild(this.tipsLayer);
         tt = ComponentUtil.getTextField("",this.tipsLayer,{
            "x":148,
            "y":206 - 20,
            "align":"left",
            "leading":3,
            "wordWrap":true,
            "multiline":true,
            "realWidth":450
         });
         str = "<font color=\'#04ff00\'>1.种植摇钱树</font>\n";
         str += "玩家在指定时间内可以种植一次摇钱树，种植之后，摇钱树成长值增加没有时间限制\n";
         str += "种植成功，立即全额返还<font color=\'#04ff00\'>78/868/8888元宝</font>给玩家\n";
         str += "<font color=\'#04ff00\'>2.摇钱树成长值</font>\n";
         str += "花费元宝灌溉获得<font color=\'#04ff00\'>20%</font>成长值\n";
         str += "提升等级可以增加一定成长值<font color=\'#04ff00\'>（成长值=当前等级/10的值向下取整）</font>\n";
         str += "<font color=\'#04ff00\'>3.摇钱树奖励</font>\n";
         str += " 当摇钱树成长值达到<font color=\'#04ff00\'>20%、40%、60、80、100%</font>可以分别领取丰厚奖励";
         tt.htmlText = str;
         vo = new Vo_DynamicTip();
         vo._w = 450;
         vo.info = str;
         TipManager.bind(this.tips,vo);
         Global.stage.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(e:MouseEvent) : void
      {
         Global.stage.removeEventListener(MouseEvent.CLICK,this.onClick);
         this.tipEff();
      }
      
      private function tipEff() : void
      {
         if(this.isPlay)
         {
            return;
         }
         this.isPlay = true;
         Tween.to(this.tipsLayer,500,{
            "scaleX":[1,0],
            "scaleY":[1,0],
            "x":[this.tipsLayer.x,this.tips.x],
            "y":[this.tipsLayer.y,this.tips.y]
         },function():void
         {
            tipsLayer.visible = false;
         });
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.isPlay)
            {
               setTimeout(this.tipEff,2000);
            }
         }
      }
      
      public function update() : void
      {
         var i:int = 0;
         while(i < 3)
         {
            if(Model_MoneyTree.currentTree == 0)
            {
               this.vec[i].setStatus(0);
            }
            else if(this.vec[i].index != Model_MoneyTree.currentTree)
            {
               this.vec[i].setStatus(1);
               this.vec[i].filters = Util.disabled;
            }
            else
            {
               this.vec[i].setStatus(2);
               this.vec[i].update();
            }
            i++;
         }
      }
      
      public function plant_eff(index:int) : void
      {
         var i:int = 0;
         var flag:int = 0;
         var fly:Function = null;
         i = 0;
         while(i < 3)
         {
            if(this.vec[i].index == index)
            {
               fly = function():void
               {
                  var targetX:int = vec[i].x + 65;
                  var targetY:int = 121;
                  clearTimeout(flag);
                  Tween.to(bmp,1000,{
                     "x":[300,targetX],
                     "y":[100,targetY],
                     "scaleX":[2,0.5],
                     "scaleY":[2,0.5]
                  },function(bmp:Bitmap):void
                  {
                     bmp.bitmapData = null;
                     if(Boolean(bmp) && Boolean(bmp.parent))
                     {
                        bmp.parent.removeChild(bmp);
                     }
                  });
               };
               this.bmp = new Bitmap();
               this.addChild(this.bmp);
               this.bmp.bitmapData = this.vec[i].bitmapd();
               this.bmp.x = 300;
               this.bmp.y = 121;
               var _temp_2:* = this.bmp;
               this.bmp.scaleY = 2;
               _temp_2.scaleX = 2;
               flag = int(setTimeout(fly,200));
               return;
            }
            i++;
         }
      }
      
      public function flyIcon(index:int) : void
      {
         this.vec[Model_MoneyTree.currentTree - 1].flyIcon();
      }
      
      public function eff_yb() : void
      {
         this.vec[Model_MoneyTree.currentTree - 1].eff_yb();
      }
   }
}

