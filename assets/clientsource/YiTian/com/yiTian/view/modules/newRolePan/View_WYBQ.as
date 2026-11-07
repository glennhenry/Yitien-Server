package com.yiTian.view.modules.newRolePan
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.horse.HorseUtil;
   import com.yiTian.view.modules.panel.Enum_panel_cast;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import com.yiTian.view.modules.wuXing.WuxingIconTip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_WYBQ extends Panel123
   {
      
      public static var LEN:int = 6;
      
      private var now:Item;
      
      public function View_WYBQ()
      {
         super();
         regResource("lang/ch/XJueSe.swf","XJueSedm");
      }
      
      override protected function initUI2() : void
      {
         var item:Item = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":383,
            "height":321 - 70
         },Global.Img_Cdm);
         move = new Rectangle(0,0,380,38);
         ComponentUtil.getBitmap("Title_WYBianQiang",this,{
            "x":111,
            "y":5
         },Global.XJueSedm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":346,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         initDynamicView();
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":23,
            "y":40,
            "width":336,
            "height":268 - 70
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":26,
            "y":43,
            "width":330,
            "height":262 - 70
         },Global.Img_Cdm);
         var i:int = 0;
         while(i < LEN)
         {
            item = new Item(i);
            item.tabIndex = i;
            addChild(item);
            ComponentUtil.setPropertie(item,{
               "x":33 + 161 * int(i % 2),
               "y":52 + int(i / 2) * 63
            });
            item.addEventListener(MouseEvent.CLICK,this.cliHd);
            i++;
         }
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         var item:Item = e.target as Item;
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         item.choose = true;
         this.now = item;
         switch(this.now.tabIndex)
         {
            case 0:
               if(Boolean(UIManager.petPanel.petVO))
               {
                  UIManager.petPanel.visible = !UIManager.petPanel.visible;
                  break;
               }
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10172",1) + "</font>");
               break;
            case 1:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(Enum_panel_cast.EQUIP_INTENSIFY);
                  break;
               }
               UIManager.castPanel.openView(Enum_panel_cast.EQUIP_INTENSIFY);
               break;
            case 2:
               UIManager.xinFaPanel.visible = !UIManager.xinFaPanel.visible;
               break;
            case 3:
               WuxingIconTip.cliHd();
               break;
            case 4:
               if(GameUnitManager.hero.level < 15)
               {
                  UIManager.centerBroadcast.addMsg("等级还不够，或者您还没坐骑");
                  return;
               }
               HorseUtil.clickHd();
               break;
            case 5:
               WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
               {
                  pan.visible = true;
                  pan.showView(1);
               });
               break;
            case 7:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(7);
                  break;
               }
               UIManager.castPanel.openView(7);
         }
      }
   }
}

import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import flash.display.Bitmap;
import flash.display.Sprite;

class Item extends Sprite
{
   
   private static var utl:Array = ["BG_TSCW","BG_ZBQH","BG_NGTS","BG_WXXL","BG_ZQSJ","BG_TSJL"];
   
   private static var utl2:Array = ["Text_TSCW","Text_ZBQH","Text_NGTS","Text_WXXL","Text_ZQSJ","Text_TSJL"];
   
   private static var lightArr:Array = [5,5,4,3,4,4];
   
   private var startBmVec:Vector.<Bitmap> = new Vector.<Bitmap>();
   
   private var _bm:ScaleBitmap;
   
   private var _choose:Boolean;
   
   public function Item(_type:int)
   {
      var i:int = 0;
      var bm:Bitmap = null;
      var bb:Bitmap = null;
      super();
      buttonMode = true;
      ComponentUtil.getScaleBitmap("Back_WYBianQiang",[3,2,1,1],this,{
         "x":0,
         "y":0,
         "width":155,
         "height":55
      },Global.XJueSedm);
      var ss:String = utl[_type];
      var ss1:String = utl2[_type];
      ComponentUtil.getBitmap(ss,this,{
         "x":2,
         "y":2
      },Global.XJueSedm);
      ComponentUtil.getBitmap(ss1,this,{
         "x":59,
         "y":3
      },Global.XJueSedm);
      i = 0;
      while(i < 5)
      {
         bm = ComponentUtil.getBitmap("Star2",this,{
            "x":59 + 19 * i,
            "y":31
         },Global.XJueSedm);
         bm.visible = false;
         this.startBmVec.push(bm);
         i++;
      }
      var lenN:int = int(lightArr[_type]);
      var j:int = 0;
      while(j < lenN)
      {
         bb = this.startBmVec[j];
         bb.visible = true;
         j++;
      }
      this._bm = ComponentUtil.getScaleBitmap("Back_FaGuang",[5,5,1,1],this,{
         "x":0,
         "y":0,
         "width":155,
         "height":55
      },Global.XJueSedm);
      this._bm.visible = false;
   }
   
   public function set choose(value:Boolean) : void
   {
      this._choose = value;
      this._bm.visible = value;
   }
   
   public function get choose() : Boolean
   {
      return this._choose;
   }
}
