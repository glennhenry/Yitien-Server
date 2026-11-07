package com.yiTian.view.modules.baby.babyPan
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.ModelManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BabyCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.baby.babyManager.Enum_baby;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   import flash.utils.setTimeout;
   import mx.utils.StringUtil;
   
   public class BabyChooseLY extends Panel123
   {
      
      private static var childArr:Array = [];
      
      private static var posArr:Array = [{
         "x":99,
         "y":117
      },{
         "x":335,
         "y":115
      }];
      
      private static var isFirstOpen:Boolean = true;
      
      public function BabyChooseLY()
      {
         super();
         regResource("lang/ch/ZN.swf","ZNdm");
      }
      
      public static function get instance() : BabyChooseLY
      {
         return Singleton.getInstance(BabyChooseLY);
      }
      
      override protected function initUI2() : void
      {
         var tf:MyTextField;
         var ss:String;
         var i:uint;
         var okFunc:Function = null;
         var child:Child = null;
         okFunc = function():void
         {
            var count:int = getPropNum();
            if(count <= 0)
            {
               if(GameUnitManager.hero.money >= 3888)
               {
                  setTimeout(function():void
                  {
                     View_Alert.show("<font color=\'#ffffff\'>是否花费<font color=\'#f9ff00\'>3888元宝</font>购买<font color=\'#ff7700\'>千年人参</font>并使用？</font>",View_Alert.OK_CANCAL,function():void
                     {
                        BabyCGMessage.CG_START_TO_LY(Child.nowChooseChild.type + 1);
                     },null,null,null,310,"","",TextFormatAlign.LEFT,false);
                  },300);
               }
               else
               {
                  UIManager.centerBroadcast.addMsg("您尚未拥有千年人参",1);
               }
            }
            else
            {
               BabyCGMessage.CG_START_TO_LY(Child.nowChooseChild.type + 1);
            }
         };
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":554,
            "height":361
         },Global.Img_Cdm);
         move = new Rectangle(0,0,554,38);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":504,
            "height":312
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":519,
            "y":5,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_LYZZ",this,{
            "x":197,
            "y":5
         },Global.ZNdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":69,
            "width":480,
            "height":271
         },Global.ZNdm);
         ComponentUtil.getBitmap("Back_LYZZ",this,{
            "x":44,
            "y":76
         },Global.ZNdm);
         tf = ComponentUtil.getTextField("",this,{
            "x":165,
            "y":46,
            "color":16772287,
            "size":12,
            "leading":0,
            "bold":true
         });
         ss = "须" + HtmlUtil.font("夫妻满足100级组队","#fe0000") + "使用" + HtmlUtil.font("千年人参","#fe0000") + "道具领养";
         tf.htmlText = ss;
         i = 0;
         while(i < 2)
         {
            child = new Child(i);
            addChild(child);
            ComponentUtil.setPropertie(child,{
               "x":posArr[i].x,
               "y":posArr[i].y
            });
            childArr.push(child);
            i++;
         }
         ComponentUtil.getButton("","Button_QueDing",this,{
            "x":231,
            "y":292,
            "textColor":16771436,
            "callBack":function():void
            {
               var typ:* = Child.nowChooseChild.type + 1;
               View_Alert.show(StringUtil.substitute("是否领养{0}？",typ == 1 ? "男崽崽" : "女囡囡"),View_Alert.OK_CANCAL,okFunc,null,null,null,310,"","",TextFormatAlign.LEFT,false);
            }
         },Global.ZNdm);
         super.initDynamicView();
      }
      
      private function getPropNum() : int
      {
         var num:int = 0;
         var count:int = CommandManager.get_bag_count(Enum_baby.propId);
         var arr:Array = ModelManager.bag.getIdByName("千年人参<font color=\'#fe0000\'>（限时道具）</font>");
         var len:int = int(arr.length);
         var i:int = 0;
         while(i < len)
         {
            num += CommandManager.getCanUseToolNum(arr[i]);
            i++;
         }
         return int(num + count);
      }
      
      public function show(e:* = null) : void
      {
         this.visible = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         var index:uint = 0;
         super.visible = value;
         if(value)
         {
            if(isFirstOpen)
            {
               isFirstOpen = false;
               index = GameUnitManager.hero.sex - 1;
               childArr[index].choose = true;
            }
         }
      }
   }
}

import com.utils.ComponentUtil;
import com.yiTian.Global;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

class Child extends Sprite
{
   
   public static var nowChooseChild:Child;
   
   private static var arr:Array = [["Back_NanHai","Back_NanHei"],["Back_NvHai","Back_NvHei"]];
   
   private static var pianYiArr:Array = [{
      "x":18,
      "y":-6
   },{
      "x":21,
      "y":-4
   }];
   
   private static const DOWN:uint = 0;
   
   private static const UP:uint = 1;
   
   private var back:Bitmap;
   
   private var childBm:Bitmap;
   
   public var type:uint;
   
   private var isChoosed:Boolean = false;
   
   public function Child(_type:uint)
   {
      super();
      this.type = _type;
      this.childBm = ComponentUtil.getBitmap(arr[_type][0],this,{
         "x":pianYiArr[_type].x,
         "y":pianYiArr[_type].y
      },Global.ZNdm);
      this.back = ComponentUtil.getBitmap(arr[_type][1],this,null,Global.ZNdm);
      addEventListener(MouseEvent.ROLL_OVER,this.rollOver);
      addEventListener(MouseEvent.ROLL_OUT,this.rollOut);
      addEventListener(MouseEvent.CLICK,this.click);
   }
   
   private function rollOver(e:MouseEvent) : void
   {
      if(!this.isChoosed)
      {
         this.lighting = true;
      }
   }
   
   private function rollOut(e:MouseEvent) : void
   {
      if(!this.isChoosed)
      {
         this.lighting = false;
      }
   }
   
   private function set lighting(value:Boolean) : void
   {
      if(value)
      {
         setChildIndex(this.childBm,UP);
         setChildIndex(this.back,DOWN);
      }
      else
      {
         setChildIndex(this.childBm,DOWN);
         setChildIndex(this.back,UP);
      }
   }
   
   private function click(e:MouseEvent) : void
   {
      if(nowChooseChild == this)
      {
         return;
      }
      if(Boolean(nowChooseChild))
      {
         nowChooseChild.choose = false;
      }
      this.choose = true;
   }
   
   public function set choose(value:Boolean) : void
   {
      this.isChoosed = this.lighting = value;
      if(value)
      {
         nowChooseChild = this;
      }
   }
}
