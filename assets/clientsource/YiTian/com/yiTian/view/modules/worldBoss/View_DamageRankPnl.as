package com.yiTian.view.modules.worldBoss
{
   import Layout.HGroup;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.WorldBossCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_DamageRankPnl extends Panel123
   {
      
      private static var _instance:View_DamageRankPnl;
      
      private var items:Array = [];
      
      private var _tfPage:MyTextField;
      
      public function View_DamageRankPnl()
      {
         super();
         init();
      }
      
      public static function get instance() : View_DamageRankPnl
      {
         return _instance = _instance || new View_DamageRankPnl();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":378,
            "height":462
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":330,
            "height":412
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":50,
            "width":310,
            "height":362
         },Global.Img_Cdm);
         ComponentUtil.getTextField("排名",this,{
            "x":64,
            "y":56,
            "color":16764206
         });
         ComponentUtil.getTextField("名字",this,{
            "x":158,
            "y":56,
            "color":16764206
         });
         ComponentUtil.getTextField("伤害",this,{
            "x":274,
            "y":56,
            "color":16764206
         });
         move = new Rectangle(0,0,width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":344,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         var hgroup:HGroup = new HGroup(39,80,0,0,0,33);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":151,
            "y":418,
            "width":68,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":125,
            "y":419,
            "callBack":this.leftClickHd
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_PageRight",this,{
            "x":224,
            "y":419,
            "callBack":this.rightClickHd
         },Global.Img_Cdm);
         this._tfPage = ComponentUtil.getTextField("",this,{
            "x":173,
            "y":420,
            "color":14662240
         });
         Utils.loadTitle("lang/ch/WuHun_Imgs.swf","Title_Rank",new Bitmap(),{
            "x":107,
            "y":5
         },this);
         Global.control.registerCallBack(Msg_WorldBoss.DAMAGERANK_INFO_UPDATE,this.onDataUpdate);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            WorldBossCGMessage.CG_WB_DAMAGED_CHARTS(1);
         }
         super.visible = value;
      }
      
      public function onDataUpdate() : void
      {
         var startIndex:int = 0;
         var dataProvs:Array = null;
         var item:Item = null;
         var i:int = 0;
         this._tfPage.text = (Model_WorldBoss._curPage + 1).toString() + "/" + (Model_WorldBoss._maxPage + 1).toString();
         startIndex = Model_WorldBoss._curPage * 10;
         var len:int = Model_WorldBoss._rankInfo.length - startIndex;
         len = Math.min(10,len);
         dataProvs = Model_WorldBoss._rankInfo.slice(startIndex,startIndex + len);
         i = 0;
         while(i < dataProvs.length)
         {
            item = this.items[i];
            if(!item)
            {
               item = new Item();
               item.x = 39;
               item.y = 80 + i * 33;
               addChild(item);
               this.items[i] = item;
            }
            item.visible = Boolean(item.visible) || true;
            item._tfRank.text = (startIndex + i + 1).toString();
            item.update(dataProvs[i]);
            i += 1;
         }
         var j:int = i;
         while(j < this.items.length)
         {
            this.items[j].visible = false;
            j += 1;
         }
      }
      
      private function leftClickHd(e:MouseEvent) : void
      {
         var prePage:int = Model_WorldBoss._curPage - 1;
         prePage = Math.max(0,prePage);
         if(Boolean(Model_WorldBoss._rankInfo))
         {
            Model_WorldBoss.updateRank(Model_WorldBoss._maxPage,prePage,Model_WorldBoss._rankInfo);
         }
      }
      
      private function rightClickHd(e:MouseEvent) : void
      {
         var nxtPage:int = Model_WorldBoss._curPage + 1;
         nxtPage = Math.min(nxtPage,Model_WorldBoss._maxPage);
         if(Boolean(Model_WorldBoss._rankInfo))
         {
            Model_WorldBoss.updateRank(Model_WorldBoss._maxPage,nxtPage,Model_WorldBoss._rankInfo);
         }
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.Global;
import com.yiTian.view.modules.worldBoss.Enum_WorldBoss;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

class Item extends Sprite
{
   
   public var _tfRank:MyTextField;
   
   public var _tfRoleName:MyTextField;
   
   public var _tfDamagePercent:MyTextField;
   
   public function Item()
   {
      super();
      ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
         "x":0,
         "y":0,
         "width":300,
         "height":30
      },Global.Img_Cdm);
      this._tfRank = ComponentUtil.getTextField("",this,{
         "x":25,
         "y":5,
         "color":13424242
      });
      this._tfRoleName = ComponentUtil.getTextField("",this,{
         "x":132,
         "y":5,
         "color":13424242
      });
      this._tfDamagePercent = ComponentUtil.getTextField("",this,{
         "x":248,
         "y":5,
         "color":16383744
      });
      this._tfRoleName.autoSize = TextFieldAutoSize.CENTER;
      this._tfDamagePercent.autoSize = TextFieldAutoSize.CENTER;
      addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
      addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
   }
   
   private function onRollOver(e:MouseEvent) : void
   {
      transform.colorTransform = Util.colorWhite2;
   }
   
   private function onRollOut(e:MouseEvent) : void
   {
      transform.colorTransform = Util.colorNomal;
   }
   
   public function update(data:Object) : void
   {
      this._tfRoleName.text = data[Enum_WorldBoss.RANK_ROLENAME];
      this._tfDamagePercent.text = (data[Enum_WorldBoss.RANK_DAMAGEPERCENT] / 100).toString() + "%";
   }
}
